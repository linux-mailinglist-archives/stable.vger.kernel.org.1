Return-Path: <stable+bounces-94517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1249D4CF8
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 13:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45821F2255F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FC1D47A0;
	Thu, 21 Nov 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxT1loui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633151D0F66
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192726; cv=none; b=KfZuk5bF7fYt9q5OL5R66kSnWVkwXOpwXETYeUI0hH/SDA8o8M+0+6j4w7cebPHJXa5XUK+WDHNX/PC61RoRI0aPMdAh3hVkWBg83Ec5m3pEgSP+jRfyzmUS3NzBlI2dFHv7pk1uZPzh/e0rgaIgVyaYKJJIAxrr8HTuvdJ1Yeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192726; c=relaxed/simple;
	bh=cpdHsDT0jvrut76CKqdc7vefAVhNgHyV7VtwvJNNkbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7XdDd5OMcVzTJH85+dDkasGXf7WP0BihR1yauiTwnY7+xvU6WQMBhZ16zY1zTHA1vWqH0aZhMKUoiyWvXVDBEdKg5elecECo9VCVCMkYEFHDGERJtsoyw8/NMIOFsNLz1d5+s+1edKSLDlNtg/P9jJaMw9aLZB8LvEx5CUiU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxT1loui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579BC4CECC;
	Thu, 21 Nov 2024 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732192726;
	bh=cpdHsDT0jvrut76CKqdc7vefAVhNgHyV7VtwvJNNkbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxT1loui+7+NqY7DGpPfNtg1gm8UTxDO99rI4Mjzwh0arYknAxlag4lKAW+k2CYBX
	 dv2nQiV7Ygv+B4u3Csl6o46MOUypYCNjAFqZW9G5mUqJ2XfGI8CuZlcyug2OjGPL2Y
	 xRcVV8sPTcUTjzpnmE5pxo8+ikcryZYPA3lr12ZJlrSW1nJfvK9w9/EBgyUbpzEtKx
	 RioNOAgSoIMioUCpkSLItpbcVM93Tbgoyg1hHt/9K+d0E/1gTQQlMm+XDSgsm6c4jV
	 +iIPUTIsQ5stsab3N1mCRRM2gknPEpG9VhLuua691uU6mdlDfny+VgAMKAQWPq+5EA
	 WvI+d/q2ht6Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] closures: Change BUG_ON() to WARN_ON()
Date: Thu, 21 Nov 2024 07:38:43 -0500
Message-ID: <20241121073837-8522dece4a873ee3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241121064607.3768607-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 339b84ab6b1d66900c27bd999271cb2ae40ce812

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Kent Overstreet <kent.overstreet@linux.dev>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-21 06:59:47.405492326 -0500
+++ /tmp/tmp.e7rRZ1qHWZ	2024-11-21 06:59:47.399091975 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 339b84ab6b1d66900c27bd999271cb2ae40ce812 ]
+
 If a BUG_ON() can be hit in the wild, it shouldn't be a BUG_ON()
 
 For reference, this has popped up once in the CI, and we'll need more
@@ -51,15 +53,17 @@
 03246 ========= FAILED TIMEOUT copygc_torture_no_checksum in 7200s
 
 Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
+[ Resolve minor conflicts to fix CVE-2024-42252 ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- lib/closure.c | 10 ++++++++--
+ drivers/md/bcache/closure.c | 10 ++++++++--
  1 file changed, 8 insertions(+), 2 deletions(-)
 
-diff --git a/lib/closure.c b/lib/closure.c
-index 07409e9e35a53..2e1ee9fdec081 100644
---- a/lib/closure.c
-+++ b/lib/closure.c
-@@ -17,12 +17,18 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
+diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
+index d8d9394a6beb..18f21d4e9aaa 100644
+--- a/drivers/md/bcache/closure.c
++++ b/drivers/md/bcache/closure.c
+@@ -17,10 +17,16 @@ static inline void closure_put_after_sub(struct closure *cl, int flags)
  {
  	int r = flags & CLOSURE_REMAINING_MASK;
  
@@ -71,12 +75,13 @@
 +		r &= ~CLOSURE_GUARD_MASK;
  
  	if (!r) {
- 		smp_acquire__after_ctrl_dep();
- 
 +		WARN(flags & ~CLOSURE_DESTRUCTOR,
 +		     "closure ref hit 0 with incorrect flags set: %x (%u)",
 +		     flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
 +
- 		cl->closure_get_happened = false;
- 
  		if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
+ 			atomic_set(&cl->remaining,
+ 				   CLOSURE_REMAINING_INITIALIZER);
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

