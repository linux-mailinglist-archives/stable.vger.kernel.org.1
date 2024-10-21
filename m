Return-Path: <stable+bounces-87562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DABC9A69F3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD72B2216F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9231F1306;
	Mon, 21 Oct 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JZXV8mmZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B31E0B96;
	Mon, 21 Oct 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516763; cv=none; b=NkLo48xN0OQbzrK7vzm3i+KNkS3VF95A9/3cTOlwBSoH6R6TO+LejT5TWZRXxSLA2xMNOLjKyo5mWfMb2oyGzbef6IJPwZha1IHkHWIOGADW1kxTqwIgvoSBDOuDRkXdvjk+cWa8FC5dfJ9olZkj2jiHOJDbZzRR5N33+XQUwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516763; c=relaxed/simple;
	bh=fN8/CgKj3jJU9zdFPli8qQkTQ7X5G/HUovnFn/qYabk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8OgPX1wAds1xYN0sBjXP1fRAYVaIbwQ9finG8qZ39U1Z1Njc8IvWiO4ka8sNRj8AHZvuZrA28JjliDEvD4wLTaWa4pY6QAh/XkRbN/td5H4EBdNlJqA1I+r1A3j/91jOFQvD3L4eRFjonZTUojbTL5gQjjf0GSBAGH3lojk6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JZXV8mmZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9fQvC000739;
	Mon, 21 Oct 2024 13:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=8Pj7g62BnpTOi3u3ZuTsxArKua2YZFJAJxMs8s4ddoc=; b=JZ
	XV8mmZbJphLECAEKanjJXIh/0wp9dZ+50zpUqP8Dk7iXdaioKmQhZ8clfEoGG5Ki
	mMdmqTUwzFhfESHvmf5wa4y6QQCpQNar7MHuaHqDJ0lmyqWeAdtHUgy4dRrzUIjK
	JpamJc0TA0uRIIkOAO/QUXR9URYHQj/fALxU45Gg5Yt822vYsqO2gd7p8pwSfqT/
	L83KVVs3G9jsLQ4PHLWQJJcuxF4NwaGmwumpHnh64xBIgDylckYLi0Znn9DUFTaf
	YWHJ48T/1oJnVP+bwSoRj8cBtF/5FBn2/ejXvpcon1pgzfw//FSqWJgscTKcEpRM
	MBYsyfiTF2W+mIbilygg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmj10sg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 13:19:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LDJGYO007636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 13:19:16 GMT
Received: from hu-faisalh-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 06:19:14 -0700
From: Faisal Hassan <quic_faisalh@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman
	<mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faisal Hassan
	<quic_faisalh@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] xhci: Fix Link TRB DMA in command ring stopped completion event
Date: Mon, 21 Oct 2024 18:49:04 +0530
Message-ID: <20241021131904.20678-1-quic_faisalh@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zgONXSfcHytGlMCGPm8K7vtHvR-Ya4c7
X-Proofpoint-ORIG-GUID: zgONXSfcHytGlMCGPm8K7vtHvR-Ya4c7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=961 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210095

During the aborting of a command, the software receives a command
completion event for the command ring stopped, with the TRB pointing
to the next TRB after the aborted command.

If the command we abort is located just before the Link TRB in the
command ring, then during the 'command ring stopped' completion event,
the xHC gives the Link TRB in the event's cmd DMA, which causes a
mismatch in handling command completion event.

To handle this situation, an additional check has been added to ignore
the mismatch error and continue the operation.

Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")
Cc: stable@vger.kernel.org
Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
---
Changes in v2:
- Removed traversing of TRBs with in_range() API.
- Simplified the if condition check.

v1 link:
https://lore.kernel.org/all/20241018195953.12315-1-quic_faisalh@quicinc.com

 drivers/usb/host/xhci-ring.c | 43 +++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b2950c35c740..de375c9f08ca 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -126,6 +126,29 @@ static void inc_td_cnt(struct urb *urb)
 	urb_priv->num_tds_done++;
 }
 
+/*
+ * Return true if the DMA is pointing to a Link TRB in the ring;
+ * otherwise, return false.
+ */
+static bool is_dma_link_trb(struct xhci_ring *ring, dma_addr_t dma)
+{
+	struct xhci_segment *seg;
+	union xhci_trb *trb;
+
+	seg = ring->first_seg;
+	do {
+		if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE)) {
+			/* found the TRB, check if it's link */
+			trb = &seg->trbs[(dma - seg->dma) / sizeof(*trb)];
+			return trb_is_link(trb);
+		}
+
+		seg = seg->next;
+	} while (seg != ring->first_seg);
+
+	return false;
+}
+
 static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
 {
 	if (trb_is_link(trb)) {
@@ -1718,6 +1741,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
@@ -1725,17 +1749,26 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	 * command.
 	 */
 	if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
-		xhci_warn(xhci,
-			  "ERROR mismatched command completion event\n");
-		return;
+		/*
+		 * For the 'command ring stopped' completion event, there
+		 * is a risk of a mismatch in dequeue pointers if we abort
+		 * the command just before the link TRB in the command ring.
+		 * In this scenario, the cmd_dma in the event would point
+		 * to a link TRB, while the software dequeue pointer circles
+		 * back to the start.
+		 */
+		if (!(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
+		      is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {
+			xhci_warn(xhci,
+				  "ERROR mismatched command completion event\n");
+			return;
+		}
 	}
 
 	cmd = list_first_entry(&xhci->cmd_list, struct xhci_command, cmd_list);
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
 	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
 	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
 		complete_all(&xhci->cmd_ring_stop_completion);
-- 
2.17.1


