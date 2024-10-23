Return-Path: <stable+bounces-87902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59059ACD17
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BA0B23C95
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216822101B9;
	Wed, 23 Oct 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcVPBl07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050621019E;
	Wed, 23 Oct 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693945; cv=none; b=ENAP/DxeTkzKChDAjY+eETQy8VpdoaLjNTAXCUC3MTkrpHIoA5RCse0kd9qKlejFcY04YfIXRr9sbfZRyBnVvgHh1vetBfJvSd7JlbgQ7E7OWTm92AAAzqWTaCJziBFHZ+LSHCL+45kvZe+I7+Jl7hnnK6VvwOtDqkMdj1Yu4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693945; c=relaxed/simple;
	bh=imG7XOhpPcLebJiLUrkf6tWJV5AXos0CtdMWmfyQNak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT7j+IEYuLwxp3IJti+BuI9iEu+lqQK31VmGj/wHn85LQf7n6WMjEipAaWvihUW7UdS4aLJjBTy7x60CJB7zRhCcQrjQSnTYVvbMyD+o1a8tlbDvoqL+Sm2/yZwN8byHHHw/57HNHQrEm/YQ0ZLSpZLNfnDucaHk6TbrBan0Jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcVPBl07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB62C4CEE4;
	Wed, 23 Oct 2024 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693945;
	bh=imG7XOhpPcLebJiLUrkf6tWJV5AXos0CtdMWmfyQNak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcVPBl07cItKL4rdhMn/OT/Tgq2UXNmVOrYbJBw3wpzPu9hfTs8/xmUJNNFTn/spj
	 vYMmKZDOpEzaOSnlprw7PujDuW3B5mgKHJeCepHz2Ld7Q9RhIau9jnoaFpg8PrNSfQ
	 4dgOy1hP4LXwkGtsAZszvJYOLLxkDAWZXRTls4HOdkXhY5eCxaACyh5Y8yRWnAQ4v7
	 SVbU2fYqdYxYdELEh/nKKm/yW9K3IzBpsZb4qvU0n75/qJtgyOzztx4EWkCDaAUB7p
	 45M4POFQXqWykgg99jX7tFtwK3sKipWHSieE1+1yXkPtSaGEYPJlRDaTt86NB2VpKq
	 gpXxtGepELmlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ryabinin.a.a@gmail.com,
	nathan@kernel.org,
	kasan-dev@googlegroups.com,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 14/17] kasan: Disable Software Tag-Based KASAN with GCC
Date: Wed, 23 Oct 2024 10:31:53 -0400
Message-ID: <20241023143202.2981992-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

[ Upstream commit 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18 ]

Syzbot reports a KASAN failure early during boot on arm64 when building
with GCC 12.2.0 and using the Software Tag-Based KASAN mode:

  | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
  | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
  | Write of size 4 at addr 03ff800086867e00 by task swapper/0
  | Pointer tag: [03], memory tag: [fe]

Initial triage indicates that the report is a false positive and a
thorough investigation of the crash by Mark Rutland revealed the root
cause to be a bug in GCC:

  > When GCC is passed `-fsanitize=hwaddress` or
  > `-fsanitize=kernel-hwaddress` it ignores
  > `__attribute__((no_sanitize_address))`, and instruments functions
  > we require are not instrumented.
  >
  > [...]
  >
  > All versions [of GCC] I tried were broken, from 11.3.0 to 14.2.0
  > inclusive.
  >
  > I think we have to disable KASAN_SW_TAGS with GCC until this is
  > fixed

Disable Software Tag-Based KASAN when building with GCC by making
CC_HAS_KASAN_SW_TAGS depend on !CC_IS_GCC.

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20241014161100.18034-1-will@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.kasan | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index ca09b1cf8ee9d..34420eb1cbfe1 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -22,8 +22,11 @@ config ARCH_DISABLE_KASAN_INLINE
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
+# GCC appears to ignore no_sanitize_address when -fsanitize=kernel-hwaddress
+# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=218854 (and
+# the linked LKML thread) for more details.
 config CC_HAS_KASAN_SW_TAGS
-	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
+	def_bool !CC_IS_GCC && $(cc-option, -fsanitize=kernel-hwaddress)
 
 # This option is only required for software KASAN modes.
 # Old GCC versions do not have proper support for no_sanitize_address.
@@ -91,7 +94,7 @@ config KASAN_SW_TAGS
 	help
 	  Enables Software Tag-Based KASAN.
 
-	  Requires GCC 11+ or Clang.
+	  Requires Clang.
 
 	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
 
-- 
2.43.0


