Return-Path: <stable+bounces-110496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8576A1C96D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E2E18868EE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421801DE2BA;
	Sun, 26 Jan 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+NGHEB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D31DE2B5;
	Sun, 26 Jan 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903061; cv=none; b=W94SUgbWLkA1CazMXgLnqwMk54NhPHelJtcDyhRoi3iPgQTTOu58JD11d6Pcvn5qAszXn/u2to5cECNLPPc5fXG8ZndK087STuouzh5Yqtww/HRlHDJkkC+M4wTTCGFaJYz/3olSwkpKda2fIPZYsGOpmei/ZkZJjJr82HtU/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903061; c=relaxed/simple;
	bh=Yy0kQ1fyWq7SRiAk8SCR8jjTKPqZkKLL08ax73rCljw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtUrvKatjr4TIQps1Mqw5dJQcLOND07ebh9v9pOARTjPDBXa+JkFxsRQg+UWUUCdgtxHisJR/OdbWGmjH8LsenqvFnlRa8x4VKmv2v7G3Sm4Wxq4MrRZqNaQPlYODpIg5IGsqto93lYdqob+jsuYLbQt2sg5WEwErqlpMc59PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+NGHEB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA488C4CEE4;
	Sun, 26 Jan 2025 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903060;
	bh=Yy0kQ1fyWq7SRiAk8SCR8jjTKPqZkKLL08ax73rCljw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+NGHEB0xyyuCEpEzLKT33sU/E0t3k4It0VY1KFW2YuATiXXfVkabAKJhw1z7s9cz
	 psPt8bSi6Hjlv+rNacnMgD7Xdxz05JGEOm0BDq8RWaaIC7kStxBejtsSxvryXeXkiG
	 Ku0aT9kive/jYNCqFVc0qnyCtEllw9yCmCWIzh1oPrOwOoBynzTO26zdwl/2KM7oNt
	 CrOoKVXQLZDpcl1uMETHi62u5ibq77stB7srzADB4satq1fqwcXb0hwXA5kEf6qD0I
	 EWYgSYzRv2loRg94qZVSdjumvuXi3s9Ke+vBmDUHVKrvZmmzO6PRObF2xnO78FMKq3
	 xXjb7Rq3You8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>,
	"J . R . Okajima" <hooanon05g@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 2/3] lockdep: Fix upper limit for LOCKDEP_*_BITS configs
Date: Sun, 26 Jan 2025 09:50:55 -0500
Message-Id: <20250126145057.926069-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145057.926069-1-sashal@kernel.org>
References: <20250126145057.926069-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit e638072e61726cae363d48812815197a2a0e097f ]

Lockdep has a set of configs used to determine the size of the static
arrays that it uses. However, the upper limit that was initially setup
for these configs is too high (30 bit shift). This equates to several
GiB of static memory for individual symbols. Using such high values
leads to linker errors:

  $ make defconfig
  $ ./scripts/config -e PROVE_LOCKING --set-val LOCKDEP_BITS 30
  $ make olddefconfig all
  [...]
  ld: kernel image bigger than KERNEL_IMAGE_SIZE
  ld: section .bss VMA wraps around address space

Adjust the upper limits to the maximum values that avoid these issues.
The need for anything more, likely points to a problem elsewhere. Note
that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
had a different symptom and has already been fixed [1].

Reported-by: J. R. Okajima <hooanon05g@gmail.com>
Closes: https://lore.kernel.org/all/30795.1620913191@jrobl/ [1]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241024183631.643450-2-cmllamas@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2025b624fbb67..db4f8ac489d41 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1408,7 +1408,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1424,7 +1424,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1432,7 +1432,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
@@ -1440,7 +1440,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 config LOCKDEP_CIRCULAR_QUEUE_BITS
 	int "Bitsize for elements in circular_queue struct"
 	depends on LOCKDEP
-	range 10 30
+	range 10 26
 	default 12
 	help
 	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
-- 
2.39.5


