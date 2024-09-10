Return-Path: <stable+bounces-74618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951697303A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A09A1C23CE1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAFC188A28;
	Tue, 10 Sep 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmZ0f7yE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BE17C22F;
	Tue, 10 Sep 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962331; cv=none; b=mENvhm5MTrfn0V92l9g/tQasE7pHpHbeT6KH5+1aCLAFvuXJ1DGIMHA1Ma8RBEPvJSEUZgH/CvzwiE7uf57drdJJ0wuYdVH8+ttltdfkXeuioyKXzria6EjiayqgJJKe+RTksRcJCnr5I2pvrW/UePBB/ZQow5A1ObRJ72GmFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962331; c=relaxed/simple;
	bh=sNxqedXu9feWD4+JJvRh/BsR0E1O3i1/wXHymEivR2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4F4jXAKnqI5wOlSFrvBeexGQpsAzsSu8u/YwTtSETQHFUJmxXs/ws8w1qqz71Fz8GwedaTSoUp0suYQGVt79HWF3GMuavERX3T+3hIDdH8vJhzYJYa4Y0OFLMVvyOE40Aw4YaBL0va9cuW7U3EyyVyiDm7chhMM3QNTNMK3WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmZ0f7yE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DDEC4CEC3;
	Tue, 10 Sep 2024 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962330;
	bh=sNxqedXu9feWD4+JJvRh/BsR0E1O3i1/wXHymEivR2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmZ0f7yETmNsR/G4d5kG2C9fqvGgCUzHXRYyn8x7Gy6pEQxR5TYJxaDt/vs1Ak+aN
	 FQzojWP5CsyqRp0tTMh6+/KhIswRrR4akPaqyzQ6MSGQQ+jwcF/n5yeKzmbPMT8baI
	 96VLYTLS8duDfiUKJZwS85Re/WsXhp8dSx9TVC6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 347/375] riscv: selftests: Remove mmap hint address checks
Date: Tue, 10 Sep 2024 11:32:24 +0200
Message-ID: <20240910092634.249591527@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit 83dae72ac0382693540a055ec6210dd3691a8df6 ]

