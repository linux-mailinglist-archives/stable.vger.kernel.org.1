Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CD77AB64
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHMVV0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHMVVZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D910D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8604362793
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA7C433C9;
        Sun, 13 Aug 2023 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961686;
        bh=lwGCTcQkL9P0smekJypRVkktTk+uh81uf5a/nipxBe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yP5OL0Cfsb73FFhXE3nKnkjIjv2c9749qqjvonpiqxGbtX7ou++sbYeNu11RnpnOm
         41o2TjwqvELQPfmPr9lEqWD/5sW6DRErcJ5h59EFYR9B8+x+2n4aue5wSlDtM6O47B
         L1QKbA03lNvcQ0sitMiViwg+gPQpG87edqPD8qzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 22/26] scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
Date:   Sun, 13 Aug 2023 23:19:15 +0200
Message-ID: <20230813211703.810652834@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
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
@@ -1505,10 +1505,6 @@ static int storvsc_host_reset_handler(st
  */
 static enum blk_eh_timer_return storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return BLK_EH_RESET_TIMER;
 }
 


