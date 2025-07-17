Return-Path: <stable+bounces-163262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA6B08D4D
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5902D188BF07
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748B2D23BF;
	Thu, 17 Jul 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PQKGkcIp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39325789D
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756378; cv=none; b=lvzGd/6E+Y/jjQn3gZeoilP5fuCcPzsOKaFZeTxFU48PQDKqEn2rl3lj6U3Muv1TBkOVZcVg3bCviVH7GbIC6VeAvCXupsIEvFuk3mo67O5DkLND8oyzxSogxxNyfQXU/OPvHhLd086lpjs9/2jTu8eA19YvnoNZ9BWLhF2ZRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756378; c=relaxed/simple;
	bh=2efKL2UyFRKf7ETBI1EsJGELomEeNm5UqI/6Z7tyPJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKC6vhgAf2vguFv8rQnBGPKj2UNLOCsPyMGcVAz0jJlpe0HGwBYCPSvpV060jR3xdTYkRvNIU7ly31WOd36mjovIKBjpxrNrf5wk/SOWHropnUUYc6u2sSOkGa7CeDHpsq4ssVhzassVQBO7KFGfAJCayZdR1pNp1q8nZcurKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PQKGkcIp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fkmV000984;
	Thu, 17 Jul 2025 12:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2K1mP
	XkFPDijTmu325Q9sc/HIfUhkvUbwYdFss30dbU=; b=PQKGkcIp2myUveWhcyE72
	iCgWo+lcilQCgNKEsKSjszd3s0Y13hVPWVEw0yKR+h1wrZxoiAzNXC8SVCa/sqlZ
	UYP+3yRja3ppcHyG3F/vIcSgU3mk+e7pIhjsCa0b1bOKnllW5ZrKpPteQm2WwjfQ
	ySydAuBgMvxRyXbc0dIWH3pYYvwGblb/2f5rbAy+qusF6jdvm07f8tHaQlR7ED7a
	5kKytQGuYEqYsEX28OIwi63KNuW3X2XdEJE2j7HEgekyjiBm92QjG4qERsQceDSs
	XAtJcIvuEQhRKfb10dcT0PphxQ4ZLh+pPi5FfnlNC0z7WOZTyYdljbqxw3QLQjW4
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b2xvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HB9X7A039601;
	Thu, 17 Jul 2025 12:46:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpy7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0o5024687;
	Thu, 17 Jul 2025 12:46:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-6;
	Thu, 17 Jul 2025 12:46:11 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com, syzbot <syzkaller@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 5/6] net_sched: sch_sfq: move the limit validation
Date: Thu, 17 Jul 2025 05:45:55 -0700
Message-ID: <20250717124556.589696-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfXwYagKrloWo+O 5UrnhDCaL+fHOmoj6WF+7q8UWAFp9m847dLyYgtOK7+eXLyyJgtabaEYoa9sj/IDTsIUDYBLbnN dGRTlHtV8ltN4rP5OL8jMpoHVF23IHYJBfY2+9seQIOOJwqlkP2v76k2Irr3iaXgFzhDuMMTKm+
 f7CE/guKh6Fkrpn6DXO5Wh3yzUl8wWx5Dli0+4DhkhUcCpryNPIHRjLYOUkX8FdgWSgKqK9UeOK U5vGnH5mnYY5WMWnLCShssiPI05eHbqZMFs4vHwG5KYoJB37025nmIEVg8hiqsWez/yB12QyXut OPmXfJhA1gmIiPOJvubxIm8j6tH8BRcyEogXPJ4EtaHEqID7X8cUVGXm5U6XztjcTB+h5hpuLA+
 /oQ3Gwtlak2pmt63EwoGuizaV/85/kuoVLfgDD57bz6iczyybCwc7/sKq6kZmWoo0HrbXieQ
X-Proofpoint-GUID: HHeB9tFLA_F0xj_bxRKMuneuBHAEBHWg
X-Proofpoint-ORIG-GUID: HHeB9tFLA_F0xj_bxRKMuneuBHAEBHWg
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6878f094 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yPCof4ZbAAAA:8
 a=T6WujiZu3G7N5XOspOIA:9 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22 cc=ntf awl=host:13600

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
index d49edcb9729e..9e8601e64508 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -661,10 +661,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -705,6 +701,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
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


