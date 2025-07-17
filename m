Return-Path: <stable+bounces-163260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3CB08D4B
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA116E1E9
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01C29E0F0;
	Thu, 17 Jul 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXvtkrsb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F15789D
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756376; cv=none; b=VXtrtmBg3UNyiX/dPQ5MRZx73EvnCdMbjMy6YMNP3qfIkfJsgXDF/xX55G9uX+dzQ1+i6qm4w3ighn/Jsdq/YDHqkRBhhAArKy5chUhA/zmXk76z3Tysq8r4owl26rU/YI1QDhTR4FpcAEfMy5VwQJmwcIHrqty/CjlHxvOSxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756376; c=relaxed/simple;
	bh=08OxqNehzT4npshv8WWV1hgDvbHooRBubklEoV8pEp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiR+Lm/TKgBttuF3TAQQAjjefo3FjiRGdEccEnrQ9TIfdBAovPUYFTbIKauXalQTPd7QYCYMBvE7sGE0CY+ux/GRWbe6Ha2xQHJi9zS9lWp23CCgk79xnQM+1UtcDwSSEmfkDZgtNwBhdqqNFjhZ0r/RbGI+bfaUtmHsFNzrQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXvtkrsb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fnmY010004;
	Thu, 17 Jul 2025 12:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ensXL
	nntpc0/EPk3FNv4VPoD8TK2EwZ+UPXnwuYCqNM=; b=JXvtkrsbopY2xWx1aLjJH
	s0utpT0NorjuGwiO4bBdywsZfJs1M4/u4SQBkABwcdWeCTYVcnOBvwPQ9Djr9YLp
	Ja3DQzuf/BL14P7clpG0LHN5KdmUaXqTc/1cXft0xMkev13LQDPfuw+jEbpDChtH
	BKC2Ai2YvqctxXWNxa6FHuRJk/pUvo8pSvoaeOkO31ejpEMmjPr6Y7pmaItXdycf
	6k9+ZSvVlVTwg509PRak/UVt9amhnj/DU87xXW0SK/7eiMS3DTJOgaUYTUIsAgx+
	PY62rZX9ZrZGUa1t69m/r+PoAd6EXnJR2CDROieWjTotnWLCy6AtDZuuQAyQn9Fe
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfbfhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCP5aZ040544;
	Thu, 17 Jul 2025 12:46:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpy4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0o1024687;
	Thu, 17 Jul 2025 12:46:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-4;
	Thu, 17 Jul 2025 12:46:07 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com, syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 3/6] net_sched: sch_sfq: don't allow 1 packet limit
Date: Thu, 17 Jul 2025 05:45:53 -0700
Message-ID: <20250717124556.589696-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
References: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170112
X-Proofpoint-GUID: 5NVQ6RVd91qHuALJniMi4vA00hq6cJ7b
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6878f090 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=I3u5-HAeXOyi3Y5IjOcA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=_sbA2Q-Kp09kWB8D3iXc:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 5NVQ6RVd91qHuALJniMi4vA00hq6cJ7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfX6c6tQTrHlz/Q JG3yLkkz3N1m7YYFK473GKkAd+rEfo0AjnzHrCc5b766Fw5JcZxvE7rWWWwarhqz/oC1Uu7C+nU QX6rvfcg6RwZS69+hqnLHMG0pp5/9mPNHGix5/7E/UbwctemLX+JGXqsRdxnu95oJ04ermNpeIB
 cagTrKbqjw8QlpfIrWYSyBuc//MU5M/xabNmsVcs1zUGX07Ir4sEv221cuhe21DeCe+nizWT7hm qozWO+Rn9g0LmtvHDnMTkKlMi3FH4gHyqTV7lCYfI8+SMWWum7Vp75e1cfZwFoyAbrJHr+mtXiM VUv1e2HxWvkE8dmW7xaNn9rkLtBstpnUFtbN2fy3UBFr4RvjS4McM2WxGnBeRQlNXOiJd514M2S
 9vEEYfxBiMjoJ9xAtnuRaivlbVUA/ykOR2ifGicO5ll/+wSZzk+CV3kWHfABiYeBhpW6vjPS

From: Octavian Purdila <tavip@google.com>

