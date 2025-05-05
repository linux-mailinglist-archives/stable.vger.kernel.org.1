Return-Path: <stable+bounces-140376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF97AAA808
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614E31B60482
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C7299938;
	Mon,  5 May 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAsILGlv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B6295531;
	Mon,  5 May 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484721; cv=none; b=hZR6chuvDDDV2P3dKH/06skZR/+nVnSvmF1cCgk95VJa9iL6HkVUEaESwy78N71DzNo7YhZKWAuaKsRd93/B7MO9xezG/q5BmY4gasyXi/eoTlx+GKIKOVicZMQqXnWp8z467gre7zW19qOEpiGsV5dowiiA56EGclbL/Z5Q7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484721; c=relaxed/simple;
	bh=cEw4GRPiyRF77vhM1EytheB+h9yphkcLAo3dRL84tfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHz9APqNwmUR1F4arr6LkASef4n4YCwX5QjCEkVcVg9G1dnfnOJk87DCbscqzB2vXrbTga2Py5QEun2g45uyHMCmtKzGq0QtXvDAg0vTtFzUihKLSOz9SgdLKmOC9/9LfJiRPv75hoRvhwygY5gx/uY+wAXzo5XC2DKJrJqdnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAsILGlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4BCC4CEEF;
	Mon,  5 May 2025 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484721;
	bh=cEw4GRPiyRF77vhM1EytheB+h9yphkcLAo3dRL84tfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAsILGlvddD7HPbZiae2mzcOPukdjFg2b0pb1NmSPmEt0K0ybD8GTZjffO+FVvhQj
	 5ctmWAKWCZv5j8ro6brpd/xqheseCTWsD+suKcmvHlvDLUMakZZGxU1bOJpU6YjwkM
	 nm6OLGgKp1nfGB9/TMfAEmeClF0RAuMrgO5JvEqzYsMJzzGX6iruA5ZBnp0oX66rhy
	 HbjUijeqFfjhOuUhNf6it201udsqTlfsMY6+d5LHfHxGH3aZ+SEHAiuFFfsXoZLl8h
	 Q/aTVga+mIaPpySP1rTcq1GJ5gTsV54aP3A/H0LBUs5CdBzK8rYC42w/uMiiWHuohe
	 +Q0Q8/T/hfpkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amber Lin <Amber.Lin@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviwanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Harish.Kasiviswanathan@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 627/642] drm/amdkfd: Correct F8_MODE for gfx950
Date: Mon,  5 May 2025 18:14:03 -0400
Message-Id: <20250505221419.2672473-627-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Amber Lin <Amber.Lin@amd.com>

[ Upstream commit 0c7e053448945e5a4379dc4396c762d7422b11ca ]

Correct F8_MODE setting for gfx950 that was removed

Fixes: 61972cd93af7 ("drm/amdkfd: Set per-process flags only once for gfx9/10/11/12")
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviwanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 3264509408bc8..d85eadaa1e11b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -69,8 +69,7 @@ static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
 		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
-		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
-		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
+		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4))
 		qpd->sh_mem_config |= (1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
 
 	qpd->sh_mem_ape1_limit = 0;
-- 
2.39.5


