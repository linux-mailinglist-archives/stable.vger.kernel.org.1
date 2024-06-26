Return-Path: <stable+bounces-55859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E591883C
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989021F2312B
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179118FC8B;
	Wed, 26 Jun 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JvwHCbU9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32C1836DD
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421719; cv=none; b=ptW2lQ4mhwYADHaXQCsch2V8U2OYkiX5vsBqpriAaBsP4pipkL38j2yYV9U7lJsLjn/xWwHEDLg1tVN0Y2JTuWLFsEQv2wrBxaIoFb+cN0ZvxK0MmwJtfmPIUeP/oRrB2eBdemuOwNN0UdS94AvUbg+Uu6sNR+MyWEOYXLFWJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421719; c=relaxed/simple;
	bh=jj8JT9Q7bseYaElmt88ghzG94u/YQzP8ahHHjaboKZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWT25SoY43ReryOYnrt2sOFirmcb8CY28WD56TpHtLNR6sZ/oRNoSpiQh5rv+Dmx8gvaNnmgphwdL4oyvpII03UDmQydPHTffAV2COUPDTYtERlo3w8fpRsl0BvwUCmNcxSw8W3EdLwJ/wrWKJRNv/BEF1+455NW21W9qMe6ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JvwHCbU9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfQQW023276
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OZDfbq5H548WZ6eRc5eVRFa/LDZz7MySVsSYLE5afew=; b=JvwHCbU9wJnm8jLR
	ttQ0GJjnbFkVly+ICtIR2iYXQWmKZ9/I1Nyc8N/p6eltTXhxARTmK18Xhy0UKtBP
	pU35gN3MPuiGyEu+E6/CDSUSqkk3sLkJW1WwnYFm1EcKCj1Nuw6zZLnWwiM53ZOV
	n1tLBcHnV+fsQ/WYy6ALuY9pUnwgbtLlscoBvnHE19laT+3f3dTnvxKDlcF/3Snk
	KLkDhZ2DIB2NbURF4t0bvLBQo70ak6kvKQkoKevm22tWyGDlsmxBdINUK4qif5/P
	1P15IEoQXsDcYpXRdEl+bRylXU/TMy6s62Yqh4F1Uzybbh5j5pE2/nFVOnpty7Fl
	FJkhdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywpu19rbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QH8ZUe003034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:35 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 10:08:33 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_ugoswami@quicinc.com>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/8] arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
Date: Wed, 26 Jun 2024 22:38:03 +0530
Message-ID: <20240626170808.1267243-4-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: LiT6gJk1ZeUxaTiT9ep-DuNt-Z8EDMaH
X-Proofpoint-ORIG-GUID: LiT6gJk1ZeUxaTiT9ep-DuNt-Z8EDMaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=314 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260125

For Gen-1 targets like MSM8998, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for MSM8998 to mitigate this issue.

Cc: <stable@vger.kernel.org>
Fixes: 026dad8f5873 ("arm64: dts: qcom: msm8998: Add USB-related nodes")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3c94d823a514..6d5e1c7b2da5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2144,6 +2144,7 @@ usb3_dwc3: usb@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
+				snps,parkmode-disable-ss-quirk;
 				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
-- 
2.34.1


