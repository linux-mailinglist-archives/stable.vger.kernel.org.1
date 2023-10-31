Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D27DD409
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJaRGv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjJaRGf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB121BE7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:04:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8720C433C8;
        Tue, 31 Oct 2023 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771890;
        bh=j0fgNlGqBJJwRkZGZVepL6jgv0UljlKuHlS3sL4v9Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H40ZnmLKY38I+2+BQeot5ajrNPLupeZMSS2Sm/D/IWlxi3iFtGHptLbJfnmjYZ6q/
         gNs/un0lXwUQi2dZk+b9/OXGxcgmmEQEDMDk9q1AUrNd9PraA6+zNNYqOt+w6bPrZ3
         n3xwGe+JEMpeZAuu36ycJu0NjVPyuD77cUVc37mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sui Jingfeng <suijingfeng@loongson.cn>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 54/86] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
Date:   Tue, 31 Oct 2023 18:01:19 +0100
Message-ID: <20231031165920.264863305@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



