Return-Path: <stable+bounces-134533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B12A93422
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299231B630B9
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430B1DFD8F;
	Fri, 18 Apr 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="abkKpi3i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5B19EED3
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963437; cv=none; b=fb5bYx7whzYiPYmIQR5m9rWz9Z5hK5tvoRyV7dwa55mburzT0s82uamYmA3a3zahtEUuzHk7f0/Y7QHnSguDBGm3H01fwxswhHCPM9AsA7ml6Z8YqWNzAzLt6zIFeLAi0kzmx8yKrx5RVE5X/UK8/UBof+wdcocrpyIN84E47Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963437; c=relaxed/simple;
	bh=7VmAgfV4HjD2TvDskbOnN334T+nY1sFF6x0JAcILQcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t92UojzR4bS8ypd7poXpolUuAzMX0KjDixwoFdx76PoPIl7XHLZDBKMgtXKriwYup4itKTrC/RROCM0IDcKto/esJ6v8078ZghZ6sJynRz/qfR3rjO0WlracFaPHvF/EKE+c0S39Ku1jLh/2Oa4C7QGhoGVNdkCruzNXOII6tyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=abkKpi3i; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso937634f8f.2
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744963433; x=1745568233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjwuy0Es9u22wH8/c6wCusVDfBZ6n6xETTX/GvvCt+U=;
        b=abkKpi3iFCYcDLSjQ8pv15jgdpu2a1eK5S7/JlhaQTyMUvod4eHiUtXn2aCelTjuJH
         I8PBnk+l7F9HdwpBam9GyktnXzCh6rS2WaLaE89E2Vm9dRaigDyktNcK4U8X6/NQmGrk
         fW5LHEomaUNl+8qL/tPvcO6Diki28E9MC6mJ+nNnSGizHLwUOSgVhIg7LEq5oTKLKPOz
         h+kUXa6ky0T6mhB3LMsnDsQyaJRN8j/wun3L7pH5oHoEw50IN/rYCE0yR270QpGnMHSU
         EK12TMyWoRfAzZNW+X+IxzJFOc8UMC5QI7BtbzoLfNXa1Im114p7uYlxShc1TRWCLiA0
         kKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744963433; x=1745568233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjwuy0Es9u22wH8/c6wCusVDfBZ6n6xETTX/GvvCt+U=;
        b=a+934/fqgE/VWwv033Nb5GGCbFcPLqarqCFqGNwf5SDV9ZoH10uwsWLayuY5+/5TjP
         oDC9BaB/i/J7hh247l97JAk3w+rIDZdnGNNUINW4YbgI0uhrkXpeWOOcjm2frmU1H9T0
         w3uLDMfWMXGY8pPf5F/rGZl1iEDKi08KbGCUbRpzfLhruECsrjtoJNdSF3A9Ge6tmhQW
         hO4GktjUMId6466r7thL7xGw8wMeNqMD1SKrjWcYkWDv2d/iFgiu2jsG7RMQpqmOMKGN
         /EFED+efZFnhLfcU0XCzGsxnWs04e/rgUTobVB7e5HbunjbLTYAxvC9jTuI6zgjJnQIk
         T8qA==
X-Gm-Message-State: AOJu0Yzfk4XUAylHb506HrT89afrxcx7yvpG27Klsjvc+hkGYwOnf94Q
	0NxjQdINGDpv246foNIVFFQ3Vq43TEKMvJsKw7+uS+coX8b7z942rj33TOTN/9wbgtfdM67YLYe
	2TWP+jA==
X-Gm-Gg: ASbGncuITD7rJKrcWBqcCka5s3k+88C/EyiDxB1ZwDMy7ajb0BtCLiarcaopIIeXEsy
	upKBiDbDsiS8NkEbE+Cj6rY943FN2qvy5hzGtisK6EpTnAQ5QRZwYHeQhgHa8WvXa7aBxroQqYd
	ChCE3Iz1ZiKeHMKm7NUhHRxH53d0ARJcEOdxKV26HEESuiaXjUzfj4pqSOr0MjA3ZcHuHM2Tg2H
	XzDUPx3xY/q8F+S00FpUa+nMfXNi6yp0P107p6M8oT4T9wOLxKnVEf3nCWo2/WAmHPWGCpzJSYm
	3IczUD7fEBpZm6XN+OzaGqjWrSsJkewJgNWSI+bMNLVLN3WwKJjMpfwOwgBsuL2Mw6ahAVWT
