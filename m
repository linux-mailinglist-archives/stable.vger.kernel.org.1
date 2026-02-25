Return-Path: <stable+bounces-219151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOaZF9tknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2C19111C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24D330961D5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C0299924;
	Wed, 25 Feb 2026 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F7FdF6+k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB7296BD1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988147; cv=none; b=oEqq6ejhOd5Eha8hpnMTDpLgf2ZOXgUGboDPkVFyfP3zikVTJFrO0p/NxB8QZpplkEnACdwyhtr6MPUJVKeezMi87MdWd6o6hcr8OdWVjAQ8iWzTUe+gSZKueqnAiQvtqqn4QLyjMxcF2sZ9Z/2923iEhzEWCH8iB6cNE4Hb7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988147; c=relaxed/simple;
	bh=e+szBBS8wcV17NFtGmEkkIwh1FQqMwj7WjqS/I6jWIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU2vKeOj3PexpXqcYYCC0LjgJSP162LidF/JaD3cI2gI6U4U3ch9nyzD0Rbt4sHtg2Y0X9MynUEHbVyjWr2/U2uOy+Cuu1VevMgsooREHkC1PhOOLnFKkMNfmCinPfY7ewtdcDJrlolmIFU8xR6XF8F01o/xtCYju+aejPpGIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F7FdF6+k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371119eacso72344525e9.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988145; x=1772592945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RWYP/6Wd1cXUj1nyOSovpOWV1+OCRgcJOavJr/lHnM=;
        b=F7FdF6+koCEtwEQGV3RYBXHh2Ga2duMIKPu1aU4UfzKLq8X5mqxRqQsi8KNMWd5LGn
         +G0XQ33jSaIW72LRlIm3yygsb4MJL8EAlHUDLPrVFZT1i7+7bTZD7b8sbnC/b5ytITRk
         QMg88Hd1hwczJh5fvY66ZwMNmO1g9P1WfZlpZHnQ05ImNV+bsTP8iw5L/BwLKrX5HUVB
         XXsTIUOWM4mHWuclm7mvj6j5GTrHhy6ON6OS+gO4L3iekLHraeRGKvF/s1ZfAe1VozYh
         m2EMF2NSaWSzLN6eQFykISJYhz19hdkEeXgjXi5/pFbLm4d/mY/2OY7kD22q1KEcXRq8
         2B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988145; x=1772592945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RWYP/6Wd1cXUj1nyOSovpOWV1+OCRgcJOavJr/lHnM=;
        b=GmkwM6vIznL2QjYWnncxe/H8RGaLkdnr/n0tkTI0lUt/NqXRl4bAwFkKrcUF7wCeAx
         JaxBUjdEBIjIyJVRAYvsw0cndB/wXYYrKjBLN+sSNEWmiOaJ5WiO2lYZ+9JHjPpK3Bf8
         lwV2V9QUkv6GN8oogS94Pt94JEv5ghTxqgWktaVY/Kj+AWM4Qi2lo+QkvtBVt6UoIVTA
         yJBxwNGmmia/zUICcPtSGycSVf1UD0Nkdx9xZVLu5hxFLBHRZ8+6Ztn32MrTLdYYQb1R
         e4X/3wKEOi9DbyYmuHzW73ij9a5QhhK/EF9e8/JF7EmIHRRi7oxEhXeYubu0zRatDSp5
         0M1g==
X-Gm-Message-State: AOJu0YzL9cia/2JTOtWDqdiOMJZqHJa70y15bAKUBDg7Noj0tJa+1oKS
	RMccWN19YNbURvxDfGydvebf0sJDrSanHy465DFuIxhL88upXVfCObRCgJ1SvF44qQaqLKabTdQ
	AFt+C
