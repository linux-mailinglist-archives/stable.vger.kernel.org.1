Return-Path: <stable+bounces-216312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEy5Ob++j2ktTQEAu9opvQ
	(envelope-from <stable+bounces-216312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:15:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEC13A213
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B58FA3045A87
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7A1C5D57;
	Sat, 14 Feb 2026 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC5OKy8Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D5944F
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771028149; cv=none; b=tWbxPSlttAcBYglyY01vwSQVT0sTdtM8B9MNUNr8HTq5GJ9ahEUpn4TiyEHxTHmiW6JZ+Vumsi4ojtoUb20Q5+djrEvUDLbdBa1IA+jeYWQhEbut+cK5IeKVToKMGx6sEHpoH+eD+ygbzPT7UOuNm5u/G3XhN70j6+NkhyrWLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771028149; c=relaxed/simple;
	bh=1Y2gDnp3k+QmNTMZEb9ab0smo7tRUetnDbZaljZPbCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrSu2uNaqWrczpb/bCsozwNDrUbnuU5i3VHGk4/R5w2b+eUj1lYjOqfsX0HdskNykJAX2s/RR7udY94E88w72TSeK9dsN5ZDlPuCEbNttRIeVvb/zCtNaxrYVitpvlujaqtRx4jst/LtyXGOEvSXZMhNU7aGs8BsjoWK4XmX8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC5OKy8Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso825957b3a.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771028147; x=1771632947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJSrOsjXaV/MjMNYMY7kpWcAneJSnkLcnWKVI0es/80=;
        b=ZC5OKy8Qo3etyte0LktEA8nVYZ3TInj/LoY9YwldgrW7b2NB7kvmWFGxhl0WKmpnpz
         ALnxVYNxX+isa8SGnk/tp36i7cEoAxXXbcFlD7JNVw6Wr5DgcqHIbJnf9BJ38EekSdzR
         0cB+lEacc68ZsUkM8mGUp+u+H4pCRT45mgHHlRAjihEJLZh/pE3iwfqrQgNtikKLroi9
         8s+J0lSSxGv4oOf9e0u9V8Z3BmipWHrX/Adnnf0DYlIeJu0qqnnXPMc1ltXRJwc32wK0
         jPEDEGnxR7QeBe1D7EGN4B+zpox7gH0LXiN378vhz5TGVDw0ZbwRknY3OvPLvrv6KJDR
         VIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771028147; x=1771632947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJSrOsjXaV/MjMNYMY7kpWcAneJSnkLcnWKVI0es/80=;
        b=EtG2/+4EAdgBczjzkKpX9spVNfUkTF5rpCgDfWesc3tnIzbIKcpJkYmJ6Zdk+5cvYA
         5bV9I1uYO0o4/afQ3bQkNlv60PCnkLbVqKU+KWZmYgpoqB1wOIKN/XGxXS9h2TSeNgJP
         d5r0dM18eD3faSCeQit1IsMc6LaWVyOiZPpzmLq3xxez6IxsxNIVos3BkVy7X55SkRJd
         ENsyXWKhtwgofb9nwR6dJhcqrFrVbSg1fiS0HGREPppfYWgFxlqRAoFAuzvJVmmPwj+c
         3G3KavQJo93PMSUMD0cMYnYdv8zFIu77WtOu/h55bga4UxSKS395i4j6SaGn/VHFEYTv
         UKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZRU1XEM0uYNFXpi91x/sSWbPZeYrm/Pb2mtQAbkYquhY32x4ymRH7EUd9gwYJBTKnEMz+dXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAm6GJG/mpSGpwXXYbIsmHmz4SI0JwNESIFT7E5NAowa04ivP
	+DVYPMhRK2nvRG5Bc75KzrOR/O0wgare6DwW3zvvzaqOByRW5T4SLet/
X-Gm-Gg: AZuq6aJr5GJxsHL3AZlrscVNPAXNqauY5VTItOR2jt8skNIBWUd+HuBpzlT7slrA3du
	4I0D+STba3mzdMWqLPzvHNrrSNTO9Vq7XUaYR7hzLfSGUOriMYuZSWVkG44SuWQqusZEAvIIlga
	Yb2wJ0m7k+aVGT2M50uRRRtg8UgttSvj7JiWCpUmtX9FP8McXGr23UBl6YqxyAO3fpKpDtuEUOs
	kzDOomIF7ebvUANCi3asf1kRIVeJUSeH5RR8j3OrG1jKlMP6KKJva5PFyQ/Xu07PcK0uPIwv/6s
	YAiO5MbOR+qzgEvC+TmGsi/enrtPjvJeeZhEdjbXxmNywErx1amL0tuEQ4+tKQcY7zIe2Q5FAPy
	Qo8A62M8YRuuliUQCVcDZVVyvA71y9Sp4XDjm6TX0+WYxEcYn1D5ot2c6KTsRkZxvaxJAvkB1Xy
	XI2vx5YUOI2gSm4/oyrvTMBXJ/RXgcNTwM2291TSAXaTho9L2A5wZd2vRdR4XyzSGvUN9dbb2VM
	0wb8mQExsyFJOxE
X-Received: by 2002:a05:6300:408d:b0:38d:ec2d:80e5 with SMTP id adf61e73a8af0-3946c9220ddmr3409951637.45.1771028146749;
        Fri, 13 Feb 2026 16:15:46 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:1ca3:229:a9f4:8c87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fcfc08sm217762a12.1.2026.02.13.16.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 16:15:45 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	i@maskray.me,
	shy828301@gmail.com,
	ackerleytng@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
Date: Sat, 14 Feb 2026 05:45:35 +0530
Message-ID: <20260214001535.435626-1-kartikey406@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216312-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,maskray.me,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 48AEC13A213
X-Rspamd-Action: no action

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
Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
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


