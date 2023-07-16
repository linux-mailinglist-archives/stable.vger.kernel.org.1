Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13E7553F0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGPUYn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC62126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C0660EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613EDC433C8;
        Sun, 16 Jul 2023 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539080;
        bh=PVmpCyB8+G37jg06SQNkbOdVomQvoJaDoOUPmLgFAdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nP5Bn4bXhCS4rjtfD/W+vR/iKqro4rkab3ZmB5G1aJeHWdqoViK8vqlnvZMllZT44
         v5xOwnw56a1+YhzHtI7d3DjadsrbamwSp62Z0P+gFw21FyobCc5Chxq9py802fw0HV
         JTq62Oj+72fhQNSa1DbBH039+QZ7Bb1DcyXQg5mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 680/800] drm/amdgpu: fix number of fence calculations
Date:   Sun, 16 Jul 2023 21:48:53 +0200
Message-ID: <20230716195004.919957358@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 570b295248b00c3cf4cf59e397de5cb2361e10c2 ]

Since adding gang submit we need to take the gang size into account
while reserving fences.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2eb2c66843a88..5612caf77dd65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -133,9 +133,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	p->uf_entry.priority = 0;
 	p->uf_entry.tv.bo = &bo->tbo;
-	/* One for TTM and two for the CS job */
-	p->uf_entry.tv.num_shared = 3;
-
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
@@ -882,15 +879,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 	mutex_lock(&p->bo_list->bo_list_mutex);
 
-	/* One for TTM and one for the CS job */
+	/* One for TTM and one for each CS job */
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
-		e->tv.num_shared = 2;
+		e->tv.num_shared = 1 + p->gang_size;
+	p->uf_entry.tv.num_shared = 1 + p->gang_size;
 
 	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
 
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
+	/* Two for VM updates, one for TTM and one for each CS job */
+	p->vm_pd.tv.num_shared = 3 + p->gang_size;
+
 	if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
-- 
2.39.2



