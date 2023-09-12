Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABF79AF56
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbjIKVUx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjIKOIk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC35CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003FEC433C7;
        Mon, 11 Sep 2023 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441314;
        bh=N3GPBUEBj7SfhhcTAqnWlZ6igchrr4/X+PBnba5eN0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3bPT/xhhsvw2k+nQwKl+7ueDoVinOV4toakdnT2l73bbhELtAcQa9kS3IAWXK4oo
         VbAb7v/CtoPboABNYwwYxQK0sup5Iasv2UZjx8Jrf2cKMltKOAVUm22KVdp7Tz8p3h
         vbnpjYXHj1EMB7uZAB1mlhHbcNFhg+4S1Iu0QYss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 343/739] drm/mediatek: Fix void-pointer-to-enum-cast warning
Date:   Mon, 11 Sep 2023 15:42:22 +0200
Message-ID: <20230911134700.691783293@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[ Upstream commit 89cba955f879b1c6a9a71f67c8fb92ea8f5dfdc4 ]

1. Fix build warning message in mtk_disp_ovl_adaptor.c
>> drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:415:10:
  warning: cast to smaller integer type 'enum mtk_ovl_adaptor_comp_type'
  from 'const void *' [-Wvoid-pointer-to-enum-cast]

  type = (enum mtk_ovl_adaptor_comp_type)of_id->data;

         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         1 warning generated.

2. Also fix the same warning message in mtk_drm_drv.c
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:832:15:
   warning: cast to smaller integer type 'enum mtk_ddp_comp_type'
   from 'const void *' [-Wvoid-pointer-to-enum-cast]

   comp_type = (enum mtk_ddp_comp_type)of_id->data;

               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               1 warning generated.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305042054.ZtWME9OU-lkp@intel.com/
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230621075421.1982-1-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index c0a38f5217eee..f2f6a5c01a6d2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -426,7 +426,7 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 			continue;
 		}
 
-		type = (enum mtk_ovl_adaptor_comp_type)of_id->data;
+		type = (enum mtk_ovl_adaptor_comp_type)(uintptr_t)of_id->data;
 		id = ovl_adaptor_comp_get_id(dev, node, type);
 		if (id < 0) {
 			dev_warn(dev, "Skipping unknown component %pOF\n",
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index fc217e0acd45d..30d10f21562f4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -832,7 +832,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		comp_type = (enum mtk_ddp_comp_type)of_id->data;
+		comp_type = (enum mtk_ddp_comp_type)(uintptr_t)of_id->data;
 
 		if (comp_type == MTK_DISP_MUTEX) {
 			int id;
-- 
2.40.1



