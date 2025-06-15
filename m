Return-Path: <stable+bounces-152673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CEADA2D6
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EF6188DCB9
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752F1FE474;
	Sun, 15 Jun 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLGXV7aQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300B1B0F1E
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750009933; cv=none; b=haJYxa5x+X8s/2fCdMg0TWNRaV3HEPrRZhrrUOW1sTufY4hCElIEC6BQl691O4hf1BwNJzHFqzZrtgIZV9jWmZdL0mFJMegOsx3W/60Qbma94IMOpNPP4P3pM0Ulgb0DLqqMDTRvjbL3HiTF+VRdGNCIL97/c3bUGQjb4qZFQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750009933; c=relaxed/simple;
	bh=ZtGvE7dolBodyQCknPcClufjkGMkuKBitk/+FL2eJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss1Ta2/gvAFN6pXo1OnzT4oVdHA+BQvFb/FsiEC4PeWOlIev4oQwTqKxlx8yD36A4ovlOfZEoG6XtSqsEwdIVyC/WrswS5CO29cZ3HXapp+vJEu6e7nC04do07G3KG+kdkpHqX4loKlwA0OrXYCqzJ3VkTBBYXFd8nj7bIjEIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZLGXV7aQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FGlfGD002514;
	Sun, 15 Jun 2025 17:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+yllb
	yV78yNYeFd2FJdd0QQI9z9gGoiWItlVRlLazBM=; b=ZLGXV7aQMbLBs//cupTjL
	VINhk0IENs2MQr5IGSHCQyYfdSoyP74/O/hbg99Z6D4arlROun3MYJoWPEFP+PSp
	GgUAg6i6ut3vkntQ8TfO9Xjr8cRnFAWh3DTivbbzxC7+6ruK1aLTU6rW3EgNlmWo
	Hgq3SULnqieIwUYcXmtl6rOFSQz8LlwHded3HBDTYDQPWBl4LFUOlQUy5Sl4jHx1
	oh40xMlgQllKf99D84YqvXBcw8aPGh2fREApXzoqPHNoqdOte8nfu0zGO+DNQbL5
	Jwh6lsytXOmwHYNZbwEhqUr68MSFSSLpBKzhFFVkPSUhlgc9Xm65TLF0Dptf6Qjr
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn0qbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FHhReb031649;
	Sun, 15 Jun 2025 17:52:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6wk2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:52:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FHpugR014138;
	Sun, 15 Jun 2025 17:52:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6wk1m-6;
	Sun, 15 Jun 2025 17:52:04 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com, syzbot <syzkaller@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 5/5] net_sched: sch_sfq: move the limit validation
Date: Sun, 15 Jun 2025 10:51:53 -0700
Message-ID: <20250615175153.1610731-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
References: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506150132
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=684f0846 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yPCof4ZbAAAA:8
 a=T6WujiZu3G7N5XOspOIA:9 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: FzgPe5qDnalt1jRo3dt0NNUiyrZdDFoa
X-Proofpoint-GUID: FzgPe5qDnalt1jRo3dt0NNUiyrZdDFoa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDEzMiBTYWx0ZWRfX9Yut7ATeyFG1 yFrf4EeEsm0RPrXDHPziry7lzYboO468yFEaIACvXea3MCEfeBsNIni1iSQaDKk2KNeFPwTm0DX 9Rv+PCAUV+21GstfPlGLZzHFwJy5ZdO9qAKW+xkKOOFw1g7Ebk0Dm8B9S03/JgJZg1Gp6y+zEUe
 EdKisyEDt9P7hYHjjj5bCicnHIv7eB9hXT1ajIQAmwQCF3hLX+cHYfnMTYu6JMVIQCoxy7/7345 g7gkToaQ0ORRB99lP4xfxpg0Bt9RK2YIn/nKIFzvq3MdPZkdkdDxFevQaQppcdY9wLjk4gFYaMm 0WyFVeND32UN0uZ+6NSAefzd30gXZwQiQ8d50KYHJjTSU2vdIoYsIORJVv1FivvFjLI/eAHqyix
 7t17570MBKJOwTw6G2IsBGAQ9IyxRwsjjtYdUpFl/YrbmrRmwfViAtJ6hJ6LKfx0AoiLBtBw

From: Octavian Purdila <tavip@google.com>

[ Upstream commit b3bf8f63e6179076b57c9de660c9f80b5abefe70 ]

It is not sufficient to directly validate the limit on the data that
the user passes as it can be updated based on how the other parameters
are changed.

Move the check at the end of the configuration update process to also
catch scenarios where the limit is indirectly updated, for example
with the following configurations:

tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 divisor 1

This fixes the following syzkaller reported crash:

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 1 UID: 0 PID: 3037 Comm: syz.2.16 Not tainted 6.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x201/0x300 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf5/0x120 lib/ubsan.c:429
 sfq_link net/sched/sch_sfq.c:203 [inline]
 sfq_dec+0x53c/0x610 net/sched/sch_sfq.c:231
 sfq_dequeue+0x34e/0x8c0 net/sched/sch_sfq.c:493
 sfq_reset+0x17/0x60 net/sched/sch_sfq.c:518
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 tbf_reset+0x41/0x110 net/sched/sch_tbf.c:339
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 dev_reset_queue+0x100/0x1b0 net/sched/sch_generic.c:1311
 netdev_for_each_tx_queue include/linux/netdevice.h:2590 [inline]
 dev_deactivate_many+0x7e5/0xe70 net/sched/sch_generic.c:1375

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
Signed-off-by: Octavian Purdila <tavip@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit b3bf8f63e6179076b57c9de660c9f80b5abefe70)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_sfq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 9a8c9138702a..ce7d658b7ecb 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -658,10 +658,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -702,6 +698,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
 		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 
 	/* commit configuration */
 	q->limit = limit;
-- 
2.47.1


