Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78475D3C7
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjGUTO0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGUTOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4181FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE01961D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF47C433C8;
        Fri, 21 Jul 2023 19:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966861;
        bh=hF0LBqH7kV4ZCw0aOxjAAgFkZICcfdBDN9LHLMxl5bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4WGbSGvcj1v2ormfuMBiRr4bSlZ5BX1azWyscpTYTty3MoagvrgbDTgxVOUaOp1J
         f860iAxIksswJSNh5ikS0JRC6URMj/wrMiiFZzRWsAEbEg044FHZmgXNTElUtVfoYy
         l9VJdoUTCoIrGxINFQwU3w8JiiAUykazyRwCgGWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pelloux-Prayer@vger.kernel.org
Subject: [PATCH 5.15 493/532] drm/ttm: never consider pinned BOs for eviction&swap
Date:   Fri, 21 Jul 2023 18:06:37 +0200
Message-ID: <20230721160641.290395554@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

commit a2848d08742c8e8494675892c02c0d22acbe3cf8 upstream.

There is a small window where we have already incremented the pin count
but not yet moved the bo from the lru to the pinned list.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Tested-by: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230707120826.3701-1-christian.koenig@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -603,6 +603,12 @@ static bool ttm_bo_evict_swapout_allowab
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
 		if (ctx->allow_res_evict)


