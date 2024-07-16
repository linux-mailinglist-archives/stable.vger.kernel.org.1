Return-Path: <stable+bounces-59467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A122B932909
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F640281567
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1281AAE35;
	Tue, 16 Jul 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbEIkrD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3851AAE2E;
	Tue, 16 Jul 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140138; cv=none; b=HfRIg1LWLTVc30bzcXNsPjjLM0/WsplPKV8LUXPgSUsjMYmgisUHyzCQXeduGs577xkSvQ8/TO8l2kmpD0JorFrnAkZ0zlAaWlqD9RIRsHgOMH/TLmC0x2Z/5UUBleZ8D4pngsm17joj/8pf1kcubXRe0vSmmZjzpe6zmxuPQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140138; c=relaxed/simple;
	bh=whL7mCH91MoYnM/lgeCnr4BW103X7PUAJfCwdrpcwho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY/0qpMgWu8fVyOLPx3+PcPEqW/iPcsC/JSVqYfp+TbXH7CEuf04u/hExLZkmPqZsP4QkWV1mN09AHUPO1InRI7wXrHbjkPJ6LJHApXGtA2shCdQMbDWdt/d5gDSFPfG2VTaPwseQksL/skYE/5ktUDtw+cOvwblMJzg9BF7I1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbEIkrD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870EC4AF0D;
	Tue, 16 Jul 2024 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140138;
	bh=whL7mCH91MoYnM/lgeCnr4BW103X7PUAJfCwdrpcwho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbEIkrD9g1BnlxA1fy861MzyVF7H/VrzAovirZVu3wUpArFOJq3LXwAjXX9VCsGs8
	 2vwF3TOfY0Lx9GiRAKumzS7hy/gLW9+jI+tqKHEY3nehE3ZiQAEVhw2JjZ6GGtavah
	 CKvvbzqJiHdiFNjlKF77V9ryg/msn48Zg/oLSRl/RjhkPhB75Fm8BR6Wl4X3SCapuE
	 HEkT5Tgwv8TX3bcff3U7VjAZ6K+bNPfX8VCMN+yXX+UZtx9bqZidOG9yW4aZyBWltO
	 Xfdq3UkYgN25Xkd06fR85FOArSoRWXdwRzyupZEp8IQumY9HTrnFMrx5o6mcNWVAWd
	 gxncLWP5OJMvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 11/15] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 16 Jul 2024 10:28:08 -0400
Message-ID: <20240716142825.2713416-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 ]

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 75d79c3110389..3388a3d21d2c0 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -657,7 +657,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.43.0


