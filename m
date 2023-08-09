Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC49776F0E
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 06:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjHJE2W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 00:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHJE2W (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 00:28:22 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E41702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 21:28:22 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qTxHY-00EOtu-E0; Thu, 10 Aug 2023 04:28:20 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Wed, 09 Aug 2023 12:25:54 +0000
Subject: [git:media_stage/master] media: i2c: Add a camera sensor top level menu
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qTxHY-00EOtu-E0@www.linuxtv.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: Add a camera sensor top level menu
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Thu Jun 15 10:29:07 2023 +0200

Select V4L2_FWNODE and VIDEO_V4L2_SUBDEV_API for all sensor drivers. This
also adds the options to drivers that don't specifically need them, these
are still seldom used drivers using old APIs. The upside is that these
should now all compile --- many drivers have had missing dependencies.

The "menu" is replaced by selectable "menuconfig" to select the needed
V4L2_FWNODE and VIDEO_V4L2_SUBDEV_API options.

Also select MEDIA_CONTROLLER which VIDEO_V4L2_SUBDEV_API effectively
depends on, and add the I2C dependency to the menu.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: stable@vger.kernel.org # for >= 6.1
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

 drivers/media/i2c/Kconfig | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

---

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 694afb85acb9..eef5e872a824 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -25,8 +25,15 @@ config VIDEO_IR_I2C
 # V4L2 I2C drivers that are related with Camera support
 #
 
-menu "Camera sensor devices"
-	visible if MEDIA_CAMERA_SUPPORT
+menuconfig VIDEO_CAMERA_SENSOR
+	bool "Camera sensor devices"
+	depends on MEDIA_CAMERA_SUPPORT && I2C
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	default y
+
+if VIDEO_CAMERA_SENSOR
 
 config VIDEO_APTINA_PLL
 	tristate
@@ -810,7 +817,7 @@ config VIDEO_ST_VGXY61
 source "drivers/media/i2c/ccs/Kconfig"
 source "drivers/media/i2c/et8ek8/Kconfig"
 
-endmenu
+endif
 
 menu "Lens drivers"
 	visible if MEDIA_CAMERA_SUPPORT
