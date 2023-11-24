Return-Path: <stable+bounces-1881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1577F81CE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C69283369
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17036364A6;
	Fri, 24 Nov 2023 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GAisfift"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC990339BE;
	Fri, 24 Nov 2023 19:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A49C433C8;
	Fri, 24 Nov 2023 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852503;
	bh=5CBIdEdPZmODBF2WZzX8AH1b1MDY3I590m2rRWjSWkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAisfift0WX8y6YUA2VgRPeRnEhgOmdOQdWYEfaJMCNnAaQJZ0s4SoSUkmzWAGoq9
	 Ak9BLYhUacacjz/carGHZQCFo1Tv3iIpl7pFyQCQJLWi5rOTM76PFaD7E0r7WCAsRy
	 MEKZVWF4vv2DNPHgwYpTeG+Y65zWeLkyU0QV4y/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 002/193] perf/core: Bail out early if the request AUX area is out of bound
Date: Fri, 24 Nov 2023 17:52:09 +0000
Message-ID: <20231124171947.225398449@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 54aee5f15b83437f23b2b2469bcf21bdd9823916 ]

When perf-record with a large AUX area, e.g 4GB, it fails with:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

and it reveals a WARNING with __alloc_pages():

	------------[ cut here ]------------
	WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
	Call trace:
	 __alloc_pages+0x1ec/0x248
	 __kmalloc_large_node+0xc0/0x1f8
	 __kmalloc_node+0x134/0x1e8
	 rb_alloc_aux+0xe0/0x298
	 perf_mmap+0x440/0x660
	 mmap_region+0x308/0x8a8
	 do_mmap+0x3c0/0x528
	 vm_mmap_pgoff+0xf4/0x1b8
	 ksys_mmap_pgoff+0x18c/0x218
	 __arm64_sys_mmap+0x38/0x58
	 invoke_syscall+0x50/0x128
	 el0_svc_common.constprop.0+0x58/0x188
	 do_el0_svc+0x34/0x50
	 el0_svc+0x34/0x108
	 el0t_64_sync_handler+0xb8/0xc0
	 el0t_64_sync+0x1a4/0x1a8

'rb->aux_pages' allocated by kcalloc() is a pointer array which is used to
maintains AUX trace pages. The allocated page for this array is physically
contiguous (and virtually contiguous) with an order of 0..MAX_ORDER. If the
size of pointer array crosses the limitation set by MAX_ORDER, it reveals a
WARNING.

So bail out early with -ENOMEM if the request AUX area is out of bound,
e.g.:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4032cd4750001..01351e7e25435 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -691,6 +691,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		max_order--;
 	}
 
+	/*
+	 * kcalloc_node() is unable to allocate buffer if the size is larger
+	 * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
+	 */
+	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
+		return -ENOMEM;
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
 				     node);
 	if (!rb->aux_pages)
-- 
2.42.0




