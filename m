Return-Path: <stable+bounces-10360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C53828231
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 09:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8591C23DDC
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E925756;
	Tue,  9 Jan 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QBZHhu65"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4A321AD;
	Tue,  9 Jan 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4095p6RY014644;
	Tue, 9 Jan 2024 08:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=7RHWn45svsCv3oa95j9KtBZTmCT0r/4lkhzt64G1rLE=; b=QB
	ZHhu65cE3clddaBXoqgvIL2WaIpdaSeXWWXJ+V+3uZXDS5klokZ40uQgV58FWwGx
	qY2JnT5jQ3XYyObEDi1kWhj3kvmJ1B+ej4BgbfBYkXZZwrC8/h1LZZhyIpdPxmp0
	46kmLwymuCZ3kTMb74FTeN5Paksas4+pMTuDxOP2L2/M+B1oDHgISnf3Xns3YBjU
	1krr2aKkkKF48cztRs4EMoZZBzv1ADFNjhfcneGH6cjs+T7T5Kh8rtAO9oOIjB1Q
	7gJdj1jf7YmVDLhr8qC1qrhzAWDvzqByuU23W5O8njEvxh6lsNSYsg++sTuSTNR/
	Uxlu2KcNhuWgozygw5yA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwhs8kky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 08:37:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4098bhs5010790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 08:37:43 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 00:37:41 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1 1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are wrongly recorded
Date: Tue, 9 Jan 2024 16:37:30 +0800
Message-ID: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
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
X-Proofpoint-ORIG-GUID: U3N-nRwGcP9eHTmHTW8sUlh8oTESUqCs
X-Proofpoint-GUID: U3N-nRwGcP9eHTmHTW8sUlh8oTESUqCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=883
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090067

hci_store_wake_reason() wrongly parses event HCI_Connection_Request
as HCI_Connection_Complete and HCI_Connection_Complete as
HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
stability issue, it is fixed by this change.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef8c3bed7361..22b22c264c2a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7420,10 +7420,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 	 * keep track of the bdaddr of the connection event that woke us up.
 	 */
 	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_LE_META) {
 		struct hci_ev_le_meta *le_ev = (void *)skb->data;
-- 
2.7.4


