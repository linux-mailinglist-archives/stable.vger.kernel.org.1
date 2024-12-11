Return-Path: <stable+bounces-100608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F389ECBA0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA61285BF2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795752210E9;
	Wed, 11 Dec 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pl5T2ult"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D81DA634;
	Wed, 11 Dec 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918371; cv=none; b=id+i0RCyxusVjaQQAwxVG0e/NZL12SI+urwqpZiR7XSUYkbOYm0+XOe7zLaI+E/ETXHiLOpA3fZK8bmjSxddbyDmny/MXi02CvRQxUjh4lufgqEVEVOEpt+mWNZ2ridHMGKeZUXQwgnu3heC+H0IoP9Ae734DYF0Tl+V7pMXbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918371; c=relaxed/simple;
	bh=I6wZVNs22wQMqttdoXVPOQc2PvNhdU0A7mQSIPBVFYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+jUVlpMzkPudgj64G34iNKHj+brnEmUQ/6RbHxwlqkBLjkhb3kxFuepxVy6c1zRyNwlHN4wLkgQN48jwbmOfNvMXcKB1mPgqlBb7Y2bnloUprl8ll1SLDMJSPU6/N9t/uw3C43mvlH4Z7G9w30MI5wZjub0R/mtsnb0qYOGO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pl5T2ult; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB308ud016161;
	Wed, 11 Dec 2024 11:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hY1t1N2sMbvghIafaPKPju
	O22QsxZgIAGYAQ3X7NipA=; b=pl5T2ult2bgpt0B9ExDS0ZUKDE95UIbnF2SxHL
	eV3catX6Kr9HOlccvX9HWfk2rWxgRLnS2snkGMUAdexGE1yx+nzJzjA5DY2Sidlg
	9QlsIXgHuvHr8fBbCDwT0zIP6FDkZc59M6572gJT7lIt73TBq8qTVmu6Fg8k2W+U
	uwX4C4RGzCWq3Vxl7bsMB+/MVcKP3Av3Ammn50865pkWQbg3U2+wTzfb8SxQRmaP
	HxmHkd+dCWESZqHj42ftBpw4ArsVTLCCg12fvbxGBSV1tXJS+LrlZ+4f5GcetHFL
	OwXMSI4kqEp8oSCGAvKkVXVTxaJrRpjd7RZJtZag6VscSgxA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3ncyru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 11:59:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBBxRLf012567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 11:59:27 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 03:59:25 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: gadget: f_uac2: Fix incorrect setting of bNumEndpoints
Date: Wed, 11 Dec 2024 17:29:15 +0530
Message-ID: <20241211115915.159864-1-quic_prashk@quicinc.com>
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
X-Proofpoint-GUID: nW7eMYvWMyMIYOr_V8V1HqY84IAUFcvJ
X-Proofpoint-ORIG-GUID: nW7eMYvWMyMIYOr_V8V1HqY84IAUFcvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=476 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110087

Currently afunc_bind sets std_ac_if_desc.bNumEndpoints to 1 if
controls (mute/volume) are enabled. During next afunc_bind call,
bNumEndpoints would be unchanged and incorrectly set to 1 even
if the controls aren't enabled.

Fix this by resetting the value of bNumEndpoints to 0 on every
afunc_bind call.

Fixes: eaf6cbe09920 ("usb: gadget: f_uac2: add volume and mute support")
Cc: stable@vger.kernel.org
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/gadget/function/f_uac2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index ce5b77f89190..9b324821c93b 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1185,6 +1185,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 		uac2->as_in_alt = 0;
 	}
 
+	std_ac_if_desc.bNumEndpoints = 0;
 	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts)) {
 		uac2->int_ep = usb_ep_autoconfig(gadget, &fs_ep_int_desc);
 		if (!uac2->int_ep) {
-- 
2.25.1


