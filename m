Return-Path: <stable+bounces-94040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F769D2996
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859D8B253CC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401EF1CF5D8;
	Tue, 19 Nov 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjJmP59x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED61CDFA6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029240; cv=none; b=OtAn2e9x2qurmhcksvXmxXg7A5uqI7SEhhZiuzLWc0Y4KLDeWQc4oYAXLld/BftCvLlFSzGJVZirW6xtLHRNOIuTG7cJ4wkLzrpK5OJB6nL+I4iO62zipOS89AXM3spOSH/EjW1ZJzPDHj/q5myAzyMDEB48h+55XyH702hog6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029240; c=relaxed/simple;
	bh=JdJn8qJ1J1VZzNIWYwh3jrLxBBPnKYxdTYs10oLXbIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk3zG5oAFOqxDMfZdcoRRWxkbTbduoN4ySdtVDh37TqnjpHG+vXqZTHcq2uyeev4wGOcqHqnHnrb0TWx1qtFmyhkXG7q6VkH4bCbsJai3oVh5Mm/3Hcwr/Waq64BZ0/PMIQJ49w8L0lIkZZ0sM6/SoQeXQ4GqR3JAeiSn9B4b/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjJmP59x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF9FC4CECF;
	Tue, 19 Nov 2024 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732029239;
	bh=JdJn8qJ1J1VZzNIWYwh3jrLxBBPnKYxdTYs10oLXbIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjJmP59xYHe+i63RgU+Bv9fDR8ml6XoSHC5HfYkM1dDzg3AN10etNzq/c3caRMkF7
	 /tXYIeEMHM8EnVEUAn4tJ4Y/riO+QOMmsfEd7MFWMjsy1wd1s2+SSCGdiYjkxBrTQX
	 l6KAUQxUaQsQgITcpZWx3Yx0TjA2yTnSi+USz4vuNfAkaZC7mOsmPrJMai8EZU+KvT
	 Encz4Vnmy+MpPIJR0IhmwSekdG3gNE7sDxYlW1seSyS7r2sHCY63con/ppT5ev3KIh
	 5DgYi9P1PMqtGd6nUWxF8oa5bm48pWilVmb/ZDk81svi9qJ4nY7sEBOn83Tm/VHsAg
	 XYDdX5fiwzdIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 v2] parisc: fix a possible DMA corruption
Date: Tue, 19 Nov 2024 10:13:57 -0500
Message-ID: <20241119133255.2573917-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119133255.2573917-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 7ae04ba36b381bffe2471eff3a93edced843240f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Mikulas Patocka <mpatocka@redhat.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 642a0b7453da)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 10:04:23.510130519 -0500
+++ /tmp/tmp.RmGTgK9eLP	2024-11-19 10:04:23.501032984 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7ae04ba36b381bffe2471eff3a93edced843240f ]
+
 ARCH_DMA_MINALIGN was defined as 16 - this is too small - it may be
 possible that two unrelated 16-byte allocations share a cache line. If
 one of these allocations is written using DMA and the other is written
@@ -15,16 +17,17 @@
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
@@ -33,7 +36,7 @@
  	select HAVE_RELIABLE_STACKTRACE
  	select DMA_OPS
 diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
-index 2a60d7a72f1fa..a3f0f100f2194 100644
+index e23d06b51a20..91e753f08eaa 100644
 --- a/arch/parisc/include/asm/cache.h
 +++ b/arch/parisc/include/asm/cache.h
 @@ -20,7 +20,16 @@
@@ -54,3 +57,6 @@
  
  #define __read_mostly __section(".data..read_mostly")
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

