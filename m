Return-Path: <stable+bounces-126955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C47A74ECF
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A8188C31A
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DB1D8A0B;
	Fri, 28 Mar 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az/csQfd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F53C0C
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181397; cv=none; b=Bq7ScFPMMvUpxpdnBVd2mdGxIOlwUm6A6aX3lg5A8ZPLDFti+DceofSemfp7IJUq+YYojiKFR5ghf983piFMR6X71iA3F+3TYlHi9BzHFCzM26uPFBv5qDhn+Ldge+1z0xV3nM/juqb8kbaFgkTm2IUtOSV+JgBdscPHy7mVRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181397; c=relaxed/simple;
	bh=lGOEgh/sRzJVt5S1IjjQTqZYvnq9DenGRBZ7YNyqKVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO3VRK9rbE+MDSJp2FpN9UF0XRReXeImlemTaaTCea2k/ChRjlbM00k01c0251X9yX6Drd9/rYBk3IMGpxNyw6LsltYHz0X3EZPRDopJ1Noyvg59D/GNKH24cXlsXK/hJSBeR3Seo/pNQ2wH/U8M4/GFASKVTlYCHJo6ZhMEmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az/csQfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C60C4CEE4;
	Fri, 28 Mar 2025 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181395;
	bh=lGOEgh/sRzJVt5S1IjjQTqZYvnq9DenGRBZ7YNyqKVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Az/csQfdcsoZSiwKcIZrBVfKza4VEMJi/XEDPHN00/7BX1ejJPRLkHuOCYuRTeNem
	 1WxxqRV8/XG5ifiy5pWPXYSRPIKLQzWhGMrYYXqnG9bIxsv1K0Tzwy48mMY76KPqCv
	 sMWxgqjk792VKLDtLYh7xDWDsN8GvRUoc1YCagPQ+XtSpPZOAkXEZpB6Fkn4c9Qpqw
	 zuOLE1f93ffR7zrsmZ1/wPPZdvVB0eEVJqbAbUq+gfKNdlBK7MVn4fm8/7j/yUSpFw
	 r7rt1snUEUG1k/+f7ffV3YZw/bD8clwvzRE9PAqZIPH9XSbyOX4eJvQr9D2FUt9nvj
	 SPzoqj31jBsCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Check denominator crb_pipes before used
Date: Fri, 28 Mar 2025 13:03:13 -0400
Message-Id: <20250328115207-816b7a16af8f13e3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250328020814.2986133-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: ea79068d4073bf303f8203f2625af7d9185a1bc6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Alex Hung<alex.hung@amd.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ea79068d4073b ! 1:  ca8dbaa5ec3a2 drm/amd/display: Check denominator crb_pipes before used
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Check denominator crb_pipes before used
     
    +    [ Upstream commit ea79068d4073bf303f8203f2625af7d9185a1bc6 ]
    +
         [WHAT & HOW]
         A denominator cannot be 0, and is checked before used.
     
    @@ Commit message
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c: static int dcn315_populate_dml_pipes_from_context(
    + ## drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c: static int dcn315_populate_dml_pipes_from_context(
      				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
      						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

