Return-Path: <stable+bounces-132146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D6A848EB
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD01881F48
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477311EDA12;
	Thu, 10 Apr 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2VOOKPQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095861E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300426; cv=none; b=aTWDttZ55Ves+hAUuyA63rClfS6FXuVEbYoATKt6loXM1T8aPqPyUIGEHyM4UeNsJZIeFvwWNqtGZjO/l6mLicBY75bKtrjvkEJYL1UfQSl/qVghp6KGekZB6tMiQu1rMVGzpJtlSVnTFtEdgOBj73OWY3paFsBqbdiocqCenHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300426; c=relaxed/simple;
	bh=q23gE2tM6uTPlGDAQVZP+BoLPdLv/j+tV5ax4wNjSYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZE+ObsO7p2oNgKZB8jvQ9NWnDfrssMBqgKLPSslecdIEW/Qj6SJY10wgsONouSpkTASsfL1GpLJKoiNEq7JRHrIUWK6E4zZydt3BK05tnWveJ8NsOnoRFrS3vOXvBpD0+Br+2S2H8VQZSUSn5946kR3YyLlDpowEc1l5b4qjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2VOOKPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E809DC4CEE8;
	Thu, 10 Apr 2025 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300424;
	bh=q23gE2tM6uTPlGDAQVZP+BoLPdLv/j+tV5ax4wNjSYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2VOOKPQdxgx85TpaLVyCXdGWe/KJCWuhDN40AuMjFlykMQHqPwwgBW4YHPxOjV91
	 bP8FEkW0cHxQkUgs5cz/KOidBuqopil8fczXPY1yDgJgBhK8nY2z4BBP/hN0gHJv5x
	 /j3eYXiCYAzAeYQMBrMTsOwYMdSZ538/STRsTHvIl81s/2I+a8Kr9lPGGNGTvC8tDH
	 ej+2THN5/aznUeBpZ897SPnFO5PtfFfuaPbOFJ5P2hZyB/5L2Va7Gz28ZE0/hwKj+I
	 S2ATJDxwQze6fXhmHjc2nyZIidyRfzyVUxSd+G9mUPMojYSs2nfE8ZKA7Pk7y3oVhj
	 yNTd3o7DVrgEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 10 Apr 2025 11:53:42 -0400
Message-Id: <20250410081636-664b0989a590574e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250410063125.3055855-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 63de35a8fcfca59ae8750d469a7eb220c7557baf

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: f01ddd589e16)
6.6.y | Present (different SHA1: 08ac5fdb9c6d)
6.1.y | Present (different SHA1: 5bd410c21037)

Note: The patch differs from the upstream commit:
---
1:  63de35a8fcfca ! 1:  8c79ce116f419 drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
     
    +    [ Upstream commit 63de35a8fcfca59ae8750d469a7eb220c7557baf ]
    +
         An issue was identified in the dcn21_link_encoder_create function where
         an out-of-bounds access could occur when the hpd_source index was used
         to reference the link_enc_hpd_regs array. This array has a fixed size
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Roman Li <roman.li@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
      		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
      	int link_regs_id;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

