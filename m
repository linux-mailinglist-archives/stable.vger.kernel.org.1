Return-Path: <stable+bounces-110813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD8CA1CD55
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A63A16C6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1A15A842;
	Sun, 26 Jan 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g99mBbdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AA335BA
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737912179; cv=none; b=OOe6igTVThY2gSQlIr6JyH1Yca06ChgH2vnAyk5daPGEWiNJwNcfyUH3MFrB2O2H/1lHtAGj8R6htfWDOLWe8UyTnmTmGyMqp71vZBLgvcwyF6UxkOsiR5NcZJqdt+1v8d1kK94QKufwNBvo/OscHCJTD6CGkWFYRMoaqwaz2Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737912179; c=relaxed/simple;
	bh=Pg3Ohr+RdHCUUJY0BsDe82gV8f35zCBjqBDmI6g1H/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDv3HpHQPkQiKee1mqpxpsXN3IUovc3G8IsDl+zVAoSundqRdYrRNbtlmmBJZbtlqSgYMKicILxUTnzOYEjSp3hV8i6O7FFUOEnf1zzFxPr8dBJvgJvUT0PKqYqZEw7rJlsxCxvWlB0FEBQeexz2eWIDao9X88TpN4X7Tbf2xwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g99mBbdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07E7C4CED3;
	Sun, 26 Jan 2025 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737912179;
	bh=Pg3Ohr+RdHCUUJY0BsDe82gV8f35zCBjqBDmI6g1H/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g99mBbdr3yasuDv84O0I/WrTwsVCxeYG3mM9KMBtyDFYbzlaw+6aUFIeMFgo9HX6v
	 9TvspqCBNJTots3UFm7hhjqcqknUNsWEMmqDVxVr3h0tCCM8Y3M3zKkNcQxokIfovA
	 WscYyzWOYUWFjE9taxh6MTNpO3two1FJY1apKoPv0dJwihkwBHa9OFj2G7cMvLe1Fs
	 nmKxAtZiKd10fLO6tYHuOjs8BUkiCjolBhVxWES0HSEIfAZsQShc7xbsglhrRR0uch
	 Jvb1ofF53QX+mWyNVFsdVkso05w3Dd1XqrLP7sYfWwL0pKIamvW+GDb93+Apof5iCh
	 LVGnT2krJnwLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Sun, 26 Jan 2025 12:22:57 -0500
Message-Id: <20250126120810-d88a2f7cd43a8736@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250126064459.7897-1-imkanmodkhan@gmail.com>
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

The upstream commit SHA1 provided is correct: 2a3cfb9a24a28da9cc13d2c525a76548865e182c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Nikita Zhandarovich<n.zhandarovich@fintech.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e040f1fbe9ab)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2a3cfb9a24a28 ! 1:  62480a5656c9a drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
    @@ Metadata
      ## Commit message ##
         drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
     
    +    [ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]
    +
         Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
         before the call to dc_enable_dmub_notifications(), check
         beforehand to ensure there will not be a possible NULL-ptr-deref
    @@ Commit message
         Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
         Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ To fix CVE-2024-27041, I fix the merge conflict by still using macro
    +     CONFIG_DRM_AMD_DC_HDCP in the first adev->dm.dc check. ]
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
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

