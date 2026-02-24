Return-Path: <stable+bounces-217876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAIGOFpWnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3318329E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8112E3053663
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9AC284894;
	Tue, 24 Feb 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z1soLWGj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298623B632
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918712; cv=none; b=pOPBI4iQ83PTQIE+8mfKnZNQ5oa5Sxu7XFQKjdzyryKD54d4oXeufmWRcQNKPkaN4Z09aKtDvhbfjqvmvFkkNf3SieRC1gDh5BwLfCZhA36Vhi7ufhtJGfJg18mUfkSbuD0sHM803yaSk7j190vSjRzBlji16L5IYWt6AxkyumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918712; c=relaxed/simple;
	bh=VNyOiWFN5fxe/ecqrxgbpB4FuxUE0jQOJObUehSUYeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6Pbjym7+gUEHZ4dMphR2btSE7c/erYYoX1wPrakXdm+0K/7MbgN6GEpY/UHUXrITdzlJUh4DLePJ9j7yYgktPxubbohsb6g2uj2lPKnB/+HVpp59EqF+t5Mlxii6C1fQOvSFkZv+M8R4rsIHajRaI3WGYRgQGdmT+XsODLPXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z1soLWGj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so3289000f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918709; x=1772523509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9j02kJAvQ9OZnSANeuTWmafFwL3uUUF7caCD34Yrjs=;
        b=Z1soLWGjfOfQwPrJEpkhs8F22MmwrtiNBQYkHo1JpzEOtHSnBQ9xLrIkpgTY6PI4Sl
         87bifnDUOU2SYRa+WSGf2E3Qccioa20WCTAFL1+sx7dQBxs4/YOyR/TFz8t3mDo8PmN1
         5ncNGR9fuv61v54Awz9cPz857En8PYYGUAKtuq+ikbmD474/J7QDv5vjtP1YfHw88Nd5
         XZQqx8qx1Pjd+phUL5BXtCh/fcgcSpa48dvTPGHGt3Bit4sJ+UQ04tDg2dN4SAe8fkzp
         rsKDFyUNwByksXFn3M82FBjHq2hrEmP8p2AqbLuzj9nEC2nfWXXsktUSqUfnrEgATVBD
         f9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918709; x=1772523509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9j02kJAvQ9OZnSANeuTWmafFwL3uUUF7caCD34Yrjs=;
        b=nrvwpjhPCQ2bnnhrp/ZYNNXNt5lwxlFHy7jvMS1zYCttJg0aeXCgNqIb0BTTpvJgmU
         //HpA61UcTEmQeAX4KzNx9c5DVna2xwSZlfrnQ5mO81zHxBlgcyKrW6wQzLVx5dnYkEP
         8hjapzng8ZbA7+6Zss/4SkNd5MTEioNW027d600lPebIipHzz0EYeFJeTOFGU5gU5lOu
         ygyUB3kYv8rtHIHF/MGtUX6L1awWiiFeAr1YtdUJ0Baa/iL0afWWOYib6qFPJXge6nCO
         ns0/+Xr0Xtxg5AhVQelzaAMynLFSrTbOtV2qiRv47sTD+b/w2wXZHi0p6zBSK/J0T0/J
         vXCA==
X-Gm-Message-State: AOJu0Yz3K57hiZ8XPD4IQ6a30Rz02BZ6ksEzTRD3LqTBUE/UlbbUCAPq
	xxv+oI3I1aCwWtltu3M1QurH3K/JzMlsoEQLBYHjiAuGm8s8D2BiCoaP9UVWUxtHE0g3cxr9eD6
	NyRQD
