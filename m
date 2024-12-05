Return-Path: <stable+bounces-98832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0ED9E58C2
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B502E282CAF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE7218AD3;
	Thu,  5 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjbwFCeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B221C18D
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409930; cv=none; b=VrJdNM2OAyle1Ap7a21lmOC0lLoPlXO2CULOj5UnQe7bcMPewlVl0xkFJdPzL1FF74bMuM8MIWB04jGcorSBMmWQEydvP+DbXzlcsnGw/CMW5OPQb0N43mipzuSDfu1riFVsWbFa7m1kf8A+orLkEkVldn815zC6fGJQocSFghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409930; c=relaxed/simple;
	bh=lOvB47LbGer+FOpEsEDJMeFdOokUetrDs8ow3HoeZNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s81uJj86JWaFK1NVPIFOGgeUvfyY5ORV2lfW5gTQ9MM6fFCHZVOnUTTiclvWs8qY7kjH04k2TjWpBMztm93Ce4biBDETkZln48MFg9GRTVtkSxVgZRMbon417+atAACS+onRKUD/qPozT7g9npw53MO0YqUcimzmIkvVEmZg8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjbwFCeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F9C4CEE1;
	Thu,  5 Dec 2024 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409930;
	bh=lOvB47LbGer+FOpEsEDJMeFdOokUetrDs8ow3HoeZNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjbwFCeXOea8JLNppFK3+6BxB1iFDfN9/YnF4KilGqeur7yjvtyMTieL0WO0ejN9K
	 2eR5L+RMTsAYjxTqgho1C/3K5TP9FYlIIBr8FgwWHuLT1gzLxq28Ksd/0y9x1hVtl7
	 50pbLt4FX19yLYH9CGeGzSvgeuJiJ3Sf1gmlPLIefMM2KTzazB0B/dx3CzgDNz3E2u
	 H7sp3VWzheprQKLyBFWxhOhYDzZ3xX7ni1qjMRIz0Yo46xCFMMwEfaXV08HrMEJdjH
	 ffgFgXl+lfBWpyFjDD6VnxSdf34JLuPC7kiQ87Mp6qHQxbqNN73Sj0rh5neEAR/I89
	 6Vt1PcvclIWxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Thu,  5 Dec 2024 08:34:10 -0500
Message-ID: <20241205064400-fd651772efea4f2f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205084329.1748881-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 2a3cfb9a24a28da9cc13d2c525a76548865e182c

WARNING: Author mismatch between patch and found commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e040f1fbe9ab)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2a3cfb9a24a28 ! 1:  df938a35abd76 drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
    @@ Commit message
         Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
         Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: static void amdgpu_dm_fini(struct amdgpu_device *adev)
    - 		adev->dm.hdcp_workqueue = NULL;
    - 	}
    + 		dc_deinit_callbacks(adev->dm.dc);
    + #endif
      
     -	if (adev->dm.dc)
     +	if (adev->dm.dc) {
    - 		dc_deinit_callbacks(adev->dm.dc);
    --
    --	if (adev->dm.dc)
      		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
     -
     -	if (dc_enable_dmub_notifications(adev->dm.dc)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

