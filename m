Return-Path: <stable+bounces-121088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B67A509F9
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41551885B1D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743122505BD;
	Wed,  5 Mar 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="QXL78SbR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5451C863D
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199237; cv=none; b=A8v1Ess1MKZdyWkIe5tAOqYbuAHF/9HI5hXPVKmdEdio66c1tLE97xQ0lnFrw87UhLeNm0gHBlvZ1nRgkta94JtYJL5qk3K7crFg7y8AdCvZbloaMdXH/nxPXpspB2dlFtU480Qvd+HOvPpdr7zDZQ+vkX+AlHYn4nXpWhVoiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199237; c=relaxed/simple;
	bh=vWcv/K1l+K3p4EVcMon7mT4ILCLwGIlbh8EAZLG7OWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUBDhEKi9pyLfZYZDtG7S9oozbRnJ+i/19viFR/At3gQA+nSwiBCKQslf16zxewjmaGuh0lQ2qbazQf8KkSTrtqOtpvNbLOIl7MsqZzMRv4RaYT0Fp3VnNYHUCWkRdBLMPEpXHUruTOaKIlSMfWZFJ+m0ypVhveJYPw3P35SEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=QXL78SbR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so29624135e9.3
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1741199233; x=1741804033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmqsPVj3zigw5SJlik1KEdOrtnV+X6vHrAHhUsdQ+jM=;
        b=QXL78SbRVu641Bk7BJe3roc7V5v/VxqsNlueoURPrSFSp0Y1r3czzSrXCJt/iWlWn9
         TZ9PpD5BaCxh7fmGo1qKvPSq8XbsnsyvL1yJwsNutiQPYBzI/STC6cJz491pu5stHAGC
         hDHjAoVBOETABBO5sY51MEOQGQKC5ihTvnuZhpclWnKElJUjxhWi5UtxOifGajqCv5gh
         85bocc5RqQgbJ6dUOM/QR0vleJOQMzAZDqwpimmZNW2trjXlfbbqt3LSwJmjJgiaDpib
         Lw1xmi+fBacEnsUKmE7B0arQwZ7ekywKRHE3CjxQ/7MOZ+AAC+FGr1iNJ+0gsAiRIQqt
         GuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199233; x=1741804033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmqsPVj3zigw5SJlik1KEdOrtnV+X6vHrAHhUsdQ+jM=;
        b=gH4yYFCsA5XYsqbIwIt9ftd823GiBq5hOJeh3yT68mj99hROBhPmp3k0XttROG077P
         D3Xi48B8ti/sKhb+qpRadWvEPUuArO5VmoW+YkOGd+6RBjegdKnkFXbg2r7O0/3Hpk9G
         VyYrv+Nvy2+uHZY+d1yiBl92S/AZ9behLZe+D3dv/oGFDWFt2RHVfu6QcJ/QxWoUH6Pe
         t03mN9BvWdJP9lH0GwaE0tspRgJCTUOaso3NaLEXNvE7bFb3w5p4hLiWmgq7AYfr+4b2
         JyoPHJo6MTdiBMmKhVtWTWZXmi/98GWRWONb0nKLZe++RHHEdfK5LlUapP651NKfrDoj
         tVAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2pFaqWZfilBqOQ20peMvQj2ojQqnR6xuDTgMK+3TEbpfV4fYJxpAG2bI4Rh1anGvkRPYfqDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWry4et1vJFO8c792ERxIviuK+UgVtw9PDpCRq5+wRCCluZD9i
	rQOje29AMHZiAjyYyZZDLDnBuqMOJgMz4ia5qINsHR9JJiZiPuNL6p1MHLaDkxE=
X-Gm-Gg: ASbGncvy2/rUWDerly5rZMW3JA6jpNOhW9gm8ezv9Xu7ibELF537HB3wOSLty50LP6J
	cdb6ff+4nFHLJiw/xME8tEtYHpcH1G0McOe9GXMbt07xaQ+ybkW7QssnkE9LhWIhpS/hKALEUIw
	0zRv+4WPZrr9O2VVoWFkr7YuN6lW5m/6U/BINQkt73VgHhr0WHhKxVafGOValmHWdBnEq/I2l20
	Safwxb/mb9QY/vvQXseWqb0hhTSZYCAXBkxOr5APqH+BhJffoUXGEsTWjZGz3puAkN/Bm+OkoHd
	F3d0u/Mx390OEjO9Vs9BOTCgBM2ovnwXweATP8mEjnRrEDurAjQJ7nlrsW4pB1b2CbGU
