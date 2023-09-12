Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50079BF60
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjIKVsq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbjIKPZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:25:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29DD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:25:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81983C433C8;
        Mon, 11 Sep 2023 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445945;
        bh=qRmGEv+/9knJjrHXCGjnxgMEr3UdxhGUWP0bT64rk4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMcKXS4lOrqcG6ScLGKHRffpE0q0/ZPnLw9zs3KXbc+ZWvQRkJmspcNZCs3I3vIRp
         9wDQQ5VDfFo+jhG5Cl2+6MroMeRfizOkT/RGiOMOWhb3/qXXYaot6o8+IwOazFFzta
         JXtyyf1lswmA6/hrUZgSEEVGivGkK2sIgLP3bu/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 528/600] scsi: core: Fix the scsi_set_resid() documentation
Date:   Mon, 11 Sep 2023 15:49:21 +0200
Message-ID: <20230911134649.209444610@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit f669b8a683e4ee26fa5cafe19d71cec1786b556a upstream.

Because scsi_finish_command() subtracts the residual from the buffer
length, residual overflows must not be reported. Reflect this in the SCSI
documentation. See also commit 9237f04e12cc ("scsi: core: Fix
scsi_get/set_resid() interface")

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230721160154.874010-2-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/scsi/scsi_mid_low_api.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -1190,11 +1190,11 @@ Members of interest:
 		 - pointer to scsi_device object that this command is
                    associated with.
     resid
-		 - an LLD should set this signed integer to the requested
+		 - an LLD should set this unsigned integer to the requested
                    transfer length (i.e. 'request_bufflen') less the number
                    of bytes that are actually transferred. 'resid' is
                    preset to 0 so an LLD can ignore it if it cannot detect
-                   underruns (overruns should be rare). If possible an LLD
+                   underruns (overruns should not be reported). An LLD
                    should set 'resid' prior to invoking 'done'. The most
                    interesting case is data transfers from a SCSI target
                    device (e.g. READs) that underrun.


