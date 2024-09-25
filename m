Return-Path: <stable+bounces-77232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647F985AAE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966C81C23585
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028C18E04A;
	Wed, 25 Sep 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQcqV81c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD418E03E;
	Wed, 25 Sep 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264665; cv=none; b=XSNFFHae9Unamd+R+bVJTkRQuD5on4OvMHg0VEWi39pMTc6gCkG8tOXRYbC9NuPZERp4Mj2S/gjblKNjF2/tieGqdMmGxIOGEvtUkD0EEQ9iwuVFQ9RBUz0iuzVU0KafpW7QjmepF2XnJegKZBBQDMp7C+yIDTDWR16aLTCFxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264665; c=relaxed/simple;
	bh=rtPOrVSzv56Du78saVp74sOxBaoeG+hVGrm0JUALDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGvAy9zuzmVFaQCMc1J+k27U5RFPP1AnTyxyTAzCnAd7up8gGqSOo++eUHW3epQ80GkYvXJc1gQ7RR1/e2HBOto0nYypuKleHFWwJR2RJFnKvNOYogmZHzfPTHRV7MGQLvjLnCdh1YI2ViYGg6cTYtYuSVzWORqefysfr/LpTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQcqV81c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F214C4CEC3;
	Wed, 25 Sep 2024 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264665;
	bh=rtPOrVSzv56Du78saVp74sOxBaoeG+hVGrm0JUALDCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQcqV81cN8LFZtwtnvBjQmAXXrFcC7oWXBMbNZgdNeTzPQk6SuZSvpEKn0cnjO2a8
	 wl3q8yKULfCpnnYKTNvuMNXK1nVgmNle3TVtSVSpg3XdCnGcde8ak4EMUptmrnz6Dn
	 ZpaNFxaBQAi6RNy+P+kO5Icy9E05OYtcy1/jM0Nhc/ZBAM1MMsFFfBXtMxA1hzZGn2
	 9VOV8nRrmGFeXRlHvGCo1TrZ7m6mnOWnMAzBnAiOX8gjeWldUA5jYCaxBhEEI/5YPV
	 m3IFo71INpPc9jHxh1sSFyBn6/8W2OlS17ncC3JVM9lnxLSQSbg8OpDoJWIHZvjTKp
	 uiJ45Wmqswheg==
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
	srinivasan.shanmugam@amd.com,
	David.Wu3@amd.com,
	robdclark@chromium.org,
	YuanShang.Mao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 134/244] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Wed, 25 Sep 2024 07:25:55 -0400
Message-ID: <20240925113641.1297102-134-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


