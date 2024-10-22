Return-Path: <stable+bounces-87751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC19AB2E4
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EFA1C210C2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E221A2C0B;
	Tue, 22 Oct 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fWQt4ge7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB019F10A;
	Tue, 22 Oct 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612612; cv=none; b=Ah/B0DmNT33A7UJXcAhYcRUXKibmhonVhXcqqUheL9atw0l5Pax9TrsCLl0QFf1IvPV7r6Jfo0RuGyG0lSeIsRZzp3udt7dBQqzNafTZs7qN/ZPvqFCTU21JZshvVVfyqLyBW1YuHOhyMBTaJXzFRfJThG38ZUec43XvLOi5yXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612612; c=relaxed/simple;
	bh=z13NicMcF9ZVpeE1GItwW03x9gDbBSHe3X3Sx9kV7Io=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vEsD3+1HuyNMbLs8fwTMIh+r5Q9XsVk6UqGbyYS3l8mHb9OSJSas79dNLhEoDqNYPPjHN6T49ojouWblVRBqJ5r8UMSVaOFeBPpLDbwwEASq/mOZRyhdJjL+hcyEjyZaPg+ux/goffLOMWis/507qcnqvhUQ8pYvTDitVVkyFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fWQt4ge7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9amGJ005187;
	Tue, 22 Oct 2024 15:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=+HbAaa1q9bAdAu7D05Pl04/COhM7iX9rJ+WJMiME4Fw=; b=fW
	Qt4ge7LMYp790WOogpb8YXokhcmpLis/b4Dz3L5RLOiuLwad9Tc7KTAlah6BZQDP
	KldtQMI3OgeuQDLBfWRArJaiTLop3xvGM1vAwpRbvOryJZtsPes1luw1CFXzg1xw
	yGJ9BYITV8s1G10fHfoCpZ9ALzCpY6oVEwf/C+TSZEgXpBvPNBBfT/PuGsSBlj3M
	KAqmWfo/W8ZbCCCqXoauk0gyXqR899qRWE9gYnDK60udjfCM5IOu23iPzvT+fmBR
	I/5x6krrXkON0ujjaexfeBAY8MxheKrialzbNxMSZaG6x+hn+fsUyeVvleKl/Cy+
	V9xMuhF4ge5nBc/4EdLw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rbgwfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:56:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MFuhR6030859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:56:43 GMT
Received: from hu-faisalh-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 08:56:41 -0700
From: Faisal Hassan <quic_faisalh@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman
	<mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faisal Hassan
	<quic_faisalh@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] xhci: Fix Link TRB DMA in command ring stopped completion event
Date: Tue, 22 Oct 2024 21:26:31 +0530
Message-ID: <20241022155631.1185-1-quic_faisalh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XTd4BBODkolSvOCLlI_s99UZf9GHG1Xk
X-Proofpoint-GUID: XTd4BBODkolSvOCLlI_s99UZf9GHG1Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxlogscore=966 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220102

During the aborting of a command, the software receives a command
completion event for the command ring stopped, with the TRB pointing
to the next TRB after the aborted command.

If the command we abort is located just before the Link TRB in the
command ring, then during the 'command ring stopped' completion event,
the xHC gives the Link TRB in the event's cmd DMA, which causes a
mismatch in handling command completion event.

To address this situation, move the 'command ring stopped' completion
event check slightly earlier, since the specific command it stopped
on isn't of significant concern.

Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")
Cc: stable@vger.kernel.org
Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
---

Changes in v3:
- Skip dma check for the cmd ring stopped event
- v2 link:
https://lore.kernel.org/all/20241021131904.20678-1-quic_faisalh@quicinc.com

Changes in v2:
- Added Fixes tag
- Removed traversing of TRBs with in_range() API.
- Simplified the if condition check.
- v1 link:
https://lore.kernel.org/all/20241018195953.12315-1-quic_faisalh@quicinc.com

 drivers/usb/host/xhci-ring.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b2950c35c740..1ffc69c48eac 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1718,6 +1718,14 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
+		complete_all(&xhci->cmd_ring_stop_completion);
+		return;
+	}
+
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
@@ -1734,14 +1742,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
-	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
-	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
-		complete_all(&xhci->cmd_ring_stop_completion);
-		return;
-	}
-
 	if (cmd->command_trb != xhci->cmd_ring->dequeue) {
 		xhci_err(xhci,
 			 "Command completion event does not match command\n");
-- 
2.17.1


