Return-Path: <stable+bounces-179574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692ACB56957
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 15:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EF83A998E
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123B2BAF7;
	Sun, 14 Sep 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iICHg0bN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016271FB3
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856646; cv=none; b=MyOjURp+Q78RvWOKgysNVT5GsAPV19sNm8yZ+r/+ttgojyJkuTcoH6YDS3UaecZIhoLqwVosBhg9itZeDYkdDV6KkqHKAfZdZC3A6Ev/Re8bBW5yN5ohaONOPn7N+y7eHZNjErdpEqHXY3zjyjlo7kGuV/Cm0UAnjQXQDMtnVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856646; c=relaxed/simple;
	bh=hVotKVK/y+yxfDlJ51jP3oyrh25J9hywh1UFCUi/0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1tSNjJszy3mge9TxMMdReUWnojJf1ROMRdbJadXv4LrbHfkQ4l+DPM1aJjA+vn2pIiFLl4AHnW7eKjRK+NGsH9iAQT/erHdOBpJIEIDGNRu46ayxCbn8QGMi7882t/it8yCqKD/NPrRAK2QNkiLuyWNApVVAhCiPq+2YVuD+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iICHg0bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7419C4CEF0;
	Sun, 14 Sep 2025 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757856645;
	bh=hVotKVK/y+yxfDlJ51jP3oyrh25J9hywh1UFCUi/0uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iICHg0bNBKjvcZi10khJQt1ezQvnbF8VJ2WQIpHgAzmJAKReHCpiHEWE10aYoAWFE
	 eROJENN5Fuwz5egcZ9zfUvi+Gl5SybznbZDT/yamhZ6eIKdGc+I6F7zY9ZmMJ5F73K
	 L26u2O7V1G58nOJQz88AQhKeDMWa3UFnYYtMZdxLiMjqRVBT7reMzdiInzMAGP5OmM
	 wqYkyoeYQ1Fq2gM8LeE299ZTxxPtxGu7/cflH7uc1d5XTQASMPc8XL2neGtMWnxyDy
	 PGBmkNLvV+1nz71IZynI4tTIOfQR+eiUV5knFtcrVbRVq1sxFrF0HboPjWlyDTD6hP
	 qiiyLe6ZY58Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
Date: Sun, 14 Sep 2025 09:30:42 -0400
Message-ID: <20250914133042.87228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091332-fool-outflank-732f@gregkh>
References: <2025091332-fool-outflank-732f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit d613f53c83ec47089c4e25859d5e8e0359f6f8da ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0e7566c25939f..e57ada07030d9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1543,10 +1543,9 @@ int unpoison_memory(unsigned long pfn)
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-
-	p = pfn_to_page(pfn);
+	p = pfn_to_online_page(pfn);
+	if (!p)
+		return -EIO;
 	page = compound_head(p);
 
 	if (!PageHWPoison(p)) {
-- 
2.51.0


