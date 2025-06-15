Return-Path: <stable+bounces-152660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDEADA251
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11F3188AE7D
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C3266B6F;
	Sun, 15 Jun 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNblhtHo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB715442A
	for <stable@vger.kernel.org>; Sun, 15 Jun 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001080; cv=none; b=PMAho4usLuczOiDEZ6VbJItkoYMUgL2euMsykOG9M7GANqOlWd3PC/pUKokQE8GIFHr7U7CVrfC/wf23WAmi50Y2+hytctxbPURDa6/b0Y+kylqP7syGBIm1oaCzENI+I1ZjvmYIP52n9aicMV2pC3mFCG9L6WOClaiwH4moaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001080; c=relaxed/simple;
	bh=CM6zSmgQJr2Wxw9vv2fQpkOWPbWSwsBFYyJzRiN2Bpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GB6tHcpzRr1Ur2Z2BGMdFbLX4bEcr2NXD0L6LbSDNCtddqbbc8LZsRa0toKZbP9xwrkZHKFZV40Vfglb+Mh7XR1o37nBFVzrD26xZ760hBIfT23q3zuKdEVgtdPgWpC6oCvAZGMCFBAHDW1oGxa1fEC1GaGEMUnGCI0/2f4gvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rNblhtHo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FEcAC1023482;
	Sun, 15 Jun 2025 15:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dN8JLPDM64GcFNEv
	tBR4I8lAogr4KxlPQ2J43q4KAy0=; b=rNblhtHoVvaKlui1EBHLv6IUAg3WPTnG
	YBVzM25lCAZ2qzMb4t1kFisPsoPr42U+BX4pZ22E24bNoEMUyPp3ls0pcnLJzrkR
	45XDY7g/FF4maabZguEHjUfk98tSrw8jLoiK1aSoW2LUAuCeO1bNhyzyObGO71HM
	LyINfe9SqLprHhA45stgOxxpcMy6aE6T/ydiLwrunOCbs4X91ofHqN4TQA67bBOh
	a8FZONiVkN2KwBramTHUbwFH+R8Uq2w6fYAqsfYpbGv1N2VOwoNgLOSYOsBM87Hl
	6enYyvQhOgRtMRgRRkrnXBTuJUr+/Eu+YrrFxYP1zz856CEl3OvWUA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn0n5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FB2YXK034394;
	Sun, 15 Jun 2025 15:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh6v521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:24:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FFOTZo022730;
	Sun, 15 Jun 2025 15:24:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh6v51x-1;
	Sun, 15 Jun 2025 15:24:29 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: tavip@google.com, edumazet@google.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 0/5] Backport few sfq fixes
Date: Sun, 15 Jun 2025 08:24:22 -0700
Message-ID: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-06-15_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506150114
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=684ee5ae cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=P6A9-gxnbDboVX8-cAIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XheCHBym2ha0g6BFeTej97MXFJS9mL6V
X-Proofpoint-GUID: XheCHBym2ha0g6BFeTej97MXFJS9mL6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDExNCBTYWx0ZWRfX6SKy7f17eL6K l/yr7VS1Sy5xSJEoaHVf2WwzBHbiy0sftyN7K8vg3ixWPe3M6fmZc1lPOi52fFCi2XIQSYjVdfO L2SJKLAUnQ3Vt1Msxq/nwVmmLvKw99JF/K1+wBgySwBfnYkTVZug0G6PEVrE2a5hfC2fVgu0P/6
 J36GqML6g+7r5i/9s3iZ2WaIfiYNR7z5DkAj23MzJMPca5lqofkjZbk6AU/5T8s/53tbwMuzA/k iKviey+uBWw6XtX1ctK3Vms5EEEo7/nCc1HtnW1m5L9ZB8CVgyLslrUEJsXiYu54EHSc3mMGE68 dhVHfHVQL20PcI3DZRet9Y5e7UXyBqUhOTkuY+QMXN58Lk/nlM1oAcJzfgrol4PIS4avUmRWmfe
 e2CollJyq1WOkEqE8GvMUtsnnOZoLIs4Smp6Pi800Pd8aqg1vmnCo9DKOoIgAWB+VIHbj9MY

commit: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
fixes CVE-2024-57996 and commit: b3bf8f63e617 ("net_sched: sch_sfq: move
the limit validation") fixes CVE-2025-37752.

Patches 3 and 5 are CVE fixes for above mentioned CVEs. Patch 1,2 and 4
are pulled in as stable-deps.

Testeing performed on the patches 5.15.185 kernel with the above 5
patches: (Used latest upstream kselftests for tc-testing)

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


# uname -a
Linux hamogala-vm-6 5.15.185+ #1 SMP Fri Jun 13 18:34:53 GMT 2025 x86_64 x86_64 x86_64 GNU/Linux

I will try to send similar backports to kernels older than 5.15.y as
well.


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


