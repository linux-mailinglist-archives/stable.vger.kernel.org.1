Return-Path: <stable+bounces-180217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3347B7EEEC
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5CD521FEF
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071FB2FBDE4;
	Wed, 17 Sep 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inb6JNMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF31E1E00;
	Wed, 17 Sep 2025 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113754; cv=none; b=dezcyWp29gY/LxbHXHHsVRp03/xrKefK1oSFJXNnDKK0VzB+mkmWdCAwE+azNH90uIpVRzyh1+03Bb7Aq00a1GmmRbfVwRKH+iE1ezRlObk/BBTCCuvKDaXY+A/L5kfBxoOyikFWOyy28/ix0hhLJtP4EHDsaKSG1a0M2/efGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113754; c=relaxed/simple;
	bh=XbpdPUmU/Yj4bwGNfdt/v1/Cu5Pc4Xa5hes7ZTO0M5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJfbKPbt+qvdtfiEg5xqU110zGeM/5o7HPSSrE4bwkySIq8p53REeZoQKxgJ5l9oDdw5xIodTdQiFQuThlx30AsTLuVDZM23ip8QpojkugP6vab+Hy76DHMXTMq8pD+mn1ySWrMPnniIK4yAiN56/QX2ilEWpg+9vohGYrDLB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inb6JNMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E38C4CEF0;
	Wed, 17 Sep 2025 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113754;
	bh=XbpdPUmU/Yj4bwGNfdt/v1/Cu5Pc4Xa5hes7ZTO0M5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inb6JNMtIyR/57OVYyZ0+0fNfGZBf9VI3yX3LoQrueANWp43+EWdtRJJtQT61+7fF
	 F4ijL9VQPzhh1pR4ATQnT4siont6hhfVi90HU6+tElM9wvS3JILOPt1KujD1hxzn8U
	 Dz87OJajyyESiTq3XfrJ3fua4aIUBM9HtLfJ+BZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 042/101] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
Date: Wed, 17 Sep 2025 14:34:25 +0200
Message-ID: <20250917123337.863283132@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
References: <20250917123336.863698492@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaohe Lin <linmiaohe@huawei.com>

commit d613f53c83ec47089c4e25859d5e8e0359f6f8da upstream.

When I did memory failure tests, below panic occurs:

page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
kernel BUG at include/linux/page-flags.h:616!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
RIP: 0010:unpoison_memory+0x2f3/0x590
RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 unpoison_memory+0x2f3/0x590
 simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
 debugfs_attr_write+0x42/0x60
 full_proxy_write+0x5b/0x80
 vfs_write+0xd5/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xb9/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08f0314887
RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
 </TASK>
Modules linked in: hwpoison_inject
---[ end trace 0000000000000000 ]---
RIP: 0010:unpoison_memory+0x2f3/0x590
RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception ]---

The root cause is that unpoison_memory() tries to check the PG_HWPoison
flags of an uninitialized page.  So VM_BUG_ON_PAGE(PagePoisoned(page)) is
triggered.  This can be reproduced by below steps:

1.Offline memory block:

 echo offline > /sys/devices/system/memory/memory12/state

2.Get offlined memory pfn:

 page-types -b n -rlN

3.Write pfn to unpoison-pfn

 echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn

This scenario can be identified by pfn_to_online_page() returning NULL.
And ZONE_DEVICE pages are never expected, so we can simply fail if
pfn_to_online_page() == NULL to fix the bug.

Link: https://lkml.kernel.org/r/20250828024618.1744895-1-linmiaohe@huawei.com
Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2535,10 +2535,9 @@ int unpoison_memory(unsigned long pfn)
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-
-	p = pfn_to_page(pfn);
+	p = pfn_to_online_page(pfn);
+	if (!p)
+		return -EIO;
 	folio = page_folio(p);
 
 	mutex_lock(&mf_mutex);



