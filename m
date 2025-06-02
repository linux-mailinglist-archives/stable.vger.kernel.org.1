Return-Path: <stable+bounces-148939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E1ACAD3B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439BA17BF69
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5F1F461D;
	Mon,  2 Jun 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="abk8xrq3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682831F098A
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863999; cv=none; b=tB2V2Pyb5DNiCEIirMf9mL2mAEev7j5oXuo5cM9ps/YkxXs5J1fXGCVtNlcqyeo66UNy/h66Q1mx3i//Vy16vllLPNFcBwncqLw40iaoJXgr8C+Ya/eg8mZNX32SqZxOISHF4pVjS8AprsWmfUyck+IjwLQzQBaUtYqdjQUN75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863999; c=relaxed/simple;
	bh=8KSedRRDLYhF//9hnYl8a0H2hJvLx5UE6PvuSn89iUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDaOaeZnwxhQawbJNipJDQ2J0lPaz1OAnJ4qbpBOZ1c09R8nQ1BCHMT2ngI9aT9filJoUwWzfyoS47b5bj8AADwrrhbQePPgsjfDjs63+/8Ctj17eEitlQVjEZHjhtSSqqY5mjBQLcLX/7f9wpr1wiwX/oPESIlILVozyN0EeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=abk8xrq3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525uF3Y004998;
	Mon, 2 Jun 2025 11:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=CfDjhvQigRmWcz+CuhlX6AvZKsSV2
	OiOmpQmK2j9khE=; b=abk8xrq3xSmGyzaxVFHwBna5bmg5JiX6X9pHDoDNY4xwv
	5dvXdaucHCmels5qSn3JScEk4Ra5L6aAIuxljx2+hAqm6SVRlbeZhLol3N8+DXBn
	whuC8TofbjV0U8NUx2capxZuC3xRACg/F8adHKPdsFmm8xrts9mxvg+J66bw+N90
	cp2P/f+F2aeFlZ0Jtxi1JwM2GIIbniHzHEQx8C0nk71SElANlpKwIPb2C64Kyxs7
	jxT0cfiVIL/O58dHKAH3jRNqECAnHFG8m1uGwNbDBLZpgdmtlVy7L0rB50fNjWES
	n5SkMEBYS/EMndZ+8U6VjzMjiuIURNkYxpSLmeP3w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ysnctcna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529ZsOr039135;
	Mon, 2 Jun 2025 11:33:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77vhux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552BWuca001684;
	Mon, 2 Jun 2025 11:33:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46yr77vhuf-1;
	Mon, 02 Jun 2025 11:33:01 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/1] Manual Backport of 099606a7b2d5 to 5.10
Date: Mon,  2 Jun 2025 04:33:00 -0700
Message-ID: <20250602113301.3475805-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020099
X-Authority-Analysis: v=2.4 cv=Jdu8rVKV c=1 sm=1 tr=0 ts=683d8bf5 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=cixntLcyVTLVvfsobb8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfXyNIOyIVGfBrV ktK1V6Xu3f79srrd4w0S1bq7yGbLZgDZ3shoFa2l01puyzAxv6ParH9NBJtpHU6X+sTE/pvvDF+ WuUu4PvasOTDK9ZCxWkIbsfetzmDLj7F4jPgp5UdsjAIiaGAqLH5m0+5ViD6XLDcappv2I7292r
 iEcrsXOGkx9mAyJvB4zK8418JuMVUR6K75n0icDT4u2AAYfthTfYjRHhcCLcr1joYEjz0mK5AuM eb6UB1YRXxUdwxJ+tax/ZqjIUECNJBSX3+NG6X5BPpVBtIzCwf/1G/5cjJREtoG8Pg+CQ88OAwp bIkymP/ni2Yn/Avq9Sb0r/XhB905U4q7WQQkQJIHlbELKqC2S6KRBXZarM/8+XYcsrEUYw1TWa8
 gtD+nw4y0WsCSZJZaW5JABeXOJJ78061uHj/owALA5avyUG9p3kjnp9d4BdQuTCzzomDbVtn
X-Proofpoint-GUID: LWPjPIADqO7-S79GFkKNeZQ-FKaukyki
X-Proofpoint-ORIG-GUID: LWPjPIADqO7-S79GFkKNeZQ-FKaukyki

The patch 099606a7b2d5 didn't cleanly apply to 5.10 due to the
significant difference in codebases.

I've tried to manually bring it back to 5.10 via some minor conflict
resolution but also invoking the newly introduced API using inverted
logic as the conditionals present in 5.10 are the opposite of those in
6.1 xen/swiotlib.

Harshvardhan Jha (1):
  xen/swiotlb: relax alignment requirements

 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.1


