Return-Path: <stable+bounces-177805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3CB455AA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE7D1C83302
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31356341641;
	Fri,  5 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVRszBdB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82733EB13
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070275; cv=none; b=Iq6ShcVRKug/qzwgR0F0QP/gbZaJiR1xLhr+57Shgo2rI98N7VMT8iAM4H1+9aCYWAw/5iB1wHnpvdcNQCIIuHsP2qUrPgUEbXf8KADip+W+VINSKmypXIQ3RRjEdvR2X4vl26SU6ZW9V4A8e9DocXkW3N8vFM9PGVuiIrzY/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070275; c=relaxed/simple;
	bh=sVVz+BBqnxYVuyXUD/R4Qb0qwugl9etn3t8GTW6nu0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbJvq5l1vDP1IKwl9EFMizk+V5bpL/9AuVlxxSM7kQ81RFEvhrpNM15gq95ebaQ6/c1W9CPJTPkCPL1r8wPt+V3PpNYldNDpdGKBtaYtaxVfMlmTA2RYu+xrt6h1UW4K6j4h0jOnZRGWsh4Myb5dxcieE0cx6RzO89p5ux2BtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mVRszBdB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AtjKp006158;
	Fri, 5 Sep 2025 11:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Qhj/1
	R9HEGZjWUxdjY57eLwKHiUBaLQxOZ9hcVnfBn0=; b=mVRszBdBT5vTg9HYmx5+Z
	cKJAeuC3eALJ2Tn/I9zzF9q503BBQbQyAlW3Xf6INJrz3A+bwC4EwY7zWeysiQoB
	4hjs6ZHH8AYbRKa1RyfSVNO3m3q1j4+lJAy4QVVklBiSiAKyXuUpmrB7hymM1Yot
	qSvfCOTg8EI9JFIusS5pgj2NqBDQt7ouoo1Y37cMPpHNgVoGYAFqMasDt8EPqgxb
	m32ayCY9pxablSIB51B/fyW1LfSrcOtbIZMDwtHDlXxZks1fr4NqdgqyWAZNJDPz
	aL1WgQwIyw056BcNdL26C+7n5zB7atT8iSbJ78cg9+LYuFI7kMBIKaXySkBbQoAa
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa5812n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JZKp019601;
	Fri, 5 Sep 2025 11:04:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hW030057;
	Fri, 5 Sep 2025 11:04:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-12;
	Fri, 05 Sep 2025 11:04:28 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Jens Axboe <axboe@kernel.dk>,
        syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU
Date: Fri,  5 Sep 2025 04:04:02 -0700
Message-ID: <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3be b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8
 a=yPCof4ZbAAAA:8 a=ZQc3DyWgPiyMokSQXlgA:9 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfX0KBCp65EYPsj
 pqKT/+MY2ajx/X95H0Gc4YdDW9ddDVQtOOIF+NujckQzzAsoCOwW8yP5UlQXmEgQckXI0iHj+sK
 5qCIbf+BJLVzLk8fnWsgIE/n+MSYrNk0orEYA0TzdrW4PdGKWGQSx84GEB1Ib317CmDrEengoB+
 MNXqNkYPQbTapNvjFYOCwdERJMW/WI5BpJJY+XdIAnJPzdJNgJ74WAFfH0kwelfEZLAbSUcQjRh
 4ThrirN30TY4ra7FGd/a1D+1QHepTttSFzU/fDbyEZxYAHAXELpBbZWrvNG/PyTw9y6ZtQQ1En4
 yrzwATf2CcpbG7e2aF0cz8uJaZa5FtEbZTkS22Zgx/JAursazM1JfJJ55QgoqP6zXUob8wrIDpp
 vOnXMUj0
X-Proofpoint-ORIG-GUID: CjGfgltJF5iw0cMuhajlFZuxsm_CvuXy
X-Proofpoint-GUID: CjGfgltJF5iw0cMuhajlFZuxsm_CvuXy

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit fc582cd26e888b0652bc1494f252329453fd3b23 ]

