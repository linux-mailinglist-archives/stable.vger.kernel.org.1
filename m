Return-Path: <stable+bounces-132661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3BA88BB9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FF13B5D70
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029C284690;
	Mon, 14 Apr 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqhjVAQU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB2270EA4
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656639; cv=none; b=HWvggxNhEw1iV7KHQTkYjTwnXG52EQA2v9IKnJeejP1GN8VBdx1LSWBdmnMvodzogAs9Gq+wTIPFSQxWSriV/euHTijnynx9tI1xbnGHs+qSoMJaqn34iYuyGNyD7qApim1a/r+QLh24K7ownUfVJr+C9TmMW9ahWbUvTdlbwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656639; c=relaxed/simple;
	bh=key630/16V2EV3Z8hOfbxKjb3F5AVvHYn3W4g8RKiU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+FpSWa+rvZm9d+uOgfMxChu5C0StULJnXLUsPUggt8zU+t87+/DHEA9Z6hL/v2ZMK3JImg6ci1giy2i5/YnJbkinBdJP6y/xQOEEQaRuzJRcsXjjnd94c8FjEBUvPdcxn8pgP76oQwkPCC0tqDAIXlIdSB//Hf3dXXID3CC/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VqhjVAQU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIlACU031092;
	Mon, 14 Apr 2025 18:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Zpiy/
	mBx1J8Bs5COqth29JJiQ2W+u6/pnyZI0GfifYg=; b=VqhjVAQUeA3y4A8WgrQv2
	QX0tRKcBH4jspImuaBIIkDOfWY34axdJpzQe0eHAgYs4IgYdhGeFhO6KRMA2VjhW
	Q0X9daxvx95+bPhKQze4AcUAvrpHNlj3UgOAhap5+QD+dUHxVdhlShybwVJIaQFH
	Tu8zsFFiZmXfuFQCRso7vcNOLnqSvwkYLUuGIAV9rskmAOsGLDfDT2q5Bde/yPIx
	H6xFggFyq+4cQLStVYk8YLMO/rVPyv45PzwQsDKo+VxvEhJZn1zOOgOHalXkI66S
	6kDKGCFUONmarcRroDVESral590Xuk4BH/i5UxPqrqIXq69qY2kqm3d/60PBbnfC
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617xm806d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHRpDH024657;
	Mon, 14 Apr 2025 18:50:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d4y5f5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EIoUHC035509;
	Mon, 14 Apr 2025 18:50:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d4y5f48-2;
	Mon, 14 Apr 2025 18:50:32 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 1/6] net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
Date: Mon, 14 Apr 2025 11:50:18 -0700
Message-ID: <20250414185023.2165422-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
References: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140137
X-Proofpoint-ORIG-GUID: SBDgICz7RuteGfzdgGmd0SXH6-cako9s
X-Proofpoint-GUID: SBDgICz7RuteGfzdgGmd0SXH6-cako9s

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

[ Upstream commit b6ecc662037694488bfff7c9fd21c405df8411f2 ]

Currently napi_disable() gets called during rxq and txq cleanup,
even before napi is enabled and hrtimer is initialized. It causes
kernel panic.

? page_fault_oops+0x136/0x2b0
  ? page_counter_cancel+0x2e/0x80
  ? do_user_addr_fault+0x2f2/0x640
  ? refill_obj_stock+0xc4/0x110
  ? exc_page_fault+0x71/0x160
  ? asm_exc_page_fault+0x27/0x30
  ? __mmdrop+0x10/0x180
  ? __mmdrop+0xec/0x180
  ? hrtimer_active+0xd/0x50
  hrtimer_try_to_cancel+0x2c/0xf0
  hrtimer_cancel+0x15/0x30
  napi_disable+0x65/0x90
  mana_destroy_rxq+0x4c/0x2f0
  mana_create_rxq.isra.0+0x56c/0x6d0
  ? mana_uncfg_vport+0x50/0x50
  mana_alloc_queues+0x21b/0x320
  ? skb_dequeue+0x5f/0x80

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit b6ecc662037694488bfff7c9fd21c405df8411f2)
[Harshit: conflicts resolved due to missing commit: ed5356b53f07 ("net:
mana: Add XDP support") and commit: d356abb95b98 ("net: mana: Add
counter for XDP_TX") in 5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/microsoft/mana/mana.h    |  2 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana.h b/drivers/net/ethernet/microsoft/mana/mana.h
index 35e937a7079c..6aac4824090c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana.h
+++ b/drivers/net/ethernet/microsoft/mana/mana.h
@@ -76,6 +76,8 @@ struct mana_txq {
 
 	atomic_t pending_sends;
 
+	bool napi_initialized;
+
 	struct mana_stats stats;
 };
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b0963fda4d9f..3c754b31c30d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1154,10 +1154,12 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		napi = &apc->tx_qp[i].tx_cq.napi;
-		napi_synchronize(napi);
-		napi_disable(napi);
-		netif_napi_del(napi);
-
+		if (apc->tx_qp[i].txq.napi_initialized) {
+			napi_synchronize(napi);
+			napi_disable(napi);
+			netif_napi_del(napi);
+			apc->tx_qp[i].txq.napi_initialized = false;
+		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -1213,6 +1215,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		txq->ndev = net;
 		txq->net_txq = netdev_get_tx_queue(net, i);
 		txq->vp_offset = apc->tx_vp_offset;
+		txq->napi_initialized = false;
 		skb_queue_head_init(&txq->pending_skbs);
 
 		memset(&spec, 0, sizeof(spec));
@@ -1277,6 +1280,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		netif_tx_napi_add(net, &cq->napi, mana_poll, NAPI_POLL_WEIGHT);
 		napi_enable(&cq->napi);
+		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
@@ -1288,7 +1292,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 }
 
 static void mana_destroy_rxq(struct mana_port_context *apc,
-			     struct mana_rxq *rxq, bool validate_state)
+			     struct mana_rxq *rxq, bool napi_initialized)
 
 {
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
@@ -1302,12 +1306,13 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 	napi = &rxq->rx_cq.napi;
 
-	if (validate_state)
+	if (napi_initialized) {
 		napi_synchronize(napi);
 
-	napi_disable(napi);
-	netif_napi_del(napi);
+		napi_disable(napi);
 
+		netif_napi_del(napi);
+	}
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
-- 
2.47.1


