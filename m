Return-Path: <stable+bounces-121197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C57A54634
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89D017168C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08B2080F6;
	Thu,  6 Mar 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="Bo0s28ES"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4320101A
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253099; cv=none; b=an+RXJ9H8MSrbliW+qjK63LrgE+8tysUAAPPNytXf4V/DadpxKbULqIUDXth/IHSSRw8gxfu/SShOZxQ+csz+pVTYbBX0poxVDLeBaK11IzM8SftfLcGH1CVEvImr+U4Yjj1fa6cwiaWDpxg0alu+FqrRBy+5iDVdtTwIqrNK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253099; c=relaxed/simple;
	bh=UXYZgBd7E0SPWfaEIMbgJmdYXQINO34nR25JeZs9mCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrf627OKquhKfdL77GV2lsgv7ReN8rz8G1Y9KayL3zsxyjri51jZ9nvmNPQpXKa4kbwH4dpA4qrYsUkI8oFuM+FCGpS6+Txbnm6ULZvxdgjzopZ4MROKUKzP5IRoFzuY3MWpD93iTnhWHwu7fqYADwy5YFrj/25Gn4CZQlRJ2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=Bo0s28ES; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso2236545e9.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1741253095; x=1741857895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhV/T3X4XR0o2C1s5ecZxEo9AmlSFdOugtjb6WjjMt8=;
        b=Bo0s28ES/UdL4Eftvctw7Gn8S7S0l3Zo14Cd9FBWR1n5835UQwZO3HbbsXqEUfiaDo
         dSIuVzBD96SCbGrIDKPkpoC+FtSKE2xZSlNbO3NG7lMKXDXDOn2nxIocbGCqCc+9c5gj
         5KnomWrdrLyBdm17z4p9+weJwZ6G2umf8W7E5B+xv0iZ3gVQW5mtE1V2DgqXV53SA0Fg
         ElFFDE0OTMndxE1aWiG2fRsBv/Ya8bTH+PrLytwIMKjE1zkEdALC+Humg5zJVmIHh/rd
         rHs1TohHPjpUdwhC5xiWnQgErQUI3uZOrGqBn6ALhIb3MUGnOarYvefUppRlIQ7zibff
         WeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253095; x=1741857895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhV/T3X4XR0o2C1s5ecZxEo9AmlSFdOugtjb6WjjMt8=;
        b=wccaxS5mt9Gh1BtycbU8gpfu5wVediNqcSjG1qBjUp3hg1wKFMiz2Fs4jS8TQ7GKgU
         ZMtFV8iVZsERKLzkaZRbsNAn1s7Aq5jgD7HZ13fOJgjxQZJsDOYUOb1/jVqAuPldhTW4
         C21j1kxApGVaKejCObYSQ/yyOuz96n1mTIc+DaG2AdTTX7hLSMDI+Fdy19UTK9PgpDSx
         DiCj4LHhqLKWZCMRM/Az0lwSezZ5X56ncnauFULTRrkJKJWPRG/dTL9aBZMBUnjRGmA5
         OvO1TW5O1QO6L8LNWU3s05qna/OFTZQxVWMz+xdcJZdjYSGbufJOBJtrVQUjCfBFpv95
         FU0g==
X-Forwarded-Encrypted: i=1; AJvYcCWpnxIqITcsyEqeTOwasWVr2apQNW5qIVt07XHh9H1t12RCGfq1LchJ1qlfTyKVAh67diLKtEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1LBTLSmBmoa5CdHFACqqhfbhxRslLloM/3TLQOpCv1tLfgMO
	RNYW8MDxhKZKvWw1IpGzFcU178drUcTBI+QI2KdnjR9RjbG1KQj2le239x7GBzg=
X-Gm-Gg: ASbGncst4lq0o7NSdnMfbonRTqHHd52VWLs9hTKVd0dZQGsgafbqH9vWgSkmVP/lwpc
	lyq5xDfFyWQNsz8bhoZj/8+sarG4UybFeJ7cmool/6qJMChNdNTxHfJsjgkO5h105lf21bFHWDD
	/fRN1pYbZBQWFokxrHn4IEkSjbCojY2RYqqk8YjufQ5R4UvtnSIOTG68l9pyqWs16CiQLQZrbUM
	MkwRh8SO5N7SnlwiTYtinaiib0wDI6tSK1o0D2q2Kitvs6XgG+NQ9GMJXzZeUkZwAETNzDhqPPU
	tgFko5UbXynCVy7ZUsoxRtVaMYPPn4Iwa2YJ/tHEj7HiBX3a15FkUKmTsxPzwS6p2kLe
X-Google-Smtp-Source: AGHT+IG4hSO06lFQ2XN2dq40YW69rWXO08sLF5FQ+kHU+aZgaZ7703tTxGVROH5QsraROPHKyu3TDA==
X-Received: by 2002:a05:6000:2b0e:b0:390:e6d3:1167 with SMTP id ffacd0b85a97d-3911f7d3041mr3190371f8f.50.1741253095082;
        Thu, 06 Mar 2025 01:24:55 -0800 (PST)
Received: from christian-m2.local ([2a02:6b67:d118:f400:558a:d339:d765:49fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103f57sm1422747f8f.91.2025.03.06.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:24:54 -0800 (PST)
Date: Thu, 6 Mar 2025 09:24:53 +0000
From: Christian Simon <simon@swine.de>
To: gregkh@linuxfoundation.org
Cc: jolsa@kernel.org, regressions@lists.linux.dev, simon@swine.de, 
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] uprobes: Fix race in uprobe_free_utask
Message-ID: <n2mkjosxf7bdnrjs4bb3zphj2tzfbssuqlgbq5m6zs3kxjrhki@5z3zuabq2tgg>
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

Christian Simon verified the regression exists in v6.1.129 as per method
below and backported the mainline fix to the older version of
uprobe_free_utask. After that change I can no longer reproduce
the race with this method within 12 hours, while before it would
show the panic in under a minute.

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
[Christian Simon: Rebased for 6.1.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
Signed-off-by: Christian Simon <simon@swine.de>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 9ee25351ceca..e9f9a669f80e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1719,6 +1719,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
@@ -1728,7 +1729,6 @@ void uprobe_free_utask(struct task_struct *t)
 
 	xol_free_insn_slot(t);
 	kfree(utask);
-	t->utask = NULL;
 }
 
 /*
-- 
2.47.1


