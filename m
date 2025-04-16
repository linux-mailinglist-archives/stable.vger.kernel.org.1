Return-Path: <stable+bounces-132856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B1A9062B
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3576116E4F1
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B65120DD50;
	Wed, 16 Apr 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US1yZ1Uw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC462063DA
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813027; cv=none; b=uz6aR5EZ3MUiDzYKLSLonIqIQdazQuFemWAW5SoKgVj+TCzBZYHG3pr96PM6PjPfp49cTZcfo2bU11R4GDmDS+FrZ6unvUFLf2/9n6VmSJZdboM+RfvLws0IbBCw8TmXdV6EuVv4gNCwy4nb6njEZA2liiBUlrA+MQsKqqHPuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813027; c=relaxed/simple;
	bh=dvWf6/+ALXr5/McVa6Tjnjr6qh8dDFywmWupv59qGOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdmA2QeM0MSfKrnh21uJ/nTLkywO9cElchuLMni+YYhdz0ZHUeiSmz6+lM6UyyQcUUQVhWdkkbZbPpPZIr+K6Ldxe8H56SyFEDE9ztAr422AnQgUNDBRMIokfXw7/A1WxgsyHjK41YHhkypSZO6msT9wa7X8wYwHPC7NcAfMVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US1yZ1Uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC7BC4CEE2;
	Wed, 16 Apr 2025 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813027;
	bh=dvWf6/+ALXr5/McVa6Tjnjr6qh8dDFywmWupv59qGOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=US1yZ1Uw7/zMKO9U3Do+Z6+VupjKy95XOaSL19vAvkGCni1LUJIJ7dmwbypDPRK6c
	 SOo8+TWufdlbWiWisfdnXIWtqU6eYpN+o0jZtdFafoXvGRGwK7EC1Z6y11JrvnR1AM
	 0m4Z09zt11ET5A8D8IRKZoIy8Y05ZoNnL778hUhhs+UxYVP0oo5GQDBxSJmoaLPXWZ
	 TjzUXipmlYIvaxd5LC8Hit9zeDD4qp8/UxBXOHJNRynst16lcntPxERNaif/1ZUMdj
	 lxVFqfjt/sDegnEVw8ybL4y8TNQcjFMptS3wYDu5/6C63Ip+KTkCKXD7GgEN2rQYpE
	 z98b+MowL8Rvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
Date: Wed, 16 Apr 2025 10:17:05 -0400
Message-Id: <20250416095614-d85ced39a0c7cd55@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416011756.388682-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  cf8b16857db70 ! 1:  d4f47fa493403 drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links
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
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
    - 		}
      	}
    + #endif
      
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
| stable/linux-5.15.y       |  Success    |  Success   |

