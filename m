Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0627B87E4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243875AbjJDSKf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbjJDSKe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E09E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECFDC433C9;
        Wed,  4 Oct 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443028;
        bh=medUUxetFAkAQF905tki+I/V2xOy49RHBbUqpS2AJ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYRVT39WCIu910ZujitpNKEoB5kCLKVJ3exk7eZnVj/UwUm7FRdsyTc9Txk4scYVo
         7Def86n3ntemzdNBGO4Gq8UCqxIH72rTFYwFFE1EZOhNxOVdWUQydbCViszkzViPaM
         y/kThB26kJ6xT3nAFcRTnN77CF4nKV9+HRbDD+u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/259] media: via: Use correct dependency for camera sensor drivers
Date:   Wed,  4 Oct 2023 19:53:04 +0200
Message-ID: <20231004175217.958653244@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 41425941dfcf47cc6df8e500af6ff16a7be6539f ]

The via camera controller driver selected ov7670 driver, however now that
driver has dependencies and may no longer be selected unconditionally.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/via/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/via/Kconfig b/drivers/media/platform/via/Kconfig
index 8926eb0803b27..6e603c0382487 100644
--- a/drivers/media/platform/via/Kconfig
+++ b/drivers/media/platform/via/Kconfig
@@ -7,7 +7,7 @@ config VIDEO_VIA_CAMERA
 	depends on V4L_PLATFORM_DRIVERS
 	depends on FB_VIA && VIDEO_DEV
 	select VIDEOBUF2_DMA_SG
-	select VIDEO_OV7670
+	select VIDEO_OV7670 if VIDEO_CAMERA_SENSOR
 	help
 	   Driver support for the integrated camera controller in VIA
 	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
-- 
2.40.1



