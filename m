Return-Path: <stable+bounces-219150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M98OdVknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD81191115
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68BAE308E875
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E611299924;
	Wed, 25 Feb 2026 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sk64ZixU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053B296BD1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988144; cv=none; b=LvqmFkqITvnH9SWYdyuS/UwHLwX+kDNLbZkikY0xf1uPgPTHQyAkhq+Sy2+wJfeN6VIiwmnu3OqjOWh6j4QqdUn4CAMC7ZI/LYpr3scYFXkXZFuoCAAd/RKWCzkkBV01BK9SDs/3GalrdxtxPWhaD7dQ80krDkkW+LrUSpmyOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988144; c=relaxed/simple;
	bh=paXKXclmFaXsCIPmVdGPEnMtah6RnCHUFLimFZmfPEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVVM5GvFiVMfGsIBWnD0+qhj362+o50SRYwfDBZuXHKUh1vIatPPLl75RF0Ou21khyHpkRl72awhkt7FtpWMmfSeRFrqyWL8Woy2oeZrJWGWkFU7r0TKEYX6ww+gMaSH0bFs5hXifXJUrbRhT9VVAhIwCCenXm+YDU7oe1Yt+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sk64ZixU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso53591065e9.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988141; x=1772592941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBdbFLV8vtf9AziFPD+ng+c73TX2ITkNEht9PFffElA=;
        b=Sk64ZixUQGerzkJv8OXtATuAincClZXnA7OO0jr4Y8V7vkc1FACh7lELgiZJc8jUDY
         ilyf3Kvrn2/gLbr1g8oy9U7OCoX3iHbqFmVZeMSm4bdlJnNTjLXnCYZ1VgO76qOgovNi
         pPzmwob8d97SYQV5qDe7UmP3Crrj1IwByMgK7oAsinIWVzAxlfzeVB9+KIzRWDAvb6y6
         zUMQhewcgBqPJpnLvhWv/bl0SGLyKrgwRS3BV8LfRFjRoLgAoHmGW1TdrmD4Ny/pIqz2
         EfJzhPx24u0E1Q+GV2jx5c46lVmrdHviX2OjLJaU/X6tTZ7Je5FMd/0v/HNiZLt+QC/J
         cEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988141; x=1772592941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBdbFLV8vtf9AziFPD+ng+c73TX2ITkNEht9PFffElA=;
        b=gEIUPS8Vt5L+UqIjKx0hIGIexe2mLyEndExFLwx9b3oqKJl1uv0ar2u9cAZiSr+W8e
         sEriWBYxoD93nMjU85aTc1BYoLTc/1EPw2Gze+NOK2zZduVbl86hd0AyBMEPMabXiwco
         M9DONilM7grqQ7cCSmiaFpi31xwQK2bYF9MyLZsfZF/+soY8dFNKbx8aHHklzwwMLd0R
         y82arrOBWDJw/jedLsGhDL9rnHXMM1BihxVF/irBFFCETuWcOhFhk/MNsxoHpMEoTjB5
         V0lmaK9A7obK4/16K4euVopQNjAxbz/l/uquA5b8txubusThXxIhzLP+otj0KyYXIcZ4
         eA7w==
X-Gm-Message-State: AOJu0YzAtAmOxEDxek3jy9NE0+mnOuW/75NP4in8bt+1+wGHpC++h1d1
	iQfMCfgnI47Cpv4gho/iVqYvPmOR1BScrQ7T+9+O3upLyPWZcvQVOYXaC4wcl9ORZPI1Yj8hFLc
	1m71R
X-Gm-Gg: ATEYQzwixpEoyidYdVe21ouB+IAW6E+C0NhiYgcCnoZ5vcI2cSqF0UAKWAmt3Kk+dKY
	2YN7zSisSPLhhui76yuDt6lqxeOAFDr9pDfjkyUx9MYdjxvlXnhdlC/GOIog7/CFZqAwhossZnt
	rSZqWFrk7/AJSOKblppgstrLiNeAzBGPKSjblhRlxnmkZkfT3eWV0+H0LBgs/nJz+ZJ5nB5H+7L
	00jFxWzJ7T/vduwBvU1u2tjf82BcBmPw5sle73m5z2W8kt98JHdDbqaVAWbZgIJ4uVDvWXHlHyD
	di967f4krlEtplptzY6+3/S6AChr23PhWonYu3wN0N+J7r+bz6Necjn0z7XJx6FSS1uzUqAMyw4
	7+eIs/YUnh1etT1IeSj+d3Ck/JQPZ1jxt4stlvv7zIY3ivDp0Gjp02KnU+TQ9dBJaQ0ylSYmM+F
	btBvj6iTcD1xslW8YLS5Wis4JoKA==
X-Received: by 2002:a05:600c:8b88:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483a963d64bmr208614055e9.30.1771988141265;
        Tue, 24 Feb 2026 18:55:41 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd692a54sm12292753b3a.21.2026.02.24.18.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:40 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 10/11] selftests/bpf: tc_links/tc_opts: Unserialize tests
Date: Wed, 25 Feb 2026 10:54:48 +0800
Message-ID: <20260225025454.17398-11-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-219150-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CD81191115
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
index d6fd09c2d6e6..6c6abe8d3d34 100644
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
@@ -2619,7 +2619,7 @@ static void test_tc_opts_query_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query(void)
+void test_ns_tc_opts_query(void)
 {
 	test_tc_opts_query_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_target(BPF_TCX_EGRESS);
@@ -2678,7 +2678,7 @@ static void test_tc_opts_query_attach_target(int target)
 	test_tc_link__destroy(skel);
 }
 
-void serial_test_tc_opts_query_attach(void)
+void test_ns_tc_opts_query_attach(void)
 {
 	test_tc_opts_query_attach_target(BPF_TCX_INGRESS);
 	test_tc_opts_query_attach_target(BPF_TCX_EGRESS);
-- 
2.53.0


