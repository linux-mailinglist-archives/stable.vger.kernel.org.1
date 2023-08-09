Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52685775D2D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjHILeh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjHILeh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE1173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40BBF634AB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEBEC433C9;
        Wed,  9 Aug 2023 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580875;
        bh=Ih7jwljwqF7FHpCt1QpekAWEWE+1zbGA+JXF/GwXh9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piNPcD1AMFa81ER4QiJnlAKS3cAxyylpnwR9M0ph6wSE/16GJucUOovrTyS/cSXqY
         hJI8hAf1OiS9LOx8JvGcr+r5a+yx7SqH0xXt6mWI/eECc9pvW7fpNrIMP/m4hpS/bn
         UaAkiX2mmXV6XQjjz9gDCgeU+174g699B8slndNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Pelloux-Prayer@vger.kernel.org
Subject: [PATCH 5.10 018/201] drm/ttm: never consider pinned BOs for eviction&swap
Date:   Wed,  9 Aug 2023 12:40:20 +0200
Message-ID: <20230809103644.436934371@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit a2848d08742c8e8494675892c02c0d22acbe3cf8 ]

There is a small window where we have already incremented the pin count
but not yet moved the bo from the lru to the pinned list.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Tested-by: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230707120826.3701-1-christian.koenig@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 9a05caec3c996..dca4dfdd332d3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -672,6 +672,12 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 {
 	bool ret = false;
 
+	if (bo->pin_count) {
+		*locked = false;
+		*busy = false;
+		return false;
+	}
+
 	if (bo->base.resv == ctx->resv) {
 		dma_resv_assert_held(bo->base.resv);
 		if (ctx->flags & TTM_OPT_FLAG_ALLOW_RES_EVICT)
-- 
2.39.2



