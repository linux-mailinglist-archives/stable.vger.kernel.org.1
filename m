Return-Path: <stable+bounces-124818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523EA6777A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2829918986E7
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA620E700;
	Tue, 18 Mar 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw6xCORL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6520C026
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310766; cv=none; b=Ox5x6u2ZItBqdLvs9SHQHCO79Dc1HejaSTAEhTwGLS+Ma4cUShtr77igtCDuWvalBLPXp9PXY3UlOG5wV0FC7VxRbpjoWIS44fTAAiGmuGLmimQvdKAXgu1c1nGE34L+b+x0Vt/UiHJ2nO79/9aLHX77ZBZcnm4RbANSFXJU474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310766; c=relaxed/simple;
	bh=Yhd7Sep0+hhlQ+E3wFT8CG9z72ktojOuKMiRVDMIm+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slU5F7eF/VVXJYTU7hsHTLv+I97VVWWfp/PDyHdYP+GszlvdIejDTS+8hSlTFw06PiLDAgMz8MbwijKqRKYfyxNNfF/W3SuN2PKZaP7939A3zGN9dWvCK+8hcKPJcsVWzx9nvGAg+dQWFXvcJuDniAnHIWleo40h9jNNceJ9t8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw6xCORL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EEC4CEDD;
	Tue, 18 Mar 2025 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310766;
	bh=Yhd7Sep0+hhlQ+E3wFT8CG9z72ktojOuKMiRVDMIm+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hw6xCORLojvXCfqnoiZjAMAhBh5/miETHF7BtiNQJFGb9vn2OxolLRPlUOYvajo66
	 FiCUN9gvhk6+t4y8BhGQ6+1aAcbYUyAGckMmKJqzqpry7rPQ2ppPz5oTKD6UkYNQHZ
	 aSi0Bhcp8y7nLdjVRh3cf70dI23PW2sIbCqWl3hikYZbS62f37jzeDXEYkxnO67qz7
	 4uz7BA8ktTFtFApL7zxLAVdDS7dANmkTi+PwQN1v71MN6fZp0Zv1WykkKs2g/y4bE+
	 phoLthZy2DvWndSB5BEBSXqEq+Egd73Dk2v0/XUO8EP7SOgCGmLWJhP7Vj83MhCdWP
	 BF0goECIS0M+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] drm/amdgpu: Fix even more out of bound writes from debugfs
Date: Tue, 18 Mar 2025 11:12:44 -0400
Message-Id: <20250318073731-5c9c07007337378b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318091310.815185-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 3f4e54bd312d3dafb59daf2b97ffa08abebe60f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Patrik Jakobsson<patrik.r.jakobsson@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  3f4e54bd312d3 ! 1:  8c3a806d075d2 drm/amdgpu: Fix even more out of bound writes from debugfs
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: Fix even more out of bound writes from debugfs
     
    +    [ Upstream commit 3f4e54bd312d3dafb59daf2b97ffa08abebe60f5 ]
    +
         CVE-2021-42327 was fixed by:
     
         commit f23750b5b3d98653b31d4469592935ef6364ad67
    @@ Commit message
         Reviewed-by: Harry Wentland <harry.wentland@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         Cc: stable@vger.kernel.org
    +    [ Cherry-pick the fix and drop the following functions which were introduced since 5.13 or later:
    +    dp_max_bpc_write() was introduced in commit cca912e0a6b4 ("drm/amd/display: Add max bpc debugfs")
    +    dp_dsc_passthrough_set() was introduced in commit fcd1e484c8ae
    +    ("drm/amd/display: Add debugfs entry for dsc passthrough").]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_phy
      					   (long *)param, buf,
      					   max_param_num,
      					   &param_nums)) {
    -@@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
    - 		return -ENOSPC;
    - 	}
    - 
    --	if (parse_write_buffer_into_params(wr_buf, size,
    -+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
    - 					   &param, buf,
    - 					   max_param_num,
    - 					   &param_nums)) {
    -@@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
    +@@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
      		return -ENOSPC;
      	}
      
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_dsc
      					    (long *)param, buf,
      					    max_param_num,
      					    &param_nums)) {
    -@@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c: static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
    - 		return -ENOSPC;
    - 	}
    - 
    --	if (parse_write_buffer_into_params(wr_buf, size,
    -+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
    - 					   (long *)param, buf,
    - 					   max_param_num,
    - 					   &param_nums)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

