Return-Path: <stable+bounces-244795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aABiMBQS/mnBmgAAu9opvQ
	(envelope-from <stable+bounces-244795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:40:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048D4F9884
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D27C3013A61
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB63D7D80;
	Fri,  8 May 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jQUnJrHu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225B2494D8
	for <stable@vger.kernel.org>; Fri,  8 May 2026 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258333; cv=none; b=V+lk8PR4QAgSTPCnAnwuRh1+lGeoeiNlUau1ZRe522XyhWkvfCSbri0gdEm7XjSjQ5X7S9CMjNFFSTPsyy2o5iBrgV4uDR1UWLqkKmESIDGwKRID3uia813k/Mz6uS2OD9XprFB9FYohagYfqC+Dm57FtSOQZKRTl+2S6G9M2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258333; c=relaxed/simple;
	bh=KCGBrLsM1JvyFSOqhR4P4DJDV8c58I+GovnRiJDfX0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRAIAaN6y6p1C+n+I10SQcC/PbwOqp7ZuX0ZdCNA7o3oueirEui839r/KoIbV90gb/naBX7K4Anlc+1LVktvc2fGyqi59k/3E7cXpPkBh3twem188N/BIcezibZoP/iqvgIjyDP9WKKABJp4tmZd8DduOZQW7NQh4sYnQuVKYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jQUnJrHu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648ErMN8577034
	for <stable@vger.kernel.org>; Fri, 8 May 2026 16:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tfA0NOsJ+BBJV2uR4TAL5Pfx3kwihpLznrUlwvu59
	eQ=; b=jQUnJrHuLrXKrJ5NwHJ3+xXx/TTU1gCRo917DRtE//R0Yn2KTKG0GpSKO
	sTYAcduCRXVynQiRrPS3yFkL2vjW2DC50fig9T7SvQlQfJh8bMIVFPeKgUSbVV3p
	+L/yOV3hLWo/LGrgVerlpBMU48L+Kr2maHtHIRC1hXRC4iBtN+G/SbNRCbZCI5YH
	wKXUEUTr2e1but2Zs0PAm5P6Q1Z6a/YhzkWhAdZUzhLwMJy3ooxgHnVhmchEx4NS
	sbtWrspkzMspXKhfO7udbn+s6VbPfimfBhTJZz9kLaL0EwbxmOTny9Sra89wTp+h
	1eGVMPkKmN+pX+JXLknGjrUCrvgdQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy39p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 08 May 2026 16:38:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648GOPBp032086
	for <stable@vger.kernel.org>; Fri, 8 May 2026 16:38:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgruqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 08 May 2026 16:38:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648Gciho11010372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 16:38:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB7D2004D;
	Fri,  8 May 2026 16:38:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9978D2004B;
	Fri,  8 May 2026 16:38:44 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 16:38:44 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: wintera@linux.ibm.com, aswin@linux.ibm.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com, pasic@linux.ibm.com, mjambigi@linux.ibm.com,
        dk@linux.ibm.com, twinkler@linux.ibm.com, jaka@linux.ibm.com,
        wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: Nagamani PV <nagamani@linux.ibm.com>, stable@vger.kernel.org,
        syzbotz+89435e7383b82238dd91@linux.ibm.com
Subject: [PATCH] net/iucv: fix UAF in afiucv_netdev_event()
Date: Fri,  8 May 2026 18:38:36 +0200
Message-ID: <20260508163836.2207648-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2NiBTYWx0ZWRfX6ne6nNcUN7hI
 DGA3JPcn754O6DPoQp3kwCUwybpTF08uGQnG5JUpUIZsS9QZUt7xMdxAhYz0zsSNPIxb06yKpPg
 QXiugF4VQ/aQwmC3oS3jVFKHynAwEamNhRmJHwWbx1wB1qVoJKbRWPZE4ScgJ4FrOBIPBRQ7/M1
 LswjUaTbSif8LRpFH9n5c9+ksuZCKDOm57DPjOPsDgq4+qzu0mmuZ2JvNSzW3NQGTsvoE/kBatZ
 UnN0GOwPDFfSQ4jz05tehNOnB0bf+KCTtP5P0jch6EESX9F8p/1welR/ZAQcTOH+JbUhnNh+U4t
 bE9MMNuMhkj8SUmq00l94U9Q/L+Rs7Tlm+c66tZexEvAdUeCc0IRPgfstnb++i5BYZ/p6/K1xKF
 s1enopHUDmNJL685LtnVAZvhE0oPd5K+tGzKY6SIBOMyXHsq97QoB1Y4fa2zkKjQh6VkuFEE5Ew
 lyFQq7GPRBpjdWRjlpg==
X-Proofpoint-ORIG-GUID: JEVlk-_3wMEdY9IuZUt8xkW4xhBih6Mg
X-Proofpoint-GUID: JEVlk-_3wMEdY9IuZUt8xkW4xhBih6Mg
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fe119a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2L6bTA5ms6rrk1lURLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080166
X-Rspamd-Queue-Id: 4048D4F9884
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244795-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagamani@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
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