X-Google-Smtp-Source: AGHT+IHdv5FlY1WzSUMxKofNr95e4N8ItyKdCsn53tQu1YMsL62Ud83XTRd9/bPT1pt6NdAlXD1J+w==
X-Received: by 2002:a05:6000:2408:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-39efbace5famr1163119f8f.40.1744963432820;
        Fri, 18 Apr 2025 01:03:52 -0700 (PDT)
Received: from localhost (27-240-201-113.adsl.fetnet.net. [27.240.201.113])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa433141sm2031663f8f.35.2025.04.18.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 01:03:52 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.12 1/1] selftests/bpf: Fix raw_tp null handling test
Date: Fri, 18 Apr 2025 16:03:45 +0800
Message-ID: <20250418080346.37112-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b2fc4b17fc13, backport of upstream commit 838a10bd2ebf ("bpf:
Augment raw_tp arguments with PTR_MAYBE_NULL"), was missing the changes
to tools/testing/selftests/bpf/progs/raw_tp_null.c, and cause the test
to fail with the following error (see link below for the complete log)

  Error: #205 raw_tp_null
  libbpf: prog 'test_raw_tp_null': BPF program load failed: Permission denied
  libbpf: prog 'test_raw_tp_null': -- BEGIN PROG LOAD LOG --
  0: R1=ctx() R10=fp0
  ; int BPF_PROG(test_raw_tp_null, struct sk_buff *skb) @ raw_tp_null.c:13
  0: (79) r6 = *(u64 *)(r1 +0)
  func 'bpf_testmod_test_raw_tp_null' arg0 has btf_id 2081 type STRUCT 'sk_buff'
  1: R1=ctx() R6_w=trusted_ptr_or_null_sk_buff(id=1)
  ; struct task_struct *task = bpf_get_current_task_btf(); @ raw_tp_null.c:15
  1: (85) call bpf_get_current_task_btf#158     ; R0_w=trusted_ptr_task_struct()
  ; if (task->pid != tid) @ raw_tp_null.c:17
  2: (61) r1 = *(u32 *)(r0 +1416)       ; R0_w=trusted_ptr_task_struct() R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  3: (18) r2 = 0xffffa3bb801c6000       ; R2_w=map_value(map=raw_tp_n.bss,ks=4,vs=8)
  5: (61) r2 = *(u32 *)(r2 +0)          ; R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  6: (5e) if w1 != w2 goto pc+11        ; R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
  ; i = i + skb->mark + 1; @ raw_tp_null.c:20
  7: (61) r2 = *(u32 *)(r6 +164)
  R6 invalid mem access 'trusted_ptr_or_null_'
  processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'test_raw_tp_null': failed to load: -13
  libbpf: failed to load object 'raw_tp_null'
  libbpf: failed to load BPF skeleton 'raw_tp_null': -13
  test_raw_tp_null:FAIL:raw_tp_null__open_and_load unexpected error: -13

Bring the missing changes in to fix the test failure.

Link: https://github.com/shunghsiyu/libbpf/actions/runs/14522396622/job/40766998873
Fixes: b2fc4b17fc13 ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Note: as of v6.12.23, even with this patch applied the BPF selftests
fail to pass because "xdp_devmap_attach" is failing, but that is an
issue to be addressed separately.
---
 .../testing/selftests/bpf/progs/raw_tp_null.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
index 457f34c151e3..5927054b6dd9 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -3,6 +3,7 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -17,16 +18,14 @@ int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
 	if (task->pid != tid)
 		return 0;
 
-	i = i + skb->mark + 1;
-	/* The compiler may move the NULL check before this deref, which causes
-	 * the load to fail as deref of scalar. Prevent that by using a barrier.
+	/* If dead code elimination kicks in, the increment +=2 will be
+	 * removed. For raw_tp programs attaching to tracepoints in kernel
+	 * modules, we mark input arguments as PTR_MAYBE_NULL, so branch
+	 * prediction should never kick in.
 	 */
-	barrier();
-	/* If dead code elimination kicks in, the increment below will
-	 * be removed. For raw_tp programs, we mark input arguments as
-	 * PTR_MAYBE_NULL, so branch prediction should never kick in.
-	 */
-	if (!skb)
-		i += 2;
+	asm volatile ("%[i] += 1; if %[ctx] != 0 goto +1; %[i] += 2;"
+			: [i]"+r"(i)
+			: [ctx]"r"(skb)
+			: "memory");
 	return 0;
 }
-- 
2.49.0


