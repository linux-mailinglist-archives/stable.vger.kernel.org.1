Return-Path: <stable+bounces-217659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FmBKcWBmmmZcAMAu9opvQ
	(envelope-from <stable+bounces-217659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 05:10:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057216E769
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 05:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5379C301411F
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AF1428F4;
	Sun, 22 Feb 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7McUW9t"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AECA5A
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771733428; cv=none; b=Y4Jt+02iLwCjRJ8AVhUyvKG8B1ciB5V0ugMiQxKjf38ffNRK5TnRVP+0RpXGkMwzj0Fv+QN/Vv8XHCmj7AQqjLVXF2AfjmwyXF49EySsgGigyXPYNqL0/SnB6dfzQ9vf37x8GyaFHbw1Gz5RiBErfyoxbn2OLbyAZU5stcEIL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771733428; c=relaxed/simple;
	bh=6xZG9/rBdxMX5P/+5namCdQ9PNebWLaGMl4C9KSTOHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlUq1rxLrRHinTeKmMrXi4o0MI7wNgxquz9oqSmNiBGWyQOvoTXb+lHQu9Clrw8ZTeKLQmxc+HoB6gJCBlcCscMzzSKoQe9gcrLL2WAR59PHeVaovOdXmmRcdEmGL0eYWc0gPY8KMIlB72u6a+nF3DPg9SpzOizKIqhi4SqcyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7McUW9t; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <448363f3-34d6-4d36-b827-9b81023230ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771733414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaVVUXcjxIxCo1C+WnEbc4wHRZyroHOv+RROfAMIzMU=;
	b=n7McUW9tN38exYfI85ypc+GpKAIdQoL0+UyhfreVAv+vIEZNK+OfcECP8fI9N9FqicCn4x
	o3Qsj7S+EgPhctDFdG6HHGIm1TIr4A9eizfnsy3KuZzN9Xi32TFpBrZRiXGohGNHjyrIif
	35d8g91YmwFh4PJJWSnFZjb2WZk1Ets=
Date: Sun, 22 Feb 2026 12:10:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
Content-Language: en-US
To: Ackerley Tng <ackerleytng@google.com>,
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, npache@redhat.com, linux-kernel@vger.kernel.org,
 Liam.Howlett@oracle.com,
 syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, ryan.roberts@arm.com,
 stable@vger.kernel.org, ziy@nvidia.com, dev.jain@arm.com, i@maskray.me,
 baohua@kernel.org, shy828301@gmail.com, akpm@linux-foundation.org,
 david@kernel.org
References: <20260214001535.435626-1-kartikey406@gmail.com>
 <b398d163-7b58-402b-a37d-9562d658a62d@linux.dev>
 <CAEvNRgGLAnZkfPZt32-wyCaefu-tvG9WcX3zq1Xe7fsTabZqmA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAEvNRgGLAnZkfPZt32-wyCaefu-tvG9WcX3zq1Xe7fsTabZqmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217659-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,oracle.com,kvack.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,arm.com,nvidia.com,maskray.me,kernel.org,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 2057216E769
X-Rspamd-Action: no action



On 2026/2/16 06:48, Ackerley Tng wrote:
> Lance Yang <lance.yang@linux.dev> writes:
> 
>> On 2026/2/14 08:15, Deepanshu Kartikey wrote:
>>> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
>>> (e.g. guest_memfd and secretmem). These files are created via
>>> alloc_file_pseudo(), which does not call get_write_access() and leaves
>>> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
>>> true, they appear as read-only regular files when
>>> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
>>> collapse.
>>>
>>> Anonymous inodes can never pass the inode_is_open_for_write() check
>>> since their i_writecount is never incremented through the normal VFS
>>> open path. The right thing to do is to exclude them from THP eligibility
>>> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
>>> filesystem files (e.g. shared libraries), not for pseudo-filesystem
>>> inodes.
>>>
>>> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
>>> large folios in the page cache via the collapse path, but the
>>> guest_memfd fault handler does not support large folios. This triggers
>>> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
>>>
>>> For secretmem, collapse_file() tries to copy page contents through the
>>> direct map, but secretmem pages are removed from the direct map. This
>>> can result in a kernel crash:
>>
>> Good catch, thanks!
>>
>> For secretmem, file_thp_enabled() can incorrectly return true
>> (i_writecount=0, S_ISREG=1), so the mapping becomes eligible for file
>> THP collapse ...
>>
>> However, if any folio is dirty, collapse bails out early with
>> SCAN_PAGE_DIRTY_OR_WRITEBACK, as secretmem doesn't support normal
>> writeback, IIUC.
>>
> 
> Yup! In the reproducers [1] I had to try to avoid setting the dirty flag
> on the pages.
> 
> [1] https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
> 
>>>
>>>       BUG: unable to handle page fault for address: ffff88810284d000
>>>       RIP: 0010:memcpy_orig+0x16/0x130
>>>       Call Trace:
>>>        collapse_file
>>>        hpage_collapse_scan_file
>>>        madvise_collapse
>>>
>>> Secretmem is not affected by the crash on upstream as the memory failure
>>> recovery handles the failed copy gracefully, but it still triggers
>>> confusing false memory failure reports:
>>>
>>>       Memory failure: 0x106d96f: recovery action for clean unevictable
>>>       LRU page: Recovered
>>
>> Right. On my setup, that would hit SCAN_COPY_MC in
>> hpage_collapse_scan_file()
>> rather than a hard crash.
>>
> 
> Deepanshu, were you able to trigger a hard crash on some earlier kernel?
> I only saw this false memory failure log.

On a setup where memory failure recovery works, we can trigger a panic by
disabling recovery:

echo 0 > /proc/sys/vm/memory_failure_recovery

Then we would hit the following panic:

[  117.608411] Kernel panic - not syncing: Memory failure on page 1024d6
[  117.609490] CPU: 4 UID: 0 PID: 168 Comm: kworker/4:1 Not tainted 
6.19.0 #83 PREEMPT(full)
[  117.610817] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.5.1 01/01/2011
[  117.612121] Workqueue: events memory_failure_work_func
[  117.612978] Call Trace:
[  117.613401]  <TASK>
[  117.613766]  dump_stack_lvl+0x60/0x90
[  117.614382]  dump_stack+0x14/0x1a
[  117.614940]  vpanic+0x1a6/0x470
[  117.615476]  panic+0xc0/0xc0
[  117.615967]  ? __pfx_panic+0x10/0x10
[  117.616571]  ? update_cfs_rq_load_avg+0x5f/0x5a0
[  117.617336]  ? dequeue_entities+0x250/0x1e30
[  117.618043]  memory_failure.cold+0x2d/0x2d
[  117.618725]  ? __pfx_memory_failure+0x10/0x10
[  117.619451]  ? __raw_spin_lock_irqsave+0x8d/0xf0
[  117.620215]  ? __switch_to+0x3e9/0xb60
[  117.620841]  memory_failure_work_func+0x150/0x200
[  117.621621]  process_one_work+0x63d/0xf50
[  117.622292]  worker_thread+0x517/0xd90
[  117.622915]  ? __pfx_worker_thread+0x10/0x10
[  117.623629]  kthread+0x369/0x460
[  117.624169]  ? __pfx_kthread+0x10/0x10
[  117.624796]  ret_from_fork+0x33a/0x660
[  117.625422]  ? __pfx_ret_from_fork+0x10/0x10
[  117.626126]  ? switch_fpu+0x19/0x1f0
[  117.626728]  ? __switch_to+0x3e9/0xb60
[  117.627354]  ? __pfx_kthread+0x10/0x10
[  117.627978]  ret_from_fork_asm+0x1a/0x30
[  117.628633]  </TASK>
[  117.629316] Kernel Offset: disabled
[  117.629902] ---[ end Kernel panic - not syncing: Memory failure on 
page 1024d6 ]---

