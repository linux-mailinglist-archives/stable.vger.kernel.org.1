Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADD7034CF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbjEOQwd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjEOQwH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FAC4EC1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A24B962998
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D43DC433D2;
        Mon, 15 May 2023 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169525;
        bh=Fy1TiHkbTaEi1fw06xSCWC0V11qSGjZg9LOrFxrMTOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjvBAVUMziIc9GiBgy8nzDj7ZvjlIHb3M6OOvzDXWycVKNp8zaUlnjvSRoDWcjOY8
         T9XOBWlUUJkYi9INpGt7Thx6nEfaCDClbxbF5l8/eK/m51Ww5+PDP0V5nI94eapNkl
         1MNqlinCgGRZSFc4ZUpW1XH906QlaDLHhhOtCfeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 084/246] drm/amdgpu: add a missing lock for AMDGPU_SCHED
Date:   Mon, 15 May 2023 18:24:56 +0200
Message-Id: <20230515161725.103866601@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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
index e9b45089a28a6..863b2a34b2d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -38,6 +38,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -51,8 +52,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
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