X-Gm-Gg: AZuq6aJHJukrC+ps+pI+bAuvjiluiImJ8MH6grGhrrQQ4a7QbtyWgarqETB7bNCGEeF
	9GYxDQAtfB3YnFXbYClODdm2/tU3HcS7eoEtwn2XL7vKFlURx7cOqURNq0AD7fV9HQW+CEo6hXH
	koWwVi6QT/KmD3UC8wCI+czePr5weUbOTSNn6rjfaFB92r/jvkwcvcrVP5wa4xTipZQX98c/it6
	QNKuO5mlTGz6R98o2y2kLpvfoqKVYr60PvJEQwtCU31rvuhEUAPgixixTQr5dTC97kGQrj+Nwf0
	dA3XYt3E0fJSUzeo707RuIKKDEbH03kbSX5ExikN+2N/bj1nKVPQxsuglco6wFjfXb/R0TFA/ys
	XWOFDpsUGExa327rhjGpdEQaiqkvUsbkPe7Qzjk3bXOuoQLn7Wtk3L9nMDPkBoTRvMBa5ipIuTg
	VwXAsI9NiorOenrJ18wOnn9KZ/aQ==
X-Received: by 2002:a05:600c:1f8f:b0:483:6d4e:9811 with SMTP id 5b1f17b1804b1-483a95ee3f2mr206407545e9.31.1771918709071;
        Mon, 23 Feb 2026 23:38:29 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7253a70sm9601336a12.24.2026.02.23.23.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:28 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 3/5] selftests/bpf: tc_links/tc_opts: Unserialize tests
Date: Tue, 24 Feb 2026 15:38:04 +0800
Message-ID: <20260224073810.85945-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224073810.85945-1-shung-hsi.yu@suse.com>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217876-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FA3318329E
X-Rspamd-Action: no action

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>

commit 207cd7578ad16dc033ab55c13ae23d27a67fc0f5 upstream.

Tests are serialized because they all use the loopback interface.

Replace the 'serial_test_' prefixes with 'test_ns_' to benefit from the
new test_prog feature which creates a dedicated namespace for each test,
allowing them to run in parallel.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Link: https://lore.kernel.org/r/20250219-b4-tc_links-v2-3-14504db136b7@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 6cc73f35406c ("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/tc_links.c       | 28 ++++++-------
 .../selftests/bpf/prog_tests/tc_opts.c        | 40 +++++++++----------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 1af9ec1149aa..2186a24e7d8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -13,7 +13,7 @@
 #include "netlink_helpers.h"
 #include "tc_helpers.h"
 
-void serial_test_tc_links_basic(void)
+void test_ns_tc_links_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_query_opts, optq);
 	LIBBPF_OPTS(bpf_tcx_opts, optl);
