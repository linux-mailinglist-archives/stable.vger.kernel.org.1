Return-Path: <stable+bounces-135232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9AA97E63
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303BF17E328
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC7265619;
	Wed, 23 Apr 2025 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0yJu21G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC58EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387668; cv=none; b=Ge6fZY1ywETu9BdhOe3g4JS/UEfF0LWBSnruX1VbUz4lfntp0Skq0uhbQvOrLUqSY/bKjh5CsGN+21vvFHWj0aJPIMd/nJBblnfoLsdmpDrfHhZYY6tqfqSkVAgM04d5/0h85Ib1T5MwA8zmC0/tqLtAcKPmddrMQX2E3LiH1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387668; c=relaxed/simple;
	bh=zkfib7IMKdNhqCi7NkHXjhd0kSC3EP1RENQA5npVnNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnJGCLgeE/B4zYccCENek9OkTLL/BU+cOT8v45iwUcuKkKOagz5CBQq9ZEAmiVclhR6r1ZAFTiqRF/qrO1bzIAMNcSz3KoBsMmVdfGO4iVK3ElfStR0FFUuPN3eTD4OI+QFGRHGzkpt9lRTZMSPeJBFxuJQ+XWpFYFWj+datmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0yJu21G; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c14016868so5972368f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387665; x=1745992465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW1G9WuNDA4Va+7AXElVcnoHPSxx+ur0q1ileeKokbc=;
        b=Q0yJu21GT6DgVGXNyEQB65SvtOPRhenmIl51qKTXTDlzjIhjaudVrDI4zxLvipXVyI
         8AFgX0lLUeB2B/jo+MsWWPq6CQUzvArMYb0DqEflHoDMeX1IUPM8Dpln8DaGchXtrd/S
         B94opayPzbyFrsiSqmWHMEJ07ZlYk31EDdryMJi2RWWlf2Ie7k/IKivHeXxktSAlVsVS
         7o1LD4/y5g7F1i70n2DBaF4ZBUWqYTyQgMfmcBRIuPrBaEK0CN8pBxM2UMZlwIvbzDOS
         uX2ccXod5nYkWhojaIv3UV7qOB3AGC/1fxjY9GLumBnF9Mo79MQt5S68jicJuU0T21vv
         qDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387665; x=1745992465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW1G9WuNDA4Va+7AXElVcnoHPSxx+ur0q1ileeKokbc=;
        b=Lc/JNR0mMpb/kkn8BnnZizKoShj4k3kAl6iQmcLQIPDseVtG1Ekr/PJd0bnuQTZXgH
         N/GCPdYpRyQ4aJQVi3pWi+ZkWoiwRTHJE4l0AoALlMVCA70rhCh9HmxsfRB2/w/fGtUw
         BlvH8mPh+kSondT9NzJE/EfqUbQAxshB0o96JNTUYuFh5WVcfXkmo9Okpa0SDFXteNPS
         8l1n0x4Z3zoRDW7I2/fKh/06V8H2LPvLAwQgqRQFD+28CiulABduQdQpKeeavUuX7spv
         2OybdYxlxDNVKY2Yjb4riLlXBdBhghvDN6Zsw0uyxaNoS/y7Zw6veDE37y8TI9TSUKHG
         EbhA==
X-Gm-Message-State: AOJu0YyhJQ4Y6Qg1cjAM/UMhUiOA1k98/8f64v2uAOfJfa38VnwQyoOA
	Rs9U3aKFwZI6uZBungtO7Bq4xNE2lNveZq/ZQ2kyftfDKfUJ/zgPGpOK31V/vycvsJ9I6ltNJJ1
	TrWXiwA==
X-Gm-Gg: ASbGncvGP0rodqwRE7oEv1riDju+ElEIjKXH11/6jjWN20nr6t1biHY2RnqMLGOs+FI
	whCUomaSEH+qEmRrmwpVSn38GoNekcQF2OxRCtP8ymuPFStMJb28UuibqOgVKTC6k/cF5QrW9oK
	m59UjHKMxq25K8iO0rdR7DxkYy4kOOkwx8K4U2j1JpaWroYe/gev/23pLriSRjVGk4BSSCcU9a5
	xGFz2uA/6BtMaxxpLVdUsdu07TnGggx2zRBc1pmmbtcEF+dYvHequegB35PXvlZdCcZl1wPn23N
	enq8riy1LfYj9yQt7j1RE68FFFLLvaWcSWOJKWOHRehWSpkv0Gd6SPhlmGLpNur50eK1EQ==
X-Google-Smtp-Source: AGHT+IGMu1p5iQJmixS8fn+NZ2mRzkPCqCMWX/qy+yU7QwYXL6a6KyqF9slUhF7QBli1R0y1bZa8cg==
X-Received: by 2002:a05:6000:1862:b0:39e:f9e8:d07d with SMTP id ffacd0b85a97d-39efba3fe8fmr14069878f8f.20.1745387664572;
        Tue, 22 Apr 2025 22:54:24 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ecf37csm95900935ad.197.2025.04.22.22.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:24 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 6/8] selftests/bpf: validate that tail call invalidates packet pointers
Date: Wed, 23 Apr 2025 13:53:27 +0800
Message-ID: <20250423055334.52791-7-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
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