X-Gm-Gg: ATEYQzzBxEl1RCYf3NXA0ESuU1FCN54KavIPWwfQUIc7VfET5AoIBC5nZCJCjcxUftL
	F6HeT2SCZWFmqtnp73EaVKpMZ2GbLVH9WFUVXpKRsuD5rewAqSd6+56fZsVy9C20xj/6sDtb1tb
	0q9qZtwngxxEBoxQoMLKHBNLJnpC/uq/mSJCSpCoxI/sxEAE1kGdy5PHUukaC7XOoj+bzPU6bPW
	UX+SPVhH7/MK9jdB4d7cE0QhDSm3c3I79HxCXGG27axKAnrcXwayftDfJlnB4gR3gAAlCBMdqvK
	Aw+Ms1suEUwYYOQaxYDQIAqzqE1KyINZ2219knaceIG+XHYn3w+ve2759PvA9fCJtFWP+uv3Eg/
	KOj8qBPxyof1cVpAzJV+tR/TJhL8U8j2AMKMQp6eEtMsG9Zli7HmIqx+fvvWNkhv8pn7v5vt7iA
	bWKSJzuW3/L5w143LnMsI27bUfFg==
X-Received: by 2002:a05:600c:3147:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-483a962e3e2mr221667955e9.22.1771988144603;
        Tue, 24 Feb 2026 18:55:44 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adae6c6674sm40278905ad.73.2026.02.24.18.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:44 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 11/11] selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
Date: Wed, 25 Feb 2026 10:54:49 +0800
Message-ID: <20260225025454.17398-12-shung-hsi.yu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-219151-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: E5A2C19111C
X-Rspamd-Action: no action

From: Martin KaFai Lau <martin.lau@kernel.org>

commit 6cc73f35406cae1f053e984e8de40e6dc9681446 upstream.

Add a test to check that bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) is
rejected (-EINVAL) if skb->transport_header is not set. The test
needs to lower the MTU of the loopback device. Thus, take this
opportunity to run the test in a netns by adding "ns_" to the test
name. The "serial_" prefix can then be removed.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20251112232331.1566074-2-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/prog_tests/check_mtu.c      | 23 ++++++++++++++++++-
 .../selftests/bpf/progs/test_check_mtu.c      | 12 ++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
index 2a9a30650350..65b4512967e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -153,6 +153,26 @@ static void test_check_mtu_run_tc(struct test_check_mtu *skel,
 	ASSERT_EQ(mtu_result, mtu_expect, "MTU-compare-user");
 }
 
+static void test_chk_segs_flag(struct test_check_mtu *skel, __u32 mtu)
+{
+	int err, prog_fd = bpf_program__fd(skel->progs.tc_chk_segs_flag);
+	struct __sk_buff skb = {
+		.gso_size = 10,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .ctx_in = &skb,
+		    .ctx_size_in = sizeof(skb),
+	);
+
+	/* Lower the mtu to test the BPF_MTU_CHK_SEGS */
+	SYS_NOFAIL("ip link set dev lo mtu 10");
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	SYS_NOFAIL("ip link set dev lo mtu %u", mtu);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, BPF_OK, "retval");
+}
 
 static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 {
@@ -177,11 +197,12 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
 	test_check_mtu_run_tc(skel, skel->progs.tc_minus_delta, mtu);
 	test_check_mtu_run_tc(skel, skel->progs.tc_input_len, mtu);
 	test_check_mtu_run_tc(skel, skel->progs.tc_input_len_exceed, mtu);
+	test_chk_segs_flag(skel, mtu);
 cleanup:
 	test_check_mtu__destroy(skel);
 }
 
-void serial_test_check_mtu(void)
+void test_ns_check_mtu(void)
 {
 	int mtu_lo;
 
diff --git a/tools/testing/selftests/bpf/progs/test_check_mtu.c b/tools/testing/selftests/bpf/progs/test_check_mtu.c
index 2ec1de11a3ae..7b6b2b342c1d 100644
--- a/tools/testing/selftests/bpf/progs/test_check_mtu.c
+++ b/tools/testing/selftests/bpf/progs/test_check_mtu.c
@@ -7,6 +7,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
+#include <errno.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -288,3 +289,14 @@ int tc_input_len_exceed(struct __sk_buff *ctx)
 	global_bpf_mtu_xdp = mtu_len;
 	return retval;
 }
+
+SEC("tc")
+int tc_chk_segs_flag(struct __sk_buff *ctx)
+{
+	__u32 mtu_len = 0;
+	int err;
+
+	err = bpf_check_mtu(ctx, GLOBAL_USER_IFINDEX, &mtu_len, 0, BPF_MTU_CHK_SEGS);
+
+	return err == -EINVAL ? BPF_OK : BPF_DROP;
+}
-- 
2.53.0


