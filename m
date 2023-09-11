Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226279AE79
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjIKVjf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbjIKP0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AADDB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE6C433C8;
        Mon, 11 Sep 2023 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445960;
        bh=mVt+hq8/arJHJ+WuFOzhCbGD2vMbJ/KocM1hO96spjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7ieBuYeaHfFh02eLtrAGw5zklQ9eqECpgKLTt590HjE0nlmhlM3PDrBUgskg5mhu
         99HWBfWtnm0rGmS7RI2s+b9XabKe9Z/UoSRCR1tPptviQUYPlL80ToP6NQvgPHk/D2
         4+B9VrKieVW/JMgqfmHmKIzH0O8Xxp0+B3ZuEI08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 6.1 532/600] media: i2c: Add a camera sensor top level menu
Date:   Mon, 11 Sep 2023 15:49:25 +0200
Message-ID: <20230911134649.331851699@linuxfoundation.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 7d3c7d2a2914e10bec3b9cdacdadb8e1f65f715a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/Kconfig |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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
@@ -783,7 +790,7 @@ source "drivers/media/i2c/ccs/Kconfig"
 source "drivers/media/i2c/et8ek8/Kconfig"
 source "drivers/media/i2c/m5mols/Kconfig"
 
-endmenu
+endif
 
 menu "Lens drivers"
 	visible if MEDIA_CAMERA_SUPPORT


