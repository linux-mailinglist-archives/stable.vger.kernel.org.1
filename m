Return-Path: <stable+bounces-100672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D49ED1FA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760BD285F86
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD531DD873;
	Wed, 11 Dec 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKmE337d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74E38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934796; cv=none; b=WqxubkoVTo3MCuY95L9JyxJrshJg7RHbz4tTFR5Zyy9Xje9x3Qmjbyr67OCsdGoPZwFtXWXGpZQL5tdpKrTVbgx8o4fyOQIOPl4vRaAO2WdwoChEE+hi172xE6ByxqlTNu2iuGzOR4WITKRGQwc5F83lkGjQAI4cX/VtgOg/g2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934796; c=relaxed/simple;
	bh=/s3hq4MhL/d+iRpnyztildfrJBr+eWf97s3h8aAHT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxbjt2hdFuJGIhv2hlqWVef5Fk8I1t8til/zZ2MZdswDp65TngOuo2PdJ3mWpNiY05heo4tjNpN1lT8ZOu/j7cQRr63VPpAwCXuw7eqRTGIT6RcuzrJwHxoQ4n7UQ9Or0B5a1al3lyJwQiizgNrOYGIk94EqF86VmPs/XZayBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKmE337d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9393FC4CEE0;
	Wed, 11 Dec 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934796;
	bh=/s3hq4MhL/d+iRpnyztildfrJBr+eWf97s3h8aAHT70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKmE337dj1i4tC1CDukulJ/P8Nf9wJhrhljee8yeVyOjGcFM1LqzsljUrF0oDV6Ap
	 4kfCKEvPAPoKDhx9dcmLvdR9IXNxTAlUVZ4FmbslBPasaYVHMCF6epFm4kNHy1D3Ue
	 Y8c/mf3WLRgynNxjxy1rb3+CcvSO64aliKjZ3x5htSL3mpertwZbDF6XIpGK+/Q7pQ
	 Qu/T7ENegv9EQVpya3T/cFgse2H9XRo/aMN5p+2H4n1CSai2vgD4Ix+jr1iNpWhTA5
	 dktrh2EJAGw+kQYhE5PgYHxEaiEx8rWDZbzjlY9KwUj15BaynGYieq+eXj0M0saOfh
	 obji6Z1ekDDnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Wed, 11 Dec 2024 11:33:14 -0500
Message-ID: <20241211093322-2faf2ff4d8ea72da@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101525.2107003-1-jianqi.ren.cn@windriver.com>
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
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e040f1fbe9ab)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2a3cfb9a24a28 ! 1:  d2c2f56b0642e drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
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

