Return-Path: <stable+bounces-74294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE3972E86
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9E32879C5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE418C02F;
	Tue, 10 Sep 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CpHVc/jF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8F188CC1;
	Tue, 10 Sep 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961385; cv=none; b=XLQI/xHeVv8J5uLd1LBMoYbhVnUzUirxSg0IJvgcBffA3NpCHuZS8vlpR3bZrDoZ3fxLCfnbEsxIUAOUQd15Sa89BJvkaZHUTWiJJtsNNbAJ3sjaTvKOWDczchxSs+h2tnTyMx7n+aRkjHwcegeM3aS3IOeRrVS+kSnTnEwbWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961385; c=relaxed/simple;
	bh=zQmASbjfteROLhenJ1pecN2B1Dy5o7RoNKwVlrdowjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQxubgvs41CXH3/5N6dnpu2XVaY84cVXdvcd+dMALg32EESSujlH1csvfrMCXsp11/hdDdGY+N5UDnmQGPBKP8V1OXHmWkw42Jt2MzfFKtljchCLrTfEB35Xn3VZmvjQVAhijBlcZvhtQiA7siMhdbaEtBmXpDbD9yb0liowyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CpHVc/jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88FBC4CECC;
	Tue, 10 Sep 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961385;
	bh=zQmASbjfteROLhenJ1pecN2B1Dy5o7RoNKwVlrdowjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpHVc/jFJazKIMy6yETtEtL3ifNu8WcF0Qqcgvqdo2nQwM7gVax49EiUsXj3NQMFY
	 5b3TmDvZekFUJffUetTlcovsDbZjmDjWzo0xLMo6FSNFJuhBnET9EViNBaejWg5NsV
	 ksX1ah+1f+4LKR2VvfAnZTIHipw1PKMlwLULtjs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Huang <ahuang12@lenovo.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 053/375] mm: vmalloc: optimize vmap_lazy_nr arithmetic when purging each vmap_area
Date: Tue, 10 Sep 2024 11:27:30 +0200
Message-ID: <20240910092624.019561416@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Huang <ahuang12@lenovo.com>

commit 409faf8c97d5abb0597ea43e99c8b3dd8dbe99e3 upstream.

When running the vmalloc stress on a 448-core system, observe the average
latency of purge_vmap_node() is about 2 seconds by using the eBPF/bcc
'funclatency.py' tool [1].

  # /your-git-repo/bcc/tools/funclatency.py -u purge_vmap_node & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1

     usecs             : count    distribution
        0 -> 1         : 0       |                                        |
        2 -> 3         : 29      |                                        |
        4 -> 7         : 19      |                                        |
        8 -> 15        : 56      |                                        |
       16 -> 31        : 483     |****                                    |
       32 -> 63        : 1548    |************                            |
       64 -> 127       : 2634    |*********************                   |
      128 -> 255       : 2535    |*********************                   |
      256 -> 511       : 1776    |**************                          |
      512 -> 1023      : 1015    |********                                |
     1024 -> 2047      : 573     |****                                    |
     2048 -> 4095      : 488     |****                                    |
     4096 -> 8191      : 1091    |*********                               |
     8192 -> 16383     : 3078    |*************************               |
    16384 -> 32767     : 4821    |****************************************|
    32768 -> 65535     : 3318    |***************************             |
    65536 -> 131071    : 1718    |**************                          |
   131072 -> 262143    : 2220    |******************                      |
   262144 -> 524287    : 1147    |*********                               |
   524288 -> 1048575   : 1179    |*********                               |
  1048576 -> 2097151   : 822     |******                                  |
  2097152 -> 4194303   : 906     |*******                                 |
  4194304 -> 8388607   : 2148    |*****************                       |
  8388608 -> 16777215  : 4497    |*************************************   |
 16777216 -> 33554431  : 289     |**                                      |

  avg = 2041714 usecs, total: 78381401772 usecs, count: 38390

  The worst case is over 16-33 seconds, so soft lockup is triggered [2].

[Root Cause]
1) Each purge_list has the long list. The following shows the number of
   vmap_area is purged.

   crash> p vmap_nodes
   vmap_nodes = $27 = (struct vmap_node *) 0xff2de5a900100000
   crash> vmap_node 0xff2de5a900100000 128 | grep nr_purged
     nr_purged = 663070
     ...
     nr_purged = 821670
     nr_purged = 692214
     nr_purged = 726808
     ...

2) atomic_long_sub() employs the 'lock' prefix to ensure the atomic
   operation when purging each vmap_area. However, the iteration is over
   600000 vmap_area (See 'nr_purged' above).

   Here is objdump output:

     $ objdump -D vmlinux
     ffffffff813e8c80 <purge_vmap_node>:
     ...
     ffffffff813e8d70:  f0 48 29 2d 68 0c bb  lock sub %rbp,0x2bb0c68(%rip)
     ...

   Quote from "Instruction tables" pdf file [3]:
     Instructions with a LOCK prefix have a long latency that depends on
     cache organization and possibly RAM speed. If there are multiple
     processors or cores or direct memory access (DMA) devices, then all
     locked instructions will lock a cache line for exclusive access,
     which may involve RAM access. A LOCK prefix typically costs more
     than a hundred clock cycles, even on single-processor systems.

   That's why the latency of purge_vmap_node() dramatically increases
   on a many-core system: One core is busy on purging each vmap_area of
   the *long* purge_list and executing atomic_long_sub() for each
   vmap_area, while other cores free vmalloc allocations and execute
   atomic_long_add_return() in free_vmap_area_noflush().

[Solution]
Employ a local variable to record the total purged pages, and execute
atomic_long_sub() after the traversal of the purge_list is done. The
experiment result shows the latency improvement is 99%.

[Experiment Result]
1) System Configuration: Three servers (with HT-enabled) are tested.
     * 72-core server: 3rd Gen Intel Xeon Scalable Processor*1
     * 192-core server: 5th Gen Intel Xeon Scalable Processor*2
     * 448-core server: AMD Zen 4 Processor*2

2) Kernel Config
     * CONFIG_KASAN is disabled

3) The data in column "w/o patch" and "w/ patch"
     * Unit: micro seconds (us)
     * Each data is the average of 3-time measurements

         System        w/o patch (us)   w/ patch (us)    Improvement (%)
     ---------------   --------------   -------------    -------------
     72-core server          2194              14            99.36%
     192-core server       143799            1139            99.21%
     448-core server      1992122            6883            99.65%

[1] https://github.com/iovisor/bcc/blob/master/tools/funclatency.py
[2] https://gist.github.com/AdrianHuang/37c15f67b45407b83c2d32f918656c12
[3] https://www.agner.org/optimize/instruction_tables.pdf

Link: https://lkml.kernel.org/r/20240829130633.2184-1-ahuang12@lenovo.com
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2190,6 +2190,7 @@ static void purge_vmap_node(struct work_
 {
 	struct vmap_node *vn = container_of(work,
 		struct vmap_node, purge_work);
+	unsigned long nr_purged_pages = 0;
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
@@ -2207,7 +2208,7 @@ static void purge_vmap_node(struct work_
 			kasan_release_vmalloc(orig_start, orig_end,
 					      va->va_start, va->va_end);
 
-		atomic_long_sub(nr, &vmap_lazy_nr);
+		nr_purged_pages += nr;
 		vn->nr_purged++;
 
 		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
@@ -2218,6 +2219,8 @@ static void purge_vmap_node(struct work_
 		list_add(&va->list, &local_list);
 	}
 
+	atomic_long_sub(nr_purged_pages, &vmap_lazy_nr);
+
 	reclaim_list_global(&local_list);
 }
 



