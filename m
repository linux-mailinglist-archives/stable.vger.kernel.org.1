Return-Path: <stable+bounces-132854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3907A90635
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B9E19E1E82
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D4205AD2;
	Wed, 16 Apr 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv/MRk4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D5205AA3
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813024; cv=none; b=OTL8ZEUKUwx66J1aF/kj7RtdUMIHstoHwY2Mu7dpMLF4Cmq6VCxUzoluFL62I5dIV6ExXrTC6PARurY3ByHKV/IKAvBCleRUZ0Eo6cJKAo2aRAcCPWInjYHHsXkrjHTklY4qD/nHQj7CLegJodjFkwrlxkjFWWwh3jVVmL4dCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813024; c=relaxed/simple;
	bh=uqLdQEMGWrzA7cPcoAGH6t1n1kuQR4FUecw4MylpbxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzeNZkvfF4WU4EnJt35Jt4/dDP6QeSreVn7WW9FW+ILLrodqSCw5VAn799Sx9zgHxZXnx45lStyqGeep4KLNIum1GdWhHresNlmTU37jODIZMjE573WgX+XfrDI6BsiykgXG9fiyB4MXnZnIow3Kdo9hp+Nqi15sg5jEEw/pjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv/MRk4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106CEC4CEE2;
	Wed, 16 Apr 2025 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813023;
	bh=uqLdQEMGWrzA7cPcoAGH6t1n1kuQR4FUecw4MylpbxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qv/MRk4bqfxaEBDTObjfDf9fv/gVwKD8MOl7C0z7XI6Be9R/1o1IqnkeWKaakBxhZ
	 ubOf7ZT+iXknXFEuXhph2iy/inwK61GAekw+pyRjiLICUCJi67icnAoqyyZHEBWpy5
	 QiXWIvhnarutLmbHhFqY1IHAaBDz4+1vajpV+NMctQsUdfFbZREYIpaWw80v9yg7f+
	 6OKEQuY7NACsOK1DSb2DtJzo1mImOAhakfw34jOVPuKtnVdZExZVZ4Xl6paWmwKIO9
	 Pl7bKO+WkVWAm9c1MovFjX5RvyLMBwabzxDW6rESWZuT0is8Hd80Fs/He09TZkIft2
	 6ZLqcgjngCFew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
Date: Wed, 16 Apr 2025 10:17:01 -0400
Message-Id: <20250416095217-4731dca943695926@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416011721.388632-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  cf8b16857db70 ! 1:  42bf554df2682 drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
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
      		}
      	}
      
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
| stable/linux-6.6.y        |  Success    |  Success   |