The mmap behavior that restricts the addresses returned by mmap caused
unexpected behavior, so get rid of the test cases that check that
behavior.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 73d05262a2ca ("selftests: riscv: Generalize mm selftests")
Link: https://lore.kernel.org/r/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/riscv/mm/mmap_bottomup.c        |  2 -
 .../testing/selftests/riscv/mm/mmap_default.c |  2 -
 tools/testing/selftests/riscv/mm/mmap_test.h  | 67 -------------------
 3 files changed, 71 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index 7f7d3eb8b9c9..f9ccae50349b 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -7,8 +7,6 @@
 TEST(infinite_rlimit)
 {
 	EXPECT_EQ(BOTTOM_UP, memory_layout());
-
-	TEST_MMAPS;
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index 2ba3ec990006..3f53b6ecc326 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -7,8 +7,6 @@
 TEST(default_rlimit)
 {
 	EXPECT_EQ(TOP_DOWN, memory_layout());
-
-	TEST_MMAPS;
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 3b29ca3bb3d4..75918d15919f 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -10,76 +10,9 @@
 #define TOP_DOWN 0
 #define BOTTOM_UP 1
 
-#if __riscv_xlen == 64
-uint64_t random_addresses[] = {
-	0x19764f0d73b3a9f0, 0x016049584cecef59, 0x3580bdd3562f4acd,
-	0x1164219f20b17da0, 0x07d97fcb40ff2373, 0x76ec528921272ee7,
-	0x4dd48c38a3de3f70, 0x2e11415055f6997d, 0x14b43334ac476c02,
-	0x375a60795aff19f6, 0x47f3051725b8ee1a, 0x4e697cf240494a9f,
-	0x456b59b5c2f9e9d1, 0x101724379d63cb96, 0x7fe9ad31619528c1,
-	0x2f417247c495c2ea, 0x329a5a5b82943a5e, 0x06d7a9d6adcd3827,
-	0x327b0b9ee37f62d5, 0x17c7b1851dfd9b76, 0x006ebb6456ec2cd9,
-	0x00836cd14146a134, 0x00e5c4dcde7126db, 0x004c29feadf75753,
-	0x00d8b20149ed930c, 0x00d71574c269387a, 0x0006ebe4a82acb7a,
-	0x0016135df51f471b, 0x00758bdb55455160, 0x00d0bdd949b13b32,
-	0x00ecea01e7c5f54b, 0x00e37b071b9948b1, 0x0011fdd00ff57ab3,
-	0x00e407294b52f5ea, 0x00567748c200ed20, 0x000d073084651046,
-	0x00ac896f4365463c, 0x00eb0d49a0b26216, 0x0066a2564a982a31,
-	0x002e0d20237784ae, 0x0000554ff8a77a76, 0x00006ce07a54c012,
-	0x000009570516d799, 0x00000954ca15b84d, 0x0000684f0d453379,
-	0x00002ae5816302b5, 0x0000042403fb54bf, 0x00004bad7392bf30,
-	0x00003e73bfa4b5e3, 0x00005442c29978e0, 0x00002803f11286b6,
-	0x000073875d745fc6, 0x00007cede9cb8240, 0x000027df84cc6a4f,
-	0x00006d7e0e74242a, 0x00004afd0b836e02, 0x000047d0e837cd82,
-	0x00003b42405efeda, 0x00001531bafa4c95, 0x00007172cae34ac4,
-};
-#else
-uint32_t random_addresses[] = {
-	0x8dc302e0, 0x929ab1e0, 0xb47683ba, 0xea519c73, 0xa19f1c90, 0xc49ba213,
-	0x8f57c625, 0xadfe5137, 0x874d4d95, 0xaa20f09d, 0xcf21ebfc, 0xda7737f1,
-	0xcedf392a, 0x83026c14, 0xccedca52, 0xc6ccf826, 0xe0cd9415, 0x997472ca,
-	0xa21a44c1, 0xe82196f5, 0xa23fd66b, 0xc28d5590, 0xd009cdce, 0xcf0be646,
-	0x8fc8c7ff, 0xe2a85984, 0xa3d3236b, 0x89a0619d, 0xc03db924, 0xb5d4cc1b,
-	0xb96ee04c, 0xd191da48, 0xb432a000, 0xaa2bebbc, 0xa2fcb289, 0xb0cca89b,
-	0xb0c18d6a, 0x88f58deb, 0xa4d42d1c, 0xe4d74e86, 0x99902b09, 0x8f786d31,
-	0xbec5e381, 0x9a727e65, 0xa9a65040, 0xa880d789, 0x8f1b335e, 0xfc821c1e,
-	0x97e34be4, 0xbbef84ed, 0xf447d197, 0xfd7ceee2, 0xe632348d, 0xee4590f4,
-	0x958992a5, 0xd57e05d6, 0xfd240970, 0xc5b0dcff, 0xd96da2c2, 0xa7ae041d,
-};
-#endif
-
-// Only works on 64 bit
-#if __riscv_xlen == 64
 #define PROT (PROT_READ | PROT_WRITE)
 #define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS)
 
-/* mmap must return a value that doesn't use more bits than the hint address. */
-static inline unsigned long get_max_value(unsigned long input)
-{
-	unsigned long max_bit = (1UL << (((sizeof(unsigned long) * 8) - 1 -
-					  __builtin_clzl(input))));
-
-	return max_bit + (max_bit - 1);
-}
-
-#define TEST_MMAPS                                                            \
-	({                                                                    \
-		void *mmap_addr;                                              \
-		for (int i = 0; i < ARRAY_SIZE(random_addresses); i++) {      \
-			mmap_addr = mmap((void *)random_addresses[i],         \
-					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
-			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
-			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
-				  mmap_addr);                                 \
-			mmap_addr = mmap((void *)random_addresses[i],         \
-					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
-			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
-			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
-				  mmap_addr);                                 \
-		}                                                             \
-	})
-#endif /* __riscv_xlen == 64 */
-
 static inline int memory_layout(void)
 {
 	void *value1 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);
-- 
2.43.0