@@ -260,7 +260,7 @@ static void test_tc_links_before_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_before(void)
+void test_ns_tc_links_before(void)
 {
 	test_tc_links_before_target(BPF_TCX_INGRESS);
 	test_tc_links_before_target(BPF_TCX_EGRESS);
@@ -414,7 +414,7 @@ static void test_tc_links_after_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_after(void)
+void test_ns_tc_links_after(void)
 {
 	test_tc_links_after_target(BPF_TCX_INGRESS);
 	test_tc_links_after_target(BPF_TCX_EGRESS);
@@ -514,7 +514,7 @@ static void test_tc_links_revision_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_revision(void)
+void test_ns_tc_links_revision(void)
 {
 	test_tc_links_revision_target(BPF_TCX_INGRESS);
 	test_tc_links_revision_target(BPF_TCX_EGRESS);
@@ -618,7 +618,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_chain_classic(void)
+void test_ns_tc_links_chain_classic(void)
 {
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
@@ -846,7 +846,7 @@ static void test_tc_links_replace_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_replace(void)
+void test_ns_tc_links_replace(void)
 {
 	test_tc_links_replace_target(BPF_TCX_INGRESS);
 	test_tc_links_replace_target(BPF_TCX_EGRESS);
@@ -1158,7 +1158,7 @@ static void test_tc_links_invalid_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_invalid(void)
+void test_ns_tc_links_invalid(void)
 {
 	test_tc_links_invalid_target(BPF_TCX_INGRESS);
 	test_tc_links_invalid_target(BPF_TCX_EGRESS);
@@ -1314,7 +1314,7 @@ static void test_tc_links_prepend_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_prepend(void)
+void test_ns_tc_links_prepend(void)
 {
 	test_tc_links_prepend_target(BPF_TCX_INGRESS);
 	test_tc_links_prepend_target(BPF_TCX_EGRESS);
@@ -1470,7 +1470,7 @@ static void test_tc_links_append_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_append(void)
+void test_ns_tc_links_append(void)
 {
 	test_tc_links_append_target(BPF_TCX_INGRESS);
 	test_tc_links_append_target(BPF_TCX_EGRESS);
@@ -1568,7 +1568,7 @@ static void test_tc_links_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_cleanup(void)
+void test_ns_tc_links_dev_cleanup(void)
 {
 	test_tc_links_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_links_dev_cleanup_target(BPF_TCX_EGRESS);
@@ -1672,7 +1672,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_links_chain_mixed(void)
+void test_ns_tc_links_chain_mixed(void)
 {
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
@@ -1782,7 +1782,7 @@ static void test_tc_links_ingress(int target, bool chain_tc_old,
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_links_ingress(void)
+void test_ns_tc_links_ingress(void)
 {
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, true);
 	test_tc_links_ingress(BPF_TCX_INGRESS, true, false);
@@ -1823,7 +1823,7 @@ static int qdisc_replace(int ifindex, const char *kind, bool block)
 	return err;
 }
 
-void serial_test_tc_links_dev_chain0(void)
+void test_ns_tc_links_dev_chain0(void)
 {
 	int err, ifindex;
 
@@ -1955,7 +1955,7 @@ static void test_tc_links_dev_mixed(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_links_dev_mixed(void)
+void test_ns_tc_links_dev_mixed(void)
 {
 	test_tc_links_dev_mixed(BPF_TCX_INGRESS);
 	test_tc_links_dev_mixed(BPF_TCX_EGRESS);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index f77f604389aa..dd7a138d8c3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -10,7 +10,7 @@
 #include "test_tc_link.skel.h"
 #include "tc_helpers.h"
 
-void serial_test_tc_opts_basic(void)
+void test_ns_tc_opts_basic(void)
 {
 	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
 	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
@@ -254,7 +254,7 @@ static void test_tc_opts_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_before(void)
+void test_ns_tc_opts_before(void)
 {
 	test_tc_opts_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_before_target(BPF_TCX_EGRESS);
@@ -445,7 +445,7 @@ static void test_tc_opts_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_after(void)
+void test_ns_tc_opts_after(void)
 {
 	test_tc_opts_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_after_target(BPF_TCX_EGRESS);
@@ -554,7 +554,7 @@ static void test_tc_opts_revision_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_revision(void)
+void test_ns_tc_opts_revision(void)
 {
 	test_tc_opts_revision_target(BPF_TCX_INGRESS);
 	test_tc_opts_revision_target(BPF_TCX_EGRESS);
@@ -655,7 +655,7 @@ static void test_tc_chain_classic(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_chain_classic(void)
+void test_ns_tc_opts_chain_classic(void)
 {
 	test_tc_chain_classic(BPF_TCX_INGRESS, false);
 	test_tc_chain_classic(BPF_TCX_EGRESS, false);
@@ -864,7 +864,7 @@ static void test_tc_opts_replace_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_replace(void)
+void test_ns_tc_opts_replace(void)
 {
 	test_tc_opts_replace_target(BPF_TCX_INGRESS);
 	test_tc_opts_replace_target(BPF_TCX_EGRESS);
@@ -1017,7 +1017,7 @@ static void test_tc_opts_invalid_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_invalid(void)
+void test_ns_tc_opts_invalid(void)
 {
 	test_tc_opts_invalid_target(BPF_TCX_INGRESS);
 	test_tc_opts_invalid_target(BPF_TCX_EGRESS);
@@ -1157,7 +1157,7 @@ static void test_tc_opts_prepend_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_prepend(void)
+void test_ns_tc_opts_prepend(void)
 {
 	test_tc_opts_prepend_target(BPF_TCX_INGRESS);
 	test_tc_opts_prepend_target(BPF_TCX_EGRESS);
@@ -1297,7 +1297,7 @@ static void test_tc_opts_append_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_append(void)
+void test_ns_tc_opts_append(void)
 {
 	test_tc_opts_append_target(BPF_TCX_INGRESS);
 	test_tc_opts_append_target(BPF_TCX_EGRESS);
@@ -1387,7 +1387,7 @@ static void test_tc_opts_dev_cleanup_target(int target)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_dev_cleanup(void)
+void test_ns_tc_opts_dev_cleanup(void)
 {
 	test_tc_opts_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_opts_dev_cleanup_target(BPF_TCX_EGRESS);
@@ -1563,7 +1563,7 @@ static void test_tc_opts_mixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_mixed(void)
+void test_ns_tc_opts_mixed(void)
 {
 	test_tc_opts_mixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_mixed_target(BPF_TCX_EGRESS);
@@ -1642,7 +1642,7 @@ static void test_tc_opts_demixed_target(int target)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_demixed(void)
+void test_ns_tc_opts_demixed(void)
 {
 	test_tc_opts_demixed_target(BPF_TCX_INGRESS);
 	test_tc_opts_demixed_target(BPF_TCX_EGRESS);
@@ -1813,7 +1813,7 @@ static void test_tc_opts_detach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach(void)
+void test_ns_tc_opts_detach(void)
 {
 	test_tc_opts_detach_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_target(BPF_TCX_EGRESS);
@@ -2020,7 +2020,7 @@ static void test_tc_opts_detach_before_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_before(void)
+void test_ns_tc_opts_detach_before(void)
 {
 	test_tc_opts_detach_before_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_before_target(BPF_TCX_EGRESS);
@@ -2236,7 +2236,7 @@ static void test_tc_opts_detach_after_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_detach_after(void)
+void test_ns_tc_opts_detach_after(void)
 {
 	test_tc_opts_detach_after_target(BPF_TCX_INGRESS);
 	test_tc_opts_detach_after_target(BPF_TCX_EGRESS);
@@ -2265,7 +2265,7 @@ static void test_tc_opts_delete_empty(int target, bool chain_tc_old)
 	assert_mprog_count(target, 0);
 }
 
-void serial_test_tc_opts_delete_empty(void)
+void test_ns_tc_opts_delete_empty(void)
 {
 	test_tc_opts_delete_empty(BPF_TCX_INGRESS, false);
 	test_tc_opts_delete_empty(BPF_TCX_EGRESS, false);
@@ -2372,7 +2372,7 @@ static void test_tc_chain_mixed(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_chain_mixed(void)
+void test_ns_tc_opts_chain_mixed(void)
 {
 	test_tc_chain_mixed(BPF_TCX_INGRESS);
 	test_tc_chain_mixed(BPF_TCX_EGRESS);
@@ -2446,7 +2446,7 @@ static void test_tc_opts_max_target(int target, int flags, bool relative)
 	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
 }
 
-void serial_test_tc_opts_max(void)
+void test_ns_tc_opts_max(void)
 {
 	test_tc_opts_max_target(BPF_TCX_INGRESS, 0, false);
 	test_tc_opts_max_target(BPF_TCX_EGRESS, 0, false);
@@ -2748,7 +2748,7 @@ static void test_tc_opts_query_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query(void)
+void test_ns_tc_opts_query(void)
 {
 	test_tc_opts_query_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_target(BPF_TCX_EGRESS);
@@ -2807,7 +2807,7 @@ static void test_tc_opts_query_attach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query_attach(void)
+void test_ns_tc_opts_query_attach(void)
 {
 	test_tc_opts_query_attach_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_attach_target(BPF_TCX_EGRESS);
-- 
2.53.0


