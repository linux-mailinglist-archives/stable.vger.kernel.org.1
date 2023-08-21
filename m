Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B378325E
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHUUA0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHUUA0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF711C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBA66164F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A960C433C9;
        Mon, 21 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648023;
        bh=KA/lQXiDMZIJDeDewA7exKjJDiJNYqY1EXweNM8TucY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPJSpZcDZJcPt5D1tRNrbTwVw4A4JGtnmq8Emg1xgIkfXZQqUAUw2wY1SGXgcM79t
         /y/A/Y3GZ7ompddwK72/d/wV+wp14rVRn1MElJgzaSAXSXZttEZAbFLJW3mGUIyHMB
         +KXutqWXgByKwjGPhnQXY+oui4btlI3p0ki3lox8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 027/234] accel/habanalabs: add pci health check during heartbeat
Date:   Mon, 21 Aug 2023 21:39:50 +0200
Message-ID: <20230821194129.953178224@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit d8b9cea584661b30305cf341bf9f675dc0a25471 ]

Currently upon a heartbeat failure, we don't know if the failure
is due to firmware hang or due to a bad PCI link. Hence, we
are reading a PCI config space register with a known value (vendor ID)
so we will know which of the two possibilities caused the heartbeat
failure.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/device.c         | 15 ++++++++++++++-
 drivers/accel/habanalabs/common/habanalabs.h     |  2 ++
 drivers/accel/habanalabs/common/habanalabs_drv.c |  2 --
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fabfc501ef543..a39dd346a1678 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -981,6 +981,18 @@ static void device_early_fini(struct hl_device *hdev)
 		hdev->asic_funcs->early_fini(hdev);
 }
 
+static bool is_pci_link_healthy(struct hl_device *hdev)
+{
+	u16 vendor_id;
+
+	if (!hdev->pdev)
+		return false;
+
+	pci_read_config_word(hdev->pdev, PCI_VENDOR_ID, &vendor_id);
+
+	return (vendor_id == PCI_VENDOR_ID_HABANALABS);
+}
+
 static void hl_device_heartbeat(struct work_struct *work)
 {
 	struct hl_device *hdev = container_of(work, struct hl_device,
@@ -995,7 +1007,8 @@ static void hl_device_heartbeat(struct work_struct *work)
 		goto reschedule;
 
 	if (hl_device_operational(hdev, NULL))
-		dev_err(hdev->dev, "Device heartbeat failed!\n");
+		dev_err(hdev->dev, "Device heartbeat failed! PCI link is %s\n",
+			is_pci_link_healthy(hdev) ? "healthy" : "broken");
 
 	info.err_type = HL_INFO_FW_HEARTBEAT_ERR;
 	info.event_mask = &event_mask;
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index eaae69a9f8178..7f5d1b6e3fb08 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -36,6 +36,8 @@
 struct hl_device;
 struct hl_fpriv;
 
+#define PCI_VENDOR_ID_HABANALABS	0x1da3
+
 /* Use upper bits of mmap offset to store habana driver specific information.
  * bits[63:59] - Encode mmap type
  * bits[45:0]  - mmap offset value
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index d9df64e75f33a..1ec97da3dddb8 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -54,8 +54,6 @@ module_param(boot_error_status_mask, ulong, 0444);
 MODULE_PARM_DESC(boot_error_status_mask,
 	"Mask of the error status during device CPU boot (If bitX is cleared then error X is masked. Default all 1's)");
 
-#define PCI_VENDOR_ID_HABANALABS	0x1da3
-
 #define PCI_IDS_GOYA			0x0001
 #define PCI_IDS_GAUDI			0x1000
 #define PCI_IDS_GAUDI_SEC		0x1010
-- 
2.40.1



