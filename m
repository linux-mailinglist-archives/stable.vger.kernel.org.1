Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603273E898
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFZS1Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFZS05 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721CF171A
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D18860F1E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15593C433C8;
        Mon, 26 Jun 2023 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803998;
        bh=VoCyN92JMw4IzOJxg/gH06Ss8/ZSL0OYhFeq2csDpCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZVa6Pd8Rm6dnfPx5NYDbhDazADVDWUjkA2gqra0k7fBWmA71fGNUSbabqShCx+D3
         DlmXeQl0DH0HUv5q5ZT1R68IE4Mk3fYzZLY/2iO1VeoqqPB+MZ/8xw14s/VADgAT77
         qomXsh2hwzGssfGwennoiowxbvM/hU1WqvWaFkWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Inki Dae <inki.dae@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/41] drm/exynos: vidi: fix a wrong error return
Date:   Mon, 26 Jun 2023 20:12:00 +0200
Message-ID: <20230626180737.649452010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Inki Dae <inki.dae@samsung.com>

[ Upstream commit 4a059559809fd1ddbf16f847c4d2237309c08edf ]

Fix a wrong error return by dropping an error return.

When vidi driver is remvoed, if ctx->raw_edid isn't same as fake_edid_info
then only what we have to is to free ctx->raw_edid so that driver removing
can work correctly - it's not an error case.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 19697c1362d8f..947c9627c565a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -480,8 +480,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
-- 
2.39.2



