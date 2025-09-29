Return-Path: <stable+bounces-181900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9FBA945D
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C53C7C2D
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F430505E;
	Mon, 29 Sep 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hK2G2f+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0F26D4DE
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151037; cv=none; b=LWDguivxX8PvyR+jmTG27yNHXtO4j0sJdTTnKmtLWYPdDWGrQBrxHuDiLsq33oyHHbHpgJe1JhWgvEgNhZ+FjtUCsf2z5LuRuzAzJdqd+JIk9ZjBZ6D6aJQklk9I9HAKHr62lfK+OtfRinFGysX3+EdhLbrlFOMYarjnalAbM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151037; c=relaxed/simple;
	bh=XkTo+45Nt7kYLWFtVsrIgCYX9KGtvgC9akD3jOIrOfQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FK4Xut8xpsNSpuGHIkrK3hcIshG3NqyX9Jes2+JrJ9xnCYJgGx1lxhvLqrLaX4lP0jOHonfpVkDzYENLbaI6fZMAxOLRJuxJWtDR2ubQT3cVwGk9yUGZ8YhvliorQC3GepEXEdnWCYU6vWLcD+3Q/8Clsb7y+iB1ASu+i5MBALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hK2G2f+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C704C4CEF4;
	Mon, 29 Sep 2025 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759151037;
	bh=XkTo+45Nt7kYLWFtVsrIgCYX9KGtvgC9akD3jOIrOfQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hK2G2f+Tub9x0pb2KJuZVB5ESLXx7X6FZPoP1VaSHhM6F13zb+8pFucyVEa3tT9N/
	 aZ1i4rOTGcAuiofFFyGPUxkVJGsrc/NoOfZZYMSq0yWs0S+L1r5CFrWU5JmeqgpS9s
	 0iuJC7+zDM1nLsaDz4j++yF9wb1JEpUHyrkFzTQE=
Subject: FAILED: patch "[PATCH] kmsan: fix out-of-bounds access to shadow memory" failed to apply to 6.1-stable tree
To: ebiggers@kernel.org,akpm@linux-foundation.org,dvyukov@google.com,elver@google.com,glider@google.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:03:54 +0200
Message-ID: <2025092954-dance-oat-7fae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 85e1ff61060a765d91ee62dc5606d4d547d9d105
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092954-dance-oat-7fae@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85e1ff61060a765d91ee62dc5606d4d547d9d105 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 11 Sep 2025 12:58:58 -0700
Subject: [PATCH] kmsan: fix out-of-bounds access to shadow memory

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

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 1ea711786c52..8bca7fece47f 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -195,7 +195,8 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	u32 *shadow_start, *origin_start;
+	void *shadow_start;
+	u32 *aligned_shadow, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -214,9 +215,12 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
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
@@ -230,7 +234,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	 * corresponding shadow slot is zero.
 	 */
 	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
-		if (origin || !shadow_start[i])
+		if (origin || !aligned_shadow[i])
 			origin_start[i] = origin;
 	}
 }
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index c6c5b2bbede0..902ec48b1e3e 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -556,6 +556,21 @@ DEFINE_TEST_MEMSETXX(16)
 DEFINE_TEST_MEMSETXX(32)
 DEFINE_TEST_MEMSETXX(64)
 
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
 static noinline void fibonacci(int *array, int size, int start)
 {
 	if (start < 2 || (start == size))
@@ -677,6 +692,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
+	KUNIT_CASE(test_memset_on_guarded_buffer),
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
 	KUNIT_CASE(test_unpoison_memory),


