Return-Path: <stable+bounces-192345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68DC304DB
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A134B4F3933
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135A296BC2;
	Tue,  4 Nov 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PkDN5HkL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F328C00C
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249111; cv=none; b=ahVY6HZgrFAnJBaGn8hSoHt8POd5RR1qtYdncb3p3y5q7SRwNU261LAuup3AmqtufCs+BVjGaNAvNJwvJyYHCBTQwoWi3K1tdJgAbNkJNzua0BV1SW4/qJ/QIcrQgGDojnXaSOf5/XHvdNBjkebTSG3/Dsv0kwVnkWOA0MgiRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249111; c=relaxed/simple;
	bh=Bh/fZvNVUtpZqy1iphbeFcZdiiDFYAV8+2UoBhrjjSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amfBLsJCqU2/Y2W3JP7qqHQFM5sM2QRYAnStkxLV4vECDNIiYaRJFVwI8IY9nwOp16F2aPEirt8fNA0+sAizQ8JmPBIQFsT2G84DxEzANqXdbRCYKMvncqqfNsVnp21L5Rugj8IEIggF+LquHmhFF7/B1eDV/9qO9BbZTBcuvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PkDN5HkL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48fiQK1488891
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q/klRFV2JYcdv2I+EPFZJCIcBLeZhyHI4B/
	2zgli4t8=; b=PkDN5HkLhau8oxNSBCvaG92wkiPVH/3oLwHDErcp7X75LIlyirD
	eZACqHpeF13bLz+unZgbs+vdMi5o2tluIvaHSICqLxqHyqWQQADJbYzkVcUIoceE
	/pYVW0074Hub88gPXw2ZSchADSbisYFtsKdVfde1x9AeQcqRFqEAyxxAYlCyApqS
	ce1e+7vaTEpCQ2VYJoj0hN9mqC46igPTKFoBuCDbWNgrabTO2AEu/8w49G3wMJYr
	ncMAyrw6DKQi9f3UJloyp1wsBXCZqmFRFoIgBSz/YuDZtaVEWULAuE/kvadUl4Fk
	rOiwSdVBIDPGgZRABK3k1eRMqbsPXOFWCgQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jgj2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:38:29 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A49cQvQ014573
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:38:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9mqwvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:38:26 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A49cQ6C014568
	for <stable@vger.kernel.org>; Tue, 4 Nov 2025 09:38:26 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A49cPlL014565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 09:38:26 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id D229723244; Tue,  4 Nov 2025 17:38:24 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: quic_shuaz@quicinc.com
Cc: stable@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_qca: Fix SSR unable to wake up bug
Date: Tue,  4 Nov 2025 17:38:22 +0800
Message-Id: <20251104093822.2443619-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3OSBTYWx0ZWRfX4CotQ3bnKQrT
 djq4eFknuIsEwBCF7+YGbMMiV2Qyk6tHiDDTsvofYOzznpd0f4V5JME5XQOgUjk9qRrY+rWDB/P
 awEGRp7qCE8FfjYBX/XDS9AA2evz0x6aQjOBcBepuVupVcCXYzDYNeiosm/sY0TdRK55qfO1zTH
 U1boo+JaFa/EcqOe4A+x7zOPAEhZs3cpf2bqaWN51/xki7AYIYevbm3aHxjmC75vR8aE3Tgp35U
 IW+6oA4PBEuYpAKvm0kdH+TwEaeVibWkcaDqN6o5j2zBNaneGT28MZo19GweeCgh6d0yV5uLsD/
 B52dQrSnFOE+jEjyNEfAZyx1ud15W4j+Rvlr+MJQU0tvspX+VXW/37IErRPVqe088jMHup6Lt+a
 IWPdN9lW2p1tE63C1EKri8/39AQBTA==
X-Proofpoint-ORIG-GUID: P2AKplloP7B3MHcWH9aGrdycWUsUQZW4
X-Proofpoint-GUID: P2AKplloP7B3MHcWH9aGrdycWUsUQZW4
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=6909c995 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=m-5Lm1s-rEeNAmgHswEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040079

During SSR data collection period, the processing of hw_error events
must wait until SSR data Collected or the timeout before it can proceed.
The wake_up_bit function has been added to address the issue
where hw_error events could only be processed after the timeout.

The timeout unit has been changed from jiffies to milliseconds (ms).

Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0f..a2e3c97a8 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1105,6 +1105,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 				clear_bit(QCA_IBS_DISABLED, &qca->flags);
+				wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
@@ -1182,6 +1183,7 @@ static void qca_controller_memdump(struct work_struct *work)
 			qca->qca_memdump = NULL;
 			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+			wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
 		}
 
 		mutex_unlock(&qca->hci_memdump_lock);
@@ -1602,7 +1604,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
-- 
2.34.1


