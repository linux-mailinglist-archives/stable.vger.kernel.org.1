Return-Path: <stable+bounces-65103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874E943E73
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546A9283A38
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821631BBE5A;
	Thu,  1 Aug 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfn1uz1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D21BBE56;
	Thu,  1 Aug 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472437; cv=none; b=YnJLcKQ/nfnaTh/6n6U8qvrt25S1QBti835Kfk6GaifN4+KicdwM+laUAmHqIQYiycqDQRpBunYdq6hHCTn7Qewd36jQa/7uV9cC/LOs6276cC+CLFS5Kv6YQFUwmuSaPMRhYKkjg7BO+Wu+VyqUXSzsf54tfX4hZa9C7DUEwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472437; c=relaxed/simple;
	bh=nBmwXxVNR/BipxcooA5oWWjM4Mya5EnwoAAyg3qy03E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tX5YqGqQk5hiwjZ+M8vprfQpxIgGrll11HWJ9IRZtJZsD/qj9U1weiMUdPgHOXO/05IkxMu5UoJqAQxj2T9CFT/j66y3wm4+9UINIjLyDNJnjBWK7sgDT2fe8Xt5VPlMxRJGaNBM+LKWxVqUB0p0zNN50WfdVK7pc4sDXe+Tya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfn1uz1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E732C116B1;
	Thu,  1 Aug 2024 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472437;
	bh=nBmwXxVNR/BipxcooA5oWWjM4Mya5EnwoAAyg3qy03E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hfn1uz1J8HlWPQwsDr3XKTza4cj6nri07QKXNBV36SA7lFVj6JliMIdQovM0f2DYJ
	 T/+mcgtCvJGTDSQBPq87UuYoAQvwYYtko+N4vaGWvnPF7eOafdhbh4CdzNqPwHG8dh
	 epLQwes5IvgPrtPF3Db8AnibCwHNoGscOnki17yoRSdnBtFQSh5rGyqjiDXn4IgAkF
	 5f4UOYDGoi6XBBnhMEedOYbn8BIE7FC4HREvIllh2gPku5z0CWFeq3i1fJcDxPP7a/
	 o6xyBfwJl61rZfMD1zYlQpkEY35X/HwYV9IbzPhzR00hPo8IjQGc4Rl3hc4mBbaATc
	 CHcWDFUq9InTw==
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
Subject: [PATCH AUTOSEL 5.15 13/47] drm/amd/amdgpu: Check tbo resource pointer
Date: Wed, 31 Jul 2024 20:31:03 -0400
Message-ID: <20240801003256.3937416-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 5f6c32ec674d3..1175b0767e071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4406,7 +4406,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
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


