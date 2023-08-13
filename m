Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D477AB87
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjHMVW6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjHMVWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D91702
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA7662843
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DB6C433C8;
        Sun, 13 Aug 2023 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961774;
        bh=slOT+eSM/CksFP5jaoLuEZ9Fud/FSn7HlcOt5ky1Z1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cKOePVqkU9wGtnGLUTQQWbw9lYr+uB6vFONtSZSun2ecL3gmahYXdcLnR+WSG6I8
         g7yUFgMk8p9VcXxhJK3SCl0BiAynHdhVJkZfUXRzAp/5lroxulu9hYO8A/FE5f/wMk
         thMem3/HP2q3VrS6jutjbwNcOmC6LxSvIMkWrM/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 28/33] scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
Date:   Sun, 13 Aug 2023 23:19:22 +0200
Message-ID: <20230813211704.947802789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

commit 175544ad48cbf56affeef2a679c6a4d4fb1e2881 upstream.

Hyper-V provides the ability to connect Fibre Channel LUNs to the host
system and present them in a guest VM as a SCSI device. I/O to the vFC
device is handled by the storvsc driver. The storvsc driver includes a
partial integration with the FC transport implemented in the generic
portion of the Linux SCSI subsystem so that FC attributes can be displayed
in /sys.  However, the partial integration means that some aspects of vFC
don't work properly. Unfortunately, a full and correct integration isn't
practical because of limitations in what Hyper-V provides to the guest.

In particular, in the context of Hyper-V storvsc, the FC transport timeout
function fc_eh_timed_out() causes a kernel panic because it can't find the
rport and dereferences a NULL pointer. The original patch that added the
call from storvsc_eh_timed_out() to fc_eh_timed_out() is faulty in this
regard.

In many cases a timeout is due to a transient condition, so the situation
can be improved by just continuing to wait like with other I/O requests
issued by storvsc, and avoiding the guaranteed panic. For a permanent
failure, continuing to wait may result in a hung thread instead of a panic,
which again may be better.

So fix the panic by removing the storvsc call to fc_eh_timed_out().  This
allows storvsc to keep waiting for a response.  The change has been tested
by users who experienced a panic in fc_eh_timed_out() due to transient
timeouts, and it solves their problem.

In the future we may want to deprecate the vFC functionality in storvsc
since it can't be fully fixed. But it has current users for whom it is
working well enough, so it should probably stay for a while longer.

Fixes: 3930d7309807 ("scsi: storvsc: use default I/O timeout handler for FC devices")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1690606764-79669-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1540,10 +1540,6 @@ static int storvsc_host_reset_handler(st
  */
 static enum blk_eh_timer_return storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return BLK_EH_RESET_TIMER;
 }
 


