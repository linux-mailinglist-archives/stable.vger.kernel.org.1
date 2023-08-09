Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8290775D83
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHILiZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjHILiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1D173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4A7635A8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07873C433C7;
        Wed,  9 Aug 2023 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581103;
        bh=nu7s9AVL9NVwj9zGrmdq53KTNTXROrJ15SAZcbFsBto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWU6YoCKT0GBR9scnK0Zh6biNJLoi0OyfmnPU27jYkw2cl7CsMWCsKh8vK1IDpX5d
         BDOW4U0Ue32fonJfB1K/OwPbjYHVkivybvo5zqCYPhKWUk+Fpu61Oy7OTmgtRfszkn
         Wd7eeE0i3OmHvLiTfZYRHA26M97r2qmN52qDfW0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 5.10 106/201] drm/ttm: make ttm_bo_unpin more defensive
Date:   Wed,  9 Aug 2023 12:41:48 +0200
Message-ID: <20230809103647.350518501@linuxfoundation.org>
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

commit 6c5403173a13a08ff61dbdafa4c0ed4a9dedbfe0 upstream.

We seem to have some more driver bugs than thought.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: deb0814b43f3 ("drm/ttm: add ttm_bo_pin()/ttm_bo_unpin() v2")
Acked-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210312093810.2202-1-christian.koenig@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/drm/ttm/ttm_bo_api.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -628,8 +628,10 @@ static inline void ttm_bo_pin(struct ttm
 static inline void ttm_bo_unpin(struct ttm_buffer_object *bo)
 {
 	dma_resv_assert_held(bo->base.resv);
-	WARN_ON_ONCE(!bo->pin_count);
-	--bo->pin_count;
+	if (bo->pin_count)
+		--bo->pin_count;
+	else
+		WARN_ON_ONCE(true);
 }
 
 int ttm_mem_evict_first(struct ttm_bo_device *bdev,


