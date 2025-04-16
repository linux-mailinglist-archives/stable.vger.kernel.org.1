Return-Path: <stable+bounces-132860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E771DA9064D
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49749168A1B
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E421B042E;
	Wed, 16 Apr 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqfFyBMA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0201B2194
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813477; cv=none; b=gHVqa3ZVk3qK7Y4Yn5Qg6Q4gHPQa7qfVaQOt6GJd8A0ZWHAwQe1kgtA09XgBvzSPlZJn73OffpxKhw3nWbZEMlkM4gQ9Y3jAoSuzz2W6rklbQ6Q3C3eKhUd3zn3B3DYOq0gt9Gr15kmO527u0EgD7VcOiKXmT9Nfv7a/r5MxZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813477; c=relaxed/simple;
	bh=jCqb0FzAnHCDHDFefXxIBuK398S6UMIhXAWEEIA527U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9d0HtyoSNeSufu/anDJPy2Dod3169DXlqYV14K4Go7SAth2G4tw6TOvaKmoGNdD4HiIkkEt9zi/52pZp+24/ut+rdCstYWQMfnfrexGK/U2IKM0AW8jpKUfnnWIVzqqLFrOxUUCxDmeGs/Ly6+wY2lc4kcs1OPeUPfy8licIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqfFyBMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA6C4CEE4;
	Wed, 16 Apr 2025 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813476;
	bh=jCqb0FzAnHCDHDFefXxIBuK398S6UMIhXAWEEIA527U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqfFyBMAqJ96aNtCEKY7qkoqBbpIfUgHoZT1GW8ilQ0DubjRBTVIFU0T1+yE1vWQa
	 pWfZb6DfR0Z0LNY/TOYA7tcFtAXEhrw/4SUVyIqxfL974rpBeivMz2Y2px/4k4TPgO
	 XfNM2mwF2hk0VTTwoLVdfrdrzGWaNLnmFhesTU+HwAisV34j3CtjVMHDuHmSF82o1J
	 3dw8pAF0hligWMdyzQxig3yWF8W1EAX1abSyX2HEv0EiKxU3ALQ9ZXEe/XXqn+QrKg
	 Ov4dtsIP70ZNkNAzCfG8sFPXlD9qtv6j/Uqt5WVZbbPq4EYu6pwPqXPYvOX5xsKLTF
	 4BnV85lfami7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
Date: Wed, 16 Apr 2025 10:24:34 -0400
Message-Id: <20250416100448-1792c6353cc256aa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416011808.388698-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: cf8b16857db702ceb8d52f9219a4613363e2b1cf

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Hersen Wu<hersenxs.wu@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  cf8b16857db70 ! 1:  47d9726408c6d drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
     
    +    [ Upstream commit cf8b16857db702ceb8d52f9219a4613363e2b1cf ]
    +
         [Why]
         Coverity report OVERRUN warning. There are
         only max_links elements within dc->links. link
    @@ Commit message
         Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [Minor conflict resolved due to code context change. And the macro MAX_LINKS
    +     is introduced by Commit 60df5628144b ("drm/amd/display: handle invalid
    +     connector indices") after 6.10. So here we still use the original array
    +     length MAX_PIPES * 2]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
    + 			goto fail;
      		}
    - 	}
      
    -+	if (link_cnt > MAX_LINKS) {
    ++	if (link_cnt > (MAX_PIPES * 2)) {
     +		DRM_ERROR(
     +			"KMS: Cannot support more than %d display indexes\n",
    -+				MAX_LINKS);
    ++				MAX_PIPES * 2);
     +		goto fail;
     +	}
     +
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: static int amdgpu_dm_initiali
     -			continue;
     -		}
     -
    - 		link = dc_get_link_at_index(dm->dc, i);
    - 
    - 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
    + 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
    + 		if (!aconnector)
    + 			goto fail;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

