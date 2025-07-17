Return-Path: <stable+bounces-163259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F8B08D4A
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 14:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557FD16C3AD
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2D28982B;
	Thu, 17 Jul 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="awCJBT5i"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3663CF
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756374; cv=none; b=DSCoKn2uHlN8YlExlJNRachfLDfD/tGjVrZmpjsTtG4ZL4M1IEKISl3ijoKVYaxkxhQWA3HTaapLlk2VnIHFyDg7C28zjslQQa4JwqIjLINvqTh+ySYdHhfnEWpiDpqMRn4AUlpHl93hFTS5WRkwKKte9UTITi9r3Hp/ywwxRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756374; c=relaxed/simple;
	bh=ojKWqS9JZTS+XNMZQ/VRbHHFLclETBNYYqPeFVXFs3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4/stnHy5BvRhqgPT9juhGaqXaf/w/+J6IuCctopgXgGi4KOB8w4gKQRK5fuM79U93w652aeNjja19FmkvCE1Y1gx11ynC/2oDHgoMZUsNC+KIwxtxwJ4PwreJoCCECaS7OxO+V6UBaqrAHY4/mIG9htAml452UEaiTyL8C+FTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=awCJBT5i; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fmd1003312;
	Thu, 17 Jul 2025 12:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=w6xGX3plX6FLUP/n
	6hvszO7+ZC0lPPimS4Sa/FFdlY4=; b=awCJBT5isYFWo/wsdPQpGpy5PKgH+uZn
	ekGAnrPn9d2KvkUA/b7XufS0lEVLUMGJ/Jj9NraXOUN/iGqUHMMB+6HylcDC67zj
	vqqeUWnePKfkNIT1RJ3ycGBVTz1t+Y4cgRawhXuJq4vqAw8zNGA04/wNCYRHeJhb
	mzazmIjWiWYKo8QDcHWlu7XL0YV9FMArt3IKe5Boma7/HPmgRM5APZuZzijn/UKi
	hiZkoiCFTgelNR6GgDHVZG+mTg2gSQsj92FKduLlVTZTAAXkXK1o/GqO5q9fOzdM
	CBVOHu5BLz3S0h37ThYWvhadht4IUGkQqbDY82udnpWpfr4IewH61Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr12t8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBTFA8039623;
	Thu, 17 Jul 2025 12:46:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cpxxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 12:46:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HCk0nt024687;
	Thu, 17 Jul 2025 12:46:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpxww-1;
	Thu, 17 Jul 2025 12:46:00 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: edumazet@google.com, tavip@google.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4.y 0/6] Backport few sch_sfq fixes
Date: Thu, 17 Jul 2025 05:45:50 -0700
Message-ID: <20250717124556.589696-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170112
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6878f092 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=iQtb2e-5LX9kfVXdYGEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 51y3ot68DX7ofGxiuw55Dk0tskpNwU5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfXyEHssz/OV4lO tbNMMMvJ2h6Rl0OWMPTpSy+wWL/VA4blFtigE+UX3rIFOFVyN27kf8SLk19p/wqQ3E8R+Hw5vAT ToSUvXbVSx3G2gLO3W/bqscsGNdGu49ji6HSPl270KCt49fXM+7t6LLgPNH/elm0ZjCXVu5nM9l
 t4+2PgjKj2zXPRzHhAiC+dN5fcToVBxtbNf0GmcR8jhu9/0Sy7L/55c0X95NUd9WgBH77xiFYed HrxmuVcYtVcoerQrakk2/KctHhzCtHqxJctq9AR1UY7D2SCnzQyppc6jSHkts3fNYs3NDPkoqS7 M6NmfFQPH6RxDWVKrO/x3vER7aeVZubEbylwUDHDDBN4GUqLbkLkfeNjmwKEApZspBpJcAiP2PO
 YOR64BAGnJcm/oez+JpdBI5hIeq3B3zpHyLmOPwKabaf6015jRb80bL9tK1jqcJOfPC5TJx0
X-Proofpoint-GUID: 51y3ot68DX7ofGxiuw55Dk0tskpNwU5M

commit: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
fixes CVE-2024-57996 and commit: b3bf8f63e617 ("net_sched: sch_sfq: move
the limit validation") fixes CVE-2025-37752 and commit: 7ca52541c05c
("net_sched: sch_sfq: reject invalid perturb period") fixes
CVE-2025-38193.

Patches 3, 5, 6 are CVE fixes for above mentioned CVEs. Patch 1,2 and 4
are pulled in as stable-deps.

Testing performed on the patched 5.4.295 kernel with the above 5
patches: (Used latest upstream kselftests for tc-testing)

$ uname -a
Linux hamogala-kdevoci8-1 5.4.295-master.20250717.el8.rc2.x86_64 #1 SMP Thu Jul 17 00:57:21 PDT 2025 x86_64 x86_64 x86_64 GNU/Linux
$ python3.12 ./tdc.py -f tc-tests/qdiscs/sfq.json
 -- ns/SubPlugin.__init__
Test 7482: Create SFQ with default setting
Test c186: Create SFQ with limit setting
Test ae23: Create SFQ with perturb setting
Test a430: Create SFQ with quantum setting
Test 4539: Create SFQ with divisor setting
Test b089: Create SFQ with flows setting
Test 99a0: Create SFQ with depth setting
Test 7389: Create SFQ with headdrop setting
Test 6472: Create SFQ with redflowlimit setting
Test 8929: Show SFQ class
Test 4d6f: Check that limit of 1 is rejected
Test 7f8f: Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)
Test 5168: Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)

All test results: 

1..13
ok 1 7482 - Create SFQ with default setting
ok 2 c186 - Create SFQ with limit setting
ok 3 ae23 - Create SFQ with perturb setting
ok 4 a430 - Create SFQ with quantum setting
ok 5 4539 - Create SFQ with divisor setting
ok 6 b089 - Create SFQ with flows setting
ok 7 99a0 - Create SFQ with depth setting
ok 8 7389 - Create SFQ with headdrop setting
ok 9 6472 - Create SFQ with redflowlimit setting
ok 10 8929 - Show SFQ class
ok 11 4d6f - Check that limit of 1 is rejected
ok 12 7f8f - Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)
ok 13 5168 - Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)

Thanks,
Harshit


Eric Dumazet (3):
  net_sched: sch_sfq: annotate data-races around q->perturb_period
  net_sched: sch_sfq: handle bigger packets
  net_sched: sch_sfq: reject invalid perturb period

Octavian Purdila (3):
  net_sched: sch_sfq: don't allow 1 packet limit
  net_sched: sch_sfq: use a temporary work area for validating
    configuration
  net_sched: sch_sfq: move the limit validation

 net/sched/sch_sfq.c | 114 +++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 39 deletions(-)

-- 
2.47.1


