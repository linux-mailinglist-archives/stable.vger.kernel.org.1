Return-Path: <stable+bounces-77260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9DE985B35
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4321C24019
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CC1922DB;
	Wed, 25 Sep 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khi01GGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC13183092;
	Wed, 25 Sep 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264860; cv=none; b=GdTpRL86AIcTnCt5cc2BQoJkU1QeNkV94/XIXJN6jiOlcQyD+QUkSfqkI9CMirO8jiKuGDWLCs7itB2FhcPnXS4RIGcKXE6XsLg/fldnoacwbCcRCT1c09CDAsPs3VdoLAtzmUkygB96XkOOQvWxFSE0HYLw5uFigEo6W1S6Ty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264860; c=relaxed/simple;
	bh=V6jOduApBvp+peAJ+82yTBPUNJPELsT1Zqt3JA7JYXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFGr4f3SUQsb9b50GGuTyCbUYTZvIV5xBhXlOxQp9k35OkCBeqFJgF0ZdWxwWbGBbkLVUXkNvW9h4mCEoeivpRNcnzlFtQWxWJJzvrWP3JVCefFmDqBvgM/56WkQux0Wba/+nSCK6bnT20eM8V4HjFS6qEwHRR8yx1vY+7MqZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khi01GGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49370C4CEC3;
	Wed, 25 Sep 2024 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264859;
	bh=V6jOduApBvp+peAJ+82yTBPUNJPELsT1Zqt3JA7JYXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khi01GGQ0bHKIHsH0IFhfpIiXGdcTrmLSmiQTT/yAGNulPynry5Be1n4dOk+AZM+K
	 3ArfPHGKBPsneNS5Od/VKN1qApfxbTUmCnztBVgAUFEAjuQBtWX6mgcmvaK2w1ehRU
	 yEFharU/qWuekj9avj9iqb47PtdGN5EIxFNfk+VYpznjiWLiE0uJfurpf9eL1zbCg1
	 rVlmm93xWCwCWP9trKPrnnoVioGDRmwGKRjRb2b3GBkAaH0dEKFvNFG1+WGWL2VOn/
	 AD3k2b5Fi4zyi/c9+pDn9jKSHqzPu38R2g5XRSfnYNYQXpd57ZzG8SLuOt7vS3aGkn
	 k73MU5k2aSh6g==
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
Subject: [PATCH AUTOSEL 6.11 162/244] drm/amdgpu: add list empty check to avoid null pointer issue
Date: Wed, 25 Sep 2024 07:26:23 -0400
Message-ID: <20240925113641.1297102-162-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 19158cc30f31f..43f3e72fb247a 100644
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


