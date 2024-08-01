Return-Path: <stable+bounces-65044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D61943DCA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735152856ED
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893B18B49B;
	Thu,  1 Aug 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0QIgmYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377018B497;
	Thu,  1 Aug 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472156; cv=none; b=LspXDiQ6Yohi+uCZUvGb6hR7Y1XEr9bCWh+xTR3k7+EvQg/O46GEVuJ87ZUV3TzibeQs9UWML39XvfqVgKZsM936vWG829sCpakb0QX7UIIHOEtiXLH2KNgznGfGwwJ28Xgs2d+DLEb2u+Ifam6IN7HJRMrONTy+4jJCtPzCpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472156; c=relaxed/simple;
	bh=k0rf7HW6K+qbpczV6o68gQEfRTAOxsNCV5V4S6ciVJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWxUQnA5Rh7r6Elgxq6SWpUZgX1v60XGOpE3PvsDJ5FZIUwuHdKnwEdpqum2Wkw+AbWt/M37/YP0UDShIAepDRw8i3lLIBKzHccC/QPdX4fUEmBs4cc99EpqdFa3OV0fnFTjwI+K+zq7z1+io9/vuUMTelbbWYcmkaBDdHH1Qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0QIgmYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB26C4AF0C;
	Thu,  1 Aug 2024 00:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472155;
	bh=k0rf7HW6K+qbpczV6o68gQEfRTAOxsNCV5V4S6ciVJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0QIgmYxQn6UwYVMFhHBLP7greBhrWuFZuyz7HK8OolOeuR9JOuz91hCpdnGeCVn6
	 tkCOa9wRzPeZ4VxCmje06L98hFVJJd4kVqipmdqMY3/x33OlmhYeERRsYqf1NpgWp7
	 1PiHqa5rNEG7wB3fnINOsjHwoltmP00SR6G4zQlNIhq3kymvAd0hezpUE8EPECcz6k
	 6Ed/GgwFuk6Mx7ZBzQn4H7TRN3dQooF0j8ArxwJK7Vcu/ulUAz4czj7f+cBebAnQEN
	 0UtjfagPLspFF0SnQp1xr1OYDqKk+VUHExVyNOEb7C+L9grLabaPl4QkM01XctWun7
	 qounSX25lGoEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	candice.li@amd.com,
	Jun.Ma2@amd.com,
	victorchengchi.lu@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 15/61] drm/amd/amdgpu: Check tbo resource pointer
Date: Wed, 31 Jul 2024 20:25:33 -0400
Message-ID: <20240801002803.3935985-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 6cd2b872643bb29bba01a8ac739138db7bd79007 ]

Validate tbo resource pointer, skip if NULL

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 157441dd07041..98ed116b5a48e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4559,7 +4559,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
-- 
2.43.0


