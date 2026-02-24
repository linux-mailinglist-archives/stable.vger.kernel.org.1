Return-Path: <stable+bounces-217869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHmODaJTnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:30:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846BE18309F
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C18B303DAA9
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605F36405A;
	Tue, 24 Feb 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxfMmeke"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559B30AAB8
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918149; cv=none; b=tHsqbngHlrAAtrMNhfwd3UIZYjvt76yJP0tKy7duy/g/nqQ8POikfVm5+iRUjwFHjBbccVKrpefxyerPZloUqyj5sXhxZfoDroKqdiZq2DcualV63ZX/AOlLOGr9WrVDNQU12SE4s1SEKmmPzdMBY1/ACbKgdMsE6MQM5BXTWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918149; c=relaxed/simple;
	bh=c6bk+ww1UWrAM7xKs7yjw/om/l0niKlzh31ZKcJVjkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7d3lsSFQS6Y6mjWjtcMqbULudGZcVnwuxfPwtSsBjV+NP/OKSdq5e32+0PHM1T2p87Cy36BlKZg5E9AQlveuKFt0NZ7t+uRvI7Wt3K7g6FBOBANaNocvE0wNNJ4JedvMlru2rUPruJblpf1zwPZ/V9rb+atZjbX2PYsItUHSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxfMmeke; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-480706554beso62046125e9.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918146; x=1772522946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOAlCmiJYIfxL2kxknEJ/GvjqMnGdRz+xbTLB4fkfN4=;
        b=ZxfMmeketvctwapfFbKpfSiYR6EjWxrTqZwe6TLt/Lg6F2zJ73cldSc5RUZlYRmvML
         25yeGOcaicnvrhB1cCTAG/HUsuc5HTQTeu+tf+Hv5psEaPHk6+xxWrhVguwEb3hRjt9E
         79ZRkq7PmVTY5jDzQvdq18+Zkrj2spCVOkhyYhfIl+22Egt4fUP4rHEKgLNoBug50Rb3
         hZxA3sVTECyszDZ1VIr21j87nZztsWqzOuygX7J88c7iARSb5oqesawV8aPQPI9QJPWr
         oXnm0q1JnmhgbLAkTza4KCSdENExvOlwX6g9I4/GwxfB8QcBHDonUL9JYDh+MK5x+JLR
         yjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918146; x=1772522946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOAlCmiJYIfxL2kxknEJ/GvjqMnGdRz+xbTLB4fkfN4=;
        b=l4wO6jq/qdcrPDoiBvsqPjk3PBHXg6WXCrpLOrGgsid0RloxaDFwUp6fGplKXn6Mfy
         Sj6eB4ipmMuhUJLxMuLpUNsoHcTScEjIls2KY9RSjR39D1AQ/CYLfkaC3A1MCcql7N5a
         FN6bxDz/tRo4La1KM29j85Y0160hDVkkNZCicQKnqB5HlB2HrBqiZFX8MCb5HzgBnCJR
         ODfZdKLYIuaMaLQ0SzgkgjuW2H2nVw1QOARWrrON2UtWQM6xXIvW3Ml+LEkIqdmvHxx0
         3NhaN8EoysPfrVsP8muJH61uGVzwe0vb1JVB3l02DsqtP8PPSuJertXdxt48yjPfj7kE
         h7GA==
X-Gm-Message-State: AOJu0YyvadLrdMZVYDSI/dNfOLXgncg2T2u6L0UOFuVktk0F+Ey8IWwV
	C+bopjKHSzhBEG2+mvatYWVHV2qkTq4UpqV4RpOLURu5DG/H0L7UFC/NZ2MFJ2Q4p5QnMtiuEW/
	yGKaB
X-Gm-Gg: AZuq6aLD2nTHtDGJ1sBbevk5I7Cz9HznD+BRLb1/mmVitAH7VZhxfyWPXTEUPMGT6lQ
	vPOBlQrKmUh0wtPF3DmZKVpEAj5ZdmjhPd+DsbxP39rSOascnfnSHU46xRVQ9PzdX0X89r80BOv
	eFuS9C9Rjo8EvtDojKsD6pyYxumjieiyBWvaN7B1u7VJoXN0sAqaXDUakrz87B+ImkbTeve44At
	XLEAPz9i1CSQLHMGnl6tHgw2+JbWAupc+Ss/fr+3US4eH9vcAyAtKt/xip2COkBNB4eOmClduhd
	8iGtNe3V89XfAB38YCqwss0M3GfeWFJaLCkCBo1w+JplM91QKB1N0g00zPayPv+JqmYJvi734B6
	a4a6h9ewfxK/3PeuK33pb/xtM9qxlOPv+Se9wR4CBT1BHLqrxRol+oBMBuEHbOAck2LGgueUjJJ
	RPaRbQiP30nNpHg789zEUejFzaqQ==
X-Received: by 2002:a05:600c:848e:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-483a9608834mr205861865e9.14.1771918145875;
        Mon, 23 Feb 2026 23:29:05 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b72434e3sm9631203a12.18.2026.02.23.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:29:05 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18] selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set
Date: Tue, 24 Feb 2026 15:28:50 +0800
Message-ID: <20260224072853.85470-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217869-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 846BE18309F
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
This is the corresponding BPF selftest for commit 6cc73f35406c
("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when
transport_header is not set") that has been included since 6.18.2.
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


