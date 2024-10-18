Return-Path: <stable+bounces-86775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741AA9A37A3
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B68281E03
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340518C35C;
	Fri, 18 Oct 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNd6OZ/y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FE18C33E
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237867; cv=none; b=KTNJhaZFKwS23Qhrr36Pg4/vcVEITnN758kMtHYjGecZ4DnZpbac2WWkZfeR+vWKSWn9XZoaog2DXEJTbezCz0iVdptLvMhdfxfi4d1a1GhEHX4ANdJVnM5vVFwVuYF4c1paNlDoWGyUoELjOXsYgkTvB9UbCfLbIyozFEBv/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237867; c=relaxed/simple;
	bh=H5fL6jF/WR4rBLsofIhGG9JHByUUf+09CuKKqYkaVec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OwPqvwg8WZLNoSVUFhriNK5DwRKqkLx1jGAOmmWk0AxfXyvvtWsX5r7AHkx34dsnyrG6CvCJRTlfrWlgJwzQQq2EKL7I9D74LVBYnk7aObWTiPBsdqA5SbuSEcOwykBfeaGKzWWktmiYBk9WNfxExoCmMyClTia1eztv8aW+zgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNd6OZ/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D8DC4CEC3;
	Fri, 18 Oct 2024 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729237866;
	bh=H5fL6jF/WR4rBLsofIhGG9JHByUUf+09CuKKqYkaVec=;
	h=Subject:To:Cc:From:Date:From;
	b=DNd6OZ/ytfZVtuzmqxz6Iy43mWUdVSZXioouF+7n+6ymgisOi6AK0E/UZHj2SWxRg
	 5E9UdTG7br2Yj0A1hdGjW8p2dKwbsWh7rSgjde+shxg6n5B7C0UNczUyR42HXqqRE4
	 L2UWkucJ3nfEHXK83Zfmp1JI+BdYAHMqaHARccsY=
Subject: FAILED: patch "[PATCH] mm: khugepaged: fix the arguments order in" failed to apply to 6.6-stable tree
To: yang@os.amperecomputing.com,akpm@linux-foundation.org,gautammenghani201@gmail.com,rostedt@goodmis.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:51:04 +0200
Message-ID: <2024101803-cage-smokiness-cb8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 37f0b47c5143c2957909ced44fc09ffb118c99f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101803-cage-smokiness-cb8b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37f0b47c5143c2957909ced44fc09ffb118c99f7 Mon Sep 17 00:00:00 2001
From: Yang Shi <yang@os.amperecomputing.com>
Date: Fri, 11 Oct 2024 18:17:02 -0700
Subject: [PATCH] mm: khugepaged: fix the arguments order in
 khugepaged_collapse_file trace point

The "addr" and "is_shmem" arguments have different order in TP_PROTO and
TP_ARGS.  This resulted in the incorrect trace result:

text-hugepage-644429 [276] 392092.878683: mm_khugepaged_collapse_file:
mm=0xffff20025d52c440, hpage_pfn=0x200678c00, index=512, addr=1, is_shmem=0,
filename=text-hugepage, nr=512, result=failed

The value of "addr" is wrong because it was treated as bool value, the
type of is_shmem.

Fix the order in TP_PROTO to keep "addr" is before "is_shmem" since the
original patch review suggested this order to achieve best packing.

And use "lx" for "addr" instead of "ld" in TP_printk because address is
typically shown in hex.

After the fix, the trace result looks correct:

text-hugepage-7291  [004]   128.627251: mm_khugepaged_collapse_file:
mm=0xffff0001328f9500, hpage_pfn=0x20016ea00, index=512, addr=0x400000,
is_shmem=0, filename=text-hugepage, nr=512, result=failed

Link: https://lkml.kernel.org/r/20241012011702.1084846-1-yang@os.amperecomputing.com
Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Cc: Gautam Menghani <gautammenghani201@gmail.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: <stable@vger.kernel.org>    [6.2+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index b5f5369b6300..9d5c00b0285c 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -208,7 +208,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 TRACE_EVENT(mm_khugepaged_collapse_file,
 	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
-			bool is_shmem, unsigned long addr, struct file *file,
+			unsigned long addr, bool is_shmem, struct file *file,
 			int nr, int result),
 	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
 	TP_STRUCT__entry(
@@ -233,7 +233,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 		__entry->result = result;
 	),
 
-	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, addr=%ld, is_shmem=%d, filename=%s, nr=%d, result=%s",
+	TP_printk("mm=%p, hpage_pfn=0x%lx, index=%ld, addr=%lx, is_shmem=%d, filename=%s, nr=%d, result=%s",
 		__entry->mm,
 		__entry->hpfn,
 		__entry->index,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff..a420eff92011 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2227,7 +2227,7 @@ rollback:
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, is_shmem, addr, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 


