Return-Path: <stable+bounces-55858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016991883B
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915421C21D4D
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678018FDB6;
	Wed, 26 Jun 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g879wx7p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086E118FC8B
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421716; cv=none; b=VooEYml7EHtEcZ+bQFuTaRkTpCk0JZBYO0pa8PQyBjMY0aaUqhl3XI78DNH+Jo1mCpM9Qu63qMs9IaQh2MbnST6X1KcAyG8DyRG5tYLVMaYFc/TJMaymnlulpNneAJpVjNxKUznrEiIU27nSc5OLQzJ8PDPY11aX+AKlUviQQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421716; c=relaxed/simple;
	bh=tP+4sJpAGQYLsPwM2Mebn9h8BtrPAUD44qsZrWQnc9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiNvzBHU5q7RRcacLb8jh7F7zGZZkdFfh+orMIFkmyyKoZz0573J/AaIDpKsNFB3HhDMK26Eb8Oshpzo6wpQneg/b9aGuMAwQ+ZSQH1ZsQIAdF2TwHOGXVg54ehM0LidPml478ema862nvNAbxPxkD2pr3pRrbjSNZiscZdoMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g879wx7p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfJ9I029732
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WNky1h01L/oGAoP1hesPha0379YWZQi0jpby3lzjt/U=; b=g879wx7pnJLlaz1O
	EYPgQsLYFDmuhvWixmzIo62vbtAqGg8ZxgzlhQ7zZPNPeUbKZgudqGPC1auChIBJ
	JzdGTF21EnmWSLkZDYbzSI4j0xzgE8+xbAY3ck8A34IqzM804EgO+OuqhQ43GB3Q
	umKHjquG5rp7srSS+IWsSwlUsE54yYgRceI5KvwzCXAROoIs7WZi+zX7W3YL2JSw
	aIoPRv0YK9mz4OmbC+vLWDdXIILpyjfb2oOFct/fl/sfOrE6+21stykr1W18aoN2
	LDJURyz7B/WGaISNuMsNEvK2c1tNF9/eA6dXLCzhONAw0LsnxrTN9T8gTP8+awsM
	TKIkTw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c469vja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QH8WCP015570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:08:32 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 10:08:29 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_ugoswami@quicinc.com>
CC: Krishna Kurapati <quic_kriskura@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/8] arm64: dts: ipq8074: Disable SS instance in Parkmode for USB
Date: Wed, 26 Jun 2024 22:38:02 +0530
Message-ID: <20240626170808.1267243-3-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: deuAcHBAJZdpLhVxrGk25z2vw7a9xgF0
X-Proofpoint-GUID: deuAcHBAJZdpLhVxrGk25z2vw7a9xgF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 impostorscore=0 spamscore=1
 mlxscore=1 lowpriorityscore=0 phishscore=0 mlxlogscore=223 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260125

For Gen-1 targets like IPQ8074, it is seen that stressing out the
controller in host mode results in HC died error:

 xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
 xhci-hcd.12.auto: xHCI host controller not responding, assume dead
 xhci-hcd.12.auto: HC died; cleaning up

And at this instant only restarting the host mode fixes it. Disable
SuperSpeed instance in park mode for IPQ8074 to mitigate this issue.

Cc: <stable@vger.kernel.org>
Fixes: 5e09bc51d07b ("arm64: dts: ipq8074: enable USB support")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 92682d3c9478..284a4553070f 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -666,6 +666,7 @@ dwc_0: usb@8a00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&ssphy_0>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
@@ -715,6 +716,7 @@ dwc_1: usb@8c00000 {
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_1>, <&ssphy_1>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
-- 
2.34.1