[ Upstream commit 10685681bafce6febb39770f3387621bf5d67d0b ]

The current implementation does not work correctly with a limit of
1. iproute2 actually checks for this and this patch adds the check in
kernel as well.

This fixes the following syzkaller reported crash:

UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:210:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 0 PID: 2569 Comm: syz-executor101 Not tainted 5.10.0-smp-DEV #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack+0x125/0x19f lib/dump_stack.c:120
  ubsan_epilogue lib/ubsan.c:148 [inline]
  __ubsan_handle_out_of_bounds+0xed/0x120 lib/ubsan.c:347
  sfq_link net/sched/sch_sfq.c:210 [inline]
  sfq_dec+0x528/0x600 net/sched/sch_sfq.c:238
  sfq_dequeue+0x39b/0x9d0 net/sched/sch_sfq.c:500
  sfq_reset+0x13/0x50 net/sched/sch_sfq.c:525
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  tbf_reset+0x3d/0x100 net/sched/sch_tbf.c:319
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  dev_reset_queue+0x8c/0x140 net/sched/sch_generic.c:1296
  netdev_for_each_tx_queue include/linux/netdevice.h:2350 [inline]
  dev_deactivate_many+0x6dc/0xc20 net/sched/sch_generic.c:1362
  __dev_close_many+0x214/0x350 net/core/dev.c:1468
  dev_close_many+0x207/0x510 net/core/dev.c:1506
  unregister_netdevice_many+0x40f/0x16b0 net/core/dev.c:10738
  unregister_netdevice_queue+0x2be/0x310 net/core/dev.c:10695
  unregister_netdevice include/linux/netdevice.h:2893 [inline]
  __tun_detach+0x6b6/0x1600 drivers/net/tun.c:689
  tun_detach drivers/net/tun.c:705 [inline]
  tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3640
  __fput+0x203/0x840 fs/file_table.c:280
  task_work_run+0x129/0x1b0 kernel/task_work.c:185
  exit_task_work include/linux/task_work.h:33 [inline]
  do_exit+0x5ce/0x2200 kernel/exit.c:931
  do_group_exit+0x144/0x310 kernel/exit.c:1046
  __do_sys_exit_group kernel/exit.c:1057 [inline]
  __se_sys_exit_group kernel/exit.c:1055 [inline]
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1055
 do_syscall_64+0x6c/0xd0
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7fe5e7b52479
Code: Unable to access opcode bytes at RIP 0x7fe5e7b5244f.
RSP: 002b:00007ffd3c800398 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5e7b52479
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe5e7bcd2d0 R08: ffffffffffffffb8 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe5e7bcd2d0
R13: 0000000000000000 R14: 00007fe5e7bcdd20 R15: 00007fe5e7b24270

The crash can be also be reproduced with the following (with a tc
recompiled to allow for sfq limits of 1):

tc qdisc add dev dummy0 handle 1: root tbf rate 1Kbit burst 100b lat 1s
../iproute2-6.9.0/tc/tc qdisc add dev dummy0 handle 2: parent 1:10 sfq limit 1
ifconfig dummy0 up
ping -I dummy0 -f -c2 -W0.1 8.8.8.8
sleep 1

Scenario that triggers the crash:

* the first packet is sent and queued in TBF and SFQ; qdisc qlen is 1

* TBF dequeues: it peeks from SFQ which moves the packet to the
  gso_skb list and keeps qdisc qlen set to 1. TBF is out of tokens so
  it schedules itself for later.

* the second packet is sent and TBF tries to queues it to SFQ. qdisc
  qlen is now 2 and because the SFQ limit is 1 the packet is dropped
  by SFQ. At this point qlen is 1, and all of the SFQ slots are empty,
  however q->tail is not NULL.

At this point, assuming no more packets are queued, when sch_dequeue
runs again it will decrement the qlen for the current empty slot
causing an underflow and the subsequent out of bounds access.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241204030520.2084663-2-tavip@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 10685681bafce6febb39770f3387621bf5d67d0b)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 69e7d01c8518..aac1a4783f11 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -652,6 +652,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
+	if (ctl->limit == 1) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 	sch_tree_lock(sch);
 	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-- 
2.47.1


