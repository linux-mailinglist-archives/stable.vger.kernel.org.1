Return-Path: <stable+bounces-86880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D759A4781
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757A2869EB
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12F18BC28;
	Fri, 18 Oct 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZrDlXiZS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE371877;
	Fri, 18 Oct 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281619; cv=none; b=sCTgdOtIs/B+7J3F2t/bB0NMP0XQ6hN8xDn0Ke42gxT9etsOxsFSUJLZcgVk3jOEfVkPoZilmI46NxSFpUqukDdukf1j4/4I8Tja1APuAavfMsmEqsK8LPaen3KPN4PaFn7jQrx7c+3iBaLxeXidXl/v+VYbtKLRO1LnYEu2Iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281619; c=relaxed/simple;
	bh=XZdx80R+JV76F0/LJjVqwGe0jn8KTRoxU7CYNqxUYcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ix8AXX9Z7t/OLvSVU+zuZRgsOXFiLne3FRXLmPqHAnA6Q72O23uxe9xokoUsHmHbuHtVqW15FCYgb8n2bqHktUZSY0ojJsL7Cnpc3wxXhicZj/JeGLdM4aKvNGmPd7IXc449A3jjoNkToYSY0YCaO96WFr3rXSX1sfRZXQh5qR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZrDlXiZS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBapUZ019324;
	Fri, 18 Oct 2024 20:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=mRufhj+cCRiCu3UD9OFgEbw5uqeGE4+lTUYy/QM5NbI=; b=Zr
	DlXiZSshaVxto6i7WiuAIiuNHGun3wCTPqUzhbkAd0+PKGKpE/UL4xDEqfyae0qF
	h3G1ScUxBmGnxMIvI6yMGRdZJ8s9If3uJ3teMqqDyj5S6yNpXbYTWqmL0sv96cgO
	7sR57TtQ5edm/3hh8axt5plsZ/D0tCdotHZCbl9hxGTtND+m6eEnRFK0OOTz6pim
	KLaREpYdGT/dFefm2aQgIA88WapfjWvDFPKgEMfcGKuDNDqN4rv/1fThsOKcKrkm
	IBy39+IXw9+od5PA8pKG/SofxYXraDUFfhCM7qngVLFWI9ZI2ruWym1JsWQZR76o
	ZLaM2oQBFOYiI1PqGY/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bexpasfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:00:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IK0CHc004281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 20:00:12 GMT
Received: from hu-faisalh-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Oct 2024 13:00:10 -0700
From: Faisal Hassan <quic_faisalh@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman
	<mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faisal Hassan
	<quic_faisalh@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH] xhci: Fix Link TRB DMA in command ring stopped completion event
Date: Sat, 19 Oct 2024 01:29:53 +0530
Message-ID: <20241018195953.12315-1-quic_faisalh@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oZcW8brLnMJCeoNee-EXtQu9dp8QcZRr
X-Proofpoint-ORIG-GUID: oZcW8brLnMJCeoNee-EXtQu9dp8QcZRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxlogscore=947 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180127

During the aborting of a command, the software receives a command
completion event for the command ring stopped, with the TRB pointing
to the next TRB after the aborted command.

If the command we abort is located just before the Link TRB in the
command ring, then during the 'command ring stopped' completion event,
the xHC gives the Link TRB in the event's cmd DMA, which causes a
mismatch in handling command completion event.

To handle this situation, an additional check has been added to ignore
the mismatch error and continue the operation.

Cc: stable@vger.kernel.org
Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 38 +++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b2950c35c740..43926c378df9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -126,6 +126,32 @@ static void inc_td_cnt(struct urb *urb)
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
+	dma_addr_t trb_dma;
+	int i;
+
+	seg = ring->first_seg;
+	do {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++) {
+			trb = &seg->trbs[i];
+			trb_dma = seg->dma + (i * sizeof(union xhci_trb));
+
+			if (trb_is_link(trb) && trb_dma == dma)
+				return true;
+		}
+		seg = seg->next;
+	} while (seg != ring->first_seg);
+
+	return false;
+}
+
 static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
 {
 	if (trb_is_link(trb)) {
@@ -1718,13 +1744,21 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
 	 * Check whether the completion event is for our internal kept
 	 * command.
+	 * For the 'command ring stopped' completion event, there is a
+	 * risk of a mismatch in dequeue pointers if we abort the command
+	 * just before the link TRB in the command ring. In this scenario,
+	 * the cmd_dma in the event would point to a link TRB, while the
+	 * software dequeue pointer circles back to the start.
 	 */
-	if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
+	if ((!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) &&
+	    !(cmd_comp_code == COMP_COMMAND_RING_STOPPED &&
+	      is_dma_link_trb(xhci->cmd_ring, cmd_dma))) {
 		xhci_warn(xhci,
 			  "ERROR mismatched command completion event\n");
 		return;
@@ -1734,8 +1768,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
 	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
 	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
 		complete_all(&xhci->cmd_ring_stop_completion);
-- 
2.17.1


