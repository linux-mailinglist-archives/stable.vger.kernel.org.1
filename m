Return-Path: <stable+bounces-152668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFCAADA2D2
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCA7A773C
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E707717332C;
	Sun, 15 Jun 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CKU5RFOw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E21B0F1E
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750009921; cv=none; b=k3fAwGI0+aCd4xvW6LqWMqS2vkwUE06b1k69ez10Fxj4jpmbEoFsumLk/qWiv9UyAiU3Twrt8ZXsplAvvR58QzGr5oEIzLlX4DatPfeghkqf1A0Aliypg5PUgf40mDH3oUVYR4mK5XvatOHqTIuXcXWqr7kiqWFkkYoqNr14c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750009921; c=relaxed/simple;
	bh=tlpIXuZd4arS1dc1PzODy+qd40N2cDSYd0+ZjM54su8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqsUGQu1H0bbtqBztlSHwUhpjNCwT3ZWCxmDM5ML9eZ9adYDvvKXRGx36C5SaKuao0hqvgpR+AA7bMTvGE8bBU/nWpVw5GVy8o90e4TIY2UXVmg9A0TqOBsoZPNCI1XYyCfckwD5KDFaoZR9WS3O02S9CWBEN3t1SkMM+sEOu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CKU5RFOw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FDtpA0012029;
	Sun, 15 Jun 2025 17:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=t3RNXxys5uUlVgnh
	4E0DDtUyHArtYHZyYsb6sXeHxqg=; b=CKU5RFOwrEwBHo2UBll/pLd3Ro9WJ6V/
	CTC5XbJzmRPoQDeT0bNPSZPImBdA3ttyP/vg3nck1lxu1Bl5VtHMnKnOeEBUDOR+
	qhgjiQNhQaxF5nAm0NRVZwxKDTlxHflfGPdrrTu5r1cnKa5SaV+eUoegcSPg8ghi
	QTmSgZYFyVVnPaShCqv24covotqjn0TFiW3AolKe9EBdL74ka63OaJP6EfC9dXps
	U3YcQHLLppie/T1uxk7AjhOGgso+WdAqb1xgcJv5e//BL/36mmwtVyIACesrAVrU
	1HWRTsLH8uwL8WLEJol9tsZ4JmJxD5bavcyOSfwojVzCryPYnOdakA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914eh9bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:51:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBm7Y8031671;
	Sun, 15 Jun 2025 17:51:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6wk1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 17:51:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FHpugH014138;
	Sun, 15 Jun 2025 17:51:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6wk1m-1;
	Sun, 15 Jun 2025 17:51:56 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 0/5] Backport few sfq fixes
Date: Sun, 15 Jun 2025 10:51:48 -0700
Message-ID: <20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506150132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDEzMiBTYWx0ZWRfX0EQzcevTi/of v4cfML1XfNs77PIL11GTwy7H0yQ4/ZlQB3mQcShEASQvDvgc7SXodkYADvQD2m5YjBNnFNI+MqD hIAEGQNPE1kcuvdRoJwzfNqWPy6RrBilSd69zgPUgleweOgwDgnr99S0MbRLVKwkbhOk4SIGCnx
 sSuMLmRg+bFTpiDUkCQRQblULYCWxO0T5cxtv3qtnEkcaB5PhHvbafd6B+MVmYKgPcyf2ndqJtZ I6NFbVIMYTDzACGDvwkq/iKGKgwX0GgamQQbMdN9Nz9W2+P0jGZXFGKde9sA01dHoBoyhOqr1zb +SXnjLOcJ+xj4vw7eOTrac8tMRtjH7+mXxHydpMRGzbhw43ZSUodjH3PeP/b4kT7uLbzAb0d+Mf
 QLQVnMSxA6z5Z30yh2Tu58+0L6NjoebKZpku6XJM3nEm759K1nTx/+mF5w2kLEV7zEcmhfe6
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=684f083d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=E6zq_qrmH0oakNB_RFgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0t9GkNB1H79DoZYWG5K3ftlqjSX_AIP_
X-Proofpoint-ORIG-GUID: 0t9GkNB1H79DoZYWG5K3ftlqjSX_AIP_

commit: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
fixes CVE-2024-57996 and commit: b3bf8f63e617 ("net_sched: sch_sfq: move
the limit validation") fixes CVE-2025-37752.

Patches 3 and 5 are CVE fixes for above mentioned CVEs. Patch 1,2 and 4
are pulled in as stable-deps.

Testing performed on the patched 5.10.238 kernel with the above 5
patches: (Used latest upstream kselftests for tc-testing)

# uname -a
Linux hamogala-vm-6 5.10.238+ #2 SMP Sun Jun 15 17:27:54 GMT 2025 x86_64 x86_64 x86_64 GNU/Linux
# ./tdc.py -f tc-tests/qdiscs/sfq.json 
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

Eric Dumazet (2):
  net_sched: sch_sfq: annotate data-races around q->perturb_period
  net_sched: sch_sfq: handle bigger packets

Octavian Purdila (3):
  net_sched: sch_sfq: don't allow 1 packet limit
  net_sched: sch_sfq: use a temporary work area for validating
    configuration
  net_sched: sch_sfq: move the limit validation

 net/sched/sch_sfq.c | 112 ++++++++++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 41 deletions(-)

-- 
2.47.1


