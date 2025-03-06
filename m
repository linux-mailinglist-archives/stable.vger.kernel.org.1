Return-Path: <stable+bounces-121237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5299A54C58
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31C51898613
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64420E037;
	Thu,  6 Mar 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="Q54L67iR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169E199B9
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268310; cv=none; b=oddifshFvlJnNX+943xsx1FqwGcXxwvnfEWVU4wdRBTgAGgmj2WWfffn/K0glkSKcQYyOLcQN8U0VO2nbZ0c6swFh8dCCBxVrPUYJW5yJ+9q4L5ru8PmBXEshJyVf5xhcviN/dpqzGLQS/Y6/JLyA8GN6/BzJh4T7GgEQwBV31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268310; c=relaxed/simple;
	bh=AkyjFd0Wa3rnyt69pk1A/DpTh1F/3OUgZVLHKgJatbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+RNH499W+VQtw2/pt1rc0agnXbN/1cg09/LzoIX9awgBV9HES0PcMtfW06gZjDQD4Va+pDaTMn5Y2vuqs+vemt2OCnpIJVfZE0UZAK6wgKiNMc9KOZ1yNq1CBF9lxKeFkPk5vzNFH9+MIeWwPzh0R/c9ovKdSfcOnyYZ7xWVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=Q54L67iR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso501665f8f.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1741268307; x=1741873107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkwkoKX7190ti5RXhzP8t6ZA5NeYywDJtwchoyuQTmI=;
        b=Q54L67iRruu0EsrkXVWHePVj58hra34cqqvDjjJZEyh3lQ3EUF26upUd6aI4Mh5Nwg
         bP5mPp19OAKANjTNPN+FaHfC3arny4qQSeaakNoOLSRV60qfRqMdBQk7XDAgoPVYVWs/
         qoFaG25nYPRdQPgmGqsGo0MMu/jLsf5dfrmT8BmQ67Miq7HbN2jOq5qE8c63DzF3EjZe
         lNSq6LwvxfG05w7OXKjsDzRqi8SnjvhD0DszXDXUDKRqUpOQv3t0Vsw68+kg5U1E/AmS
         afWc7wm9Ra1UbWLXcqOhnMZr4Hy/nj/H19pLGXA6I8A5B5Cymvht+R0yCDFPEhh3pZqW
         eRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741268307; x=1741873107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkwkoKX7190ti5RXhzP8t6ZA5NeYywDJtwchoyuQTmI=;
        b=tlNv1HO3SerZomGTFEhXb7/4vHhSwf6peVxlObQmz1EuOBtZKtf8EAfIEBt4gEiA5N
         Gs/nU38qsie/A4NyvsfO20rsA9YesHej7qZsQHpNzN9f1DYtxzIWtFSIzuJxS9PdxSU0
         5i5WWWx0IF+JwRKd53PWWJbat9U1nmptX5EZcrdSaugMs/rxjxq7grUQKp5ZyoJYUw+X
         OMalKhuYaIH+BEURMmIFAyn5Y/XfIWUCQakSNOX8X/lwzFwglk1XOCWo23A7aOszEqUD
         UgRG/MPUBiMZW3xr2k3+aUORiwfzi+G4SY7y68c+Hqj2D663YyKpA9kOmigJSbXQ1wtg
         5Txg==
X-Forwarded-Encrypted: i=1; AJvYcCUfp2OZuMk64hzi5SGa3FZV5h4GR2VPlqby8aWxTf9YoT7TY6hSFTMzotI5mE/mX6hcHxPqxLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVGIkbcTH7O0HZpta2K9XXGGTBpdQbQh5P2wjaWIKjpHVULmk
	9TKSpsac7dyJ9P1bQn1Wrn5Hj2bRo5Ctqqb5shOKgyknd2jTKm1pNKRbfnL8swI=
X-Gm-Gg: ASbGncuPElmLCRnU/3WJ+wlRYIp05dgri/u9ABVPbQrbppOSM9A20kpHvOGRODpejma
	L+7O7xNq5W6j/XJw+Ljo1m520Nqq2Vt/DJ/XX+Dp8P+akIfkPdG8W6s4lAryhf9mAI1q4CjvVna
	gVEDpKwtJE4iYuhbfdkbLTYHWhwsVjrJ3fW+Mz1yEWrmSg0mIIUAyrayeWLgMprLSrHyq9RWOPV
	30AKoouWpMUWAURXNUL5L9EVm3n8OlGsf4bFE4LI5Oxbkr4aTqtE6O3W9dnJ0Kp+nsg3CxLv2Nm
	ziEHR6ceZ/cN8kAzj3lKlv/btLME59IpCsB6+NeI+knJMHRtAzHkcTuEG9mn/OL3twZK
X-Google-Smtp-Source: AGHT+IHRDT+UAaQw7oFEmzS+GWI1qFFPciKHABU9S0C7Q6REV7AakAMtPtN2rr+7AySWXlX37u+nUQ==
X-Received: by 2002:a05:6000:154d:b0:390:fe4b:70b9 with SMTP id ffacd0b85a97d-3911f72fc6cmr6896614f8f.21.1741268306938;
        Thu, 06 Mar 2025 05:38:26 -0800 (PST)
Received: from christian-m2.local ([2a02:6b67:d118:f400:558a:d339:d765:49fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7ae4sm2038715f8f.5.2025.03.06.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:38:26 -0800 (PST)
Date: Thu, 6 Mar 2025 13:38:25 +0000
From: Christian Simon <simon@swine.de>
To: gregkh@linuxfoundation.org
Cc: jolsa@kernel.org, regressions@lists.linux.dev, simon@swine.de, 
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] uprobes: Fix race in uprobe_free_utask
Message-ID: <u27rnbdpxnayssubw557qxf2rrf6p22cmwkg43skziesvpj7bq@ig5nmblcelrr>
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

Christian Simon verified the regression exists in v6.12.17 as per method
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
[Christian Simon: Rebased for 6.12.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
Signed-off-by: Christian Simon <simon@swine.de>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b52cb2ae6d6..fcb777ba17df 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1770,6 +1770,7 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	t->utask = NULL;
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
@@ -1779,7 +1780,6 @@ void uprobe_free_utask(struct task_struct *t)
 
 	xol_free_insn_slot(t);
 	kfree(utask);
-	t->utask = NULL;
 }
 
 /*
-- 
2.47.1


