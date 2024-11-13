Return-Path: <stable+bounces-92964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF79C7EF9
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 00:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC862845CF
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEC18C935;
	Wed, 13 Nov 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MeqaBM03"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CA618A6A0;
	Wed, 13 Nov 2024 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542137; cv=none; b=BCcJ4qVW63HQOXxKI5bmjSfV9owBbVx3WC0Ui+OJ6VNN7nwyrPZUT68daIV5a1bZPNW738XXmSU4kP6cEq/2kK71V7gM7GNh33sB/lTStWLmTec+DubBwekqMohHxDs5CH+PjOiRCx24DQSq3Eg/U0z3ecIRW5yBqYqph1X6dsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542137; c=relaxed/simple;
	bh=ItMqY/DQc5+bQ9nVL1ka+v2Fou18KSYRXrIlxeLivYg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vue2cNBug643bKiDs50C+fcjQeuM9fi8gqxs4A0OHruYgXsM0evIYaDHMyXf6660ttoeH8SQLOyzviFT3GtyRVgQsOtBrOcJaLmhC/BrjVRKcdxq0ag+YkGlhWbv63711Jm2cGbmsWGMRAPtksvFq7+PTEihckB6FTVLGihs3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MeqaBM03; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1QC5015403;
	Wed, 13 Nov 2024 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=Nyfj0bDUA/i5
	CMGSuns1LVirTkcJuSpcYXzxbyy+MjE=; b=MeqaBM03xfYRu0LN1gBmLA/HyvPj
	0aU44TZ+PEfTRcu2AhOhVIFxkdaRZ/qlyFLUrScvcR8jrlGxbMyjYbDscJV8EHmP
	SusBqGyhgtHnWpL5X+NM9gvdlBATnb2LoBzQmga0xzkltF636ULg5riI9B26MTkc
	n4T9ZJnFJf+0rwJOgWX9hMTQqX/P/WoUTNazvps5lzOQLASnSw310RudUZ1thtZ+
	RuIoIdGUsb61izRQwbeLjR4lypbwkf9Jq1qS/3HN7u9IaNx2uYZG16dPYq6IivOa
	dDKseluzoQBmydCF2NxOWxC5IorPSFHStTOPPU0xJqxEw6FiPUrs0UlUzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf32559-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 23:55:30 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADNtTVO003188;
	Wed, 13 Nov 2024 23:55:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 42vwj4khsx-1;
	Wed, 13 Nov 2024 23:55:29 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADNtTBk003183;
	Wed, 13 Nov 2024 23:55:29 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 4ADNtT5H003182;
	Wed, 13 Nov 2024 23:55:29 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
	id CA8A850016F; Wed, 13 Nov 2024 15:55:28 -0800 (PST)
From: Elson Roy Serrao <quic_eserrao@quicinc.com>
To: gregkh@linuxfoundation.org, peter@korsgaard.com,
        michal.vrastil@hidglobal.com, michal.vodicka@hidglobal.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2] Revert "usb: gadget: composite: fix OS descriptors w_value logic"
Date: Wed, 13 Nov 2024 15:54:33 -0800
Message-Id: <20241113235433.20244-1-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jG3x1PpwfQOLRWJVSj_Rjzg2vvmbNKv0
X-Proofpoint-GUID: jG3x1PpwfQOLRWJVSj_Rjzg2vvmbNKv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130192
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Michal Vrastil <michal.vrastil@hidglobal.com>

This reverts commit ec6ce7075ef879b91a8710829016005dc8170f17.

Fix installation of WinUSB driver using OS descriptors. Without the
fix the drivers are not installed correctly and the property
'DeviceInterfaceGUID' is missing on host side.

The original change was based on the assumption that the interface
number is in the high byte of wValue but it is in the low byte,
instead. Unfortunately, the fix is based on MS documentation which is
also wrong.

The actual USB request for OS descriptors (using USB analyzer) looks
like:

Offset  0   1   2   3   4   5   6   7
0x000   C1  A1  02  00  05  00  0A  00

C1: bmRequestType (device to host, vendor, interface)
A1: nas magic number
0002: wValue (2: nas interface)
0005: wIndex (5: get extended property i.e. nas interface GUID)
008E: wLength (142)

The fix was tested on Windows 10 and Windows 11.

Cc: stable@vger.kernel.org
Fixes: ec6ce7075ef8 ("usb: gadget: composite: fix OS descriptors w_value logic")
Signed-off-by: Michal Vrastil <michal.vrastil@hidglobal.com>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
Changes in v2:
 - Added comments to explain wValue byte ordering discrepancy in MS OS
   Descriptor Spec.
 - Link to v1: https://lore.kernel.org/all/9918669c-3bfd-4d42-93c4-218e9364b7cc@quicinc.com/T/

 drivers/usb/gadget/composite.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 0e151b54aae8..9225c21d1184 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2111,8 +2111,20 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			memset(buf, 0, w_length);
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
+			/*
+			 * The Microsoft CompatID OS Descriptor Spec(w_index = 0x4) and
+			 * Extended Prop OS Desc Spec(w_index = 0x5) state that the
+			 * HighByte of wValue is the InterfaceNumber and the LowByte is
+			 * the PageNumber. This high/low byte ordering is incorrectly
+			 * documented in the Spec. USB analyzer output on the below
+			 * request packets show the high/low byte inverted i.e LowByte
+			 * is the InterfaceNumber and the HighByte is the PageNumber.
+			 * Since we dont support >64KB CompatID/ExtendedProp descriptors,
+			 * PageNumber is set to 0. Hence verify that the HighByte is 0
+			 * for below two cases.
+			 */
 			case USB_RECIP_DEVICE:
-				if (w_index != 0x4 || (w_value & 0xff))
+				if (w_index != 0x4 || (w_value >> 8))
 					break;
 				buf[6] = w_index;
 				/* Number of ext compat interfaces */
@@ -2128,9 +2140,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				}
 				break;
 			case USB_RECIP_INTERFACE:
-				if (w_index != 0x5 || (w_value & 0xff))
+				if (w_index != 0x5 || (w_value >> 8))
 					break;
-				interface = w_value >> 8;
+				interface = w_value & 0xFF;
 				if (interface >= MAX_CONFIG_INTERFACES ||
 				    !os_desc_cfg->interface[interface])
 					break;
-- 
2.17.1


