Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95C70384F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbjEORbd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjEORas (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89C14909
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC6A62D2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FDC433D2;
        Mon, 15 May 2023 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171678;
        bh=b6Kv8UWszLsLNRCxxD058jg2S9x6TQ3vamFJWjl2HLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjwfB3R8I4lREJWrR5/KpIlc8+pCw8d7kZRtW9VFOYcjl0BvE/OjisWVEJW64cD0d
         iPN8HqbIvNWZ19V9Z+pk2fFdaOfF6gJmIcrPH8aWAIcR+zTJWQFjz8aJ8Y6khiGQ3+
         ZrFP/Nc+3zkDqjZsifMX7T2tloWsKy7VUojXxYps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 042/134] drm/amdgpu: add a missing lock for AMDGPU_SCHED
Date:   Mon, 15 May 2023 18:28:39 +0200
Message-Id: <20230515161704.548923376@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Chia-I Wu <olvaffe@gmail.com>

[ Upstream commit 2397e3d8d2e120355201a8310b61929f5a8bd2c0 ]

mgr->ctx_handles should be protected by mgr->lock.

v2: improve commit message
v3: add a Fixes tag

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Fixes: 52c6a62c64fa ("drm/amdgpu: add interface for editing a foreign process's priority v3")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b7d861ed52849..88f986a61c93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -66,6 +66,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -79,8 +80,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
-- 
2.39.2