syzbot reports that defer/local task_work adding via msg_ring can hit
a request that has been freed:

CPU: 1 UID: 0 PID: 19356 Comm: iou-wrk-19354 Not tainted 6.16.0-rc4-syzkaller-00108-g17bbde2e1716 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 io_req_local_work_add io_uring/io_uring.c:1184 [inline]
 __io_req_task_work_add+0x589/0x950 io_uring/io_uring.c:1252
 io_msg_remote_post io_uring/msg_ring.c:103 [inline]
 io_msg_data_remote io_uring/msg_ring.c:133 [inline]
 __io_msg_ring_data+0x820/0xaa0 io_uring/msg_ring.c:151
 io_msg_ring_data io_uring/msg_ring.c:173 [inline]
 io_msg_ring+0x134/0xa00 io_uring/msg_ring.c:314
 __io_issue_sqe+0x17e/0x4b0 io_uring/io_uring.c:1739
 io_issue_sqe+0x165/0xfd0 io_uring/io_uring.c:1762
 io_wq_submit_work+0x6e9/0xb90 io_uring/io_uring.c:1874
 io_worker_handle_work+0x7cd/0x1180 io_uring/io-wq.c:642
 io_wq_worker+0x42f/0xeb0 io_uring/io-wq.c:696
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

which is supposed to be safe with how requests are allocated. But msg
ring requests alloc and free on their own, and hence must defer freeing
to a sane time.

Add an rcu_head and use kfree_rcu() in both spots where requests are
freed. Only the one in io_msg_tw_complete() is strictly required as it
has been visible on the other ring, but use it consistently in the other
spot as well.

This should not cause any other issues outside of KASAN rightfully
complaining about it.

Link: https://lore.kernel.org/io-uring/686cd2ea.a00a0220.338033.0007.GAE@google.com/
Reported-by: syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Fixes: 0617bb500bfa ("io_uring/msg_ring: improve handling of target CQE posting")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit fc582cd26e888b0652bc1494f252329453fd3b23)
[Harshit: Resolve conflicts due to missing commit: 01ee194d1aba
("io_uring: add support for hybrid IOPOLL") and commit: 69a62e03f896
("io_uring/msg_ring: don't leave potentially dangling ->tctx pointer")
in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 include/linux/io_uring_types.h | 2 ++
 io_uring/msg_ring.c            | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 5ce332fc6ff5..3b27d9bcf298 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -648,6 +648,8 @@ struct io_kiocb {
 	struct io_task_work		io_task_work;
 	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
 	struct hlist_node		hash_node;
+	/* for private io_kiocb freeing */
+	struct rcu_head		rcu_head;
 	/* internal polling, see IORING_FEAT_FAST_POLL */
 	struct async_poll		*apoll;
 	/* opcode allocated if it needs to store data for async defer */
diff --git a/io_uring/msg_ring.c b/io_uring/msg_ring.c
index 35b1b585e9cb..b68e009bce21 100644
--- a/io_uring/msg_ring.c
+++ b/io_uring/msg_ring.c
@@ -82,7 +82,7 @@ static void io_msg_tw_complete(struct io_kiocb *req, struct io_tw_state *ts)
 		spin_unlock(&ctx->msg_lock);
 	}
 	if (req)
-		kmem_cache_free(req_cachep, req);
+		kfree_rcu(req, rcu_head);
 	percpu_ref_put(&ctx->refs);
 }
 
@@ -91,7 +91,7 @@ static int io_msg_remote_post(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	req->task = READ_ONCE(ctx->submitter_task);
 	if (!req->task) {
-		kmem_cache_free(req_cachep, req);
+		kfree_rcu(req, rcu_head);
 		return -EOWNERDEAD;
 	}
 	req->opcode = IORING_OP_NOP;
-- 
2.50.1


