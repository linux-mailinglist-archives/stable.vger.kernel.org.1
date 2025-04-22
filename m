Return-Path: <stable+bounces-134945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55CA95B81
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FF91897747
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EB25DD08;
	Tue, 22 Apr 2025 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR0MHCt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99725E453;
	Tue, 22 Apr 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288252; cv=none; b=nUCeuXoe900/6mydm61hBt8GsLA/Gx+E4hC59XXPCCiHXylunDO0VQ7iIYJ6ZjowICRbBhrxU5hcpDpbJjUkAgUGis5iN673vuG7w+3+5tTeSomxdwlOha+RG7eefWMVqSTdzZrcfrCrYCPYD9vwYvPeZBuD7Eo4mn1RRuG2eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288252; c=relaxed/simple;
	bh=Bajci9RVViShoHebpmmjyMnZxE/rkvpjN1R1FfxX0Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlK7QMO7Pk+rOYrUTfVvCVF5/opWnaqz6/CNRjI85dciJ5x1LKgYarUSXA+jG2IN1of+hoT2gY2v+yNUGwusuLR6xujCxF4Se8zMVLlvblX5QMye6x1HAPMTJohHvNN921ZSMUcRBTCqQyyNy+k5r4kyayZC3RKAFBNUl6F1RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR0MHCt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06827C4CEEC;
	Tue, 22 Apr 2025 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288251;
	bh=Bajci9RVViShoHebpmmjyMnZxE/rkvpjN1R1FfxX0Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR0MHCt+WAdM/DaZ2CNOPP1RRkmly/rzqS7dVj2sFQWCfMstdTB60onjxqbWXkbzk
	 uDL06GBz+t+o00ma5eWoz0ZBxuju25ux2krvYtUreVwo4YCZr3CafV1XGLW3Y/lcpy
	 AbXu+X2m8cUyqGZSx58kxZmlQ8m/IA4M1AOuvxKOidyPcK5+ZcXm1NZHSHaK6lPwQt
	 u6ziUIDLgDeDGHIebxHTGCxs5zvpe9bhzdUL4+lL9jc9iD8uFl4GqUstEdbbcxovgH
	 Yac/X0mjYpccVXgAVNTkcr2qMzQoKFEawa1ugBIvPRYE2C47fqtg3DW5Uy1BlsOBj+
	 w5ddUO1LGGldA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 17/23] ubsan: Fix panic from test_ubsan_out_of_bounds
Date: Mon, 21 Apr 2025 22:16:57 -0400
Message-Id: <20250422021703.1941244-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Mostafa Saleh <smostafa@google.com>

[ Upstream commit 9b044614be12d78d3a93767708b8d02fb7dfa9b0 ]

Running lib_ubsan.ko on arm64 (without CONFIG_UBSAN_TRAP) panics the
kernel:

[   31.616546] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: test_ubsan_out_of_bounds+0x158/0x158 [test_ubsan]
[   31.646817] CPU: 3 UID: 0 PID: 179 Comm: insmod Not tainted 6.15.0-rc2 #1 PREEMPT
[   31.648153] Hardware name: linux,dummy-virt (DT)
[   31.648970] Call trace:
[   31.649345]  show_stack+0x18/0x24 (C)
[   31.650960]  dump_stack_lvl+0x40/0x84
[   31.651559]  dump_stack+0x18/0x24
[   31.652264]  panic+0x138/0x3b4
[   31.652812]  __ktime_get_real_seconds+0x0/0x10
[   31.653540]  test_ubsan_load_invalid_value+0x0/0xa8 [test_ubsan]
[   31.654388]  init_module+0x24/0xff4 [test_ubsan]
[   31.655077]  do_one_initcall+0xd4/0x280
[   31.655680]  do_init_module+0x58/0x2b4

That happens because the test corrupts other data in the stack:
400:   d5384108        mrs     x8, sp_el0
404:   f9426d08        ldr     x8, [x8, #1240]
408:   f85f83a9        ldur    x9, [x29, #-8]
40c:   eb09011f        cmp     x8, x9
410:   54000301        b.ne    470 <test_ubsan_out_of_bounds+0x154>  // b.any

As there is no guarantee the compiler will order the local variables
as declared in the module:
        volatile char above[4] = { }; /* Protect surrounding memory. */
        volatile int arr[4];
        volatile char below[4] = { }; /* Protect surrounding memory. */

There is another problem where the out-of-bound index is 5 which is larger
than the extra surrounding memory for protection.

So, use a struct to enforce the ordering, and fix the index to be 4.
Also, remove some of the volatiles and rely on OPTIMIZER_HIDE_VAR()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Link: https://lore.kernel.org/r/20250415203354.4109415-1-smostafa@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_ubsan.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 5d7b10e986107..63b7566e78639 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -68,18 +68,22 @@ static void test_ubsan_shift_out_of_bounds(void)
 
 static void test_ubsan_out_of_bounds(void)
 {
-	volatile int i = 4, j = 5, k = -1;
-	volatile char above[4] = { }; /* Protect surrounding memory. */
-	volatile int arr[4];
-	volatile char below[4] = { }; /* Protect surrounding memory. */
+	int i = 4, j = 4, k = -1;
+	volatile struct {
+		char above[4]; /* Protect surrounding memory. */
+		int arr[4];
+		char below[4]; /* Protect surrounding memory. */
+	} data;
 
-	above[0] = below[0];
+	OPTIMIZER_HIDE_VAR(i);
+	OPTIMIZER_HIDE_VAR(j);
+	OPTIMIZER_HIDE_VAR(k);
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
-	arr[j] = i;
+	data.arr[j] = i;
 
 	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
-	arr[k] = i;
+	data.arr[k] = i;
 }
 
 enum ubsan_test_enum {
-- 
2.39.5


