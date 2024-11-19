Return-Path: <stable+bounces-94029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399559D2886
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2425283346
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE611CF5E9;
	Tue, 19 Nov 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrwV1lLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223891CEACB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027623; cv=none; b=jMC2YgYbm140aY4iSJj8SWeWZdALSruq6qh9CBMyf+PIoOUEWdez+9+5eKUp2qbmgJm1vcmHSsiff70B5oSBYxYSm9fBWQGeixo2Z4NSTEad/mTy1TWlARVWTgYOZaLJr57w9AWlfgQ7VwW2+H+QJPN062dKSQ8wjYqUlCjw78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027623; c=relaxed/simple;
	bh=5b8/A/Doflb6lQOJYmS58Bt3GjPqnVNwZz1k3HpDARY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcubqOqhWL42DRXa09+boDlhPPso0gjM6k443/bQjwFJJHCsyi66JjdhsppsPRyziKPDdQZhcx6IJjP6wcHaW0IJWfsbMVznMLdeDizPNTfG0hOKhXrjYnTKnDOB0q1f6dOS3+WhqLS70gc1n/5shOjiM2zwojj0kHzqXq3PPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrwV1lLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89290C4CECF;
	Tue, 19 Nov 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027623;
	bh=5b8/A/Doflb6lQOJYmS58Bt3GjPqnVNwZz1k3HpDARY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrwV1lLJYPBz9DfMku5gI2cm8nNlr7c5apz48EOI1a+CNszcA+b+ewvkPxGjhT84f
	 3ViP68Pa1LHzOQ3J4GjqnicAd/n0c8ufUDAhebV89C1K+J+ORUMMuPtaOj5dLLwa1u
	 J582I0TfDebQxOOWDRyZJM3GtZlkB0Bc13kEXFXzD5aqEF6nB4buJ212r45opJKATH
	 Y7swWRfPhC2T7bJuTvphD33BedDfpRO8UYwXgp/n5XJt7H0x/iwMGyoGCeM97p8L/0
	 OgcUaAyQJLuYzLWfem3G6xMRdoV44HRwTWQPdQI/B5epSekK31G4Vjx6s0jmP6L9tV
	 BJolDN2/VEPNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] parisc: fix a possible DMA corruption
Date: Tue, 19 Nov 2024 09:47:01 -0500
Message-ID: <20241119054933.2367013-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119054933.2367013-1-bin.lan.cn@windriver.com>
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

Found matching upstream commit: 7ae04ba36b381bffe2471eff3a93edced843240f

WARNING: Author mismatch between patch and found commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Mikulas Patocka <mpatocka@redhat.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 642a0b7453da)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:21:52.789319248 -0500
+++ /tmp/tmp.F1gLT4KxR7	2024-11-19 08:21:52.782984641 -0500
@@ -15,16 +15,17 @@
 Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
 Cc: stable@vger.kernel.org
 Signed-off-by: Helge Deller <deller@gmx.de>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  arch/parisc/Kconfig             |  1 +
  arch/parisc/include/asm/cache.h | 11 ++++++++++-
  2 files changed, 11 insertions(+), 1 deletion(-)
 
 diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
-index 5d650e02cbf4a..b0a2ac3ba9161 100644
+index 3341d4a42199..3a32b49d7ad0 100644
 --- a/arch/parisc/Kconfig
 +++ b/arch/parisc/Kconfig
-@@ -20,6 +20,7 @@ config PARISC
+@@ -18,6 +18,7 @@ config PARISC
  	select ARCH_SUPPORTS_HUGETLBFS if PA20
  	select ARCH_SUPPORTS_MEMORY_FAILURE
  	select ARCH_STACKWALK
@@ -33,7 +34,7 @@
  	select HAVE_RELIABLE_STACKTRACE
  	select DMA_OPS
 diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
-index 2a60d7a72f1fa..a3f0f100f2194 100644
+index e23d06b51a20..91e753f08eaa 100644
 --- a/arch/parisc/include/asm/cache.h
 +++ b/arch/parisc/include/asm/cache.h
 @@ -20,7 +20,16 @@
@@ -54,3 +55,6 @@
  
  #define __read_mostly __section(".data..read_mostly")
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

