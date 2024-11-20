Return-Path: <stable+bounces-94085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3C9D324B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E06B21C06
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 02:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1D3F9C5;
	Wed, 20 Nov 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC0prTm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D549620
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070702; cv=none; b=R7l58ayXGQuLVbrMGHbyj4aSYvfaZXXpwCBbPZV3JwDt4lJbolzoCxsCkxJL1bMimJfTStPAAuJM3YPp18gfwerJL1oYR8enEYh5KsD6Fi14KUD6fwEmkDdOSckr0HNYaiKozNGP4Gxok/NGrb6whA/bSGNX56sp50dTwL+RVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070702; c=relaxed/simple;
	bh=QYQhNyTnz9EkWe+q2OdyuPTcKkSTCcKsGsNxogDKnnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG5UmtbsCQhibWQbLxNrEeGQJ9LRSAC82vk93vWWmW6mCWE+GxlPmQA0l+NGkAvoJihKo5z8ToV+DghvLRuthnmCHw0c5VfJoZlH4GIXMTA40DUX0BIHgLYASDL1fXFH6FDhNGn8W59N7kmzAK97yx7/TIhFGKxXQpJxG2LCmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC0prTm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9CC4CECF;
	Wed, 20 Nov 2024 02:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732070702;
	bh=QYQhNyTnz9EkWe+q2OdyuPTcKkSTCcKsGsNxogDKnnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KC0prTm4RmZ5FzU7y9WoO8NEdy7/k84OT8Kcx346LoTFzp49zU6RxuBev/J1VVeGF
	 ymapcIKQnRbjltJwp/fQ8r/XRIiwStoediocp39fU/dmQmoSet7AYw36X4pEdKrbSe
	 x0jDGpFQ0pJivpB+SUqyxkX+ofZSOwL6Zr/4bmcOippW43jywVjM/wrElO9k6onXgQ
	 LBJ5HH//xcE3j67LGltDmqyr3pi2KTMiGb3KX8F4VlG7VCb5InsES7XZhBlRoC46b+
	 s3/D5oBxNEp5ZLNKFK3gsppOUgDAxkk3kc1yJmyta4Zh2aX4NbxA1pQYbvU8EaRI5w
	 DlvLamOrpCsFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] drm/amd: check num of link levels when update pcie param
Date: Tue, 19 Nov 2024 21:45:00 -0500
Message-ID: <20241120023051.2591465-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241120023051.2591465-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 406e8845356d18bdf3d3a23b347faf67706472ec

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Lin.Cao <lincao12@amd.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 09f617219fe9)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 21:37:40.879993929 -0500
+++ /tmp/tmp.NxKnnO1gNT	2024-11-19 21:37:40.874224741 -0500
@@ -1,24 +1,31 @@
+[ Upstream commit 406e8845356d18bdf3d3a23b347faf67706472ec ]
+
 In SR-IOV environment, the value of pcie_table->num_of_link_levels will
 be 0, and num_of_levels - 1 will cause array index out of bounds
 
 Signed-off-by: Lin.Cao <lincao12@amd.com>
 Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+[ Resolve minor conflicts to fix CVE-2023-52812 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
  1 file changed, 3 insertions(+)
 
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
-index 3917ae5e681a3..a49e5adf7cc3d 100644
+index 3aab1caed2ac..e159f715c1c2 100644
 --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
 +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
-@@ -2438,6 +2438,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+@@ -2498,6 +2498,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
  	uint32_t smu_pcie_arg;
  	int ret, i;
  
 +	if (!num_of_levels)
 +		return 0;
 +
- 	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+ 	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
  		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
  			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

