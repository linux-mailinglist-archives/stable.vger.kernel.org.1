Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B577AC56
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHMVcP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjHMVcO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E451700
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C1162B5A
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE0C433C7;
        Sun, 13 Aug 2023 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962325;
        bh=aYo3nfS70hiuAR6MC1KJQmyn4pU0OCZceC9spGImXIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaDCKOgsPux2cniIT0Mq4jMynwhp0VSx6nxUIm20l1i8MQw4nAMGYrD0VE5os2RvH
         h0isSDu+ZY7snE4ea2l7wLjFGhpUcomKeJENnk7gQSucjbO7y6yq7f5xeKbuS94yK9
         K9llK8s/8iz1Gbr+8AnlL0wP7cuPirECf/JLbrww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 195/206] scsi: fnic: Replace return codes in fnic_clean_pending_aborts()
Date:   Sun, 13 Aug 2023 23:19:25 +0200
Message-ID: <20230813211730.600035704@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karan Tilak Kumar <kartilak@cisco.com>

commit 5a43b07a87835660f91d88a4db11abfea8c523b7 upstream.

fnic_clean_pending_aborts() was returning a non-zero value irrespective of
failure or success.  This caused the caller of this function to assume that
the device reset had failed, even though it would succeed in most cases. As
a consequence, a successful device reset would escalate to host reset.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
Link: https://lore.kernel.org/r/20230727193919.2519-1-kartilak@cisco.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fnic/fnic.h      |    2 +-
 drivers/scsi/fnic/fnic_scsi.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.54"
+#define DRV_VERSION		"1.6.0.55"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2139,7 +2139,7 @@ static int fnic_clean_pending_aborts(str
 				     bool new_sc)
 
 {
-	int ret = SUCCESS;
+	int ret = 0;
 	struct fnic_pending_aborts_iter_data iter_data = {
 		.fnic = fnic,
 		.lun_dev = lr_sc->device,
@@ -2159,9 +2159,11 @@ static int fnic_clean_pending_aborts(str
 
 	/* walk again to check, if IOs are still pending in fw */
 	if (fnic_is_abts_pending(fnic, lr_sc))
-		ret = FAILED;
+		ret = 1;
 
 clean_pending_aborts_end:
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"%s: exit status: %d\n", __func__, ret);
 	return ret;
 }
 


