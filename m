Return-Path: <stable+bounces-83105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B089D995A14
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B621C21D2E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773C215F50;
	Tue,  8 Oct 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1DUT4T7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F5216429
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426605; cv=none; b=IO3x0LLrJHt4rDMuHBaISk3N3RCIUuEdiC3yTDhfOmgAENRlFG/8LVrWfMw3DV3d8TnqYWGpCwZyJcLuYWcoBA9S3ThyroRiKOzKxjpIVV9wQSJJHXXUH50Uy49pnl/Z4n+YMXDa12p1Chx1vv50xjT2yRT7eW0xFIh9WWs/KfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426605; c=relaxed/simple;
	bh=N72UdJJ940sFOr3Ie/IaJEkdbFl/7c5qR+/FbnfGxDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYhaCTkPbe6kP3KcNYaybrc+iitMqSIPzHdAEoSi7iyGx252HmFmlxOnspLulPD4Tf+nCqWy3ckXFnCazostxdZkjJJ6QS2p6c2sGh83euRKdh1YZtIo2qivrcNme1rhzqvuFC90E0IbSPCNRZemr3Op2m39UPKewrxB+m9H6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1DUT4T7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtaJH004838;
	Tue, 8 Oct 2024 22:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=UyHHp7ENCVoiYoIyUH4dOtcW67xLP
	ctxOCtJeE3RDC0=; b=o1DUT4T7BicMPr7QAbVfRt8kuebFia/ayqD+DYUZqXRwt
	HLfKaLiNJrY55C69FJ3dZrQVekUkalBDr/GtqzhYbn0ZIlrCCymMaz14ZneWT3Sc
	F/IHYF3zo8LWmh5hh0nqZL9RuyP8I+HwVTl7Bl+D5U3wBqMmxj5y9kMqFENcvMzo
	0goQoMOJ4nK2XQVVsM0i3N3VdgaZYcaugLFlfvWIOB6S8cRusKA1WRFgn6mavTZm
	BIbHa9+RUgYsB+iSLDawbYaT/k0snrR69MAeSEeU1RmukyOfdYvQoP8ZiHsnoFJU
	f5kc/azRhpRxnszGcVq0ajA2X1oSkJCykLtcmBeKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv70m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498KwX6W019093;
	Tue, 8 Oct 2024 22:29:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe3rdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 22:29:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498MTsjF036464;
	Tue, 8 Oct 2024 22:29:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe3ra6-1;
	Tue, 08 Oct 2024 22:29:54 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, jeyu@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        sherry.yang@oracle.com, flaniel@linux.microsoft.com
Subject: [PATCH 5.10.y 0/4] Backport fix commit for kprobe_non_uniq_symbol.tc test failure
Date: Tue,  8 Oct 2024 15:29:44 -0700
Message-ID: <20241008222948.1084461-1-sherry.yang@oracle.com>
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
 definitions=2024-10-08_22,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080146
X-Proofpoint-GUID: yStwxM9SQ4l1NAH66rads38Tj_adKezn
X-Proofpoint-ORIG-GUID: yStwxM9SQ4l1NAH66rads38Tj_adKezn

5.10.y backported the commit 
09bcf9254838 ("selftests/ftrace: Add new test case which checks non unique symbol")
which added a new test case to check non-unique symbol. However, 5.10.y
didn't backport the kernel commit 
b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")to support the functionality from kernel side. Backport it in this patch series.

The first two patches are presiquisites. The 4th commit is a fix commit
for the 3rd one.

Build and test case passed.
[73] Test failure of registering kprobe on non unique symbol
	[PASS]

Andrii Nakryiko (1):
  tracing/kprobes: Fix symbol counting logic by looking at modules as
    well

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

Jiri Olsa (2):
  kallsyms: Make kallsyms_on_each_symbol generally available
  kallsyms: Make module_kallsyms_on_each_symbol generally available

 include/linux/kallsyms.h    |  7 +++-
 include/linux/module.h      |  9 +++++
 kernel/kallsyms.c           |  2 -
 kernel/module.c             |  2 -
 kernel/trace/trace_kprobe.c | 76 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 6 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.46.0


