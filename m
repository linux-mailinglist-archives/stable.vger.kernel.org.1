Return-Path: <stable+bounces-95721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A39DB90A
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E033AB23647
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEA1A9B4B;
	Thu, 28 Nov 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmC8BrSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653919CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801397; cv=none; b=Fb+ugak0r7ltzRCvEqsEy5MTi0w7pQtGnYqMohxL+bNkjp1cY3brfJuiTlgcTLWOyY/a1jNYQ5LB6DCCYYRRgel2JoBmBPwf48MwnRK8zJwYw48Hf0Sx5A+DgvzxjoEQxE8B+YT9S8PA/PCnWZL+eTA7I4XNq0whk3tD/Dw/W2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801397; c=relaxed/simple;
	bh=WZsBCnmnhgDX8iuTAzeXK5oRmZ4CNO+SN/ClZDrgcjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bn6fNpD7bm3m0hj8FwBad2GWJKuW++1534cQ27Q5NpQ4qxJkw4L9t03HAmJM9fbqsm0YFON88JB3jUlwVImAHpByjShtYkS1moJO/n/p6ElHNSsVTD9HqD9GgGkxDjKlWCts0xmOHVGTh2TY+uFMQduATgHrq6xwPa6Utw8CEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmC8BrSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DAEC4CED3;
	Thu, 28 Nov 2024 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801397;
	bh=WZsBCnmnhgDX8iuTAzeXK5oRmZ4CNO+SN/ClZDrgcjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmC8BrSpZ417+kLiqaJxyWPJjFlCgAVrRIhOlfD0xL4erNSTTLgyFCm1S7jZlqKZK
	 BbHsbfUVbEsokmYdgTnTxXztyKi2Vz8YAJR1Htne6YrOBQOJd9v5jCJBc8/DCgt4mz
	 t/htjOX8ZbwcAOmF7NUqsUPkwMTeudpaGrUclSo5tZvxB5Xows20rgUoM2RSbTzdF1
	 hYVwL3qFRaiCPHKyWkhfLsuMAAEn/GWPPmipFfHyU1PevnV5sEf8j9sZ33gfcNtshO
	 I15HBDqBbbFV5enVDGt3GqKCQMjorUBHY73VAiHFpHZBb2EoRiCUQn3L/Zzx4VPeNH
	 0NdhnpTOwJLVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
Date: Thu, 28 Nov 2024 07:57:05 -0500
Message-ID: <20241128063354-40690685068cbd32@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128065521.1471959-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: efeb7dfea8ee10cdec11b6b6ba4e405edbe75809

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Ido Schimmel <idosch@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 817840d125a3)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-28 06:27:54.820071472 -0500
+++ /tmp/tmp.TYWoQ2w0cN	2024-11-28 06:27:54.814129152 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit efeb7dfea8ee10cdec11b6b6ba4e405edbe75809 ]
+
 When calling mlxsw_sp_acl_tcam_region_destroy() from an error path after
 failing to attach the region to an ACL group, we hit a NULL pointer
 dereference upon 'region->group->tcam' [1].
@@ -36,15 +38,48 @@
 Acked-by: Paolo Abeni <pabeni@redhat.com>
 Link: https://lore.kernel.org/r/fb6a4542bbc9fcab5a523802d97059bffbca7126.1705502064.git.petrm@nvidia.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+[ For the function mlxsw_sp_acl_to_tcam() is not exist in 6.1.y, pick
+mlxsw_sp_acl_to_tcam() from commit 74cbc3c03c828ccf265a72f9bcb5aee906978744 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
+ drivers/net/ethernet/mellanox/mlxsw/spectrum.h          | 1 +
+ drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c      | 5 +++++
  drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
+ 3 files changed, 8 insertions(+), 2 deletions(-)
 
+diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+index c8ff2a6d7e90..57ab91133774 100644
+--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
++++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+@@ -970,6 +970,7 @@ enum mlxsw_sp_acl_profile {
+ };
+ 
+ struct mlxsw_afk *mlxsw_sp_acl_afk(struct mlxsw_sp_acl *acl);
++struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl);
+ 
+ int mlxsw_sp_acl_ruleset_bind(struct mlxsw_sp *mlxsw_sp,
+ 			      struct mlxsw_sp_flow_block *block,
+diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+index 6c5af018546f..93b71106b4c5 100644
+--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
++++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+@@ -40,6 +40,11 @@ struct mlxsw_afk *mlxsw_sp_acl_afk(struct mlxsw_sp_acl *acl)
+ 	return acl->afk;
+ }
+ 
++struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl)
++{
++	return &acl->tcam;
++}
++
+ struct mlxsw_sp_acl_ruleset_ht_key {
+ 	struct mlxsw_sp_flow_block *block;
+ 	u32 chain_index;
 diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
-index d50786b0a6ce4..7d1e91196e943 100644
+index 685bcf8cbfa9..6796edb24951 100644
 --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
 +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
-@@ -681,13 +681,13 @@ static void
+@@ -747,13 +747,13 @@ static void
  mlxsw_sp_acl_tcam_region_destroy(struct mlxsw_sp *mlxsw_sp,
  				 struct mlxsw_sp_acl_tcam_region *region)
  {
@@ -60,3 +95,6 @@
  	kfree(region);
  }
  
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

