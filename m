Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF37B4EEA
	for <lists+stable@lfdr.de>; Mon,  2 Oct 2023 11:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjJBJVE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 2 Oct 2023 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjJBJVD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Oct 2023 05:21:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858694
        for <stable@vger.kernel.org>; Mon,  2 Oct 2023 02:20:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692a885f129so11599202b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Oct 2023 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696238457; x=1696843257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZEAIvCKjKxg1y/mOTHgOyfszBWrD2m6dpbpnehzSJo=;
        b=ZqfyTGpdx4cHBBaywa94Vq5fo/UHc4MRsJHY09S/5912GoLcdtLmSe3N7PRJwCn9kE
         o/uDZyntDBH4mKf/4gdLOEy0A8YUPwHkWDNmxomViV4egb5RlJVnoFTP4hBqpn4iluPp
         6gGFszHq+DwHXK3zjg0VmHzRrX0lUjBgdG+jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238457; x=1696843257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZEAIvCKjKxg1y/mOTHgOyfszBWrD2m6dpbpnehzSJo=;
        b=OCatowk8iCVIjZzxiSynNIQ9e2sLG222slg1QoZ4eLddOpleectOGZWOFF2WlfAQoF
         ea985zop8Xz+QtNn3qwLHe0KZhg3Rt2bIVegzyTntQp/60HN659Ft2KZHA2nkxyxjE9e
         pt3H1xiemGMkGVF1Dlf8DXLourRVacdTj8nkS/daiY41IR8Lrv1app0ZKzYXCklB0GtN
         0rsQa1JPwHXdPZ3Orhi9fPuJvFfAnGte5z83RguEAbey3JYTBnJLSXHAqDv0O/jjAgHp
         6VpyCZGHHv+3rwHu4K6vsmlY4Yb5qPLNYhTJHsteZ1MRbDktoxv5XORQOE2Lqn+tVEx/
         pZrQ==
X-Gm-Message-State: AOJu0YwXlzlBr0khDuFCG2VvjroXou4vk1cqmiSnZvXkDhhQ0Hpa9RY+
        RLzVj2y8W8VBZAYZrmJ6VjSI0w==
X-Google-Smtp-Source: AGHT+IH+tG+Aai4uuggMfO+rGGTM2xMUkfQN5lWyX+UpJgbKOheJR2hXD3NjLu95wgcSCgr7dLlOhA==
X-Received: by 2002:a05:6a00:21ce:b0:68f:c865:5ba8 with SMTP id t14-20020a056a0021ce00b0068fc8655ba8mr10744096pfj.18.1696238457377;
        Mon, 02 Oct 2023 02:20:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:16ed:daa5:ae8c:12dd])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b0068c0fcb40d3sm19164936pfn.211.2023.10.02.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:20:57 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap
Date:   Mon,  2 Oct 2023 17:20:48 +0800
Message-ID: <20231002092051.555479-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The MediaTek DRM driver implements GEM PRIME vmap by fetching the
sg_table for the object, iterating through the pages, and then
vmapping them. In essence, unlike the GEM DMA helpers which vmap
when the object is first created or imported, the MediaTek version
does it on request.

Unfortunately, the code never correctly frees the sg_table contents.
This results in a kernel memory leak. On a Hayato device with a text
console on the internal display, this results in the system running
out of memory in a few days from all the console screen cursor updates.

Add sg_free_table() to correctly free the contents of the sg_table. This
was missing despite explicitly required by mtk_gem_prime_get_sg_table().

Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Please merge for v6.6 fixes.

Also, I was wondering why the MediaTek DRM driver implements a lot of
the GEM functionality itself, instead of using the GEM DMA helpers.
From what I could tell, the code closely follows the DMA helpers, except
that it vmaps the buffers only upon request.


 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 9f364df52478..297ee090e02e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	npages = obj->size >> PAGE_SHIFT;
 	mtk_gem->pages = kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
 	if (!mtk_gem->pages) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		return -ENOMEM;
 	}
@@ -248,11 +249,13 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 	if (!mtk_gem->kvaddr) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		kfree(mtk_gem->pages);
 		return -ENOMEM;
 	}
 out:
+	sg_free_table(sgt);
 	kfree(sgt);
 	iosys_map_set_vaddr(map, mtk_gem->kvaddr);
 
-- 
2.42.0.582.g8ccd20d70d-goog

