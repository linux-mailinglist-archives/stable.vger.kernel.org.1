Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DE7DD545
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbjJaRsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376501AbjJaRsu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCAA2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE23C433C8;
        Tue, 31 Oct 2023 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774527;
        bh=pUv486cStpbg6/WXiTyBBc+6BOWkqT+Xb17YjPJmQIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuUdgbXVOQUxA1GikD/jN89fVgFczf3FHApwDhqPH4RmnS/nwD6vYXx34ap2OBdqA
         jU1CSuHa1R2ngu9fgXB9jUFoOZepMs20yJuQpZ8+uGK7UHijJyYRq6YxVsbziZwRdj
         pODgUH2YdHgQ8ZSbHJeyhDznJ4fxVK4DAp+FxMHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sui Jingfeng <suijingfeng@loongson.cn>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 077/112] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
Date:   Tue, 31 Oct 2023 18:01:18 +0100
Message-ID: <20231031165903.750584232@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sui Jingfeng <suijingfeng@loongson.cn>

[ Upstream commit 4e6c38c38723a954b85aa9ee62603bb4a37acbb4 ]

drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select this
two kconfig option, otherwise the driver failed to compile on platform
without REGMAP_MMIO selected:

ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicvc/logicvc-drm.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
make: *** [Makefile:1978: modpost] Error 2

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Link: https://patchwork.freedesktop.org/patch/msgid/20230608024207.581401-1-suijingfeng@loongson.cn
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/logicvc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
index fa7a883688094..1df22a852a23e 100644
--- a/drivers/gpu/drm/logicvc/Kconfig
+++ b/drivers/gpu/drm/logicvc/Kconfig
@@ -5,5 +5,7 @@ config DRM_LOGICVC
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
+	select REGMAP
+	select REGMAP_MMIO
 	help
 	  DRM display driver for the logiCVC programmable logic block from Xylon
-- 
2.42.0



