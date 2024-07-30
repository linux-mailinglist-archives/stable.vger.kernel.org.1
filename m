Return-Path: <stable+bounces-62804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD850941287
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87762285C60
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F301A08BB;
	Tue, 30 Jul 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MaK778k6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAF1A08BC;
	Tue, 30 Jul 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343681; cv=none; b=CVteKnfzrSczEhV1p7WcLulaFDRWf0+abuJjrY+Q3oC2q1zWuKrZRxLif5GeDFhvhyRYl+gAEsV30dn/zj1UWxZgA6NXmkQjUTTgJe1T2Ghu6PI044YjWMvndhazaLIBifBmxDooT6NQs+zDKStCgFgLgZqtKKQi81IodvVhW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343681; c=relaxed/simple;
	bh=TH14SZVKEQYd33hCGU2MbRZHy86J+QbddqBKiFIxfMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Egm6TbybtmjBwc683yO+pnRRrxFSXWGLdVeQ1alQT7p8F4suIEmTeiXqgavaVNStT3CSlkpO4VbGybzLim2J8tH6FsmKf/zUTXvmSLWPN2lRqSkm9S9sM5Q2Dt/qMXxMNw3tk2NTF6Q27Zl+KEW3GGhz7B/YoXUa5SDlI2gVWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MaK778k6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UA0XXJ014432;
	Tue, 30 Jul 2024 12:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=90Im+Dj/0aVNIvCzFKCmXT
	yf0WUls8JPX3+qap19Q9o=; b=MaK778k6VR5pp0JMAnQJ/+v0rmJKfRtILafcH1
	YPJJsMsQIQ1SEWEJ6ML8YnKlv+soOO23+5M6n1IVoc18GXxCNYwIDoESD4m6+Od4
	0XP3vGgNoOkCH+KMu5etm/btqfvQsZll54Ht7QG/FoLVI47bpnNzpc5QYo8dRp5M
	RXV20iCOH17qgeVhwoSBdE81hvfQPWZyEpnEqF7/wAwEx/PS2ijUXJ9TBx/nmS34
	1nShnxPeOS9Nx49PIL69825dr4b1Z+aesczTFaQfejjQILXaV+gT4kE3lHFQvMQk
	FId2IO69kWj1wru3Ua+KARUiaBTwMxXlLubq1z36CA+HOHcw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqurqdhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 12:47:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UClsMm003087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 12:47:54 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 05:47:52 -0700
From: Prashanth K <quic_prashk@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup event
Date: Tue, 30 Jul 2024 18:17:42 +0530
Message-ID: <20240730124742.561408-1-quic_prashk@quicinc.com>
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
X-Proofpoint-GUID: 3rgcpzxn7SdzM362vH93kMVILUpmx3IW
X-Proofpoint-ORIG-GUID: 3rgcpzxn7SdzM362vH93kMVILUpmx3IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=649 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300089

When operating in High-Speed, it is observed that DSTS[USBLNKST] doesn't
update link state immediately after receiving the wakeup interrupt. Since
wakeup event handler calls the resume callbacks, there is a chance that
function drivers can perform an ep queue. Which in turn tries to perform
remote wakeup from send_gadget_ep_cmd(), this happens because DSTS[[21:18]
wasn't updated to U0 yet. It is observed that the latency of DSTS can be
in order of milli-seconds. Hence update the dwc->link_state from evtinfo,
and use this variable to prevent calling remote wakup unnecessarily.

Fixes: ecba9bc9946b ("usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer")
Cc: <stable@vger.kernel.org>
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..3b55285118b0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -328,7 +328,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	}
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
+		int	link_state;
+		bool	remote_wakeup = false;
 
 		/*
 		 * Initiate remote wakeup if the link state is in U3 when
@@ -339,15 +340,26 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		link_state = dwc3_gadget_get_link_state(dwc);
 		switch (link_state) {
 		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
+			if (dwc->gadget->speed < USB_SPEED_SUPER)
+				remote_wakeup = true;
+			break;
+		case DWC3_LINK_STATE_U3:
+			/*
+			 * In HS, DSTS can take few milliseconds to update linkstate bits,
+			 * so rely on dwc->link_state to identify whether gadget woke up.
+			 * Don't issue remote wakuep again if link is already in U0.
+			 */
+			if (dwc->link_state == DWC3_LINK_STATE_U0)
 				break;
 
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
+			remote_wakeup = true;
+			break;
+		}
+
+		if (remote_wakeup) {
 			ret = __dwc3_gadget_wakeup(dwc, false);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
-			break;
 		}
 	}
 
@@ -4214,6 +4226,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 {
 	dwc->suspended = false;
+	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 
 	/*
 	 * TODO take core out of low power mode when that's
@@ -4225,8 +4238,6 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
 		dwc->gadget_driver->resume(dwc->gadget);
 		spin_lock(&dwc->lock);
 	}
-
-	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
-- 
2.25.1


