Return-Path: <stable+bounces-44209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460BB8C51BA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44A1282898
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9E13B2AD;
	Tue, 14 May 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfFEW5sq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966913B287;
	Tue, 14 May 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684973; cv=none; b=WYnkfyyRBQI0WmnuDGkN5/cAz/6+1SwQdLXp6U7xG05LNq2VTOyEZNCrsKKhpyHLI6/ULoN9CuOqXbA6pSN8ztxkqYk1AKqxYTjB5TgOJsniW0dcx0cB9gRfaru8A1C63VePdGGd3cZGlzDX6Kf2dm9dh2qLBopfdCnT+PXXX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684973; c=relaxed/simple;
	bh=4T8Lyt20n9SAQtQpiZsx8F1Jc/JxnqRPaQ7E3tUPEZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWFeMHPssIWr5BxE16rsl8htPK2nktv7W3HMyveMpeHPHiEwInqKW6fFTk7FWKwjBrnAut1/VURc93IWQWiI7gshn1h5ZfJG9vnKQ7CsKKTrqeFHNO5SHNaHYxtkKyPQzHrOABhRmtX97wwwidu9S35NzWH2ShurTO/EnSMMOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfFEW5sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA2C32781;
	Tue, 14 May 2024 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684973;
	bh=4T8Lyt20n9SAQtQpiZsx8F1Jc/JxnqRPaQ7E3tUPEZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfFEW5sqmN27yLT0OxDuXfN8HICSHe3xD6IiBpFTnA9OOj3etJt2yLrmt/kGd2R+R
	 0yGuSJKXMhEi9qztzfPKaFIu0XPAFPV5O+QntvIOr9ddGEUxabqkZrOGzS8D2cKO9x
	 KxBb6JuJGgJhMTNneq5o7jNHc6AQomsTJ+oelwTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 115/301] bpf: Check bloom filter map value size
Date: Tue, 14 May 2024 12:16:26 +0200
Message-ID: <20240514101036.592699459@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Matei <andreimatei1@gmail.com>

[ Upstream commit a8d89feba7e54e691ca7c4efc2a6264fa83f3687 ]

This patch adds a missing check to bloom filter creating, rejecting
values above KMALLOC_MAX_SIZE. This brings the bloom map in line with
many other map types.

The lack of this protection can cause kernel crashes for value sizes
that overflow int's. Such a crash was caught by syzkaller. The next
patch adds more guard-rails at a lower level.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240327024245.318299-2-andreimatei1@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bloom_filter.c                           | 13 +++++++++++++
 .../selftests/bpf/prog_tests/bloom_filter_map.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index addf3dd57b59b..35e1ddca74d21 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -80,6 +80,18 @@ static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return -EOPNOTSUPP;
 }
 
+/* Called from syscall */
+static int bloom_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->value_size > KMALLOC_MAX_SIZE)
+		/* if value_size is bigger, the user space won't be able to
+		 * access the elements.
+		 */
+		return -E2BIG;
+
+	return 0;
+}
+
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
@@ -191,6 +203,7 @@ static u64 bloom_map_mem_usage(const struct bpf_map *map)
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bloom_map_alloc_check,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
 	.map_get_next_key = bloom_map_get_next_key,
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index d2d9e965eba59..f79815b7e951b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 
 #include <sys/syscall.h>
+#include <limits.h>
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
@@ -21,6 +22,11 @@ static void test_fail_cases(void)
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value size 0"))
 		close(fd);
 
+	/* Invalid value size: too big */
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, INT32_MAX, 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value too large"))
+		close(fd);
+
 	/* Invalid max entries size */
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 0, NULL);
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max entries size"))
-- 
2.43.0




