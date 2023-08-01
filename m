Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C476AD0B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjHAJZo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjHAJZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74530CB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1757A614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFFFC433C8;
        Tue,  1 Aug 2023 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881849;
        bh=KLiV0EFTD7wFFcDB+KeO9xC/kKrt3pEEnLWxbgM5Mrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cpbh93KTwr78WTxQrEOnLkr2vxUYgtrFfdJUx9X4w9EkTDW6WNfN+jUri284ACGQ2
         9E68dZiQfuNs1wreR3cxH4hIegApLlYfAluJXeC6xBaOELtvQY7RjpbdTL1hs9r1fB
         NwqIe0cRj+aFnvt+b2rVu6ubsl+ntlRcKMVdxDsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 022/155] drm/ttm: Dont print error message if eviction was interrupted
Date:   Tue,  1 Aug 2023 11:18:54 +0200
Message-ID: <20230801091910.998421425@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit 8ab3b0663e279ab550bc2c0b5d602960e8b94e02 ]

Avoid printing an error message if eviction was interrupted by,
for example, the user pressing CTRL-C. That may happen if eviction
is waiting for something, like for example a free batch-buffer.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230307144621.10748-6-thomas.hellstrom@linux.intel.com
Stable-dep-of: e8188c461ee0 ("drm/ttm: Don't leak a resource on eviction error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d5a2b69489e7f..cf390ab636978 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -557,7 +557,8 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	if (ret == -EMULTIHOP) {
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
 		if (ret) {
-			pr_err("Buffer eviction failed\n");
+			if (ret != -ERESTARTSYS && ret != -EINTR)
+				pr_err("Buffer eviction failed\n");
 			ttm_resource_free(bo, &evict_mem);
 			goto out;
 		}
-- 
2.39.2



