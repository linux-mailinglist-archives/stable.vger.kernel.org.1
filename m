Return-Path: <stable+bounces-139115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAFAAA451C
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A5916EABA
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194721420B;
	Wed, 30 Apr 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ekaP/JeQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F97FBA2
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001237; cv=none; b=sqkn+QcWWyEUmeDtQ0x0JkYq9xWhiWmc/7h+BvzjpIB4XMajD2hiB+KTTr2AddsjAUDtgS6aPnf9h/Sc3Cxni2aRZloIf5ndXS5UFg3SPoOFA3tg+KwqCBK1JtRwMvmtZyPzMuLR6dRFb1LTGf+N+pR1ovuVdH6d3wCCUvgbhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001237; c=relaxed/simple;
	bh=zkfib7IMKdNhqCi7NkHXjhd0kSC3EP1RENQA5npVnNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBtGByHDJYSf7DoivPveudE38y+uErcTOhlNGXeqK9Xr4W9kim2VbEnjRVArZUkdYHsJ0RKhcRSjnJNrG7RBv9JEmRN5gQXE1kfd5QCdXRSOp4Dh8ROV+xbpR9B8I7YVilyenS8SszpN0ws0fMyegKd5s7VpQuuTm5yndq7yp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ekaP/JeQ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-441ab63a415so23612445e9.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001234; x=1746606034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW1G9WuNDA4Va+7AXElVcnoHPSxx+ur0q1ileeKokbc=;
        b=ekaP/JeQwxCXpFDSTbMDqkfRlrys8nFD6mO2tXLX5Vi0tbMjEorHXfqDxMToAI+uqc
         vde4UypZdqzY6bY+eZlSklmKtdjFQkNxUaCZzO4HDK6GcwV8uIQyj4l/7Lofo83HMqHA
         Hl/VveBcBF7Asc/gkvKuQjQPprQ2qk3/GjbnW4ifpYUtAJrNdC70qVrikjKr/fm5zUYW
         sxtVd5RIDNn0kALLfCD6Kt8VNuthzwkynpkTJhO1Nub7apFQFtXu0uGbgvUhAEGvCPS3
         4KrntXPmrBnnGjqcOzzolgFrFCHfpPSgBLNJ9MLuhlGCcExkRxf9a7V+u4AfW4n/myjd
         ahmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001234; x=1746606034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW1G9WuNDA4Va+7AXElVcnoHPSxx+ur0q1ileeKokbc=;
        b=nJ5DErl9kQ3o/Nj/mCpHWAF05Y/7N9Mp7PvOXuAt8GomlzFxGupphUes0BupEiUPMi
         yb7+T7ccUyfHoRRCK6V0ccU9dpw9NMzm0bqZSp7autKOvGcCB52BTjmTqZnwOYQV+eiX
         l9rh/4Nq3gKvOiq9SalnNETT15lSwtQYtRm9jv34YNRDYiP0Vu2tf3rD5fCTfajaqq8y
         kfo4RvysNoPlWct4p/OTG1FiOUNcHcbi6shodrIK4ehvtCE+5sw8iZ66GdsIRwHOGwNZ
         E4rea31wTlR4mfic2QEg58j5Fz15FGUPnk9TaFppngetnaZ/DMKknWqGYxPufWJ1coX9
         10hA==
X-Gm-Message-State: AOJu0YzZRqC2lMdIJrEL8vUiF3WeFVB2smZ5vNk5AoVQ5fIvw0vKTrW4
	/IBZr+xtf91A2k+4F5tpIwfxP55LrzipdJAfkas+KAoxr6UQs6xjBh65uaUx56UJSFlECWfuNtl
	za+q2Zg==
X-Gm-Gg: ASbGncsJkxknKS1U7rAI9pno1H0arqqvpXYRM2S5xP5iWbxDtYnbtdXK6WCf8qAWGYz
	bDgTGk+3VRgqV1SmbfBizoebkj/ow+xx86d/yC7x5OfEVbeBRLdAC3p9rtPGna7q4DK/ffhpcc0
	9sdhaaU56v1FhHXAQ1xumy+kpOp8CB7DYuZ+Lb5J1itm0588yB2LgUOIp/7nNankc5/6oGan+MV
	HnR36AkMPdlfWJ2aQclLJGHOrib2dcCzvX2vlzzKYXavqqjiONOcL4hqUJsweT8YvbY4tVPKbj6
	Tik6KF8vKV7HwHWWHRAamqF2SB7icGYiw7libCLPjzGMPJ4pg8WJtw==
X-Google-Smtp-Source: AGHT+IGkMoLU3oohgCvT8i9jQoSzpxsmeRJofUmyrW6EkvBP9uUEGO5vMzBp33p6FwvfX7WDxsfvhg==
X-Received: by 2002:a5d:64a5:0:b0:3a0:8331:3380 with SMTP id ffacd0b85a97d-3a08f7525a8mr1932263f8f.8.1746001234124;
        Wed, 30 Apr 2025 01:20:34 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22dd9530465sm54401195ad.10.2025.04.30.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:33 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 08/10] selftests/bpf: validate that tail call invalidates packet pointers
Date: Wed, 30 Apr 2025 16:19:50 +0800
Message-ID: <20250430081955.49927-9-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit d9706b56e13b7916461ca6b4b731e169ed44ed09 upstream.

Add a test case with a tail call done from a global sub-program. Such
tails calls should be considered as invalidating packet pointers.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-9-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index e85f0f1deac7..3c8f6646e33d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -50,6 +50,13 @@ struct {
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } sk_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
 SEC("cgroup/skb")
 __description("skb->sk: no NULL check")
 __failure __msg("invalid mem access 'sock_common_or_null'")
@@ -1005,4 +1012,25 @@ int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+__noinline
+int tail_call(struct __sk_buff *sk)
+{
+	bpf_tail_call_static(sk, &jmp_table, 0);
+	return 0;
+}
+
+/* Tail calls invalidate packet pointers. */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	tail_call(sk);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


