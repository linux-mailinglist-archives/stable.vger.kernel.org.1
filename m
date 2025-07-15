Return-Path: <stable+bounces-162141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458FB05BC2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF217164007
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4192E2F06;
	Tue, 15 Jul 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F881U6Dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFD2E041E;
	Tue, 15 Jul 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585782; cv=none; b=KPnBwadcWoy4290EeMljwuVzAYQSouOf92p1QD7lNjEcZaEVBpH2FzIcixq1c3htGo8GRcBw4DfZbPl6zO+VGy4Y9zg8SoPysXOiGwboOjbt+I3MfdEYS000rnKx+EfdZMWn9fpAVTqGJsQZCHcLu8oMh/nkSPWcLHTXTWzGFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585782; c=relaxed/simple;
	bh=tfQyQ2TgKosci/UIfNV8tCmTBnJ4SQ8LpATOTYWze8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTlWOvZ3cE3lwtCeEjJmW/UmS/BXS7VN3JK4ZHfkauFkwwDk53hmOSmuY/uNSW3LbJ25ekox2/1tauNpsB9qn2Lm/Yz3f50vUtNCKty5fiNpY0X+ZPU20/9wksO07G+B/gZMQ5nhjuTU9+Er6aLJZePJ53122sfO3B0ROYsvasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F881U6Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF111C4CEF1;
	Tue, 15 Jul 2025 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585782;
	bh=tfQyQ2TgKosci/UIfNV8tCmTBnJ4SQ8LpATOTYWze8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F881U6DvOQ2VHXjq3gVe+jUdq2hr1RxUEVOBU3kqcuIqoQHgR9npYIUSvJiYkUO7R
	 /Dr/vl2t+TYPI74lQQU8rzpzw2a29P/GmAZrMq9U0kOyQ6PP+FstxRSo4tsG8Am/+B
	 cF4w14eC5lUD6Z1ydPmb/UW8TKO8TF+I9zFUvXPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12 158/163] selftests/bpf: adapt one more case in test_lru_map to the new target_free
Date: Tue, 15 Jul 2025 15:13:46 +0200
Message-ID: <20250715130815.172872572@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit 5e9388f7984a9cc7e659a105113f6ccf0aebedd0 upstream.

The below commit that updated BPF_MAP_TYPE_LRU_HASH free target,
also updated tools/testing/selftests/bpf/test_lru_map to match.

But that missed one case that passes with 4 cores, but fails at
higher cpu counts.

Update test_lru_sanity3 to also adjust its expectation of target_free.

This time tested with 1, 4, 16, 64 and 384 cpu count.

Fixes: d4adf1c9ee77 ("bpf: Adjust free target to avoid global starvation of LRU map")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20250625210412.2732970-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_lru_map.c |   33 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -138,6 +138,12 @@ static int sched_next_online(int pid, in
 	return ret;
 }
 
+/* Derive target_free from map_size, same as bpf_common_lru_populate */
+static unsigned int __tgt_size(unsigned int map_size)
+{
+	return (map_size / nr_cpus) / 2;
+}
+
 /* Inverse of how bpf_common_lru_populate derives target_free from map_size. */
 static unsigned int __map_size(unsigned int tgt_free)
 {
@@ -410,12 +416,12 @@ static void test_lru_sanity2(int map_typ
 	printf("Pass\n");
 }
 
-/* Size of the LRU map is 2*tgt_free
- * It is to test the active/inactive list rotation
- * Insert 1 to 2*tgt_free (+2*tgt_free keys)
- * Lookup key 1 to tgt_free*3/2
- * Add 1+2*tgt_free to tgt_free*5/2 (+tgt_free/2 keys)
- *  => key 1+tgt_free*3/2 to 2*tgt_free are removed from LRU
+/* Test the active/inactive list rotation
+ *
+ * Fill the whole map, deplete the free list.
+ * Reference all except the last lru->target_free elements.
+ * Insert lru->target_free new elements. This triggers one shrink.
+ * Verify that the non-referenced elements are replaced.
  */
 static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -434,8 +440,7 @@ static void test_lru_sanity3(int map_typ
 
 	assert(sched_next_online(0, &next_cpu) != -1);
 
-	batch_size = tgt_free / 2;
-	assert(batch_size * 2 == tgt_free);
+	batch_size = __tgt_size(tgt_free);
 
 	map_size = tgt_free * 2;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
@@ -446,23 +451,21 @@ static void test_lru_sanity3(int map_typ
 
 	value[0] = 1234;
 
-	/* Insert 1 to 2*tgt_free (+2*tgt_free keys) */
-	end_key = 1 + (2 * tgt_free);
+	/* Fill the map */
+	end_key = 1 + map_size;
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Lookup key 1 to tgt_free*3/2 */
-	end_key = tgt_free + batch_size;
+	/* Reference all but the last batch_size */
+	end_key = 1 + map_size - batch_size;
 	for (key = 1; key < end_key; key++) {
 		assert(!bpf_map_lookup_elem_with_ref_bit(lru_map_fd, key, value));
 		assert(!bpf_map_update_elem(expected_map_fd, &key, value,
 					    BPF_NOEXIST));
 	}
 
-	/* Add 1+2*tgt_free to tgt_free*5/2
-	 * (+tgt_free/2 keys)
-	 */
+	/* Insert new batch_size: replaces the non-referenced elements */
 	key = 2 * tgt_free + 1;
 	end_key = key + batch_size;
 	for (; key < end_key; key++) {



