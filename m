Return-Path: <stable+bounces-132660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50188A88BB7
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EA43B591C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D51EE02F;
	Mon, 14 Apr 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KHD+zsEo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DECBE4A
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656634; cv=none; b=h6w4g5TIwslb5hOnD4zHNCHZ4k+B+VRAUCm1FsYryZuxyk5jaTJ4azw0TwEjFUsQwqb2ssCvnSHHzmi+PWrO5D5smoQVvU12GFoORtavURFTyHCZVdO7fk8HrDhC4PSPVQNX+ZizivXVKwg3UtBMsSJ+bf1eBsnww475iNMQCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656634; c=relaxed/simple;
	bh=SgOy1y6UfrQYnxkJEdBn1czkmAR6l0N+1lBx+m9hivQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2T8tPxxCrANUQ5XEZ5vmB/cO/1x3uSf5OB0a3in2/JeqnqHX+E8s2Y7HhY3Mz3GT7xfzTGfS76ObPWK3LePc9yPqjqrLzV6jpjObshsq3S02A9Gopj/KIUnVPYkWCEG08R9FYEFYK0/lrVm7cHxiKYGaRcKS0UolqcaZmYHGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KHD+zsEo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIMYoO021050
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=/lAaJk9EotDuWfSR
	tertAWEYf2G+KRVqo5BNugr4gWk=; b=KHD+zsEoG3VcQQgUu2+BpicXTyE7jA6L
	w1re0nIFh+pq3A/a8KxlaeN320DeOdmCW5bWyzu6ne9qfDGWQdmOop8fzkKdzVss
	/WkzOQyyVUAT2MFNaRRdElaUpWcwwaOOzoAIx2ojJ+7EYptF/Ey/H3bZgVjXTMlx
	Dp4fJjV9IKVMyPKODepUqh7GgQnR+NQtwMF51ob+EpHPysYJR0NAgKh3b/7oSvuG
	Tq3lFy79f/LFVhMnsKEbA9usvq6D1mJiwn9dsxSLCVOAbc6Fqtrc92iDi1N3oOhz
	AS3Qn5BQfM7J3I2Il4IshRSrh70SoEH022WThH+Ub11++CqafH3DWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju81tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHTGso024735
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d4y5f4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EIoUHA035509
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d4y5f48-1;
	Mon, 14 Apr 2025 18:50:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 0/6] Few missing CVE fixes
Date: Mon, 14 Apr 2025 11:50:17 -0700
Message-ID: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140137
X-Proofpoint-GUID: DKxhCxbiXRSetI454oX1D9c_9EuUuduC
X-Proofpoint-ORIG-GUID: DKxhCxbiXRSetI454oX1D9c_9EuUuduC

Hi stable maintainers,

I have tried backporting some fixes to stable kernel 5.15.y which also
have CVE numbers and are fixing commits in 5.15.y.

I am not a subsystem expert and have only done overall testing that we
do for stable release candidate testing and not any patch specific testing.

Note: All these patches are present in 6.1.y.

Patch 1 -- minor conflicts resolved due to few missing commits.

Patch 2, 3, 4 -- clean cherry-picks from 6.1.y commits and will
therefore have additional SOBs from backporter/stable maintainers

Patch 5 -- Minor conflict resolved as 5.15.y don't have folios.

Patch 6 -- Resolve conflicts due to missing unrcu_pointer() helper and
other commit

Please let me know if there are any comments.

Thanks,
Harshit

Michal Schmidt (1):
  bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq

Paolo Abeni (1):
  ipv6: release nexthop on device removal

Rémi Denis-Courmont (1):
  phonet/pep: fix racy skb_queue_empty() use

Souradeep Chakrabarti (1):
  net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Trond Myklebust (1):
  filemap: Fix bounds checking in filemap_read()

Wang Liang (1):
  net: fix crash when config small gso_max_size/gso_ipv4_max_size

 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |  3 +-
 drivers/net/ethernet/microsoft/mana/mana.h    |  2 +
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++----
 mm/filemap.c                                  |  2 +-
 net/core/rtnetlink.c                          |  2 +-
 net/ipv6/route.c                              |  6 +--
 net/phonet/pep.c                              | 41 +++++++++++++++----
 7 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.47.1


