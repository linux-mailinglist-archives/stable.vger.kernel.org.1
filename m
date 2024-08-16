Return-Path: <stable+bounces-69288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12F995419F
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5F31C20A1A
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 06:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC280045;
	Fri, 16 Aug 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XGXHU2gE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74034CD8;
	Fri, 16 Aug 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789241; cv=none; b=UTEnPsoxTJVXY85MF1ZdW+IGPWB2y0ByNE4yFwX/FT0rmji9EGseLMUz026Ifuzv7mX2TgqhWaOgz/UXU6mdFtD/gxIDPKc6WEMZRpmqbdBs+1eMILgTHlPeH76PMOLHZ+2lsoqLdi02drVGtko9NvBrYxlp9p6mKB6KZcGNhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789241; c=relaxed/simple;
	bh=kVuTMKHMeIFr5A7ZvDLmKBOh3Us/hBW2O7R11SpOyVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pa9hDe9270sAR/tFw/sdVNjOXIR3fZUZYQTstw+d+xOGO9aD6E63iOJnMIWGvqZ8NtN8DaILOnB5x0tMiHg2IUyWZKGOo4KoMSC4fyZsid5rEOb9/baZVMlvtA//mO+sFWSZt2leaDDXFPU9cVIDj+T92EFE1dLw2gaZ6Vz/vNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XGXHU2gE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FKwO39026844;
	Fri, 16 Aug 2024 06:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GU4RTXFaRm7bLUEgi7WuOl
	0ugb1/6wDQmyPMD5AVWnA=; b=XGXHU2gEG/+ko4w0PJoVeoQf4FAUSWV5h5Kfkb
	33GZxLdB9eXUg1tHgvrNL3W1L4AKWKOD8gpVNfGPs7URPw30C+Q1zjmd1z31NyTY
	qlBCx4WQAh9LN9q3iCRX34s3FJqxSf6sNlGoUV72OAwuIIhGoFzhgBxe/HELINSr
	9z+41PlVxKVft1b92HwAqg8LtqSSzT0h2FkeiqDR89v54LSojRhIBM0vAFoxpTOE
	j8/8shcuzUaTuKDG3ExmyjcU/t0THBwustio1Yp++rhD+kokizkNGcmOoLXjRupQ
	CdAldVMblA2/uz3TnLxuF36DlzfyOajlrEmQsIZf4ijE/qsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411s5pgvjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 06:20:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47G6KZad024646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 06:20:35 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 15 Aug 2024 23:20:32 -0700
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [v2] usb: dwc3: Avoid waking up gadget during startxfer
Date: Fri, 16 Aug 2024 11:50:17 +0530
Message-ID: <20240816062017.970364-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6zPB1cE4UgM3yPjRWYQk81sQzaXci-sR
X-Proofpoint-ORIG-GUID: 6zPB1cE4UgM3yPjRWYQk81sQzaXci-sR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=299 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160044

When operating in High-Speed, it is observed that DSTS[USBLNKST] doesn't
update link state immediately after receiving the wakeup interrupt. Since
wakeup event handler calls the resume callbacks, there is a chance that
function drivers can perform an ep queue, which in turn tries to perform
remote wakeup from send_gadget_ep_cmd(STARTXFER). This happens because
DSTS[[21:18] wasn't updated to U0 yet, it's observed that the latency of
DSTS can be in order of milli-seconds. Hence avoid calling gadget_wakeup
during startxfer to prevent unnecessarily issuing remote wakeup to host.

Fixes: c36d8e947a56 ("usb: dwc3: gadget: put link to U0 before Start Transfer")
Cc: <stable@vger.kernel.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v2:  Refactored the patch as suggested in v1 discussion.

 drivers/usb/dwc3/gadget.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..3f634209c5b8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -327,30 +327,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
-
-		/*
-		 * Initiate remote wakeup if the link state is in U3 when
-		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
-		 * link state is in U1/U2, no remote wakeup is needed. The Start
-		 * Transfer command will initiate the link recovery.
-		 */
-		link_state = dwc3_gadget_get_link_state(dwc);
-		switch (link_state) {
-		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
-				break;
-
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc, false);
-			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
-					ret);
-			break;
-		}
-	}
-
 	/*
 	 * For some commands such as Update Transfer command, DEPCMDPARn
 	 * registers are reserved. Since the driver often sends Update Transfer
-- 
2.25.1


