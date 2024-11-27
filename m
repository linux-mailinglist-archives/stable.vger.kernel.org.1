Return-Path: <stable+bounces-95634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B499DAB85
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F354281F9E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13BA1FCF77;
	Wed, 27 Nov 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QniUYtQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0EC200B9C
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724103; cv=none; b=fsezc2kcBd7nHPuD5XkO2wqF4ngDELxYJUpDq0aDCaGgEqy91YUOs2KtEsX/RlTywcxlBajtl9IZte0+Fcdw3MH/cfpKQJO+XwgfJd7vHq1KYAV4r1FcewBcvKjdh1Aki3UlYeP41gnFtdgwDv6HAY6Vys6WDt60PrhPDcOCMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724103; c=relaxed/simple;
	bh=H8/iPG4GMsd1+cwQqWCA9SoteRegxnXBpuM7ZP6lHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3W/SWDXGsRRCKeVPKEj3fTy2sVcwXJAPMwgNCGdfizgTLUlbr8nImGOsIhPaEoHubUDN8V29wlo1/xuPTD0G4O/qpuH/KY5VQH77roJzLtmUJKDkMhLiNE1w6mDUtovezV1UDmKUsYmQnPf4amrtyEaCGRnoABuiM0zA9w/itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QniUYtQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799CC4CECC;
	Wed, 27 Nov 2024 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724103;
	bh=H8/iPG4GMsd1+cwQqWCA9SoteRegxnXBpuM7ZP6lHbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QniUYtQwjY+KmBd/uJuSaWc18Sn5Vs0r0/Uz1ggSYHDlExt9qyAB5MLKg0B1GHKnj
	 4QMLyZRjaElqXgGcdaVOWAZQNfvbNaRz1+e7cDcVYTauiWwTTzeFHXUkC/Ay8o8+h4
	 4BiGkjYn6deUthTYoHRZQchA5KFkNXLvla88+7H7iT/dYHicmkt7YqXO0aHYsyFLsU
	 7y9Jtm8FpK9C8w/mQKIFNZsmDwb5CGg+Oyx1IdI1kAg6fI4N5FvbtmewsRpUVGc+6N
	 a8SEQo3hDwR330YigHfC7TpaSa7pqKZmpxeehafLFoxkaHhcOQ7TDhxl+NMIWyCllQ
	 pMWvO/R0i2TvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 27 Nov 2024 11:15:01 -0500
Message-ID: <20241127092348-71078fcecc786710@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127130814.1203257-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: fb63435b7c7dc112b1ae1baea5486e0a6e27b196

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: lei lu <llfamsec@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 09:15:10.118544781 -0500
+++ /tmp/tmp.yXhwFlxu6p	2024-11-27 09:15:10.108180884 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]
+
 There is a lack of verification of the space occupied by fixed members
 of xlog_op_header in the xlog_recover_process_data.
 
@@ -22,15 +24,16 @@
 Reviewed-by: Dave Chinner <dchinner@redhat.com>
 Reviewed-by: Darrick J. Wong <djwong@kernel.org>
 Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  fs/xfs/xfs_log_recover.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)
 
 diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
-index 4fe627991e865..409b645ce7995 100644
+index affe94356ed1..006a376c34b2 100644
 --- a/fs/xfs/xfs_log_recover.c
 +++ b/fs/xfs/xfs_log_recover.c
-@@ -2489,7 +2489,10 @@ xlog_recover_process_data(
+@@ -2439,7 +2439,10 @@ xlog_recover_process_data(
  
  		ohead = (struct xlog_op_header *)dp;
  		dp += sizeof(*ohead);
@@ -42,3 +45,6 @@
  
  		/* errors will abort recovery */
  		error = xlog_recover_process_ophdr(log, rhash, rhead, ohead,
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

