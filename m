Return-Path: <stable+bounces-77479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999C985DA3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210BB1F24DE9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA401B3B31;
	Wed, 25 Sep 2024 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiAgALf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5718C344;
	Wed, 25 Sep 2024 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265974; cv=none; b=o4kc+6YVYR+LPzcMz0L04f9V82WcDw8bQn58H5sWPWSHk6dOZhWkUHeeyK0QqnWYnAdYqzkThYHR/07jqOwNOTcBHb2TDA3DsgE30kV3u1v9+TsbseCoObotzFzwCFK9/B4LAAFMPuOOaNcJt5aV67lqgG5P+1jqkzllTIow71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265974; c=relaxed/simple;
	bh=HKyQQwQXqC934qpnYwhQK2yV8yYAIvsvzhH8wsD/nrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoDAnTIKeX5wzTkOxlpdjKLEXMy6ycoaYID0gsCSmbmM6LwJQO6Vx7mCOHoyY8q661Yfn+btnNrGpsqLCSTHsLUi7kNrkC1hFtBZVoBvjJueNMWKbEilF42d06mU1i88MdghsKWTPhUFaH3xkVreiI950qPf73qcj6i92kRodxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiAgALf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A297C4CEC7;
	Wed, 25 Sep 2024 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265974;
	bh=HKyQQwQXqC934qpnYwhQK2yV8yYAIvsvzhH8wsD/nrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiAgALf/YKRpld4puIQYU0f/TRAhU79lW99o+dGSvLLEE421qpDWCwpMZP4OP/sLi
	 ilLMYS9Odhyc3AOR5hFiFgmus2MiQXMnbISpTEEdjHk5ewTI6LPSKbgBUEbTzltcNP
	 MqDKDLlFXA0/6nUaFEh4ZRvAaUOKTUyRAnc0ivS0i0EuVa/BNcp5qDRb+tnMWuqQn7
	 tcdq3J4ip2rfW1IRF4HLMblqUfzUzed/0lu9L5mYzP4PMlmPZhe9B3jFeRZgDi4U1e
	 spRdmxfUJMoGHZq3Hz2+UHcq6Ngl3TqvVM26+3ObME0JyE7JP5QvSQaaGINPQ0abLR
	 TyUSLvxT9Hvvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 134/197] drm/amdgpu: add list empty check to avoid null pointer issue
Date: Wed, 25 Sep 2024 07:52:33 -0400
Message-ID: <20240925115823.1303019-134-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 4416377ae1fdc41a90b665943152ccd7ff61d3c5 ]

Add list empty check to avoid null pointer issues in some corner cases.
- list_for_each_entry_safe()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 9baee7c246b6d..a513819b72311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -80,6 +80,9 @@ static void aca_banks_release(struct aca_banks *banks)
 {
 	struct aca_bank_node *node, *tmp;
 
+	if (list_empty(&banks->list))
+		return;
+
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
@@ -562,9 +565,13 @@ static void aca_error_fini(struct aca_error *aerr)
 	struct aca_bank_error *bank_error, *tmp;
 
 	mutex_lock(&aerr->lock);
+	if (list_empty(&aerr->list))
+		goto out_unlock;
+
 	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
 		aca_bank_error_remove(aerr, bank_error);
 
+out_unlock:
 	mutex_destroy(&aerr->lock);
 }
 
@@ -680,6 +687,9 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 {
 	struct aca_handle *handle, *tmp;
 
+	if (list_empty(&mgr->list))
+		return;
+
 	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
 		amdgpu_aca_remove_handle(handle);
 }
-- 
2.43.0


