Return-Path: <stable+bounces-244800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELZuAgYZ/mmQmwAAu9opvQ
	(envelope-from <stable+bounces-244800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:10:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668954F9CB7
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5674930948BE
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0603D47B8;
	Fri,  8 May 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKltmZB4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF36282F38
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259945; cv=none; b=O8q8f5uHd/mAnSMrbOJknZtf1uybD3GiwazNrAr1rKa2xCGbz9ApI9mLbhU7tibNYOLJQnu27HP6OcSVitAVX8HvdtdueA4MwkN8D9Y3Vh6BRv4teBx+4KBsL+bcL6NyLSiaOyBtuX0yoJAlq+K6K1D6z9Q0XcRp32lfxVlSN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259945; c=relaxed/simple;
	bh=6Tewy3ljxwpLp3F9Q8zxqQ9KL39V9J4C1tVXUmmozw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnqFi3okBq4Le0ffv3auDEo0mYZ+niCbvf+ieW2OalqK4XU/CQyqbAkkDBwP6buo45hwV8ZkyXUA2ElPwNpprBjQaFQrvd09x3QrFxZ2I9ybQMFhfV92z3voN4Wa/nBFTuHwbKTHTts5V9BXAlZuoHiox9p2L/fjaxR9AWHuP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKltmZB4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648FtXo23634645
	for <stable@vger.kernel.org>; Fri, 8 May 2026 17:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tcCsskAYYNCBJaMrgGJiZyzM0uTVZCz4JgB5GKEnC
	WQ=; b=QKltmZB43hBbUhxi5tZsF8nMgj52XlppT+RukiBJk0kh5SNzFXavOoh74
	uDSWvsZZhKyPSuaNmcS2TfzAVX1mQA1wdpbHXgfEFRNWoHUb7CTOUQsnrm15MiuC
	bfQsU2xNc1Y+sUc8O6JxauSmVcklw+ZvNLXO333WS1Q9wumfwD1SP4f0b3miUjcf
	Zi9u48A8JkMCjAzIkZcfnak7jtoAY9+AulVJdzfq+WUx6NR43Rc3nJwmezirRhgz
	tXWYMuiCvbKiO7Ep+lcWRjkYqAbyBmmlr7/LTwHNhbHrVK6DtiW6fHkhcAeLqWQc
	h3jCPI+6HZFGKxsBlVCJg8RaUtUMA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6uev3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 08 May 2026 17:05:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648GsX9U017708
	for <stable@vger.kernel.org>; Fri, 8 May 2026 17:05:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hh2h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 08 May 2026 17:05:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648H5bbZ51970360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 17:05:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC6B020043;
	Fri,  8 May 2026 17:05:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD99C20040;
	Fri,  8 May 2026 17:05:36 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 17:05:36 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: wintera@linux.ibm.com, aswin@linux.ibm.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com, pasic@linux.ibm.com, mjambigi@linux.ibm.com,
        dk@linux.ibm.com, twinkler@linux.ibm.com, jaka@linux.ibm.com,
        wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: Nagamani PV <nagamani@linux.ibm.com>, stable@vger.kernel.org,
        syzbotz+89435e7383b82238dd91@linux.ibm.com
Subject: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
Date: Fri,  8 May 2026 19:05:34 +0200
Message-ID: <20260508170534.2208812-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fe17e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2L6bTA5ms6rrk1lURLYA:9
X-Proofpoint-ORIG-GUID: CDxbwSiDIwL0iItnFBCVRzaDxvcO5JeC
X-Proofpoint-GUID: CDxbwSiDIwL0iItnFBCVRzaDxvcO5JeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2NiBTYWx0ZWRfX+JXJp4wjkQp2
 zhEIy4ilSI3/Rf1FS75ZN9PdHkXdrsLoGA2s3M1wMtRydQmvtixzNxl41sdTl2V3CMnLR6IM5WQ
 yj6JibEq1bi1segWsJ2z30xtBeBhi6y0mZglJ6GPc21p4IcpxCJi9CCj2kJBpETpyTlIaOWZnZ8
 RI75kiQ/cCsfdENCogWZ4vTXbmaQy9xjW1tMYKpYW04eTjZGqiBOJKXtIwTqqfzOwl/8pjA9D0T
 dtzbEP+dJXyRgGQODzM9eCLp4eEmRg5VuOVIkeJAfzKawYpLNUgkrBEXxUEuxFzjP65L2V+C2YK
 1pWhig3TazoPJP0m6rXYK+kI/W435Ibf4NvexzqZe5Sx2aPtl6g0lGGCTaUd0lv9b2+b0SRj4U1
 648XM94SpS/vVWhYf4ymIcKx6709kq06arWHosn0ikH70V6IfrhPNq+z9/3XMmrQGULzKensd+G
 gW/4uPyFJD9careV5gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080166
X-Rspamd-Queue-Id: 668954F9CB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244800-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagamani@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,89435e7383b82238dd91];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

afiucv_netdev_event() traverses iucv_sk_list without holding
iucv_sk_list.lock.

A concurrent socket teardown can unlink and free the socket via
iucv_sock_kill() while the notifier path is still iterating over
the list, leading to a possible use-after-free when dereferencing
the socket.

Protect the traversal using the existing read-side lock, matching
the locking pattern already used by other iucv_sk_list traversal
paths in af_iucv.c.

Use read_lock()/read_unlock() to remain consistent with existing
softirq/tasklet-side readers in the same file.

Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
Cc: stable@vger.kernel.org
Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91
Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

---
v2:
- Target net-next (missed in v1 subject)
---
 net/iucv/af_iucv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 72dfccd4e3d5..e8a0b55fc55d 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2188,6 +2188,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
 	switch (event) {
 	case NETDEV_REBOOT:
 	case NETDEV_GOING_DOWN:
+		read_lock(&iucv_sk_list.lock);
 		sk_for_each(sk, &iucv_sk_list.head) {
 			iucv = iucv_sk(sk);
 			if ((iucv->hs_dev == event_dev) &&
@@ -2198,6 +2199,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
 				sk->sk_state_change(sk);
 			}
 		}
+		read_unlock(&iucv_sk_list.lock);
 		break;
 	case NETDEV_DOWN:
 	case NETDEV_UNREGISTER:
-- 
2.53.0


