Return-Path: <stable+bounces-181992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB0BAA723
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB65119223F7
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B92417E6;
	Mon, 29 Sep 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ/j+QuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2F19E967
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173759; cv=none; b=M8hP+lWfQ2C8HW2m40z7NOl4GTWGWWqKTvHs2gwtte2bsRoYwZGj+/ReoaHYtVUi/Q9SAaWFCB3tpb5DFwWo7KGR7dCEEKpW2T8oa5JYF3CjdLceLRwfvVEzczgl+4gdAJ1Olwn2ZPaF9BnnetkVn4uJAwZjoOUUqkvG5px7Jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173759; c=relaxed/simple;
	bh=N1FDCvMKunrPkPIncK4DI/hSXuBcYWELpO1GVr3/98A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuS66ADBsP0KCoJ/85XpDvvDiyInrC1VVzvp1YjiAzjJkjOyLjFyytG91Yq8bFdnzoDTSiTFhTlK4etgyN6fdbdoZS790kO8aJr6uSOBaTmZkLcPuFiAN/tca0gkSM3X4AjwXkdxQkpWg4zTj2Z+9NnQ4pYBHHdnew30qpo7Xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ/j+QuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969FDC4CEF4;
	Mon, 29 Sep 2025 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759173758;
	bh=N1FDCvMKunrPkPIncK4DI/hSXuBcYWELpO1GVr3/98A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ/j+QuWGsCCnWYU/WTnfL7trNEb603Hoo2FJflW0yJn1DWAHmzouDtYjqe2skIpP
	 HP6NjXDSoXRXeemCqvpTGu/DvzotidT0o8ALJ7Q+GgrgLsQYJp2b+4K7E+3e2kJpqN
	 Fa/lCp/FmrhbtoPwO+oILQ0jdx0or+FlGy0mR4EiAkPGwpYQMylwPnATVUSOHru/db
	 5MPBrgjD5oVRudZ/20X+B9aVv8R/fViWchfuIsWQh4AN3vjNBWj2vGZ1j6/FuGlzv9
	 XdvAi6ggoTWNSU1OHD+VH3swHcDg3D5IUGkHeRpnQrRI8PFNTWTqYXxzVSNsHWln2C
	 dfM00PFzXw30w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] kmsan: fix out-of-bounds access to shadow memory
Date: Mon, 29 Sep 2025 15:22:34 -0400
Message-ID: <20250929192234.298716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092954-dance-oat-7fae@gregkh>
References: <2025092954-dance-oat-7fae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 85e1ff61060a765d91ee62dc5606d4d547d9d105 ]

Running sha224_kunit on a KMSAN-enabled kernel results in a crash in
kmsan_internal_set_shadow_origin():

    BUG: unable to handle page fault for address: ffffbc3840291000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 1810067 P4D 1810067 PUD 192d067 PMD 3c17067 PTE 0
    Oops: 0000 [#1] SMP NOPTI
    CPU: 0 UID: 0 PID: 81 Comm: kunit_try_catch Tainted: G                 N  6.17.0-rc3 #10 PREEMPT(voluntary)
    Tainted: [N]=TEST
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
    RIP: 0010:kmsan_internal_set_shadow_origin+0x91/0x100
    [...]
    Call Trace:
    <TASK>
    __msan_memset+0xee/0x1a0
    sha224_final+0x9e/0x350
    test_hash_buffer_overruns+0x46f/0x5f0
    ? kmsan_get_shadow_origin_ptr+0x46/0xa0
    ? __pfx_test_hash_buffer_overruns+0x10/0x10
    kunit_try_run_case+0x198/0xa00

This occurs when memset() is called on a buffer that is not 4-byte aligned
and extends to the end of a guard page, i.e.  the next page is unmapped.

The bug is that the loop at the end of kmsan_internal_set_shadow_origin()
accesses the wrong shadow memory bytes when the address is not 4-byte
aligned.  Since each 4 bytes are associated with an origin, it rounds the
address and size so that it can access all the origins that contain the
buffer.  However, when it checks the corresponding shadow bytes for a
particular origin, it incorrectly uses the original unrounded shadow
address.  This results in reads from shadow memory beyond the end of the
buffer's shadow memory, which crashes when that memory is not mapped.

To fix this, correctly align the shadow address before accessing the 4
shadow bytes corresponding to each origin.

Link: https://lkml.kernel.org/r/20250911195858.394235-1-ebiggers@kernel.org
Fixes: 2ef3cec44c60 ("kmsan: do not wipe out origin when doing partial unpoisoning")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context in tests ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmsan/core.c       | 10 +++++++---
 mm/kmsan/kmsan_test.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index dff759f32bbb3..ea5a06fe94f99 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -258,7 +258,8 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	u32 *shadow_start, *origin_start;
+	void *shadow_start;
+	u32 *aligned_shadow, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -277,9 +278,12 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	}
 	__memset(shadow_start, b, size);
 
-	if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+	if (IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+		aligned_shadow = shadow_start;
+	} else {
 		pad = address % KMSAN_ORIGIN_SIZE;
 		address -= pad;
+		aligned_shadow = shadow_start - pad;
 		size += pad;
 	}
 	size = ALIGN(size, KMSAN_ORIGIN_SIZE);
@@ -293,7 +297,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	 * corresponding shadow slot is zero.
 	 */
 	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
-		if (origin || !shadow_start[i])
+		if (origin || !aligned_shadow[i])
 			origin_start[i] = origin;
 	}
 }
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 1328636cbd6cd..bc2a460000ff6 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -470,6 +470,21 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/* Test case: ensure that KMSAN does not access shadow memory out of bounds. */
+static void test_memset_on_guarded_buffer(struct kunit *test)
+{
+	void *buf = vmalloc(PAGE_SIZE);
+
+	kunit_info(test,
+		   "memset() on ends of guarded buffer should not crash\n");
+
+	for (size_t size = 0; size <= 128; size++) {
+		memset(buf, 0xff, size);
+		memset(buf + PAGE_SIZE - size, 0xff, size);
+	}
+	vfree(buf);
+}
+
 static noinline void fibonacci(int *array, int size, int start) {
 	if (start < 2 || (start == size))
 		return;
@@ -515,6 +530,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_memset_on_guarded_buffer),
 	KUNIT_CASE(test_long_origin_chain),
 	{},
 };
-- 
2.51.0