X-Google-Smtp-Source: AGHT+IGU8nWcRtr2B4UqfYOtk0TV+SeXAVWhv3bRuc0d3YJPXNqkxv9KOLJ7m+TP6j8MyKd8pDQEnA==
X-Received: by 2002:a05:600c:1c94:b0:439:7c0b:13f6 with SMTP id 5b1f17b1804b1-43bd2ae52d7mr35655225e9.31.1741199233420;
        Wed, 05 Mar 2025 10:27:13 -0800 (PST)
Received: from christian-m2.local ([2a02:6b67:d118:f400:558a:d339:d765:49fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc135676sm44022965e9.1.2025.03.05.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:27:12 -0800 (PST)
Date: Wed, 5 Mar 2025 18:27:11 +0000
From: Christian Simon <simon@swine.de>
To: gregkh@linuxfoundation.org
Cc: jolsa@kernel.org, regressions@lists.linux.dev, simon@swine.de, 
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] uprobes: Fix race in uprobe_free_utask
Message-ID: <f2x6zmel57ijjmvy7fqy2h4uaffm2cptpnj3ei7ythdmwi6vd7@h4ohwls4p77f>
References: <2025030550-last-fit-9d20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025030550-last-fit-9d20@gregkh>

commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d upstream.

Christian Simon verified the regression exists in v6.6.80 as per method
below and backported the mainline fix to the older version of
uprobe_free_utask. After that change I can no longer reproduce
the race with this method within 1h, while before it would show the
panic under a minute.

Max Makarov reported kernel panic [1] in perf user callchain code.

The reason for that is the race between uprobe_free_utask and bpf
profiler code doing the perf user stack unwind and is triggered
within uprobe_free_utask function:
  - after current->utask is freed and
  - before current->utask is set to NULL

 general protection fault, probably for non-canonical address 0x9e759c37ee555c76: 0000 [#1] SMP PTI
 RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
 ...
  ? die_addr+0x36/0x90
  ? exc_general_protection+0x217/0x420
  ? asm_exc_general_protection+0x26/0x30
  ? is_uprobe_at_func_entry+0x28/0x80
  perf_callchain_user+0x20a/0x360
  get_perf_callchain+0x147/0x1d0
  bpf_get_stackid+0x60/0x90
  bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
  ? __smp_call_single_queue+0xad/0x120
  bpf_overflow_handler+0x75/0x110
  ...
  asm_sysvec_apic_timer_interrupt+0x1a/0x20
 RIP: 0010:__kmem_cache_free+0x1cb/0x350
 ...
  ? uprobe_free_utask+0x62/0x80
  ? acct_collect+0x4c/0x220
  uprobe_free_utask+0x62/0x80
  mm_release+0x12/0xb0
  do_exit+0x26b/0xaa0
  __x64_sys_exit+0x1b/0x20
  do_syscall_64+0x5a/0x80

It can be easily reproduced by running following commands in
separate terminals:

  # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }' -c ls; done
  # bpftrace -e 'profile:hz:100000 { @[ustack()] = count(); }'

Fixing this by making sure current->utask pointer is set to NULL
before we start to release the utask object.

[1] https://github.com/grafana/pyroscope/issues/3673

Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")
Reported-by: Max Makarov <maxpain@linux.com>
(cherry picked from commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d)
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250109141440.2692173-1-jolsa@kernel.org
[Christian Simon: Rebased for 6.6.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
Signed-off-by: Christian Simon <simon@swine.de>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6dac0b579821..70fae75c48ca 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1716,6 +1716,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
@@ -1725,7 +1726,6 @@ void uprobe_free_utask(struct task_struct *t)
 
 	xol_free_insn_slot(t);
 	kfree(utask);
-	t->utask = NULL;
 }
 
 /*
-- 
2.47.1


