Return-Path: <stable+bounces-80774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258479909E1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7E01F22416
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF91CACFE;
	Fri,  4 Oct 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e3bF5s5F"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8401AA7BA;
	Fri,  4 Oct 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061425; cv=none; b=Pe07pyqrS/Rf8rNE7H83WzJSIeT24VtAPdoOzQhgr8IRNBekikNUmCrLK3XRsxNFng24dhHlhHH33mxmEOYi3Q+i9gbvqp0ghy5fXa2HbnYamv7cb001bjT8KCvuCgtQt1WF8ggqVxFejNSSMtZTEZoD0jE0oc/ot+7GpgyJh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061425; c=relaxed/simple;
	bh=ojT71JeCOkm2cujKgA99HgLFAxry+kQTbscoJT3AMFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euTIal7fIehG0Yyy6skUI7KDkS7j1oOLC9qNmcL25zjZINoYmHMUsbJ/yRIri2WxFGsVZTcwXuSzOUmLbgdYpMuSLvFjy+SMrG9vkYPqkWfGOPjElh6F3a1yCLO1SbWGyv8a656xEBKp4gckLfDfXds+UVMdGFjdl1/rPVEbXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e3bF5s5F; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Gfr9q024728;
	Fri, 4 Oct 2024 17:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=mLpGajwr/fVaNM
	PK3CcJGTfM792ZV3Tl1fXux5mdpfQ=; b=e3bF5s5FGdz7sqMpo7kC+g1xZsyxcd
	grxJavVPonNjgkcZ9W7fSXdEIZzdEcjSo2M8EkHTi8vKUggC0R5mNDBlq9ZvZtQf
	TTvBl2EWEV5Gg+cM3y0JbkJhIBwtyXoU9DQapREJfEx/WSG5K/g0K3e0VCOOs2+n
	D/j8lvKpGklYptbpKB1hyBO6IMJsJHqxt6DPDDN+W86swm1ZIgn2mj6E9ftl3d/1
	Te6nlXOUGesCMxGKc6W62tJj9WACfJp1cp1oIlhmlIG0VD7/zjZeqvLbAw+NH4RC
	PSHQD6wAt31fhFwq1Hv23VQJLYuq8JsmtD2CFQn3w8OMT3xV1Hm0P2+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422048a39b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494FHVY9005957;
	Fri, 4 Oct 2024 17:03:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056tdww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:03:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494GxlJk035743;
	Fri, 4 Oct 2024 17:03:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422056tdvr-1;
	Fri, 04 Oct 2024 17:03:31 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org, kuba@kernel.org, gregkh@linuxfoundation.org,
        roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.15.y 0/2] Backport fix for CVE-2024-38538
Date: Fri,  4 Oct 2024 10:03:26 -0700
Message-ID: <20241004170328.10819-1-sherry.yang@oracle.com>
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
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=594
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040118
X-Proofpoint-ORIG-GUID: _VhB2sSjv2Lr1pbBk2SDSo8XZOxFZJNv
X-Proofpoint-GUID: _VhB2sSjv2Lr1pbBk2SDSo8XZOxFZJNv

The 2nd patch fixes CVE-2024-38538, but it requires the helper function
pskb_may_pull_reason which is defined in the 1st patch. Backport both
together.


Eric Dumazet (1):
  net: add pskb_may_pull_reason() helper

Nikolay Aleksandrov (1):
  net: bridge: xmit: make sure we have at least eth header len bytes

 include/linux/skbuff.h | 19 +++++++++++++++----
 net/bridge/br_device.c |  6 ++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.46.0


