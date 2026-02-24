Return-Path: <stable+bounces-217878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNGVNYJVnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:38:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ADF183217
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF39303B4C9
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB62877E5;
	Tue, 24 Feb 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DhkWttQx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39B26ADC
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918719; cv=none; b=IN9kPicaWbMUiZjHdjtlN66FBkys3ZfCRiL/rbTrMOXhZe15xAj+zP/K7fiyvij2ntumUSC1tj+1rdn7xP/0erC6JIM7S3fTmk/fcy/k3C04dpf4PueLq6JBTmiJOxj1CAPSTg9Dfcf5/JtdtMgeqM0Dg/f0aQtlhUXN/whFAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918719; c=relaxed/simple;
	bh=e+szBBS8wcV17NFtGmEkkIwh1FQqMwj7WjqS/I6jWIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR0qrnovtCi9LRbTCuUUuoAAsGdAHGmhAVJ1RtIfQYUpc035j6Xcg3HqGynQiSWAP1Q1S4tnTlB66Gvv+L3Z7mznxfsKGHN/WyMMb0fpJxVsjYggWysbgVIDaQqZdWLoLutGIu6w181tg3WATQC1ub+MMziwGN1pQBvtd7IV0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DhkWttQx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48378136adcso31045865e9.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918716; x=1772523516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RWYP/6Wd1cXUj1nyOSovpOWV1+OCRgcJOavJr/lHnM=;
        b=DhkWttQxJLxASBIEuR51FWiX5tOj10+XP4vknbO3Kf1hMDnWbm+fuOH/l4uQCf1FMW
         n/d82mmOsi3dUAOt8Toi8Hi3lWSS7fLAUSwBBq3pZG0eEkbnY2sPp0WqQhtUFisLG8u7
         3MoTOytRy2nWYzB8QAk2U7CXdqohvbbvj7hVpmM6FarFX/CKFNFMz+GGJ1u2vTnEsUE1
         uGIMAUIIIE1ZK/ICdRVQA4ypY15skI6jf5oZqixXFXbbGm6tbpl+iB+i7+Rz5mP7mPfC
         nfJ/TfdYCWPvLNvt4wuuzSgZn8opCUfEGU2fQYD7WyoGq0XvJLX7kvD0mWQGpo3YbUFV
         qFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918716; x=1772523516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RWYP/6Wd1cXUj1nyOSovpOWV1+OCRgcJOavJr/lHnM=;
        b=AvtSB2+pq4fnkPkLww4yrHfu3+x96iHE2xpVj1nPJ/pe3KbNe+fQ3Kasf7HroRQ2Gd
         e3vIshGxAXbz6G70J/EBw+K3U1H5Ob6eAy+JaC2k6xXXhW2KP92gefkNeQz4x6xJ5+xA
         Xn03LCvUIiQk3d3sSIjB+2G09z1BD2u0EurV9zAb8bOVoZRudTwlIbME/W+RUBQg63Wj
         VDGCJeYTOG/j3NkwPm3F/9qo9AgDB5fKNIWRuLezbc2K23tgbULdWVBNvusjnGl3ixpB
         57S2AVWd2lj03leOwTN32Udtt7xWrorSY+Huo8pdMoxZsCyXfnnw8EdI94f8HqT05yz9
         h12w==
X-Gm-Message-State: AOJu0YzBX9drVKLzWl9juswKr8lt0TkJcqIZAx+cfIEmtV2jF25WEDSq
	TlHxendFo5r3lkJj7dcMgdKGSJ55N76AVHTjJOQcAPN3weQNpKY5g74yJKr+OLdobtWg+VqacnZ
	r1C1F
X-Gm-Gg: AZuq6aK7j7rfU8bZxw6cbpmLDvvg6OFBNJvudWuRbyJvDd+XSzwScvAivDkN9uqBUGb
	ZtG12epmahGJqIwelk34pWgiF02w83B04hqkqfZ8a9pQ4F4ci9g7Z2mBVapXs4W0epnhD1RXmnW
	531wpixk+Kl4p3VAa9kBm+uJKUVCdrzfS+NNb+kDtiXhgTED+utqQu/DH13psn6ljkRiRSsOqah
	42Pl1KfzQF5FvmGbgzN8P6Qax5mItFeBH0rVLoOHORwgH2xpc/gzUzeLyJKQGTItce+LnwX3GyM
	ajL6lUhbh2tNU5M3yilZgj0uqGL/zYQbpD9/Olj2kbyLb6Hjqnh9mQs9LE6kvkETU3sMj4m2Bd/
	KyNqBoT2DG8xjICB8IRRzinXbs6dhMBcTv+B+5ebGs2cIhTyf9hC6eB4kEH8A2zjDAmTYfecE7l
	BFKXdfQWYNIeNU0acNanQx7Zuj+Q==
X-Received: by 2002:a05:600c:8b88:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-483a9636340mr175267455e9.29.1771918715894;
        Mon, 23 Feb 2026 23:38:35 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd688aa7sm10166103b3a.14.2026.02.23.23.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:35 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 5/5] selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
Date: Tue, 24 Feb 2026 15:38:06 +0800
Message-ID: <20260224073810.85945-6-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53ADF183217
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


