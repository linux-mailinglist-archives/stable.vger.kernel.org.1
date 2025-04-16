Return-Path: <stable+bounces-132859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE8A90658
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06120188A2DF
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13A1ADC67;
	Wed, 16 Apr 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBslEDhN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF61AC892
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813476; cv=none; b=Ap6y7uxniGfd3fMDLo369et4U0cVO0KcXLUOSbeozU1sRFgz+NEop6O7jhdQGJgCGJrIREexZQGTMrUovMI5TSeN43rsy2DhIR2IwAg30MOPl69+zA2M07+l6g/etZWou4QA1KX6qcTA6+8IUsqo7hKueH2i7KnpeUvgr41jrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813476; c=relaxed/simple;
	bh=ocU1vJNyqApCdp/OhYvVAEX6I12YQCJDinzTJcYWbsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvTtdDOCNuFEp+3OwsJOVdFPZIkJbI+mlDNStG/GxA9Ig7b9YZMFdodiFCuUoWKeONciTUlrHt2fm1YeixVlrGZs5wIEXrDSBOpTHOOO8MkaIcCOgl0UOlPuGMTNzJPVHYj8yzJjXzinNFEzuAw0k797A1xG4/xa6/nXL+65rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBslEDhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016DEC4CEE2;
	Wed, 16 Apr 2025 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813474;
	bh=ocU1vJNyqApCdp/OhYvVAEX6I12YQCJDinzTJcYWbsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBslEDhNhHHfyGVrptyBUileSVRItzUCqiAj1ZBB2kZtAN5uZetZe1GImhyIiwdEY
	 NV+OQVQtL77c2NX2gDVrsL3fwa55k+2fdKUJdf6NAOyEIVkDOFuWm4hyeANYJxzGvJ
	 lAnAbpCoS+jq1zhlCGODuP024zd00XFE/bSUSxVw8/4EaZ8kPZwm1uzZi6L35cE9fg
	 B5Yl5+dLj2wQL3QRf+u6Dv0cCCCJu4MUEYPZUa3zRfbeV2oXJNIZFG4PhO+cww5xwb
	 LkUTmRww4EEJjeWPW8EIyrjbpAcZ0C0ve8+3GpU+2ukYs9wQ3LLoKDU9RUA0EnLpt1
	 rEU+zVGYX5JOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
Date: Wed, 16 Apr 2025 10:24:32 -0400
Message-Id: <20250416092211-276f708a3affc92c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416011738.388665-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  cf8b16857db70 ! 1:  97a1c1318e997 drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
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
| stable/linux-6.1.y        |  Success    |  Success   |

