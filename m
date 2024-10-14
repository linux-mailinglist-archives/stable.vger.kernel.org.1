Return-Path: <stable+bounces-85052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9206099D43D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445F01F21284
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAE1AC8AE;
	Mon, 14 Oct 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrsoNnpi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F461AB53A
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922023; cv=none; b=fZtqRESLULa/9amULpmR9q0mBV+LCbZ99pT1PUSP2FirZTaYJdoezlbDadFB/CJpSspXgg9V+1rmfwK4VOvadNWH0BjqC1s8E4pMztQaS+C60WBAvyZ0ZyaPzyK8sJOvXy2SetL8wQElz1IxIrjs/9hp9PjCaEzKlqq0o9KiKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922023; c=relaxed/simple;
	bh=WYSp7ZoZEyPijf1hEQ6LZbUfFxdbvCBeCjlq9cqrgJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkKeeKaeP7IbJGdN/20LpMcwAK474RJRL06ZbROYQpYAEXf3hj56nHKLHjaaDkHI4l0AkW0epyYdpiKzArhlg0iihrvwZxtqDo9pDEpZXq4GgLsouqtFJqkfPjKqLE/FWonmrFy6jpkD3FOIJAbz26RCvSIRnFGN1b9O+eF9Wko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrsoNnpi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfcn5024102;
	Mon, 14 Oct 2024 16:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=QpOfCbuktHSThkGSRy14M1MTgynTF
	Oo8SmeAZFLnvMo=; b=FrsoNnpiXzFlEJTZnW9LHVu31Sy18iQLEoqfMZuhBfEvl
	rhlvpHe6zKtn9i/hCRMrgRqcw2yRows3zdBO2Vrs+ptKnmIkHiAVVaUzAxRx65YO
	kHV3eyPMniE1CoPoL3vCldncpd0iBtppv+iMWhxG3ax3/ThKbdpsZVULc3gAkFyN
	mpojQkzh2/vqz2NyvQp7lSnd5JCgDp/AEPBde1uDh4HOINwz4t0Xs9U/sF2dUleW
	8FLmfLZLR2oMIb+P0ZgUdEuWcMoKsbHCNzkjKoR32MxOHhEdBVODoQfYiBgrdZR3
	kffnSbJWmBlMrOeJD8ZpxCAy02VsyMaUudVnJzNgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt6u5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:06:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFPRl2038561;
	Mon, 14 Oct 2024 16:06:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjchk26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 16:06:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49EG4YYe036561;
	Mon, 14 Oct 2024 16:06:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjchk1a-1;
	Mon, 14 Oct 2024 16:06:53 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org, mingo@redhat.com, sherry.yang@oracle.com
Subject: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Date: Mon, 14 Oct 2024 09:06:50 -0700
Message-ID: <20241014160652.2622878-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140117
X-Proofpoint-ORIG-GUID: dQPMOF0vXd-D7PnsDgw6DXHHwN1h0hf2
X-Proofpoint-GUID: dQPMOF0vXd-D7PnsDgw6DXHHwN1h0hf2

The added test case from commit 
09bcf9254838 ("selftests/ftrace: Add new test case which checks non unique symbol") 
failed, it is fixed by 
b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols"). 
Backport it and its fix commit to 5.4.y together. Resolved minor context change conflicts.

Resend the patch series after backpporting to 5.10.y first.

Andrii Nakryiko (1):
  tracing/kprobes: Fix symbol counting logic by looking at modules as
    well

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

 kernel/trace/trace_kprobe.c | 76 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 2 files changed, 77 insertions(+)

-- 
2.46.0


