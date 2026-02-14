Return-Path: <stable+bounces-216475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id acu2LkBckGljYwEAu9opvQ
	(envelope-from <stable+bounces-216475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 12:28:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274013BBE4
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 12:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1373F30071C9
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92211274641;
	Sat, 14 Feb 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tk9n+s8Y"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CD1A5B84;
	Sat, 14 Feb 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771068475; cv=none; b=AXYykXYSV8v4OQqGDyDg5v5Dw3w6MQXkEvzGcAJSHVz4Cm7JNTNF1T+Jjcb+Ih/ylXU0QW83h8sBESxCSuZ9t+604R9dCpkWwFrXyFIbe+V0Oq/kjC2KGpVg7PrJqBfkxI1P2DGOqVwdUxYJjH5TpjQKxR69qAA446Mo7tZQFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771068475; c=relaxed/simple;
	bh=WMKkP1gXuvQ6yuG26KiG7r1QVW79MHrjnC00JJMO1jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZEsrMBTJqERtD+v5o3NjOzN9sDNn5S/qUg0i9uptbNqT7zbgq+dawaX5BHzdbEyOaSY8IiW9oocgbpi9Ct7Bgxyk1PqlO+zUkbEErTHoIkcDGOUKcYhuG1NM76v/Ak1uDznCZt6xDu5c7wUCT+zN5TIZ5++LVJ6N6g6Vf9a+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tk9n+s8Y; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b398d163-7b58-402b-a37d-9562d658a62d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771068470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpYezoVv7JEZ5/A/iares9/UqeOLdNYr44Ew2wojbn4=;
	b=Tk9n+s8YHiNSW3Ydfv5tEgx2GFe+9h/u1Mml7AZX78lUW2mQMjwgfWAy9do87rOWaqTeQB
	kGOSkvGGCCTTUw/dG0vNn1z/N4LSngM5+mytnSnCW364ddlLTuGyj+Ax3siRt3uDYmtCAf
	oByqFUDCSSnXhCuOlZhuu0qScHK/x/g=
Date: Sat, 14 Feb 2026 19:27:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
Content-Language: en-US
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 ackerleytng@google.com, linux-mm@kvack.org, npache@redhat.com,
 linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com,
 syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, ryan.roberts@arm.com,
 stable@vger.kernel.org, ziy@nvidia.com, dev.jain@arm.com, i@maskray.me,
 baohua@kernel.org, shy828301@gmail.com, akpm@linux-foundation.org,
 david@kernel.org
References: <20260214001535.435626-1-kartikey406@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260214001535.435626-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216475-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,oracle.com,google.com,kvack.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,arm.com,nvidia.com,maskray.me,kernel.org,gmail.com,linux-foundation.org];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.dev:mid,linux.dev:dkim,linux.dev:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 4274013BBE4
X-Rspamd-Action: no action



On 2026/2/14 08:15, Deepanshu Kartikey wrote:
> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
> (e.g. guest_memfd and secretmem). These files are created via
> alloc_file_pseudo(), which does not call get_write_access() and leaves
> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
> true, they appear as read-only regular files when
> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
> collapse.
> 
> Anonymous inodes can never pass the inode_is_open_for_write() check
> since their i_writecount is never incremented through the normal VFS
> open path. The right thing to do is to exclude them from THP eligibility
> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
> filesystem files (e.g. shared libraries), not for pseudo-filesystem
> inodes.
> 
> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
> large folios in the page cache via the collapse path, but the
> guest_memfd fault handler does not support large folios. This triggers
> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
> 
> For secretmem, collapse_file() tries to copy page contents through the
> direct map, but secretmem pages are removed from the direct map. This
> can result in a kernel crash:

Good catch, thanks!

For secretmem, file_thp_enabled() can incorrectly return true
(i_writecount=0, S_ISREG=1), so the mapping becomes eligible for file
THP collapse ...

However, if any folio is dirty, collapse bails out early with
SCAN_PAGE_DIRTY_OR_WRITEBACK, as secretmem doesn't support normal
writeback, IIUC.

> 
>      BUG: unable to handle page fault for address: ffff88810284d000
>      RIP: 0010:memcpy_orig+0x16/0x130
>      Call Trace:
>       collapse_file
>       hpage_collapse_scan_file
>       madvise_collapse
> 
> Secretmem is not affected by the crash on upstream as the memory failure
> recovery handles the failed copy gracefully, but it still triggers
> confusing false memory failure reports:
> 
>      Memory failure: 0x106d96f: recovery action for clean unevictable
>      LRU page: Recovered

Right. On my setup, that would hit SCAN_COPY_MC in 
hpage_collapse_scan_file()
rather than a hard crash.

> 
> Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
> anonymous inode files.
> 
> Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
> Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---

Confirmed that file_thp_enabled() is working as expected now with this fix.

Tested-by: Lance Yang <lance.yang@linux.dev>


Cheers,
Lance

