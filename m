Return-Path: <stable+bounces-55857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B076591883A
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527451F2415C
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400A418FDAC;
	Wed, 26 Jun 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A9Ec5X91"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155318FDCF
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421710; cv=none; b=lvpMwleSZNbKFd1xATF8e5TMOR7ot8qcRCdwUul7OmuUxzUrHOWYyvTuSrafRauTyX97WRbBSSnZFYNcXyirBsPWL5D9LCYrJdr43jr5SkgqkP47kyDPixTDLEotCC1/zimEfP/m5JmS/jMDSlcs2ZDlJE+8eZaFFNPewTKGeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421710; c=relaxed/simple;
	bh=XVsMBoqB8hPvEJ3wSksq3olQM2x3XlKrKLDD0R6haTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbJt7U53d7T9bze/mE78AXKUjFUpm8nrBQAZbfHy7x7GKDEb23hh2GSL6ywwuqrVH77iRObtF+tZX1Zq0zGY1zTo9W5ZpmLo+SWKQEZ9cofW+x8ZqE7M5yAYjPaGFSVmkPaX1Br3MZBMyYuKJXaxLp0MWUzWMuYvUJozCUpFH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A9Ec5X91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAg4Ki025153
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L5ErWb7VKHFzfeu8Yh+ParQXB4rrDVHAqKE7PQ2MKfM=; b=A9Ec5X91tlZoIC9I
	tWXIXwBDc1wbPZJIGGLb3gMmtsYzRVbVrMuyVtjpoY6qeQkTMzdu0VzrYQX2Ko2z
	mumfb3tNXt2Pnr525DmlnQKzJdd6U4AjDADY53ngWZdU5nkKa9+OsnCit18LAXHx
	O1V7W2truiLFERZSwNNYq6ucQM3liJeSAKt0t1Vo7oi2pAFGoct6skIXUte1R6xj
	L3/P/KYqqDs+WXd18dOSppRfPfqJu0poAcEOJkNRynEGLYWYDiG/w/BABwtBXoUu
	HiEeo16cDC0Gh0rwLskF3O8lgDcnXqzyoEXHpAyBJAnJ790HGB4aEQJMoV6rbWya
	TXkyaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yt6u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QH8QEA002949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:26 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 10:08:23 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_ugoswami@quicinc.com>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/8] arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB
Date: Wed, 26 Jun 2024 22:38:01 +0530
Message-ID: <20240626170808.1267243-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626170808.1267243-1-quic_kriskura@quicinc.com>
References: <20240626170808.1267243-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Yu3jokpFCY-Alqa1kSJo1zHyWnBUySS
X-Proofpoint-ORIG-GUID: 9Yu3jokpFCY-Alqa1kSJo1zHyWnBUySS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=369 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260125

For Gen-1 targets like IPQ6018, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for IPQ6018 to mitigate this issue.

Cc: <stable@vger.kernel.org>
Fixes: 20bb9e3dd2e4 ("arm64: dts: qcom: ipq6018: add usb3 DT description")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 9694140881c6..8b63c1a6da10 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -685,6 +685,7 @@ dwc_0: usb@8a00000 {
 				clocks = <&xo>;
 				clock-names = "ref";
 				tx-fifo-resize;
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
-- 
2.34.1


