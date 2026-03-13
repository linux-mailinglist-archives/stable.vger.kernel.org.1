Return-Path: <stable+bounces-225266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMqzD1zHs2kqawAAu9opvQ
	(envelope-from <stable+bounces-225266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:14:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A527F6A3
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3BA7302CC1B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217537186D;
	Fri, 13 Mar 2026 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNG1yOIM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0F34214F
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389564; cv=none; b=q7IlFijBbDJoMffaWq3NjlNqgd1zlDwDmlQ5mk4xc1P0oF9SZDLyQcpqPSpEv0rekgvFhC2+Vr2mAOIk3/JQnLAyaSFPAm04iEm1de8kAC/P/amJ2mc/46OAN5zf6KTHgC0dh4//mYKXqRi85tU10EJL52cirtNCAKtsIw9rYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389564; c=relaxed/simple;
	bh=hUDPMMTY3NGE2OaVvwLOGIt07v6Q527615uwNQUMsQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PldlXaZ3CH6dLkg0rMzFCeQsqDbaSDREuHO6dEwA8a1ugGH12iuhJfX+KQ7MPPSqySaYleBtiBRqELUJZJV4PIII28mxkry6biHrxaLpbyjjWMKdcxPJfCE2a+0+JIQNsy4h+P6b8xgRKwPc3yC4scU4PjR40Yplm0P51BZJuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNG1yOIM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso1420496a91.1
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773389562; x=1773994362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1Ogm2w5XxIskT8rZmjcX4cRscqWBup4vkkTta6Aq3A=;
        b=ZNG1yOIMeNtV5jFLNPhivBBEn+ntdscOmczNUt0wIn920YDjax5L/nePP2tyZRdE1V
         A2CBGpwyilg3I9+vF9bjMWXHpvtFn1BfZK5LzpGe9gCCYdWbLaHbSBmfQy6H8OWMuXO2
         xXzXnvbTuh+5WSgapUbgVPVUVN6TA0v/MioFL5x0pI3TiamLZOg+7CHP7usNXRUUG8cP
         P7aWGX4bKQDUfJ/jbLZGiPeTGkyzW4ClAme1oL8mmy+iQvc8W/TnTUU2Wp6Jv5G+XLbM
         Fl4q1XkXqVeSAZ+05Q5ytPWHcTgqjmXpiA2+9CRGBzfHnoFDvZZ93L6Sk2OZT6dDGLgL
         oTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773389562; x=1773994362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1Ogm2w5XxIskT8rZmjcX4cRscqWBup4vkkTta6Aq3A=;
        b=Nk1F3Fedc0QYH9qKWQBMUsmhxc5objN/p40GqTJMR35cl0lonWKbsO6crFfYJRpD66
         4x5QsYlOOO1tL/QllB89O93pv01zEjVU1SUUJu1HDoXvWGiLXyC+S9MdRixnP+0kBvBz
         xvCp/OX1X1FYzyNqQAC2W2EYGbaQ2n3NfIrqsIbChkXkRfe5bbJ8x+D/CQj6h6vHSYuG
         VFWVc3PGvHHF5Am3sY3t7VmjhxRpLFEqzb8rWtPYMPR1YCvR82YNuQvE9cWRUiV9R57e
         ktrFjcKcQc6wX/1rPVKFRHfx3dH3A8i1E7jrsXeAZneKa/SuDJVLmZK6xo3/Ex0DyLUy
         rT3Q==
X-Gm-Message-State: AOJu0YzAQjTAYMWAydSbgT8TbgKOIAu/yGNQAzXD2x5dwd2bEScN8YsX
	ZSxeB6HHZPXCPfRygxXkncTHGEKpbQLaPP4Ia8ZZgvQbSRZAg43ZyqRnQn7iPvZT7gf8RDgKaVN
	P3B4YtzJGnCzcbh4ptWu/rV9vTsrDORxctHTMbQsXalzBKIpT1Q5zExEfKEqEAGQ/7U9sTBAp4c
	lIDh22BoeN1C0nvV25qVqDAlVEPDHxqj3eto7xa/EXkgeY0/qNlIUXCnfzYCBAzlw=
X-Received: from pjaw8.prod.google.com ([2002:a17:90a:288:b0:359:84b7:a9a2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5348:b0:359:f55a:1f13 with SMTP id 98e67ed59e1d1-35a220ad76bmr1751338a91.35.1773389562147;
 Fri, 13 Mar 2026 01:12:42 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:12:38 +0000
In-Reply-To: <2026030900-shore-output-ef28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026030900-shore-output-ef28@gregkh>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313081238.2643803-1-ackerleytng@google.com>
Subject: [PATCH 6.12.y] mm: thp: deny THP for files on anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, Deepanshu Kartikey <Kartikey406@gmail.com>, 
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, 
	Lance Yang <lance.yang@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>, Barry Song <baohua@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, 
	Fangrui Song <i@maskray.me>, Liam Howlett <liam.howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225266-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux.dev,kernel.org,google.com,oracle.com,linux.alibaba.com,arm.com,maskray.me,redhat.com,nvidia.com,linux-foundation.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E3A527F6A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit dd085fe9a8ebfc5d10314c60452db38d2b75e609 ]

file_thp_enabled() incorrectly allows THP for files on anonymous inodes
(e.g. guest_memfd and secretmem). These files are created via
alloc_file_pseudo(), which does not call get_write_access() and leaves
inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
true, they appear as read-only regular files when
CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
collapse.

Anonymous inodes can never pass the inode_is_open_for_write() check
since their i_writecount is never incremented through the normal VFS
open path. The right thing to do is to exclude them from THP eligibility
altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
filesystem files (e.g. shared libraries), not for pseudo-filesystem
inodes.

For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
large folios in the page cache via the collapse path, but the
guest_memfd fault handler does not support large folios. This triggers
WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().

For secretmem, collapse_file() tries to copy page contents through the
direct map, but secretmem pages are removed from the direct map. This
can result in a kernel crash:

    BUG: unable to handle page fault for address: ffff88810284d000
    RIP: 0010:memcpy_orig+0x16/0x130
    Call Trace:
     collapse_file
     hpage_collapse_scan_file
     madvise_collapse

Secretmem is not affected by the crash on upstream as the memory failure
recovery handles the failed copy gracefully, but it still triggers
confusing false memory failure reports:

    Memory failure: 0x106d96f: recovery action for clean unevictable
    LRU page: Recovered

Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
anonymous inode files.

IS_ANON_FILE() is not available in 6.12, hence this backported version
checks if the mapping is a secretmem_mapping() instead. This is sufficient
for 6.12 since guest_memfd, which was also excluded from THP with the check
IS_ANON_FILE(), is not available in 6.12.

Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
Link: https://lkml.kernel.org/r/20260214001535.435626-1-kartikey406@gmail.com
Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
Change-Id: I7530421f3ce71607410f8312f118e4c564181c81
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Fangrui Song <i@maskray.me>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/huge_mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f70b048596b53..bd34b70dd0cf9 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -7,6 +7,7 @@
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
+#include <linux/secretmem.h>
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -262,6 +263,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 
 	inode = vma->vm_file->f_inode;
 
+	if (secretmem_mapping(inode->i_mapping))
+		return false;
+
 	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
-- 
2.53.0.851.ga537e3e6e9-goog


