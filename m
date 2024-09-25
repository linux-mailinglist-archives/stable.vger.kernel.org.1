Return-Path: <stable+bounces-77460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46250985DD6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DE8B2508E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B21B253C;
	Wed, 25 Sep 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTntR6fp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA81B2538;
	Wed, 25 Sep 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265857; cv=none; b=com6ClnPXmEkCtQTi4UEcQ146sSKa2L9ZsCBG0nR5pewKVv63EOnK8r1b45hTvb25/OUbjJq7eYaHjBisRvfLccy9JKR/5ieMgBF4UEOAOxVxcD29zvReFiqqemIaId32TjEKbFbieuV+AlBRsKqUWFvfU8sIqvrgqA/1ef7SF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265857; c=relaxed/simple;
	bh=rtPOrVSzv56Du78saVp74sOxBaoeG+hVGrm0JUALDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQbeK75UbZQilk9bt3KKJ0ViCp6LFeerLyIMKtXr87aa8GWB1NB0T6pL+FgW8pOj/b4pD5Pk70fDSvnv8m9m/JxJCVJ+ia0M0hOgF1Va2wfMIYR5wzjp2RqIMRynSyRhKr3NeS0hHam7zkwWq+nbnz9RNuW9g3obKyOdO+tzLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTntR6fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A098CC4CEC3;
	Wed, 25 Sep 2024 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265856;
	bh=rtPOrVSzv56Du78saVp74sOxBaoeG+hVGrm0JUALDCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTntR6fpKaN2rBiAmeJOYoPHTc/6wF3C8JmtbVw9c9xVDYeai1WtX6yuQNMniRNZH
	 Ctshswg0JU3+drRsYWRgwlmB5oHofFKNKxxDoNnrNHJDAj1QyQbSYp3un6l0YE1CVY
	 Jr4x6uOCRAURGfF5MOhdHp6nu7rslxH3cGXgVRAinX4GFCi6IejXfs9B5UzgeShcMZ
	 jJgSbpHkDyPO17+NAUxRODSxXCOKIn2OsNw5Igq39DX2Zl2wHsaIk10ebVLTyjmBhO
	 IYlyx4MUGTv61nu0W/IsORPxnmIt//UfcBcYCaM5BFKDEgw08Md4coCZWpPmdNyHMi
	 JGkvZ7p2DPLHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	felix.kuehling@amd.com,
	robdclark@chromium.org,
	David.Wu3@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 115/197] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Wed, 25 Sep 2024 07:52:14 -0400
Message-ID: <20240925115823.1303019-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit fec5f8e8c6bcf83ed7a392801d7b44c5ecfc1e82 ]

Before this commit, only submits with both a BO_HANDLES chunk and a
'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).

But if UMD sent multiple BO_HANDLES, what would happen is:
* only the last one would be really used
* all the others would leak memory as amdgpu_cs_p1_bo_handles would
  overwrite the previous p->bo_list value

This commit rejects submissions with multiple BO_HANDLES chunks to
match the implementation of the parser.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6dfdff58bffd1..78b3c067fea7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -263,6 +263,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_bo_list_in))
 				goto free_partial_kdata;
 
+			/* Only a single BO list is allowed to simplify handling. */
+			if (p->bo_list)
+				ret = -EINVAL;
+
 			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
-- 
2.43.0


