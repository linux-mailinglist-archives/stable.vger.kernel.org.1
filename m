Return-Path: <stable+bounces-151389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92302ACDE2D
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C98316FCA4
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EB28E61C;
	Wed,  4 Jun 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="PO0RKBtr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2C13AD1C
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040739; cv=none; b=qaP2Yzru+DqyUcs+75LMyLeXmhMYQh/WAPDUYVMDE3aK46yV1U+YymvH9P3EvkSatPzY95QziBR0VGwxQUvqlqtMr1G8tjQ8s0Wl800hbZPaBdoUyIfA58oHQdLrVL5cuGzwe99k2Z69vOEE9MI75GDefIYI8KkTDdxT/LakLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040739; c=relaxed/simple;
	bh=nzSRRfsXHZNw+iyvhUviFdppppQkSgDQTWo/kF+q91Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2Ns0/RiUST2R+roYcFZhwodXcIv7EedlGbFUIvMwXEXYK5pqwvaNfen9WGLQfmcjuQDGiJDX9kTXx91rQpRDh798kVrzSLbAroi5DHaSB1/+rW8gswJPtkUdhTqLuPVKuNbIAw+UJ7p2OUO95vSjvAhPYLK8Q8B7lalsi0mKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=PO0RKBtr; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1749040737; x=1780576737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QB2tbGuwmI6AHcPbvKEwX83qrUu7uj2dcJ4E09VP1iE=;
  b=PO0RKBtrZrsEySdJOVZ9vsNh0CrE3fxBrv69BFRmWQy6AEG5xoo/Roge
   E13YQyn2adbpHv6Ma6ZsmZMH/EotyV/FebQ0R/pug1f1DSiGDXRAqryYg
   VSciDZ37APv5yUh+9YuGqe6hA6+oE6EO8LgIn6zzV19zwnLSErJNkELPE
   R2R4Q3hy51GYe6lKXvJdJh7UUYQ/Htb4lsVb2L8g5teQZJmByFA5QbPah
   OvtKf5AZ8bv5nt/n4CTSVM7sskiLOE23zyxYQ7E0m8isHaJ0FiRTLrqcs
   6TGAtkPTlFWrf/25mrlrm7zIhnVKlEcmeObLlSYCDXJcrrK6M0EHaDNe0
   w==;
X-IronPort-AV: E=Sophos;i="6.16,209,1744070400"; 
   d="scan'208";a="505907041"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 12:38:50 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:52925]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.118:2525] with esmtp (Farcaster)
 id 431190b7-a98a-4e45-9f87-8492c13c1c06; Wed, 4 Jun 2025 12:38:49 +0000 (UTC)
X-Farcaster-Flow-ID: 431190b7-a98a-4e45-9f87-8492c13c1c06
Received: from EX19D019EUB003.ant.amazon.com (10.252.51.50) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 4 Jun 2025 12:38:46 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D019EUB003.ant.amazon.com (10.252.51.50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 4 Jun 2025
 12:38:43 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <stable@vger.kernel.org>
CC: <acsjakub@amazon.de>, Peter Xu <peterx@redhat.com>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Stoakes <lstoakes@gmail.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jakub Acs <acsjakub@amazon.com>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.1] Mm/uffd: fix vma operation where start addr cuts part of vma
Date: Wed, 4 Jun 2025 12:38:30 +0000
Message-ID: <20250604123830.61771-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D019EUB003.ant.amazon.com (10.252.51.50)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit 270aa010620697fb27b8f892cc4e194bc2b7d134 upstream.

Patch series "mm/uffd: Fix vma merge/split", v2.

This series contains two patches that fix vma merge/split for userfaultfd
on two separate issues.

Patch 1 fixes a regression since 6.1+ due to something we overlooked when
converting to maple tree apis.  The plan is we use patch 1 to replace the
commit "2f628010799e (mm: userfaultfd: avoid passing an invalid range to
vma_merge())" in mm-hostfixes-unstable tree if possible, so as to bring
uffd vma operations back aligned with the rest code again.

Patch 2 fixes a long standing issue that vma can be left unmerged even if
we can for either uffd register or unregister.

Many thanks to Lorenzo on either noticing this issue from the assert
movement patch, looking at this problem, and also provided a reproducer on
the unmerged vma issue [1].

[1] https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e

This patch (of 2):

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge() by Lorenzo Stoakes:

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

It's possible that "start" is contained within vma but not clamped to its
start.  We need to convert this into either "cannot merge" case or "can
merge" case 4 which permits subdivision of prev by assigning vma to prev.
As we loop, each subsequent VMA will be clamped to the start.

This patch will eliminate the report and make sure vma_merge() calls will
become legal again.

One thing to mention is that the "Fixes: 29417d292bd0" below is there only
to help explain where the warning can start to trigger, the real commit to
fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
issue, but unfortunately we may want to keep it in Fixes too just to ease
kernel backporters for easier tracking.

Link: https://lkml.kernel.org/r/20230517190916.3429499-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20230517190916.3429499-2-peterx@redhat.com
Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jakub Acs <acsjakub@amazon.com>
[acsjakub: contextual change - keep call to mas_next()]
Cc: linux-mm@kvack.org

---
This backport fixes a security issue - dangling pointer to a VMA in maple 
tree. Omitting details in this message to be brief, but happy to provide
if requested.

Since the envelope mentions series fixes 2 separate issues I hope the patch
is acceptable on its own?


 fs/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 82101a2cf933..fcf96f52b2e9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1426,6 +1426,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (prev != vma)
 		mas_next(&mas, ULONG_MAX);
 
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	do {
 		cond_resched();
@@ -1603,6 +1606,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (prev != vma)
 		mas_next(&mas, ULONG_MAX);
 
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	do {
 		cond_resched();
-- 
2.47.1



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


