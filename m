Return-Path: <stable+bounces-10469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82E82A8DE
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7111C2279A
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE56D53C;
	Thu, 11 Jan 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uwu1Q7XX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B32F9D2;
	Thu, 11 Jan 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B7TYrl003904;
	Thu, 11 Jan 2024 08:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=ZoOpTDkO3PZHFU5dQRmU3J9Ylc/ozw3QutY0nMOReec=; b=Uw
	u1Q7XX/4351c6TZfTAn0jKRaFDGJeH2FohuiGDeUzqXBLI8dWJUObveH3PYJKr/A
	zRPYMXuBq9uK5oJmwQagJgXeXEqgSsYyPQTXWHzJVFzGEZHwiO7lxsAjvTPbvU8k
	PgnVq7fz4q17rXHXJ3I6iq5jr9glBv7Vnt2b4eGbqjJe2Dz/+P5nCkXnjnSp7+pm
	meSCut7eOudJTHuLSAygoKw/RYz94PfQnts4cg/Wt9HYcOSXDHTSNEy8Z1uVIyZ0
	v/Ek2ydGKkfeFPRFWkPt2SH7+hTFdM/R1TwbSHJ9Qxr36Zn7x1Dw9cq1KRHkKh1O
	y8lxV/GDhxbGcRGMGE6w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqytp96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 08:16:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B8GOMC015570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 08:16:24 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 00:16:23 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: qca: Fix crash when btattach controller ROME
Date: Thu, 11 Jan 2024 16:16:18 +0800
Message-ID: <1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sMbQPrTlxl-qBcTzGDJhAYj39sy80rSu
X-Proofpoint-ORIG-GUID: sMbQPrTlxl-qBcTzGDJhAYj39sy80rSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0
 mlxlogscore=846 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110065

A crash will happen when btattach controller ROME, and it is caused by
dereferring nullptr hu->serdev, fixed by null check before access.

sudo btattach -B /dev/ttyUSB0 -P qca
Bluetooth: hci1: QCA setup on UART is completed
BUG: kernel NULL pointer dereference, address: 00000000000002f0
......
Workqueue: hci1 hci_power_on [bluetooth]
RIP: 0010:qca_setup+0x7c1/0xe30 [hci_uart]
......
Call Trace:
 <TASK>
 ? show_regs+0x72/0x90
 ? __die+0x25/0x80
 ? page_fault_oops+0x154/0x4c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? kmem_cache_alloc+0x16b/0x310
 ? do_user_addr_fault+0x330/0x6e0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? exc_page_fault+0x84/0x1b0
 ? asm_exc_page_fault+0x27/0x30
 ? qca_setup+0x7c1/0xe30 [hci_uart]
 hci_uart_setup+0x5c/0x1a0 [hci_uart]
 hci_dev_open_sync+0xee/0xca0 [bluetooth]
 hci_dev_do_open+0x2a/0x70 [bluetooth]
 hci_power_on+0x46/0x210 [bluetooth]
 process_one_work+0x17b/0x360
 worker_thread+0x307/0x430
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf7/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x46/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 03b0093f7b31 ("Bluetooth: hci_qca: get wakeup status from serdev device handle")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 94b8c406f0c0..6fcfc1f7bb12 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1951,7 +1951,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
-		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
+		if (hu->serdev && device_can_wakeup(hu->serdev->ctrl->dev.parent))
 			hu->hdev->wakeup = qca_wakeup;
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
-- 
2.7.4


