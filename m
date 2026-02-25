Return-Path: <stable+bounces-219149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SChuCNBknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46119110E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629E13084636
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B56296BD1;
	Wed, 25 Feb 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hhkcj1QT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39259298CC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988140; cv=none; b=SR3eahVFK58mwISIORqGtqiSWqNG/kq3aXKjX0lZOdqTmXdzmvCLcdqqvR0j6wuE1Tm/O0b5dSL3DRhAC84T+AZ5R4PuIDTn6cdW+8rlJpPzEhYCmZ/qzZngeoHIm3azbjVG2FVtE5Du+61MrZk8mUEjUZKAQkgWwZuG2u6iH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988140; c=relaxed/simple;
	bh=iETcxymnHiCRriR+9CT/d7wUhRApae2nQSFPYqBjH10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGl6Y2l+V0WVtxdiyAfw8d+C2if73ndKSqtKjTgZf99huM8YF0xlJTR1h25vunF6uSpieX+7LT/hPtAPJyypnQ7b2aUMaldWgIZX6Ex6Bs27LRGAogCD40j2IcbuUTV4u082ntk1ngU3tEk7vfwNuKavmWJfvZvKXXzLrEh+ZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hhkcj1QT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso53590835e9.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988137; x=1772592937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h9RQGrrepe7Yg75Oqogq/myOl6hqIV+X3SadIG0YHc=;
        b=Hhkcj1QT6U4cG+bxgDTXm7BI05IDwg0crwpn7KI9yJmhkYPyJYkmDUTWroJVtZsl8K
         2oYne6qxa7B40RDLwt4HQP4oqWuHpHxt3r3r33PEHxGxvWWPE0IyshjmgASWDrTPx7dt
         oTW2eA/c47qmReS3Ymdlid4ns6SYgVW9wpfc/QOc7FBUgME4d6pwYdH6WC5eRqrGJ1+I
         5ckEk8AD1ljrcLRF3U5eknb+QqD760f6YumJ52/vCR51nCEgnUsowLCu5jDOmGls462l
         244epA7/PCcYe0P/8pA3edUHAWGga0J+KVEhyRZkLyHvLXAVs8Q8qGoJHK8or7Cx/uWF
         dgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988137; x=1772592937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/h9RQGrrepe7Yg75Oqogq/myOl6hqIV+X3SadIG0YHc=;
        b=PUXYkOg1dyHg2wVKSK9+uj7veB3MnXDnUADeMzWKyk7QEPvJwlY9121zwEAjnlEYs/
         MmHH1dbptZ4hxHuSfJA5G+TbTxj6PhZn89A48L3ahVpFS1DkFBXotFx0dNv4PIBzcZ8i
         zHGV1nSR6xLxFnMIpzDYdSD3QDeaYVJ79880HBFeIYnDAjDawzcWmP62s0xyRoOxZqgE
         vSHetKebtcDBHEYThjOX/HIMqPvNnsW6DrKfWLrqWfnoDxn5Tte51RT+oGoZaUzQH59s
         n3jcj5uyNUQTj1dILwwFcNjFwrP02EPC/qHSe+t576zOnRRp9mEfqzcMAePsSkAbGiYu
         elZg==
X-Gm-Message-State: AOJu0Yxa76Bu08rIGHAAjIbp7qvBBqE7mnvmZhl4FPIgwCKJ8QaMuVy+
	tkJVRutAjESicLYIunHpubx8yXaEPE5S+nlXK9DGCOgj6J8bxXEf/HNTT0ySFD0SKklftNBZwGO
	VtnVC
X-Gm-Gg: ATEYQzyKXBLRpHRGAzbpROMGNB/jpfSIe5/Xuww5vKEZu8HbLbW1xKYiGgtrR2THhgG
	48JVNKRwh71XLENaxT2YXvfkX4E5cvEFn4rT/aaHUhoPul+cqtzPLfAUx8G6Is0M6E+FjRaFuS0
	qkyNG1IL/Qy/MZKr2fKLv9djs+bw4I3FScJV2GfhU9qPVbYiGi+dOrB5ec/WI4R4gxgFbCK699Y
	zemtYslqaqHz6jrEr+8by0mAA4MXc8RMOv2ScFp336Si3cPkgENf1cb7xEQ9mLFK1BhQFQCn9JE
	tPSIpwnuiyQmYQSyauoRmw3RVIdmMTWDRXutKOvZ8bEWvgO0u4mkkcyyf/0w7HcNUF7xpfMywZA
	bfAXezKeJMneD7V04d1YANmpOs3HMVa6aOAVpCb3axco3/mJC41x+1Ct0yDfBHtD/rg3lp6tU6k
	gOifkUyRNeBqNzl+Uo3DiaAxCS3Q==
X-Received: by 2002:a05:600c:8183:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-483a962e3d4mr196549305e9.19.1771988137433;
        Tue, 24 Feb 2026 18:55:37 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3591342f60fsm24146a91.9.2026.02.24.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:36 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 09/11] selftests/bpf: Optionally open a dedicated namespace to run test in it
Date: Wed, 25 Feb 2026 10:54:47 +0800
Message-ID: <20260225025454.17398-10-shung-hsi.yu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-219149-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 9A46119110E
X-Rspamd-Action: no action

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>

commit c047e0e0e43560bf73ae47f7cfd5772f690b6d48 upstream.

Some tests are serialized to prevent interference with others.

Open a dedicated network namespace when a test name starts with 'ns_' to
allow more test parallelization. Use the test name as namespace name to
avoid conflict between namespaces.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Link: https://lore.kernel.org/r/20250219-b4-tc_links-v2-2-14504db136b7@bootlin.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 6cc73f35406c ("selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 650bb694d84a..960f3c7899f6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1206,20 +1206,32 @@ static int recv_message(int sock, struct msg *msg)
 	return ret;
 }
 
+static bool ns_is_needed(const char *test_name)
+{
+	if (strlen(test_name) < 3)
+		return false;
+
+	return !strncmp(test_name, "ns_", 3);
+}
+
 static void run_one_test(int test_num)
 {
 	struct prog_test_def *test = &prog_test_defs[test_num];
 	struct test_state *state = &test_states[test_num];
+	struct netns_obj *ns = NULL;
 
 	env.test = test;
 	env.test_state = state;
 
 	stdio_hijack(&state->log_buf, &state->log_cnt);
 
+	if (ns_is_needed(test->test_name))
+		ns = netns_new(test->test_name, true);
 	if (test->run_test)
 		test->run_test();
 	else if (test->run_serial_test)
 		test->run_serial_test();
+	netns_free(ns);
 
 	/* ensure last sub-test is finalized properly */
 	if (env.subtest_state)
-- 
2.53.0


