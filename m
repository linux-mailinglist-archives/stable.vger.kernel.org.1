Return-Path: <stable+bounces-217877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMhMIF5WnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5891832A5
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3358D3046054
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB14284894;
	Tue, 24 Feb 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dpg2AH6w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABD26ADC
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918716; cv=none; b=eGLYc56WExlvpggdRUMmTGnoltBcEsQTvmfpx89FKq94DYz4zNzM1kI57GBHBLmVvllyeNwGvXyOJRxw84LlJGn68BMEsMEHran3bwP2rNatrYrhtUUipacRopuEG++QmWGuzjtR9jijgBZ6rNSII2C4/lYvG/rfSMAZutvU9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918716; c=relaxed/simple;
	bh=FZzqS0zxv1BowtX+2KD0LDY7PlziTmCdtV7vH835SV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep9tG8gwzxL3bANHCJXGnEDjRxtZUNr6sxO2FoWLdePZOEIqRP/7EJBlsRMF2lN7/tTfEHdeUjk7ivljD67VlzJ2wKsoKCriXUrD23gOZoAqm7VU+P2+dKimGEi8lhnGJZDhVwq4/TtGbUVezQSQnMKMEr1jl22oJSrnScIaOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dpg2AH6w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so53540515e9.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918713; x=1772523513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx7B3No9WeFJgnPJoroj3edXIHPBwCBlsQAysG1FxF0=;
        b=Dpg2AH6wOakkNfT95CnZl4+DY1LSgB0vIqqklGytPdr/bfdNCfreHziNQRm+si2Pez
         XqHAh9Z1dUaRhBOsT5xQJD4A4xOEV55wvHtVCiaync3ryYd8pWmhpdZmXgFLJ14heM2B
         ZeFRThKKtYAuis776yEPyuJfLvrD7iKlAuvAHrtMJ6MFfnv/Xe7Jv8pLIwQ6zrRDM1im
         ENZYIkC3yU8dzK/JMJmjXxf4az1wTq54lY3ATofjJ8yH59dz/LsQRJKmUXXe5UMIdibO
         qaRMEZsm+0M2/U/9Wh0IYFtc0NCrXg2dGBUfvQpR5eOdYtlTSheNi7SzQqQWqzZ2wdRa
         D1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918713; x=1772523513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mx7B3No9WeFJgnPJoroj3edXIHPBwCBlsQAysG1FxF0=;
        b=Eaw6grVYtUBfZ7HNDYfF6Y+O71wE60Jcvh8Pr6peGILJmUfAPyzvj/F6/CLg85GGRs
         DvchMJhcpYvuB+aXt87yQowVDh3pmxhxKqr1i1AZMZ6CO9vGLkbZh6KTnTHwC9XYNcDJ
         mo3PkBcPHUePHMZtNdqkP+/c2i7LnTDEkXoguR1kRozF1WCA0KWA0MOHGsaPIlSsch5F
         cb9HJRo68ItOsUP/+XMuWUgp5i313kEOTq9SmNKhIcwsmDJKCh8x71U7Et8C2cHix7lM
         3VdhqErPcNQRkEkPP2KdSng1otFuzM0NEY2FPB1SRq3zSScJfoNvzeBqcwltYaJDRPcd
         XzCA==
X-Gm-Message-State: AOJu0Yw4J29ofsuZPlZV3oJo7cjXDQYAQUJRYsvZQODqo8Y5aUp+ZlVv
	n9iDuu01PNHOpngXExYBYo+0ecLQK4+7jMiz0XVKDsOAKdIrpZPajtGV+eDyGqcT9NRGCtkU0MY
	dVk+x
X-Gm-Gg: AZuq6aKV4j6oB2prTUnChI7u6nljagQArJolnHTD+qoS+p7sYPqAszSsn7YgypbQxhK
	OF50dS5+jpe7XNEnnIqRAVTCY39S4PGdss2ja0wNnHOdFD5rofGqz2qyPmgS1uYiUy9FXbfxIGv
	1XPrF3DZ2/LMo+dY7I+oJ/MEhQg6OOVJhV/mvihUqmir8oSejoVr3Ahup7C4T+ChpqGygUYAuq4
	izTZRSOU/P4yC1Kr4oxCjOQDoJmbybb8f6z/C437Ua7Wbxsxp6pAaZTPOLlw9oyMdjc+HSjxhlc
	Lrw3TTE6vritysqG1hfYZVvYaQBveNN3ReOn7id9nRbNbywu2RyOyqA7NxoxD5rBoFE2U84ghEg
	PhLnZRFJlkB1mNBv2nwjE4Lo52FxoLCnkaxM9HsbQRqZnF3dMxY+38wI9+sB3caOu8ETUjb4kMA
	dsAVFJxN++3jaJS3e4YI8OmAk+XQ==
X-Received: by 2002:a05:600c:1e1d:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483a95bebcdmr207587435e9.13.1771918712935;
        Mon, 23 Feb 2026 23:38:32 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd640d16sm10142975b3a.13.2026.02.23.23.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:32 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 4/5] selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature
Date: Tue, 24 Feb 2026 15:38:05 +0800
Message-ID: <20260224073810.85945-5-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217877-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: DE5891832A5
X-Rspamd-Action: no action

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>

commit 157feaaf18cec6a6eeb71dba334e214834a21030 upstream.

Two subtests use the test_in_netns() function to run the test in a
dedicated network namespace. This can now be done directly through the
test_progs framework with a test name starting with 'ns_'.

Replace the use of test_in_netns() by test_ns_* calls.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Link: https://lore.kernel.org/r/20250219-b4-tc_links-v2-4-14504db136b7@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 6cc73f35406c ("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 47 +++++++------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 78020ece6a29..99c953f2be21 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -200,25 +200,6 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-static void test_in_netns(int (*fn)(void *), void *arg)
-{
-	struct nstoken *nstoken = NULL;
-
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto cleanup;
-
-	test_ns_current_pid_tgid_new_ns(fn, arg);
-
-cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
-}
-
 /* TODO: use a different tracepoint */
 void serial_test_current_pid_tgid(void)
 {
@@ -226,15 +207,21 @@ void serial_test_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
-	if (test__start_subtest("new_ns_cgrp")) {
-		int cgroup_fd = -1;
-
-		cgroup_fd = test__join_cgroup("/sock_addr");
-		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
-			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
-			close(cgroup_fd);
-		}
-	}
-	if (test__start_subtest("new_ns_sk_msg"))
-		test_in_netns(test_current_pid_tgid_sk_msg, NULL);
 }
+
+void test_ns_current_pid_tgid_cgrp(void)
+{
+	int cgroup_fd = test__join_cgroup("/sock_addr");
+
+	if (ASSERT_OK_FD(cgroup_fd, "join_cgroup")) {
+		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_cgrp, &cgroup_fd);
+		close(cgroup_fd);
+	}
+}
+
+void test_ns_current_pid_tgid_sk_msg(void)
+{
+	test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_sk_msg, NULL);
+}
+
+
-- 
2.53.0


