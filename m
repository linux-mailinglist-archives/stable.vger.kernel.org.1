Return-Path: <stable+bounces-109280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF92A13C7D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF2C169534
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7922B8BC;
	Thu, 16 Jan 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Obpgcc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44522A819
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038408; cv=none; b=Hd8qkPJm+c8FLP0aQI5lzhPf7DRIsJRz3Rv5WpgljwA+8U/KqwYkiNHJjQ6kAnHd9zo2Qi6Z0kpPlNZcC3iKWmW3LfhtpOn5DCiYgn8QvPMttKbRwJycI1/l8HTFn6Onywumb1hmzbEB+ukZpvRxYOFiAAIXZ5pxzncJi6G7zQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038408; c=relaxed/simple;
	bh=jLifuM4nSYTL0ZnkTMNiXenhDyLtew24rhslrCo/zDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYrCCdql+G4kpVRMfc72GF7iXNarbfxUll19026NB7V0xTOiEqE7/mbG4Y5qPqC+XjVw1YzBfJtHlZv+kIBH2Xa+VPtQUo+91t5bt5ecGQ4hXY0pwoG0oHmsD4gjDrPf0Ft/vS9wemRm0i/anyWuZq4D1FEcCRtaOn+AixAYOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Obpgcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E7C4CEE2;
	Thu, 16 Jan 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038408;
	bh=jLifuM4nSYTL0ZnkTMNiXenhDyLtew24rhslrCo/zDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2ObpgcciPUyjmoQy2pmehPzrQRqfR/V2Ok4abLYKpHpZ81sYftErqSTQGe1PQbyq
	 cW3OkClmdFaYnFc7Aj2HPePLmYROzdpow5/2gaUK59xHGdqui/msYpQVPlyil7ERrj
	 oxf15o+JG43KqGCppPbmRLaUoQ1GFvPtDFAx/Xtm5whvpoUDmkX6avXVJsjdIvjYjj
	 dTCqwkpB5SSph6vaDj55Oys+BpexLQd16Dwfk8K5oR3+95zLrzK8VjIQOCql9MJrws
	 uMyruh0aUOPMx0AUF+bAlzeKZaNoScm5mda3XjKsmHMrZ/gpe8J/Tp8adOGwMQ5eM4
	 BuYKuxSCnabUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 16 Jan 2025 09:40:04 -0500
Message-Id: <20250116085636-5a171b7737c737f2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_A6264C7FC305AD420DEF47932496B5150E06@qq.com>
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

The upstream commit SHA1 provided is correct: 63de35a8fcfca59ae8750d469a7eb220c7557baf

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: f01ddd589e16)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  63de35a8fcfc ! 1:  38682f44d456 drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
     
    +    commit 63de35a8fcfca59ae8750d469a7eb220c7557baf upstream.
    +
         An issue was identified in the dcn21_link_encoder_create function where
         an out-of-bounds access could occur when the hpd_source index was used
         to reference the link_enc_hpd_regs array. This array has a fixed size
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Roman Li <roman.li@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
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
| stable/linux-6.1.y        |  Success    |  Success   |

