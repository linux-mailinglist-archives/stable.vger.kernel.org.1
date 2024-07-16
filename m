Return-Path: <stable+bounces-59478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3037932925
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D869283F7A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027DC1AC431;
	Tue, 16 Jul 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZYF4n5l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D921AC42B;
	Tue, 16 Jul 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140181; cv=none; b=PnheKwOyTLE393VZMq3Twy4Q+hNptS8V3fLQUdIIc0LyEpiNaQye/udxeIz4vTdSA4BBCa+ATWNff+X1JuFkS45gRNKnTFzA5A7sFYgBExY2g7cTN2PG3M1ta75V2NoT0CVaHFbASjtE5OvIMoUz4NU5j614tZfxIsb2wflif5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140181; c=relaxed/simple;
	bh=AKf2/St0vql7ngfPNNpPADDQZGaecaGuzCCmRFBcmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnwf22oJuo8oX9riS8x9TELnbGsXOAxpU/asYukGSgPdsHqQXeukgLNqVs/mDTzL3VWgSpnbKvrm8D2de2NmgH7/HQaSiptPVSLenKFlXtt69PrPxUlfDLpRF/v2uGU9ohjyBsklv27J9Wqt8uTOk8wN7Aqci6StOmXU2LM4t7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZYF4n5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A6CC4AF0F;
	Tue, 16 Jul 2024 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140181;
	bh=AKf2/St0vql7ngfPNNpPADDQZGaecaGuzCCmRFBcmqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZYF4n5lg348eFUS85pvNhrp0I0VYogPe54kGzomr0XB5E4ytk1rNHtYmX6yBCU32
	 3a9NO7JXeaZsayWvnFuGXice45m1SXzaTA88CBwAFB6jlQk257rbTMyEaRL+PAle/A
	 B/aFREH55nHC9Acf8FxolT1wOn0C31DJkT2ZojqaG2QPyjfTLIVbdzK+SPRzX1DHny
	 1jc9srQWTrpswQtRN89OnIhMB7aLJAPp8F9JHj8E2xB8cjYgroiUduwZNS/zoNJTEQ
	 OyfRzJRqoeEZSwBo+U9ndSEHGeq+C3DtcyEdOgw7rMbCuQvQAHeM7AJ1M3CfENQuhn
	 gZpEQSSbvvLpA==
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
Subject: [PATCH AUTOSEL 5.15 7/9] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 16 Jul 2024 10:29:09 -0400
Message-ID: <20240716142920.2713829-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142920.2713829-1-sashal@kernel.org>
References: <20240716142920.2713829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 57218263ef3b1..277a313432b28 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -653,7 +653,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.43.0


