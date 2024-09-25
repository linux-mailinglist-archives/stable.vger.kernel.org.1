Return-Path: <stable+bounces-77632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9B985F54
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED181F24A50
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68F223124;
	Wed, 25 Sep 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu5KZTdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DED223120;
	Wed, 25 Sep 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266525; cv=none; b=Nau9mxcQOYGpa1ICV9UGl7M9syI3TZTtlRO1ab/lraldDkCIAI7Lx8Y7tbWiC253r/G0vJuGbN3i1fcHWtliH7iTXm9AnzjSyW7xkEndx1m5atD+E+OXb3YGkiRPfFypRgzDklzXmQKXdkikLiu8RvnuZisAvaPy0/inOpOJ8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266525; c=relaxed/simple;
	bh=CYajmbx9prw2S0Ak/5/EIouMep9LYASd91oKa/eiWcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsuWfFm8eMnmKFE3MKxJxuIXYlHsXrHVNyAu0CP9sfp5anNNY5MviXzu+3pEcfV3VbcfTU7CAPJqOzpirRDIoXWT76C9C01Akai//W5INhr0C4EucpK8a5rySzYISFvdByjQdRyzRwR9VOxe1JrwTY5EjBNenx1ZOfQDI6TgWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu5KZTdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6368EC4CECD;
	Wed, 25 Sep 2024 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266525;
	bh=CYajmbx9prw2S0Ak/5/EIouMep9LYASd91oKa/eiWcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bu5KZTdfJ3ZZ+u0QbhLBOtxjjbg8xd/QmIR39bk+VfSAyNDw+lG7mRKoahoPnIsz5
	 7qCI6/bpLhwlBCZ/cI5PiRL2oj27/OSXlaPUZku2b9SZWnTewk9bYYDxRgXq19sRS1
	 IiURgiDL4wvtKUTkpe7FrczwBMTAX5hoUwexyHrDhffiWixiUvt+FY4LMA0qw7ZLbC
	 rdBJN58SAl+VdHCTt1AeAnUh77adL6Tu0viQEAVjtuolvPN7bYp021ZowiBM8HPlj+
	 YlGKoDurrynSHn1LtzxdzD8cO/XMqevr5OBeJzgZKZai+KxbxpdiUkGXnSjQb6GL6H
	 zB8EAZ/nk80/g==
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
	srinivasan.shanmugam@amd.com,
	David.Wu3@amd.com,
	YuanShang.Mao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 085/139] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Wed, 25 Sep 2024 08:08:25 -0400
Message-ID: <20240925121137.1307574-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index e361dc37a0890..7abcd618e70bd 100644
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


