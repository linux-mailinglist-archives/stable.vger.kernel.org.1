Return-Path: <stable+bounces-130814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D55A80665
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5961B82C73
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293D26B2BA;
	Tue,  8 Apr 2025 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXvupzvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3222206F18;
	Tue,  8 Apr 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114722; cv=none; b=BR+WejcTceT2wCn7fMFm140RV1RVYYkCKyuBfGFt1/eYLEmMjm6Q9y8G/es2bJOIhOh8vjxjtbc9f5mXIOcRhA0mJz3yo8iA5rhOYIvSLz/6THsMRUhOnIW16VJfNZ70743JB5BNkDNjCH2dHfM6+ywRpv0UGH5Ldnlr26jcXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114722; c=relaxed/simple;
	bh=DLhIMbW7J2r+BJE1zAdezXPzmXi2sgKuodt36dVNt7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY9YfXOF0evN/kaQm9YNtTrZfpFcyaEJCTKkTppr35kxALG01lMxT3Yl7eu4XyWr4FtiiHLxR3Gf2zS1DnLlftq0RKJvGxb8vuDqlZHh9nVKHGoapRMnq+88JDHvOnx8dhEZad6Tlxm9hat+K6pv1UCQaZJerNwfZPevzIySnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXvupzvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB51C4CEE5;
	Tue,  8 Apr 2025 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114722;
	bh=DLhIMbW7J2r+BJE1zAdezXPzmXi2sgKuodt36dVNt7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXvupzvvg5VljQKEyyyyYqEI88ltN2KWqlFfrzk7bpYCXu+e2xw1FjfdHVlWSdMFL
	 zPYSKus8L/pKXs4ndrZ/Y9v//uGMKFTPJA32+3/x0ePdjcES1XVFsXTORcayFX1tvk
	 jVj2IpenfUV0pu72gslsize+jZRpdE3AOeCtswL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 172/499] selftests/bpf: Select NUMA_NO_NODE to create map
Date: Tue,  8 Apr 2025 12:46:24 +0200
Message-ID: <20250408104855.465365075@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>

[ Upstream commit 4107a1aeb20ed4cdad6a0d49de92ea0f933c71b7 ]

On powerpc, a CPU does not necessarily originate from NUMA node 0.
This contrasts with architectures like x86, where CPU 0 is not
hot-pluggable, making NUMA node 0 a consistently valid node.
This discrepancy can lead to failures when creating a map on NUMA
node 0, which is initialized by default, if no CPUs are allocated
from NUMA node 0.

This patch fixes the issue by setting NUMA_NO_NODE (-1) for map
creation for this selftest.

Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/cf1f61468b47425ecf3728689bc9636ddd1d910e.1738302337.git.skb99@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index cc184e4420f6e..67557cda22083 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -6,6 +6,10 @@
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
+#ifndef NUMA_NO_NODE
+#define NUMA_NO_NODE	(-1)
+#endif
+
 static void test_fail_cases(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
@@ -69,6 +73,7 @@ static void test_success_cases(void)
 
 	/* Create a map */
 	opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
+	opts.numa_node = NUMA_NO_NODE;
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
 	if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter success case"))
 		return;
-- 
2.39.5




