Return-Path: <stable+bounces-45298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA398C77BC
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75404B23BA7
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB0814B965;
	Thu, 16 May 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hNZDVzdj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB214B06E;
	Thu, 16 May 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866344; cv=none; b=qF53sJUmzVJDb6yTHUZVKNS2lXBhs4MF1Dg+tGmws+IVV3G/DjDbS+MWBX6xpEFC/nuczCPz8y7Cy1f3xodNSbp4iWYqPga5ESonzmZL9TQRBxydUC/Eo6B/1Cp8AEybVlTMSXg7vVGTsukyAQOyEBP+ISkLG6beY8rC2SAlCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866344; c=relaxed/simple;
	bh=HsYZoT10qOQGfgRr3VKNQkyb70+BVLLxcy/xSeyokH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOnnqDA8G02b5qtofarIQgCZ5lZMfJCVZBDzjh2zh1BDcZrORWiNPWUA5/lteXE9kgvqTw2R2hFBzjoD7S2GidzrlECsnDsz9Qy7PGt1YUa8u3g9aTOWPichy7pTNyTEmAS1N0vh0K9yk6JIYgqCduY4KpNhSbymHzcvyEz27u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hNZDVzdj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G9r5fW021369;
	Thu, 16 May 2024 13:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=+/eQ88JSeksu5lIGmXlMS3egFKoWcxF11wAcQsE1AzQ=; b=hN
	ZDVzdjopn9NFhjhUz6CqKXoqk35xh/QuZXj1Pm02y0SbJ9/5OOrSxVZna7TI96qt
	L//VeRLocPypGB3J3OwPHMGQTaGVn1Wwnv9NgWsFaVLxQNdduLMw4AgtdaRUEgqg
	PxhIdLEei2uHwafOAEC+V691gJ5LF0f+jqZvvz0eEFPmL0CPrSgQSZfTSvJkxVbS
	YUN62Ym+Fxzw2ZkYz8Oi9cSpppCEmjjX1FeCwdvSKA4VMrQt7QxUOTSCzv7aQl7F
	cmgTRh43NNXxgG0Fypvt9zgv86y20cUnkUiJIwqb/vHMXHWhC6hVUXbzgkdgGwiy
	88CQ6tgWgTgKqA6hXueg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbdvdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:31:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GDVtLl003759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:31:55 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 06:31:52 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <pmenzel@molgen.mpg.de>, <krzysztof.kozlowski@linaro.org>,
        <lk_sii@163.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot
Date: Thu, 16 May 2024 21:31:34 +0800
Message-ID: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: OWR5DugCuC7EIQRlLZgLv4luGjYdLDSe
X-Proofpoint-ORIG-GUID: OWR5DugCuC7EIQRlLZgLv4luGjYdLDSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160095

Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev") will cause below regression issue:

BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA6390.

The commit is to fix a use-after-free issue within qca_serdev_shutdown()
by adding condition to avoid the serdev is flushed or wrote after closed
but also introduces this regression issue regarding above steps since the
VSC is not sent to reset controller during warm reboot.

Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
once BT was ever enabled, and the use-after-free issue is also fixed by
this change since the serdev is still opened before it is flushed or wrote.

Verified by the reported machine Dell XPS 13 9310 laptop over below two
kernel commits:
commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
implementation for QCA") of bluetooth-next tree.
commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
implementation for QCA") of linus mainline tree.

Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
Cc: stable@vger.kernel.org
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
V1 -> V2: Add comments and more commit messages

V1 discussion link:
https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#t

 drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..9a0bc86f9aac 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device *dev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
-		if (test_bit(QCA_BT_OFF, &qca->flags) ||
-		    !test_bit(HCI_RUNNING, &hdev->flags))
+		/* The purpose of sending the VSC is to reset SOC into a initial
+		 * state and the state will ensure next hdev->setup() success.
+		 * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that
+		 * hdev->setup() can do its job regardless of SoC state, so
+		 * don't need to send the VSC.
+		 * if HCI_SETUP is set, it means that hdev->setup() was never
+		 * invoked and the SOC is already in the initial state, so
+		 * don't also need to send the VSC.
+		 */
+		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
+		    hci_dev_test_flag(hdev, HCI_SETUP))
 			return;
 
+		/* The serdev must be in open state when conrol logic arrives
+		 * here, so also fix the use-after-free issue caused by that
+		 * the serdev is flushed or wrote after it is closed.
+		 */
 		serdev_device_write_flush(serdev);
 		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
 					      sizeof(ibs_wake_cmd));
-- 
2.7.4


