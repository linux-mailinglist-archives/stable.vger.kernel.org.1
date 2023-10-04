Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14F7B8917
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbjJDSWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjJDSWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:22:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44141BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A66CC433C8;
        Wed,  4 Oct 2023 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443757;
        bh=EeD9qLZCxIHn+YabTcIdm1KXx9ltbWVhcKhMEDh7RDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGC5asEbS8nPlgT9mGJcO3L4PvcWksAzncpeltBHpnR78Zk/2C/NrV6uoucs6bD94
         bmhClPpUJ5zA2XoEoQ396Wad9zLpMr5CmW7Oq34UMPipGOPAPhKEUTRGvbReIkSkB/
         Cp8dR2lF+HmX7IvnGhWUpRnws1ZpglqHRNDiJ138=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 010/321] media: v4l: Use correct dependency for camera sensor drivers
Date:   Wed,  4 Oct 2023 19:52:35 +0200
Message-ID: <20231004175229.686620445@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 86e16b87afac20779da1228d690a95c54d7e2ad0 ]

The Kconfig option that enables compiling camera sensor drivers is
VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
Fix this.

Also select VIDEO_OV7670 for marvell platform drivers only if
MEDIA_SUBDRV_AUTOSELECT and VIDEO_CAMERA_SENSOR are enabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/marvell/Kconfig | 4 ++--
 drivers/media/usb/em28xx/Kconfig       | 4 ++--
 drivers/media/usb/go7007/Kconfig       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/marvell/Kconfig b/drivers/media/platform/marvell/Kconfig
index ec1a16734a280..d6499ffe30e8b 100644
--- a/drivers/media/platform/marvell/Kconfig
+++ b/drivers/media/platform/marvell/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_CAFE_CCIC
 	depends on V4L_PLATFORM_DRIVERS
 	depends on PCI && I2C && VIDEO_DEV
 	depends on COMMON_CLK
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_DMA_SG
@@ -22,7 +22,7 @@ config VIDEO_MMP_CAMERA
 	depends on I2C && VIDEO_DEV
 	depends on ARCH_MMP || COMPILE_TEST
 	depends on COMMON_CLK
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	select I2C_GPIO
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
index b3c472b8c5a96..cb61fd6cc6c61 100644
--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -12,8 +12,8 @@ config VIDEO_EM28XX_V4L2
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
-	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
+	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
+	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	help
 	  This is a video4linux driver for Empia 28xx based TV cards.
 
diff --git a/drivers/media/usb/go7007/Kconfig b/drivers/media/usb/go7007/Kconfig
index 4ff79940ad8d4..b2a15d9fb1f33 100644
--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -12,8 +12,8 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
 	help
 	  This is a video4linux driver for the WIS GO7007 MPEG
 	  encoder chip.
-- 
2.40.1



