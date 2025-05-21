Return-Path: <stable+bounces-145836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F09ABF634
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371F33AA3E9
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73127CCE3;
	Wed, 21 May 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JitxMd/z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HuCtZxF+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JitxMd/z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HuCtZxF+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF77272E42
	for <stable@vger.kernel.org>; Wed, 21 May 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834424; cv=none; b=aZmwuM3oyJktiC9dJlkKFui9JP+HEWKBPfGeQHpLg0tA7w2zbYTTyNwfqJBNfwRdL9Tay1bqo078ocR7IB2yR+4bU2nZOaMZRiYr4wO9i8a1Z8FQ6vrb2nw5N5X9yMM9Mid6Y9cR8Ty+n2fRcTCysMRk8MfFm4rOzbhS1d6j1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834424; c=relaxed/simple;
	bh=rieLMTjrQAsXfOo6NiyH//Ig54cxECs3IPCFH0Szeyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBwhCkQSD5SeTw9rbA9+ME7cSForrLmWqbernm5P6jXN3ySCzafh4mAdEeAY752rEE31aO7aBrwnACQNEo2AHPHmmk8dANVzVfSXVncTYxLcHBZGVG5t/c1Jy6N1bHicEl/B8/D+4bkL63KU0+Wii/qwiMZI9inKbDIeUu9GZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JitxMd/z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HuCtZxF+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JitxMd/z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HuCtZxF+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F2341F88A;
	Wed, 21 May 2025 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GpFh+YzT6LkTyhq1+ztaaJC5X679keKrZkWxYGe3Tk=;
	b=JitxMd/zbUTlCWCL3mWGGQnXpIZd9ujBtRqslfPlmATt4lUoaPWfbbCRetOd5079TwCkEv
	6rJAXipG/by9/vVWH1iyNBp0X7NpUj5pLnWmyWbZyOyiL/lpF68BdOk6j/JSNuzAxxyXkF
	7oPEf6ba3P3zhDcoQ9GVp9M2xV/Gjgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GpFh+YzT6LkTyhq1+ztaaJC5X679keKrZkWxYGe3Tk=;
	b=HuCtZxF+CRF+yNPT7ats0Ii7fiZJ7dgLjPOfOhXmJ5BzW5+POzitpimz9ESdHJpSgcnuNv
	IwninOUJh2RLcBDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="JitxMd/z";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HuCtZxF+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GpFh+YzT6LkTyhq1+ztaaJC5X679keKrZkWxYGe3Tk=;
	b=JitxMd/zbUTlCWCL3mWGGQnXpIZd9ujBtRqslfPlmATt4lUoaPWfbbCRetOd5079TwCkEv
	6rJAXipG/by9/vVWH1iyNBp0X7NpUj5pLnWmyWbZyOyiL/lpF68BdOk6j/JSNuzAxxyXkF
	7oPEf6ba3P3zhDcoQ9GVp9M2xV/Gjgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GpFh+YzT6LkTyhq1+ztaaJC5X679keKrZkWxYGe3Tk=;
	b=HuCtZxF+CRF+yNPT7ats0Ii7fiZJ7dgLjPOfOhXmJ5BzW5+POzitpimz9ESdHJpSgcnuNv
	IwninOUJh2RLcBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C3513888;
	Wed, 21 May 2025 13:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8dDxCDTWLWgXBgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 13:33:40 +0000
Date: Wed, 21 May 2025 15:33:34 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aC3WLsdsiXM0M-C2@localhost.localdomain>
References: <20250521115727.2202284-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521115727.2202284-1-gavinguo@igalia.com>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: 5F2341F88A
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,localhost.localdomain:mid]

