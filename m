Return-Path: <stable+bounces-162188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82384B05C8A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC60F7B9A70
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376882E49B6;
	Tue, 15 Jul 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPWCLtHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38C2E49A2;
	Tue, 15 Jul 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585907; cv=none; b=oW+AEl4hkCJcb3kCzeJq5p4MABCEHXqddy/eQKW3D2GCEgFjdpQbyp3sZQLKCg2Pbrax3gAaALij74h7C7N5W1/2ftmrGnh+KUobTQS/qeicEmkFSUwUxP6tC9Uc1KlQq3I3idkbpDGGNF4w7ZhHVVusEt03McRIYVeM/uMmqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585907; c=relaxed/simple;
	bh=FGhNuLzjQFeW5xyCETe0ZASrHz0inICJ+MZ933ryonE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOD2ip+c+tbEcivL923dPhOqtDphXRgnQDBcu9gaRhKELjsaMIzK4Riz0wAYQ73Fx1RK8SADoErQtAuz9spWYUrUYM9Rexc1E/962yYm7a8dsxsyQY1jf0yqOqjRu8gVssRi385hRtuH2Q93Xt/AczockL0ssy6uG8bip/HuFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPWCLtHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590BDC4CEE3;
	Tue, 15 Jul 2025 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585906;
	bh=FGhNuLzjQFeW5xyCETe0ZASrHz0inICJ+MZ933ryonE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPWCLtHRCHY/WTUD+DShvvAabEYQKa64nhG4NzNHRBfKRDHOhDiWNqabURf4kjDUw
	 QOasSiSRm6VaLqx+Zi7dupbCyx6epN135o1jl/MPFq3domJ3bwNcyP3o3TB8t1WkPr
	 1qPwY8IBoLJDfuerGPiZeLgDIr5IrYssFiwiEsQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 053/109] mm: fix the inaccurate memory statistics issue for users
Date: Tue, 15 Jul 2025 15:13:09 +0200
Message-ID: <20250715130800.996828254@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
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

From: Baolin Wang <baolin.wang@linux.alibaba.com>

commit 82241a83cd15aaaf28200a40ad1a8b480012edaf upstream.

On some large machines with a high number of CPUs running a 64K pagesize
kernel, we found that the 'RES' field is always 0 displayed by the top
command for some processes, which will cause a lot of confusion for users.

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
      1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd

The main reason is that the batch size of the percpu counter is quite
large on these machines, caching a significant percpu value, since
converting mm's rss stats into percpu_counter by commit f1a7941243c1 ("mm:
convert mm's rss stats into percpu_counter").  Intuitively, the batch
number should be optimized, but on some paths, performance may take
precedence over statistical accuracy.  Therefore, introducing a new
interface to add the percpu statistical count and display it to users,
which can remove the confusion.  In addition, this change is not expected
to be on a performance-critical path, so the modification should be
acceptable.

In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
dec/inc_mm_counter(), which are all wrappers around
percpu_counter_add_batch().  In percpu_counter_add_batch(), there is
percpu batch caching to avoid 'fbc->lock' contention.  This patch changes
task_mem() and task_statm() to get the accurate mm counters under the
'fbc->lock', but this should not exacerbate kernel 'mm->rss_stat' lock
contention due to the percpu batch caching of the mm counters.  The
following test also confirm the theoretical analysis.

I run the stress-ng that stresses anon page faults in 32 threads on my 32
cores machine, while simultaneously running a script that starts 32
threads to busy-loop pread each stress-ng thread's /proc/pid/status
interface.  From the following data, I did not observe any obvious impact
of this patch on the stress-ng tests.

w/o patch:
stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec

w/patch:
stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec

On comparing a very simple app which just allocates & touches some
memory against v6.1 (which doesn't have f1a7941243c1) and latest Linus
tree (4c06e63b9203) I can see that on latest Linus tree the values for
VmRSS, RssAnon and RssFile from /proc/self/status are all zeroes while
they do report values on v6.1 and a Linus tree with this patch.

Link: https://lkml.kernel.org/r/f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com
Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by Donet Tom <donettom@linux.ibm.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: SeongJae Park <sj@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/task_mmu.c |   14 +++++++-------
 include/linux/mm.h |    5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -33,9 +33,9 @@ void task_mem(struct seq_file *m, struct
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
-	anon = get_mm_counter(mm, MM_ANONPAGES);
-	file = get_mm_counter(mm, MM_FILEPAGES);
-	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
+	anon = get_mm_counter_sum(mm, MM_ANONPAGES);
+	file = get_mm_counter_sum(mm, MM_FILEPAGES);
+	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -56,7 +56,7 @@ void task_mem(struct seq_file *m, struct
 	text = min(text, mm->exec_vm << PAGE_SHIFT);
 	lib = (mm->exec_vm << PAGE_SHIFT) - text;
 
-	swap = get_mm_counter(mm, MM_SWAPENTS);
+	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
 	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
@@ -89,12 +89,12 @@ unsigned long task_statm(struct mm_struc
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
-	*shared = get_mm_counter(mm, MM_FILEPAGES) +
-			get_mm_counter(mm, MM_SHMEMPAGES);
+	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
+			get_mm_counter_sum(mm, MM_SHMEMPAGES);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->data_vm + mm->stack_vm;
-	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
+	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
 	return mm->total_vm;
 }
 
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2551,6 +2551,11 @@ static inline unsigned long get_mm_count
 	return percpu_counter_read_positive(&mm->rss_stat[member]);
 }
 
+static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
+{
+	return percpu_counter_sum_positive(&mm->rss_stat[member]);
+}
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)



