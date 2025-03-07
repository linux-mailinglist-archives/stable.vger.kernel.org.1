Return-Path: <stable+bounces-121384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E228A5688E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064F11898F5D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015C219A72;
	Fri,  7 Mar 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCT8uYvi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFF192B77
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353178; cv=none; b=JLmoBmuB97D/TDVIj7FcJrATzyjPeuzWeuHboGjL2iiFIgvEtljrUbojEswQ1ExW5EMTUrFw/z9OqpjjT18aw1k+necvMD14H5QZ8rl1d8YpLoe0t76Urhw6xtkCsjnI4dkz1kMPStVbEeOq99FDBz41jxO3/I7kqUuCM1P7uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353178; c=relaxed/simple;
	bh=XiZyMlv6q8diC5zMkv6Q6zJd0bIDPaNgl4gU3t6jI58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3M/AOtUjqDZgbCbl27wEBQTTEsWHf68lZPbE8GXQAH2k9Sz6lyLrQYZQmPZoQunvok56LnXnqZ65AumZAvNhL9r7BJLbjRH03BCuQBMmfGRGsvnd0DbEhy1uPMTVXu/M9+uX50+Ntwxt81ePnwgbQcRj/vH4kvqfDOoR/WgQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bCT8uYvi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc21f831bso1808545e9.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741353175; x=1741957975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ardG4Ps/EyujMRlvDicI6y4TPhLuKr8XaxVtNHC6RsM=;
        b=bCT8uYviNIKwYat738WXhQ2e9TeOcsb731Zm72vxtxAxIW8jv75D6uwQj5qH8F5bfQ
         GTg5HjBKQIeMwBFzNo8dIjjSmmbtHB+uPDOyauaHqdhWbhleClQn7OAn3rbQchbpg3uX
         n6cePEgkOi8EGzwQhKiF2UB7kuctpsR52w82k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353175; x=1741957975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ardG4Ps/EyujMRlvDicI6y4TPhLuKr8XaxVtNHC6RsM=;
        b=mvToponO4hWyTjedydChimA03ynhxRkB1FGTGTIuWH/j2sLpVL9Ucl2t3wn5NKyIZe
         Cm/fTxdNFPQ6mcLAM+fpqJyPhxPKPDENFKP3en0EFZp3D4fFfy4DVWoriJPhyYtyBB+I
         msL2YPn1EFgUEjBhymviee8eWEYbpzOrREARiWwGmDxt9tIuBM5s+KCZfsGSwiUGoA4u
         pZqHa4yNGOCzeMHlrqzoGp9prvqgU6pAombwViZ3Cgv81xWkOZJFO7Lg2K7BD5JuoygK
         Vxb8Td4nSc/4gMKZ9YpAIYqGUo87EnAGuvZCgrOV3mCpbW/UjpS3oW87+26PCfjFjLeq
         KSaw==
X-Forwarded-Encrypted: i=1; AJvYcCUE7rKyGs268giW6t66yUQOptS1OKlqpdzWbdSOM4VbDyufdE2qX6GDkgCigd+SPAq+2ut9F0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEd3t+W7TKCi/fSSY23ZnUJth60y83Il4vlCVg4IQbXQf2qJgc
	w25TW3za/t71l7xh3tLZBHFM+NfCUMRFDTFUOhRpyjAQKuzb5JpW2BgtNjAnxQ==
X-Gm-Gg: ASbGncuULv0D4kAwU5eQcXxtZSm8IbgVtOyWRD3WybWRrIMguzwVWLBk5Tb0jLfaZvr
	SGFXOu2DoKX7tVOpbxzEHJwEXCKfwIikmJWnxsk4RvrHjm36nqhqOlra4bkdQ8C779ijkNqNtl+
	MmQpCtV2KIXuk3PMTBvjOCSNNtY04ciMBoF38Kr6AxYHzA51mjip2j9iwGOb5PuXoAT7QB2V/Vg
	t20JRJwI72tbecUvU8imqOTnk/eDMj+ixmZH8yI8ESuTd5kcM41MnCvGuJa7qKFdDTxomDEThag
	fOVu0dK77PqzCa92+9G32dD8ZPzXjf2QMwiiglBVaVvfUr/bFM0I/rwrcNV/
X-Google-Smtp-Source: AGHT+IHEDtX8wMz17rBCScCFd9p5OqjVNL5r7IMzeZAqPHx801xfwZOzXHNszHykNzQ0JSloh/qTFA==
X-Received: by 2002:a05:6000:2cc:b0:38f:2113:fb66 with SMTP id ffacd0b85a97d-39132d9b63fmr789248f8f.9.1741353174872;
        Fri, 07 Mar 2025 05:12:54 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:9df3:6426:af03:5121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8a9sm5330631f8f.9.2025.03.07.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:12:54 -0800 (PST)
From: Florent Revest <revest@chromium.org>
To: bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	Florent Revest <revest@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
Date: Fri,  7 Mar 2025 14:12:43 +0100
Message-ID: <20250307131243.2703699-1-revest@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, load_microcode_amd() iterates over all NUMA nodes, retrieves
their CPU masks and unconditonally accesses per-CPU data for the first
CPU of each mask.

According to Documentation/admin-guide/mm/numaperf.rst: "Some memory may
share the same node as a CPU, and others are provided as memory only
nodes." Therefore, some node CPU masks may be empty and wouldn't have a
"first CPU".

On a machine with far memory (and therefore CPU-less NUMA nodes):
- cpumask_of_node(nid) is 0
- cpumask_first(0) is CONFIG_NR_CPUS
- cpu_data(CONFIG_NR_CPUS) accesses the cpu_info per-CPU array at an
  index that is 1 out of bounds

This does not have any security implications since flashing microcode is
a privileged operation but I believe this has reliability implications
by potentially corrupting memory while flashing a microcode update.

When booting with CONFIG_UBSAN_BOUNDS=y on an AMD machine that flashes a
microcode update. I get the following splat:

UBSAN: array-index-out-of-bounds in arch/x86/kernel/cpu/microcode/amd.c:X:Y
index 512 is out of range for type 'unsigned long[512]'
[...]
Call Trace:
 dump_stack+0xdb/0x143
 __ubsan_handle_out_of_bounds+0xf5/0x120
 load_microcode_amd+0x58f/0x6b0
 request_microcode_amd+0x17c/0x250
 reload_store+0x174/0x2b0
 kernfs_fop_write_iter+0x227/0x2d0
 vfs_write+0x322/0x510
 ksys_write+0xb5/0x160
 do_syscall_64+0x6b/0xa0
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

This patch checks that a NUMA node has CPUs before attempting to update
its first CPU's microcode.

Fixes: 7ff6edf4fef3 ("x86/microcode/AMD: Fix mixed steppings support")
Signed-off-by: Florent Revest <revest@chromium.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 95ac1c6a84fbe..7c06425edc1b5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1059,6 +1059,7 @@ static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t si
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
+	const struct cpumask *mask;
 	struct cpuinfo_x86 *c;
 	unsigned int nid, cpu;
 	struct ucode_patch *p;
@@ -1069,7 +1070,11 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 		return ret;
 
 	for_each_node(nid) {
-		cpu = cpumask_first(cpumask_of_node(nid));
+		mask = cpumask_of_node(nid);
+		if (cpumask_empty(mask))
+			continue;
+
+		cpu = cpumask_first(mask);
 		c = &cpu_data(cpu);
 
 		p = find_patch(cpu);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


