Return-Path: <stable+bounces-128353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED00A7C66B
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 00:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455A37A442D
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE61A23B0;
	Fri,  4 Apr 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1AKPZmB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7912E62B2
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743806568; cv=none; b=R8qfEsb78uTwaSWTSyXt6vbfn7bLwiNyGQwSK4V5rZyxCPF8IdivEYiA0W++h7eB87hHVItkq3dfIjwFDWMaHdgZn7wAZc1IoyjInYJKcmIIvxgWfYJoxfhRXxVtJbbu3U6bOUEAGqgSkGiJUqaHABXJXFDP4y/fN9M+9Syt+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743806568; c=relaxed/simple;
	bh=NCiUDgIJUFQ7WvglxqBHj8zMTldLi1Rerkypwrr1nO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvzIQ1hkilI8Os/Uv93E4NrEZCcD5PfZi40TAWsq/G0XmJXK0xaGMOur2H7tXMfhM0IKXhZND4kxC4iKZKmJIMugS+APKO91E27rugWqIFI5eSzZ0YuDMyvY1qCt3T0/3Ks7/dKDzwy9lT2m0/njQday7256aUPf+wtJccQwt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N1AKPZmB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534L4HGm011467;
	Fri, 4 Apr 2025 22:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=6W8z79XH0jMbEdZtlmUZtuF/iT9Yb
	u/JhwqF1/lr5Js=; b=N1AKPZmB2mJjyNuYsraEjfQEA3IhtbtgpbCQBtW7TdbRq
	8Bt4iAEiBYVoWPeahYUClxdGpQ/47Uzu06h3pYARKsPCQp5B0jqpUQuDHi4H134E
	fVBWYfpapdixH533EZA9FRgcNlLVVSBT9DE/E8bCdr8ZSaXVkfjUe8ofxU3o4A2Y
	3T6+Nx4enq1Dx6RdgdmjBLXP19bJZDroIsv3vUyUA7BDusRDnXZjwRU4bCEdPkzC
	Ee74wsQ7V9G8S6b5Lbr0BZPo+Cx+2P42sRhAsIkvfovg5dJnhzjseST2ieEvdbme
	mHvoq9FplGeQmQdbouH+fCuAmXKPs9NE0elIwrftg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtr5fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 22:42:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534Kd8u8036124;
	Fri, 4 Apr 2025 22:42:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2nunbxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 22:42:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 534MggcA027581;
	Fri, 4 Apr 2025 22:42:42 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2nunbxj-1;
	Fri, 04 Apr 2025 22:42:42 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: jdamato@fastly.com
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        aleksander.lobakin@intel.com, jack.vogel@oracle.com
Subject: [PATCH Linux-6.12.y 1/1] idpf: Don't hard code napi_struct size
Date: Fri,  4 Apr 2025 15:42:12 -0700
Message-ID: <20250404224212.16753-1-yifei.l.liu@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040156
X-Proofpoint-ORIG-GUID: _D0qGTerNn97FfYm1Mo4f5gzi5r1ebDM
X-Proofpoint-GUID: _D0qGTerNn97FfYm1Mo4f5gzi5r1ebDM

From: Joe Damato <jdamato@fastly.com>

commit 49717ef01ce1b6dbe4cd12bee0fc25e086c555df upstream.

The sizeof(struct napi_struct) can change. Don't hardcode the size to
400 bytes and instead use "sizeof(struct napi_struct)".

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://patch.msgid.link/20241004105407.73585-1-jdamato@fastly.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 49717ef01ce1b6dbe4cd12bee0fc25e086c555df)
[Yifei: In Linux-6.12.y, it still hard code the size of napi_struct,
adding a member will lead the entire build failed]
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f0537826f840..9c1fe84108ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -438,7 +438,8 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 112,
-			    424 + 2 * sizeof(struct dim),
+			    24 + sizeof(struct napi_struct) +
+			    2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
 
 struct idpf_rx_queue_stats {
-- 
2.46.0


