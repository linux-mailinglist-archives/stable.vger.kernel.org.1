Return-Path: <stable+bounces-124345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68086A5FDA3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB50719C361A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37071376F1;
	Thu, 13 Mar 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OizGIO1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC628633F
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886536; cv=none; b=RCxCFGASd7ijdSz0fiufQhC2HM2mDTI5We4ecgwp1PodEG3PmGcXgS/faU/MrBymQ5EI3T6KUcdEzhwRR5wwzvO0BlRZNaD9EM5txZFhvxweu3C3yYt1ilW0yI9bBD3AbfUC4bpzjS5UBJxFlh/DtSxQXmQfzwAUgx11EVQjgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886536; c=relaxed/simple;
	bh=Tv8zBGIKvV2LVN7KpHOIRMbubXNNCryEH2EAoeG1apY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0996CErq1VHIzSKXyR8KvhEuZf4AAfXnscx5RP1QWsWyRg+dRNEizF7nKZ6EDLREp2/BfrIzcM2IEhW22uPi0tsb+UoOYq1nPQ7lw2XZZmnRrMc6D/IxaVbtH002r68ZGWOraJl2fvXgfPUcI7IXgCaYvF9mhNKW9EyGr25/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OizGIO1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30338C4CEDD;
	Thu, 13 Mar 2025 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886535;
	bh=Tv8zBGIKvV2LVN7KpHOIRMbubXNNCryEH2EAoeG1apY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OizGIO1ZS3Uj0zZPGk0mcp8xnoTgjA9s2nfHjt5U0hMox9kfg3XvqAx2ZdtdJ3WuG
	 syggvicreyrE6zrzZ70lTyU0JWiLhYcwPTE9+yCstY8GlI8cE2jRaDjrCe0DJ1rGgC
	 sQlUrqyhffZTLrnwhKsZi31g1I9rEv85O7I115uAZjTrocbTeLLKDs/5O3RhYaKXeA
	 I7eqciJS2XVYKLn3JV7QkgMJBVSO2sFLZ5kKlIlLL6+Px8uchanPKljukl91LfZqoD
	 aLSM3uadWbcthvAFmldzci7tOUSFA31UQ3Wpgjg2UZ6/N51WowRXQF0fbGzwCl8rwT
	 6RAEw1Wxw4V3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kareemem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 5.15.y] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Thu, 13 Mar 2025 13:22:13 -0400
Message-Id: <20250313121916-7e052e4c92e792ae@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313152307.14830-1-kareemem@amazon.com>
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

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Kuan-Wei Chiu<visitorckw@gmail.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 4a2c4e7265b8)
6.12.y | Present (different SHA1: 404e5fd918a0)
6.6.y | Present (different SHA1: 4acf6bab775d)
6.1.y | Present (different SHA1: 9a6d43844de2)
5.15.y | Present (different SHA1: 131e6c9d16e2)

Note: The patch differs from the upstream commit:
---
1:  3d6f83df8ff2d ! 1:  eb76eb68e0427 printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
    @@ Metadata
      ## Commit message ##
         printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
     
    +    [ Upstream commit 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a ]
    +
         Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
         leads to undefined behavior. To prevent this, cast 1 to u32 before
         performing the shift, ensuring well-defined behavior.
    @@ Commit message
         Acked-by: Petr Mladek <pmladek@suse.com>
         Link: https://lore.kernel.org/r/20240928113608.1438087-1-visitorckw@gmail.com
         Signed-off-by: Petr Mladek <pmladek@suse.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    (cherry picked from commit 9a6d43844de2479a3ff8d674c3e2a16172e01598)
    +    Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
     
      ## kernel/printk/printk.c ##
    -@@ kernel/printk/printk.c: static struct latched_seq clear_seq = {
    +@@ kernel/printk/printk.c: static u64 clear_seq;
      /* record buffer */
      #define LOG_ALIGN __alignof__(unsigned long)
      #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/kernel/printk/printk.c b/kernel/printk/printk.c	(rejected hunks)
@@ -420,7 +420,7 @@ static u64 clear_seq;
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;

