Return-Path: <stable+bounces-211514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBU0A4EJd2lGawEAu9opvQ
	(envelope-from <stable+bounces-211514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D384872
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DD1530120E1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707626E6F8;
	Mon, 26 Jan 2026 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aJC6mvi1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1786250
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408717; cv=none; b=IOVaofpItfIhlrGa97lLFm0RAskQKgSENAdFaCRVTJtRi6KCHJ02VIrNQNjuPMyOCG4+OB/gpc/cGkLvGwp7JLeztdXBQ2h+FFQUheTxfc9OuqtVg0mo7DWOFEZDv2pDgfaf1UcrEjho0aGiAZwk0JJ1BW96IEfGFEUEs89Ud4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408717; c=relaxed/simple;
	bh=/4EWuN8l4q4Og797mTc4CidhOA9Bdhs1yZfewqPbTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9h85MtqsV32QHonAl6mAmtWhr66AWL5oAp4zznpjj+YRWeu3bz1Cv6Arxau5wU1LI01VeHWCyBWrKsxlPpBvdR0aeUDI8UaIvXOm0zoV5n9NTAgqn+hRru92O58UMuAXDPK/Q7YUZ1Ex9T7GPoJ1yQxqGH+0brIpK2TIbt4rO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aJC6mvi1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edffe5540so47319825e9.0
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 22:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769408713; x=1770013513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63OFM9QgnRQ1EDzZTsdKOdlQxfJDgB8cLPkDkghIv7w=;
        b=aJC6mvi1BPKgmqiiRKxU5WT0zjQkGO2iIFHKW/SKKUsnFviZlY1MbpkPTk9X+1jcsJ
         DY/juCb1eVLVvDfXEPKzGT/+wXtIgk2Mrh5MwR5K05jZM897cabgVzzkbS2mGcHIotl6
         OSvd8OTYVgp93BO7RmWCOXctiCidJiFDpPoZBLNpHpmLDbASYZzUhGP0NL+JAX6ER5Ff
         fqNMHrIwaY5AoOijcEc0RV0cZsdz8qDIC36vjHP9BVm2wOO2gLeYZ8uDh0ie7GNfCfF4
         obT0hOXEvtnkD4fcokADqi1l454eIkrJjoGLZjIIoFTtHSSi8RqjwKCLS36nU/ZWF8wC
         zIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769408713; x=1770013513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63OFM9QgnRQ1EDzZTsdKOdlQxfJDgB8cLPkDkghIv7w=;
        b=Xp+65P/nvjbz6tc+pyUIJc57c3Sehi432ifkoFJsx5wwXcoZeH47aMohiD+KkM4g3i
         mN1gfby319gpiGQgmwpEsFzjMBy5Cmk7YH/30x4ZeRQk0sYkQsJo0V0ErFGGeNx4ozS5
         jULIwqKHbTej+Yy2bf2/931t1d3T08QKPrmdh/YV9gU5rIC+o1tzq17986BkMAdBrBd5
         XyzPq2nFN6rxe7pB+2D3YWnfkwOfg4u3JPdEHb0w8/jagYptRPIKIJcWZBIW5PQ4J35h
         n+ry00bWJNrZH5QealZDg5tj2+lazP0sOOJIflHf+BhJiyVFXppWZnG47oVgawamkVOF
         D2Bw==
X-Gm-Message-State: AOJu0YylikulaczNjcW29jn6j7Rql2Pgi2Be5rtW/FojnRQdnArKsoSF
	mSesZK7Ki4WsjFfvGq7SHknK2FKT9UAt8iMkH5uoFkAQEKWI5OYJ4wHcc69sneOlMFmHZYXG8Mf
	n3W1n
X-Gm-Gg: AZuq6aKX2xCozoOlNHch1rP4sQQ0aR3C3YzM1IQZF3sscx9sbVfgQkSKfHfQLI3xAL5
	TYqxhSSyR/GFBfEkfebNV5pa3cpaUN/KtjdmHz2AqEcCMMxGf5JMv+IWOSefWCQ0Qimvj2Qo3a7
	bUZJPeCNOVebVnUbDE5gGNx3TzK/U6q4vVAieEOni7DBxSUrDItbuGHdEWT7gPdMpzET1sfikr+
	nhDiIw+sVhxRL7E1tdwOAVLpOzO+P3HRK5r58oaNj8q7utMwog3QOdb49ZWz709gYv/3QVq4Axc
	JW9wia+S28/rwHqDTFSo3fHUDxgVqc1Q5MN/C0P/QtWbNN29P1LsH3sH4oKJrTZMkGDd3Jz2676
	JofjFUUwNJqwCkcbE8bsLXE5DDgsxuNGfHPY028yU5oo78bzemM72nN1Sgn0w+mw8BNGz0n7mER
	jpB7Un7uPvgQ00dou3QNqNmRooQUWqfS+EBakVrux6
X-Received: by 2002:a05:600c:530e:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4805ccddb9bmr59584965e9.0.1769408713550;
        Sun, 25 Jan 2026 22:25:13 -0800 (PST)
Received: from localhost (27-240-121-17.adsl.fetnet.net. [27.240.121.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5b67sm254792925e9.10.2026.01.25.22.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:25:13 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable v2 6.12 6.6 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Mon, 26 Jan 2026 14:25:04 +0800
Message-ID: <20260126062507.12876-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211514-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 728D384872
X-Rspamd-Action: no action

From: Ihor Solodrai <ihor.solodrai@pm.me>

commit e6c209da7e0e9aaf955a7b59e91ed78c2b6c96fb upstream.

Recently perf_link test started unreliably failing on libbpf CI:
  * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
  * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
  * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251

Part of the test is running a dummy loop for a while and then checking
for a counter incremented by the test program.

Instead of waiting for an arbitrary number of loop iterations once,
check for the test counter in a loop and use get_time_ns() helper to
enforce a 100ms timeout.

v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Stablizes BPF selftests. Previous submission[1] missed reference to
upstream commit.
1: https://lore.kernel.org/stable/20250609052941.52073-1-shung-hsi.yu@suse.com/
---
 .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index 3a25f1c743a1..d940ff87fa08 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -4,8 +4,12 @@
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
+#include "testing_helpers.h"
 #include "test_perf_link.skel.h"
 
+#define BURN_TIMEOUT_MS 100
+#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
+
 static void burn_cpu(void)
 {
 	volatile int j = 0;
@@ -32,6 +36,7 @@ void serial_test_perf_link(void)
 	int run_cnt_before, run_cnt_after;
 	struct bpf_link_info info;
 	__u32 info_len = sizeof(info);
+	__u64 timeout_time_ns;
 
 	/* create perf event */
 	memset(&attr, 0, sizeof(attr));
@@ -63,8 +68,14 @@ void serial_test_perf_link(void)
 	ASSERT_GT(info.prog_id, 0, "link_prog_id");
 
 	/* ensure we get at least one perf_event prog execution */
-	burn_cpu();
-	ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
+	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
+	while (true) {
+		burn_cpu();
+		if (skel->bss->run_cnt > 0)
+			break;
+	        if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
+			break;
+	}
 
 	/* perf_event is still active, but we close link and BPF program
 	 * shouldn't be executed anymore
-- 
2.52.0


