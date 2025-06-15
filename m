Return-Path: <stable+bounces-152661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBEADA250
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81943B061B
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6027990A;
	Sun, 15 Jun 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PhODGQ7B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04815442A
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001083; cv=none; b=erf+ne7k0CFfp2+qXpDc6VKcixLZzb25MI2zj7atShJvbsZf/ZJpwNN54oKva/ifrTMIHBEMbXNTYBb0t11dtmDJ98TZEk1aBAYy8Qvb7PUzoWupdxaW/eGcq48g7NcqJ8zhjiVM2toyG99PegZmGPCS06RAnAOe90whQY8Xvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001083; c=relaxed/simple;
	bh=xzQNtpQmZqQKGWFsuYwTcZKS7aj6Xt4SkZAdLoxA6rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJvRyqOhCzikQsDE6ftt4ZTikCkpTofCyN/+hanpbvbiklf3fYZEontTPamNZpReLCJ618zBZoA4GYv0S/viVFjtRmBKoiaa0w8pv/urhZ8fbBYKzhObYtewJxdqmuKenDxYRMgQ9lvPTD/kmhf+pCndYOLKibCBysjsBw450KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PhODGQ7B; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FEFE5q032445;
	Sun, 15 Jun 2025 15:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KPyJv
	hIhoOUT6Yd7oLj9lwC7UEALu5Vpv9/bwcg9B1A=; b=PhODGQ7BWZ7RtpJRBl6Ej
	FEsQDD+30OJrkSiv58iqZmvX+jIu15gekVr808I4GNhCiAcrAdn39PigPr3iZQ82
	iK/wiUzKSD6SpH9Z/KhX+UhLUM/azoV1hf0f2egn9MmK+AfUn0oarbz1BxSaL3TH
	P5qEZHytEbqvB77mFurVAxSWPtprGIKOjVJxiuq5plisnF6Fz8bfQyWoufJrrZie
	RcNSxAHq7YM3ln1pguIdThyTcskQtJz8oTiKsO5JgohiUYLI1kpQzuEf68YxBe2A
	kEgXXPPkLhsYCpJzadQqDOLcE6dMYUi6ehSy9pyyVfu1TXJgvF/V69K+J0Jhp+R6
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxh5tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBL8EL034375;
	Sun, 15 Jun 2025 15:24:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6v52r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FFOTZu022730;
	Sun, 15 Jun 2025 15:24:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6v51x-4;
	Sun, 15 Jun 2025 15:24:34 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com, syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 3/5] net_sched: sch_sfq: don't allow 1 packet limit
Date: Sun, 15 Jun 2025 08:24:25 -0700
Message-ID: <20250615152427.1364822-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506150114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDExNCBTYWx0ZWRfX9w0ADrufbej9 ReTnw3krGydD/n4GFFVqtRC1q96CVHTnzJXUv524eOUJ2Lw9YfJUfly6VgA+jFrSHOx/QqiYBiP uoEmaTpfsAkU5n5uf4F7ZshS/C2v72SVNFrj8e/2jTzgiyeZuzKEOpVBccSwHRClUjg+cLiwwtx
 oZwRkZXpPvJ+ECWo3L4zaIdpItRJqIqewSJCgxsudg8a7PICR/b7a9oGfT3JdgfCcDdPp1jKkUR wF/3fxEYH5rz22PlOhtjPXl5WrD+kiv96xNZcjMca/O1QmgAWW/veZfw3SylVtBc71JOq0XveBI ykLCIUWFrgahAvc/Fuoy4XunIevSeB/21p/IpHj0V3tjIKgB1LlNwL8WvK61CWz9G0hMxhCSx2E
 2y13WJu3Zhv4rLz3S5oxToYiiPZFD3yKy0/ymDKSfh/hHSVjAyPAW8VgBZljoxBrab01xCWK
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=684ee5b3 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=I3u5-HAeXOyi3Y5IjOcA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-GUID: uN-H3kFzB03sD07FdUlhb9gCtbP8R_Uz
X-Proofpoint-ORIG-GUID: uN-H3kFzB03sD07FdUlhb9gCtbP8R_Uz

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
index 714bdc2c5a68..505209a932ab 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -649,6 +649,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
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


