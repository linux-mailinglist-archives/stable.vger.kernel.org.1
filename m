Return-Path: <stable+bounces-216252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C3UKM9Gj2kiPAEAu9opvQ
	(envelope-from <stable+bounces-216252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ABC137A76
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3643302E934
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFD35CB87;
	Fri, 13 Feb 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkBXexLD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755B2F362B
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997429; cv=none; b=bZNhsvapaYtOM//BGdxg3Rhp33hEmdmyCRlRX4AETPzFJYLXHR3E9YGDocXO9EeIarl4BWQwI+gnHNg0M5ULgd1+fy/J+fsbfGUIgbGPZCqc/sOpZG5U8y4hYXALMs4xLHd8Fqb7+IG+V3EiQ1IMrm+oFJ19TcyNSr0RXjOC8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997429; c=relaxed/simple;
	bh=+dusP7b7Y+fR/eQZCzTfPMiG+QuUHfUOipSCPalrPDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhP2XPJT9gv+euIxlRJW1KZRB9nQCv4dxDqzJlpb4dFPDhQH0DVw1+Dau1TeTuVt7E+dt+HE2wZdUmwF8hk441QlQGONwOYRA1GbjVg9zVkx/n9khe5eFUBMaZpMkTpdvSGt1zxEm/gCvwLlCAaMs3JwsWKV7d5LKb9+YA1KVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkBXexLD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-823075fed75so628927b3a.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770997427; x=1771602227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmLUL6Mdt8fjL0IuFsbCh5POYvLXg7Y0PhqJLQXRfPY=;
        b=UkBXexLD9i26HNorv7qOX7wcwzoMbYvY2X8U/v5/iCflbTrAFNcf7Jcz+z6wRGfVWy
         /b2uoWPUnobSfYY7iJ9ncpaINibIBzNaKrgJIGUTHIQ2VW3Y60hAnVjq2cxSLx5HoIT3
         flx/y5Ypqe17rNqrgKqk+uMaPUz0+BEgsmZsc5y7P79/VY5oQdAb85cZW5Sr0J9zIpt7
         vbz9qj+pj9eTBdLJzE6RlnYCfmkDV8y5PLFagcwlegPZraNc5j9aEA7kag4LwM1YNLsk
         bKyOs+ya4Kwu+IwY7rT2B+y7Smb/uIHH7qvdNPEBq0Ja+iuTp5oFj6abLj6ysv5YSaLv
         /kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770997427; x=1771602227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmLUL6Mdt8fjL0IuFsbCh5POYvLXg7Y0PhqJLQXRfPY=;
        b=f8+eT00yjOpsnTxThVINdAGXEROrxmgzlMTA7jgpxd5LbdJRyNxlU6woelNH+H8rDv
         mgGK8g/jDz2NH2zXdjLJTcR60GNGBpOsg8v/46b2r6Fitb5abBdXPXu5NoTlGBrww7jR
         sUv9RgnCZQGDpxYxQX2NS7P3spvAF28by6yvTHl2fGAgFUG2B8ZSDee1jmxhFG7F9DHc
         1Ji0hwo1LEZ/KVdbxRS14MvHkJyBV13WO4IyKMKI7z6+TdvzcG0+zoAyDQ4qBuwrefeF
         +GsDFW1j1zvu/vCfZy3ADE93taLAN5NJ4JnEwLxvwP+depSPpkidP1bL3qcQPgJgT1ue
         GHIw==
X-Forwarded-Encrypted: i=1; AJvYcCX1FFi73HdVysYlS82OcbTYbQMiT+MYp72Gm/+G9NjAImcChBbTvym/NolEsKAwea//vY57P1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAypCKZNKNCsLCX4X7XuDGJAsSuk8/6G8oGRVbODdOpYkT1zm
	HgY/EcdUAg7hbQOYiWFj4nvBxh8YQS3CbBrJn6yPM7eCWtu79Mn5LAS9
X-Gm-Gg: AZuq6aKw5GD1YJ/INCrLhmxbrbn3EPfOB0m4+khEhka24Hj3KCacfR0JJrDetyQNQ7K
	xlFWnyb8UM7Ze1Nmn0J7zwNfrXfcTvRQht+ccTOcQvOMNtplXwctgqx+3jOdHo9i7nWvQVuL9qb
	kICq7i4ZF8lhYlxN0t+kBEoZ7CFXBLdzNaqXteuJt69Bd3SHxQ791STrjk5a1aYiehz1EgrOGQT
	KYDYo/FzIFQ0aPdsmz13gwQUwuKQaWfhb8z5qEKIjPcYayL7f2veLfAN5AtdrKu99681Uwr+dM/
	wih6rr1VY8zRMaDrkzxfZTFzs3VimPkcu3ky93UpLIXILPcU6t89cu1Nah3vOrpQUFiuoRQq/vh
	uNIRPIGEH6SlDNMT2PTDhdo52NM7l8ma/XmJ0xLdkxlE0+eZVj/4uIUqjtQDyw0fziSyw80yOpz
	3RMFiclYhL8NGe8Tv7eUKmvpZwdmIJgs568bfQa/G1jAjGcgx8L/yW/c2mC/5IZPBx/cNhRReca
	meNVRo=
X-Received: by 2002:a05:6a00:4fc1:b0:81f:440b:4f61 with SMTP id d2e1a72fcca58-824d5ee63d3mr443651b3a.35.1770997426769;
        Fri, 13 Feb 2026 07:43:46 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:775e:88a1:54b0:dcdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69f2asm2888129b3a.37.2026.02.13.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:43:46 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] mm: thp: deny THP for files on anonymous inodes
Date: Fri, 13 Feb 2026 21:13:36 +0530
Message-ID: <20260213154336.434008-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216252-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 08ABC137A76
X-Rspamd-Action: no action

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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

Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
v2:
  - Use IS_ANON_FILE(inode) to deny THP for all anonymous inode files
    instead of checking for specific subsystems (David Hildenbrand)
  - Updated Fixes tag to 7fbb5e188248 which removed the VM_EXEC
    requirement that accidentally protected secretmem
  - Expanded commit message with implications for both guest_memfd
    and secretmem
---
 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..d3beddd8cc30 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -94,6 +94,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 
 	inode = file_inode(vma->vm_file);
 
+	if (IS_ANON_FILE(inode))
+		return false;
+
 	return !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-- 
2.43.0


