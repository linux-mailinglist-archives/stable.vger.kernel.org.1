Return-Path: <stable+bounces-100131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8939E9114
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1075281C80
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A9216E3E;
	Mon,  9 Dec 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orB4Z5An"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F691216393;
	Mon,  9 Dec 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741872; cv=none; b=JF9158CaL0q2scIDjtIsmfQZ3NA4M1tMQCujOhfk74o6Y2poMsirIrJJmZ6dmG9TKAtBf54AhblR0srKWA7gB8CRWCSonVd0mCIvfD0TRk+UMuvJyZxPYIrknTzzMGBifEBshaMUjQpFm4WR/pSnni9URInTn8fBaJKxAgS8rBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741872; c=relaxed/simple;
	bh=/iBnR9Ld9+iCIUQLKuVYtxZIMOQV3jgyKmVe1tDe33A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oT/hFAxAqlx+KN5K+pF8XxIeRKlO2sezWOZKJ/OVOMWzy3zHKLvctrDsyyx+g7o78ZGY6wOgPNA0gjyNFR0i3Ur9QC6y+P7eCl62c4TMb+V8wPogJ8nv06sXfXgvxGuHT68jkdjNPFTW25eSpVFa6pbxDihACP0vwpaXQBgbxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orB4Z5An; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AWriq002578;
	Mon, 9 Dec 2024 10:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QztADghPPB1Z1CVJ2/czzj
	c2ZG3W/9nXzHJbuK3O2Es=; b=orB4Z5AnH+XXX0HNRTf3HosChj0LZQK89NRkH/
	X/Vwc5agiv12YvIlnvQ03NQ2SpNzqKmINHWfzQjXxDKCJfXBR+j1NTZ6528RVEWt
	om4KCdFkQCIRi7+CDRZQD+SVGIwD7qtU9umpLvGmpyJhR/88CYq2C/v4o16tMX2k
	FI8zkOVO+MQr3X6UTIr5/r1fVsShuNpiKK3+KigMy5mrgfejhY6WdEZk4S3RC0o9
	ixBND7495N8BdnCPbb+Wehj4Gb9bJyrWRybD+1C6raww+cmWvmA9srmETOVe3zdq
	66J+y+/b1cL/2NIYYBXNX7znstoQkJZ/PPGu06rcKWp8MCrw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw403bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:57:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AvkhM008688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:57:46 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 02:57:43 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: Aswath Govindraju <a-govindraju@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Prashanth K <quic_prashk@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3-am62: Disable autosuspend during remove
Date: Mon, 9 Dec 2024 16:27:28 +0530
Message-ID: <20241209105728.3216872-1-quic_prashk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: f0Tt3uI4ANUgFTVcq8K8X8Ho7kehXwKy
X-Proofpoint-GUID: f0Tt3uI4ANUgFTVcq8K8X8Ho7kehXwKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=558
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090085

Runtime PM documentation (Section 5) mentions, during remove()
callbacks, drivers should undo the runtime PM changes done in
probe(). Usually this means calling pm_runtime_disable(),
pm_runtime_dont_use_autosuspend() etc. Hence add missing
function to disable autosuspend on dwc3-am62 driver unbind.

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Cc: stable@vger.kernel.org
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/dwc3-am62.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 5e3d1741701f..7d43da5f2897 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -309,6 +309,7 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 }
 
-- 
2.25.1


