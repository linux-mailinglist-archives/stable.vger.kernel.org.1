Return-Path: <stable+bounces-267773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEh3Jm5qOWrvsAcAu9opvQ
	(envelope-from <stable+bounces-267773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:01:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2D6B1583
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267773-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267773-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF10301E764
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67D33F8C3;
	Mon, 22 Jun 2026 17:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D633F39C
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:01:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147677; cv=none; b=rXTa7xRzYG7pTojIMjz6Xk4u9yheQ4Gnhs5Iqy3RvSH3FvtTxiM11/R8p+QQ5OkVN1tvB5OBqAfpdLi0PBzrYdREy5l93VaElAIBwRLMWAQG2Ai7oIRvJz1rQcHhDP6CjTZsYr9GpEjIt6vFHofuBN2T0Q09/G/pl9vg0ah7vY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147677; c=relaxed/simple;
	bh=MFTvz8h6gKKk4WaSohfwv1nTuQMWIS3dzLtN4hyEuyY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WxKLCPLKFw05e3LN8onhirIuQXhvKWfiM65Y5j0kl1/tf2PfhNbnIbkWUswtnav24ZQCyze5MbbqLZ+QiSuwffCQxX1PHME8ax7kx8m7Uk9HTcOrzvQW8MS5VWETrzNJhxJGWITwkVf2X+ZTCKjaXik+EmQvwQerKrKq/osx8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e92c443b82so5148994a34.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 10:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147675; x=1782752475;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cH6/V58LvPbwIPyJoxFid5UDIq9SWXBxGFouXXPBLwE=;
        b=F3xEN6sXcOXN0D/BvmKj8VUFt/0PM1O/AMxObMBlCHFVjl07972IrtlwgFFLi++h+P
         JrZPwBgMMZrrlnW5WVwecbEvbVlGDIEzo9o31YymptyUMvQKMkwb9gevQ4QswXCctLp7
         0Ljb4aMS81sMrYyGd0b30/5IQvlWoUCDdJ0Ofyqb2Nmyhni6zzhaGefFJFNOMdh2bF/v
         S9xlcp//4W1P5XFYwNu6vtUJPP+vR/tbtkDitwLi2fkhCUypLWJgot3cAU+U0JDcYR0Q
         G6JMj6Z8jgOLwlON7R8E+5oKYMN6VDKABVeLnyAalc7pCizj9PQOzWSQqHUmKEe60T59
         aTUg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zh4Xhuw3LmCZHSIzECd7+NlBW09KruNNzEFuWV3PbQPLjGJyxJKAWS/G8d650YbzFqiW+q3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6PgRQ21EyjCprx7LL10/VTioP/i4UjO9RkSW9Hrs9JOFuuCc
	uICVEqPFmPEM00UzmcMzQ+zTeUsuNJmhrvUPhDOWMVad9P/nEkN7SN/Pet4TKOlGIGZy2CgQgiM
	FOWhWAfzWWiOZEJyiU2LF2YLl5BIpkVRKckjBk/5rRAODVj5NxUOJ8UuoE40=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:718d:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7e92d37a1efmr12028083a34.0.1782147674625; Mon, 22 Jun 2026
 10:01:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:14 -0700
In-Reply-To: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a396a5a.ac26f6c2.9a9c4.0000.GAE@google.com>
Subject: [syzbot ci] Re: mm: page_ext: add count limit to page_ext_iter_next
 to prevent invalid PFN access
From: syzbot ci <syzbot+ci8a7f89fd8f70a458@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@kernel.org, hannes@cmpxchg.org, 
	jackmanb@google.com, kernel@oss.qualcomm.com, ketan.kishore@oss.qualcomm.com, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ljs@kernel.org, luizcap@redhat.com, mhocko@suse.com, rppt@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, vbabka@kernel.org, 
	willy@infradead.org, ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:hannes@cmpxchg.org,m:jackmanb@google.com,m:kernel@oss.qualcomm.com,m:ketan.kishore@oss.qualcomm.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:luizcap@redhat.com,m:mhocko@suse.com,m:rppt@kernel.org,m:stable@vger.kernel.org,m:surenb@google.com,m:vbabka@kernel.org,m:willy@infradead.org,m:ziy@nvidia.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267773-lists,stable=lfdr.de,ci8a7f89fd8f70a458];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email,googlesource.com:url,appspotmail.com:email,syzbot.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10C2D6B1583

syzbot ci has tested the following series

[v2] mm: page_ext: add count limit to page_ext_iter_next to prevent invalid PFN access
https://lore.kernel.org/all/20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com
* [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next to prevent invalid PFN access

and found the following issue:
WARNING in depot_fetch_stack

Full report is available here:
https://ci.syzbot.org/series/092dd7dc-cb78-46b6-8703-6044fff2631d

***

WARNING in depot_fetch_stack

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      e1201ff76176ef666b13d1a4ec6b6190ddc6abc8
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/18f461a2-7098-44bc-9d42-634b56ba48d9/config

------------[ cut here ]------------
!refcount_read(&stack->count)
WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x91/0xa0, CPU#0: kworker/u9:4/1114
Modules linked in:
CPU: 0 UID: 0 PID: 1114 Comm: kworker/u9:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:depot_fetch_stack+0x91/0xa0
Code: 39 f5 72 d0 48 8d 3d 7e 1b 4d 0b 89 ee 44 89 f2 89 d9 67 48 0f b9 3a 31 c0 5b 41 5e 5d e9 87 67 b8 06 cc 90 0f 0b 90 eb ee 90 <0f> 0b 90 eb e8 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0000:ffffc900079a6ce0 EFLAGS: 00010246
RAX: ffff888168b94000 RBX: 0000000000000ce0 RCX: 0000000000000067
RDX: 0000000000000000 RSI: ffffffff8e215937 RDI: ffffffff8c28ab20
RBP: 0000000000000067 R08: ffff88810495a407 R09: 1ffff1102092b480
R10: dffffc0000000000 R11: ffffed102092b481 R12: 00000000019c0068
R13: 0000000000000001 R14: 000000000000010f R15: ffff88810afb1dc0
FS:  0000000000000000(0000) GS:ffff88818dcb5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e74a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __set_page_owner+0x140/0x4c0
 post_alloc_hook+0x1f9/0x250
 get_page_from_freelist+0x21fa/0x2270
 __alloc_frozen_pages_noprof+0x18d/0x380
 alloc_pages_mpol+0x212/0x380
 alloc_pages_noprof+0xac/0x2a0
 get_free_pages_noprof+0xf/0x80
 __kasan_populate_vmalloc+0x38/0x1c0
 alloc_vmap_area+0xd1a/0x1420
 __get_vm_area_node+0x1f2/0x300
 __vmalloc_node_range_noprof+0x358/0x1730
 __vmalloc_node_noprof+0xc2/0x100
 dup_task_struct+0x28e/0x830
 copy_process+0x79d/0x4380
 kernel_clone+0x2d7/0x940
 user_mode_thread+0x110/0x180
 call_usermodehelper_exec_work+0x5c/0x230
 process_scheduled_works+0xa8e/0x14e0
 worker_thread+0xa47/0xfb0
 kthread+0x389/0x470
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

