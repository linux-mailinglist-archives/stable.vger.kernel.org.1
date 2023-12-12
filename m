Return-Path: <stable+bounces-6437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAF80EA4F
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56A3281F53
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242895D48C;
	Tue, 12 Dec 2023 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZnUV8rOS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541ED2;
	Tue, 12 Dec 2023 03:25:42 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC748BS031926;
	Tue, 12 Dec 2023 11:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Tk9BFd+I+EOifDPCLIH0OJzyrz4a1iub/Ug3yC9KN6s=; b=Zn
	UV8rOSqjovd3qJzbmC+1jEYtYyT35JOToN9o4gxOsEsM2R9jEZkP7Ep6ZlDkXqR/
	X9P4wdtHVwzoJQh/GwOxxLnFcb/v/Dts2kFryKM9WxwPNnM55G725JG3G0U3rOT+
	VdLTPy30lHvAmR8n7DwK1iNfVwocgDFWVRpQ2xysvT6Xzu12TNbBB8l+io59ZtT1
	lRayOI2l5sJFX9lmE3qapfoRoZjSoBQKG1yeYod5quR/jd/LxK3sfSxZgRQKQprZ
	opdNHBc3CQR/yewwWFR37es0LCnnokrd7LdlVouwtdvZFewrs6xIpuRHUCZOjdrX
	FomLl3xP/d5aF/4Gz5yQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxgbb0vwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 11:25:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBPbmM009987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 11:25:37 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:25:34 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman
	<mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Date: Tue, 12 Dec 2023 16:55:20 +0530
Message-ID: <20231212112521.3774610-2-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212112521.3774610-1-quic_prashk@quicinc.com>
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
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
X-Proofpoint-GUID: R0YQiPCZdxS7xT1dzQPEitH6XfAmaUT9
X-Proofpoint-ORIG-GUID: R0YQiPCZdxS7xT1dzQPEitH6XfAmaUT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120091

Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
which fixes XHC timeout, which was seen on synopsys XHCs while
using SG buffers. But the support for this quirk isn't present
in the DWC3 layer.

We will encounter this XHCI timeout/hung issue if we run iperf
loopback tests using RTL8156 ethernet adaptor on DWC3 targets
with scatter-gather enabled. This gets resolved after enabling
the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
the xhci device property since its needed for DWC3 controller.

In Synopsys DWC3 databook,
Table 9-3: xHCI Debug Capability Limitations
Chained TRBs greater than TRB cache size: The debug capability
driver must not create a multi-TRB TD that describes smaller
than a 1K packet that spreads across 8 or more TRBs on either
the IN TR or the OUT TR.

Cc: <stable@vger.kernel.org>
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe5bb78..31a496233d87 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
+
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 
-- 
2.25.1