On Wed, May 21, 2025 at 07:57:27PM +0800, Gavin Guo wrote:
> The patch fixes a deadlock which can be triggered by an internal
> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> [3] in this scenario:
> 
> Process 1                              Process 2
> ---				       ---
> hugetlb_fault
>   mutex_lock(B) // take B
>   filemap_lock_hugetlb_folio
>     filemap_lock_folio
>       __filemap_get_folio
>         folio_lock(A) // take A
>   hugetlb_wp
>     mutex_unlock(B) // release B
>     ...                                hugetlb_fault
>     ...                                  mutex_lock(B) // take B
>                                          filemap_lock_hugetlb_folio
>                                            filemap_lock_folio
>                                              __filemap_get_folio
>                                                folio_lock(A) // blocked
>     unmap_ref_private
>     ...
>     mutex_lock(B) // retake and blocked
> 
> This is a ABBA deadlock involving two locks:
> - Lock A: pagecache_folio lock
> - Lock B: hugetlb_fault_mutex_table lock
> 
> The deadlock occurs between two processes as follows:
> 1. The first process (let’s call it Process 1) is handling a
> copy-on-write (COW) operation on a hugepage via hugetlb_wp. Due to
> insufficient reserved hugetlb pages, Process 1, owner of the reserved
> hugetlb page, attempts to unmap a hugepage owned by another process
> (non-owner) to satisfy the reservation. Before unmapping, Process 1
> acquires lock B (hugetlb_fault_mutex_table lock) and then lock A
> (pagecache_folio lock). To proceed with the unmap, it releases Lock B
> but retains Lock A. After the unmap, Process 1 tries to reacquire Lock
> B. However, at this point, Lock B has already been acquired by another
> process.
> 
> 2. The second process (Process 2) enters the hugetlb_fault handler
> during the unmap operation. It successfully acquires Lock B
> (hugetlb_fault_mutex_table lock) that was just released by Process 1,
> but then attempts to acquire Lock A (pagecache_folio lock), which is
> still held by Process 1.
> 
> As a result, Process 1 (holding Lock A) is blocked waiting for Lock B
> (held by Process 2), while Process 2 (holding Lock B) is blocked waiting
> for Lock A (held by Process 1), constructing a ABBA deadlock scenario.
> 
> The error message:
> INFO: task repro_20250402_:13229 blocked for more than 64 seconds.
>       Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:25856 pid:13229 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00004006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock+0x75f/0xeb0
>  hugetlb_wp+0xf88/0x3440
>  hugetlb_fault+0x14c8/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0x61d/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0010:__put_user_4+0xd/0x20
>  copy_process+0x1f4a/0x3d60
>  kernel_clone+0x210/0x8f0
>  __x64_sys_clone+0x18d/0x1f0
>  do_syscall_64+0x6a/0x120
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x41b26d
>  </TASK>
> INFO: task repro_20250402_:13229 is blocked on a mutex likely owned by task repro_20250402_:13250.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  io_schedule+0x92/0x110
>  folio_wait_bit_common+0x69a/0xba0
>  __filemap_get_folio+0x154/0xb70
>  hugetlb_fault+0xa50/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0xace/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>  </TASK>
> INFO: task repro_20250402_:13250 blocked for more than 65 seconds.
>       Not tainted 6.15.0-rc3+ #24
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro_20250402_ state:D stack:28288 pid:13250 tgid:13228 ppid:3513   task_flags:0x400040 flags:0x00000006
> Call Trace:
>  <TASK>
>  __schedule+0x1755/0x4f50
>  schedule+0x158/0x330
>  io_schedule+0x92/0x110
>  folio_wait_bit_common+0x69a/0xba0
>  __filemap_get_folio+0x154/0xb70
>  hugetlb_fault+0xa50/0x2c30
>  trace_clock_x86_tsc+0x20/0x20
>  do_user_addr_fault+0xace/0x1490
>  exc_page_fault+0x64/0x100
>  asm_exc_page_fault+0x26/0x30
> RIP: 0033:0x402619
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/35:
>  #0: ffffffff879a7440 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180
> 2 locks held by repro_20250402_/13229:
>  #0: ffff888017d801e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x37/0x300
>  #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_wp+0xf88/0x3440
> 3 locks held by repro_20250402_/13250:
>  #0: ffff8880177f3d08 (vm_lock){++++}-{0:0}, at: do_user_addr_fault+0x41b/0x1490
>  #1: ffff888000fec848 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlb_fault+0x3b8/0x2c30
>  #2: ffff8880129500e8 (&resv_map->rw_sema){++++}-{4:4}, at: hugetlb_fault+0x494/0x2c30
> 
> Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
> Link: https://github.com/bboymimi/bpftracer/blob/master/scripts/hugetlb_lock_debug.bt [2]
> Link: https://drive.google.com/file/d/1bWq2-8o-BJAuhoHWX7zAhI6ggfhVzQUI/view?usp=sharing [3]
> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> Cc: stable@vger.kernel.org
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Florent Revest <revest@google.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>

Acked-by: Oscar Salvador <osalvador@suse.de>



-- 
Oscar Salvador
SUSE Labs

