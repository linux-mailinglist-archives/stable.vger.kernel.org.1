Return-Path: <stable+bounces-110499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C83A1C97F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBF03A86EC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA11DE4C5;
	Sun, 26 Jan 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6MUaVZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F51DE3D8;
	Sun, 26 Jan 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903067; cv=none; b=j8ARGHSWoKXiO0xvx3SIvBFNojVmaOTIUaOh7mqP16vz8R7QehTRJso3gpVRAwja0fRffqkSjNmPmQ6AoHoIGEGAg33Jg50duRhO438uwUoQerfDv9r160h1QLwH2OBxpjhBX7neC8xaUbBTtjaCh6fjwfCPauPXwTaRlblPzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903067; c=relaxed/simple;
	bh=89CeYPzNYFN392VwOC99d0X5zTBu8pOseGg48dclxlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PH6BBGIaV9kKrI3c+3IOmENy95UFc3sgWEENgBmTAz+QtyBdSqHkQ2/JTPQTWCcX6eXvnW4ImuiY+iLWVUvX2LQua08NhsfysHb1MVPMsvGWX7MbWpHpEeWbl6GHju60wyrUazuOISTuQ5I1pXXBFzIyGQvUibrHKhUS0HvEEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6MUaVZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75252C4CED3;
	Sun, 26 Jan 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903067;
	bh=89CeYPzNYFN392VwOC99d0X5zTBu8pOseGg48dclxlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6MUaVZE6vdl5QZgnQD1Atz3DSzj2N/kCwOFSNrpMUwbcgZ1zmYE0fFg2t2noIxVM
	 UbpZBOo3oTLlYEzmOyyt6DaUdAUSeQ7mk3T408aEXcmkW+NdSO2RsBhv7wKbkG8t1H
	 Iu3cfxqsz+6tkFI/sjEA0rzw23cf5HAgUF00jNJ9pTXGZr3e4iBdFpohRjeYPIJet0
	 aemit36bhyfcfv8QexKgyrK9CwLcsOyqvvMbUyEDbc87F2w0Y/WrZ3Xtr+XxSytRmm
	 CdV05o6JVh4DhKZp571xNAT32ZbCmMcKvLyvHFT9ypprRFyo5odV0jKbDaolIJbFzl
	 irX/rNpfNN26A==
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
Subject: [PATCH AUTOSEL 5.10 2/3] lockdep: Fix upper limit for LOCKDEP_*_BITS configs
Date: Sun, 26 Jan 2025 09:51:02 -0500
Message-Id: <20250126145103.926122-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145103.926122-1-sashal@kernel.org>
References: <20250126145103.926122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 24ca61cf86ddc..c20729cd67b1e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1315,7 +1315,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1331,7 +1331,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1339,7 +1339,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
@@ -1347,7 +1347,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
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


