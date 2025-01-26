Return-Path: <stable+bounces-110490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062CA1C96F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8704D3A26F7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A51DB924;
	Sun, 26 Jan 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFVgVVoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13474193079;
	Sun, 26 Jan 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903047; cv=none; b=ECWFSV9gxEKXfyLFUPHZFIaMLtK4+io0TLd36B5FBd593VNQ6+zK5QTDe9ub8KSBlv22TJ8SUmr7ICjigMBb0hVtaotA2Kqy9fnr+tPFKOD+Pxig/v6/45Z+9nX75LHvXmCUfcdqtv1H3AC2qr+/QhXac2+FPnvGDwtNDqlveZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903047; c=relaxed/simple;
	bh=1SZq1ex0BUPPQ4vKNlgISLqwNRY7qa90nR0fkbZCbKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4XPgemDrCPMBVfft9JxjpMhYB3pFnZz7259sOxp9YT1fQ/REbqkKwqTHTJVMOAbQwk34/IGMPQuFhDW3zsmQJ8MIFnWeaUWUwgM/4kbK6fgemMKYUdnKh5OhZAut05WiKkQDQLAx+aPU2d1utqJqYLKHeZ/SG46mZvnvBi26eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFVgVVoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB28C4CED3;
	Sun, 26 Jan 2025 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903046;
	bh=1SZq1ex0BUPPQ4vKNlgISLqwNRY7qa90nR0fkbZCbKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFVgVVoLnAtSlD5+xLIrDfTe65Pmufu8uAPH6cvTSDIicKD0MMmRZSFMMbUDUzGrp
	 SybAlYKFdYSt3kRVuyZK/PNlgko8SR0DrnocRrzApzT4E7sLlKs01iPt8rj2bnoDg0
	 fOt+H7XELyRNq7eHHOuwJXsIpwW2XHv3fXQ8DpYwZVHCqSXd5CRNZLgKv/lrQAR2N+
	 f7zcFQBYwYHIjUibs/xeYIqbs3ARKzMquEtL5kljgvv0PKgTQLsKpc5ZfGxrNptuPv
	 LgW+yqOx7KOLWRKQlKyc0h2X+CFEONpSnSzSsYyIgYfJ7pDOFa/A4l3iW3Vln9icOP
	 F4EfkkV187FlQ==
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
Subject: [PATCH AUTOSEL 6.6 2/3] lockdep: Fix upper limit for LOCKDEP_*_BITS configs
Date: Sun, 26 Jan 2025 09:50:41 -0500
Message-Id: <20250126145043.925962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145043.925962-1-sashal@kernel.org>
References: <20250126145043.925962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index f94c3e957b829..e809b6d8bc537 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1454,7 +1454,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1470,7 +1470,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1478,7 +1478,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
@@ -1486,7 +1486,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
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


