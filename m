Return-Path: <stable+bounces-78163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504DB988BEC
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB2CB21B1B
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38788189513;
	Fri, 27 Sep 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gY3a76d7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C841779BB;
	Fri, 27 Sep 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473475; cv=none; b=nkzyMly2YBu/9OagudiisNlMNsY8xQAaIpbycEKo5vW/Tj/xk9UBQ9kdzyXzy5naAe+SCNE59+MzjyZXpC/Z5sG7XBUjXIDFksalGT/6MXV5FPBAlPP9YdH7i+WBOD9Q9I8MLj/u6CUOhOlfpaqVI0SxKnD2Rer4ybXUCNS/XsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473475; c=relaxed/simple;
	bh=83ZFatQgcedvirDU6wJWcrqFM39uGXyno63vdVIUjnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEUw+SnV79lxFvx/okUYlYvSxiMHuEWpW0bDHSJXzoOnyLXHAoipJx2KAgCv69GI8LMt/LS0A1/GKvbVUdxc6IQi2HQ5S7sQhrQ1rYGK42F2agmC/UJ60lAkkVtwST4+Tdnqu9i6bHuwWahWzbAbZ1yyaWayOcdyz4uGQQb2FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gY3a76d7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RKVl1S024668;
	Fri, 27 Sep 2024 21:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=edu2c8j1yOuX4c
	Iimrh7oXbhUwEIvY3NLpGWV5pSFaM=; b=gY3a76d7h3HpjEPgrMbPaoFGCfbWyv
	2eDy39+YPmMtyKNPluq7iPy7uRUCvkccTeBiDZaReKL8bcIYjzHs0EoNlKjvf4Oi
	INCQFxA3BRB3ocbswyp9W/9sDcV38hWCOGPsXKTsG6+nmKowIG+nV0LQe47ipqff
	KbAkfizf/PPqMN1Uj/lPqV0SyG18Idjm7PDjiD/QWSLq6nfg+6W6UQbXyqd5yMej
	8no5/Zmeo8XDQ4aEEUt3GVgO1AQYnfZDV91TnOXbT92Ury4GgZdoA9LR9TDZX+Tm
	l9olj1ZV7+GVLzdg33jInzG9lyW39027zs1oSL5zk/9FASoGd+GpX1Yw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3e91m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 21:44:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RJe8He025226;
	Fri, 27 Sep 2024 21:44:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smke5aek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 21:44:01 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RLaw32030299;
	Fri, 27 Sep 2024 21:44:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smke5ae0-1;
	Fri, 27 Sep 2024 21:44:01 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: rostedt@goodmis.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Date: Fri, 27 Sep 2024 14:43:57 -0700
Message-ID: <20240927214359.7611-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270159
X-Proofpoint-ORIG-GUID: cprpbUyTQYLyYY3tftiemiIZVQ43xKTC
X-Proofpoint-GUID: cprpbUyTQYLyYY3tftiemiIZVQ43xKTC

The new test case which checks non unique symbol kprobe_non_uniq_symbol.tc 
failed because of missing kernel functionality support from commit 
b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols"). 
Backport it and its fix commit to 5.4.y together. Resolved minor context change conflicts.

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


