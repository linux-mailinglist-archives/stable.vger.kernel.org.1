Return-Path: <stable+bounces-170007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358FB29FD7
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8017A308C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8274261B8C;
	Mon, 18 Aug 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KDtMuP0O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1056261B62
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514768; cv=none; b=ZlXuFrVJdM3W7UtE1hH0MPVuiAjCiXVfkDN8AgCM/D3jS/rwuaW3XGNiJhvkFLSPorg91uy9Y8K3q/QOi2uFaDWec/yEkfGF3IYi5c6IPGNQc1sWJK2RLhrtaGbKLZ7XcVXCvMtAmWHE7W6VvFm3Mhmg4Y1lq/KJg+8YgHape/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514768; c=relaxed/simple;
	bh=TWI4NDV7omZnoybzWvZw4G7KXwDtlIFuMmatVEKdooU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pfRgtNsXd7ed6TGE8RYfkLfz62ybAMegkfteomAUoKsyBbl+k8gBNqIg+7MRVqT5VSQ7tocCSm90KTEPjVgaMhAmaV9HFj4K0Whd6xb+iybz/N/4151jMtrjPXPXtxZ6iTEwOkOWWEAcRr7tF2Cic1ktX7aRsv0EiP/f1uCeSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KDtMuP0O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7VApt026395
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lYQqNeoRMH/Jf573LZ3mZJ5yNeY8aFkKqVi
	voDveUck=; b=KDtMuP0Or4TnxGnW+uXqSnD8SVHyQK1ai3x1jySqQvbuH/BIPgO
	zkwTpiofaxFbp2LnIjDuFKq64G+B4VbDOvr1SSFyNLXipOqtwf+sWfdyIk0eWgB5
	MCol3U/2XiNrTwdwnu579MdT9Ev2yEuBYdzdE9NRRPX/geWehGFuuBWug6AJAulP
	aq/QmNMeYaZ/w/COnKQp6KQCC+bE6GE+6wXdKsbwKDkfuB0910f2Njpo4JVW0itj
	FwLfP/OcS1zF/Goa778koEhELMPYWe43W7BZ0ZSSBtaBspJM96gIm7V+qJDd2BZM
	wHwzP62AB/4bxH3YjN6q+AWfnvh0n5vGd5Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunrkna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:25 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IAxM80022860
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 48jk2krdkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57IAxMC7022857
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:22 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-anupkulk-hyd.qualcomm.com [10.147.252.186])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 57IAxMJM022856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:59:22 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4405423)
	id 036695CB; Mon, 18 Aug 2025 16:29:20 +0530 (+0530)
From: Anup Kulkarni <quic_anupkulk@quicinc.com>
To: kernel@oss.qualcomm.com, periph.upstream.reviewers@quicinc.com
Cc: quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com,
        Anup Kulkarni <quic_anupkulk@quicinc.com>, stable@vger.kernel.org
Subject: [PATCH v4] tty: serial: qcom_geni_serial: Improve error handling for RS485 mode
Date: Mon, 18 Aug 2025 16:29:18 +0530
Message-Id: <20250818105918.1012694-1-quic_anupkulk@quicinc.com>
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
X-Proofpoint-GUID: lvoLeqBqA001LEBZsmuqglJVDzw-Pdp4
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a3078d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=bGVla3ei2X7EtWq2w9IA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX3fVHJ8XxDcOC
 GBaWEfsMd14cyG/5/dxDj02xBnUpUSpIuflDYEqk3yA7Qmo/06XBG72Kjd6WEV5KT9xG12glCLK
 RqDM6nzPH+zNYqG1HyDTuAls1azASdFPFUqhVH+QtLZJE4a6WE9q8gRbCI9yP0v5EX3Sgh9129+
 tlm3bvVEufRQa7Kq7Q9gf+2VZaevRzGDDi8Ha2u5N2FmOdDcIeWiXcsnI2EKwtHoS3QAJlM0ZZV
 R3JQWvN06IoLAMNrf8vIWWZj1y3AjoWDbr/vB8cF/Oc4A+Od3ts4x/dc68INy4cg/NVt6nyh+O+
 lXJltxO+Z4UJs7gBkqrJKmq28GP7it/C038w/dos62us7a5sA1wOIMuIwbqlY+6nixdmDh4/XgL
 gP7PP13F
X-Proofpoint-ORIG-GUID: lvoLeqBqA001LEBZsmuqglJVDzw-Pdp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

Fix  error handling issues of  `uart_get_rs485_mode()` function by
reordering resources_init() to occur after uart_get_rs485_mode. Remove
multiple goto paths and use dev_err_probe to simplify error paths.

Fixes: 4fcc287f3c69 ("serial: qcom-geni: Enable support for half-duplex mode")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
---
v3->v4
- Added Fixes and Cc tag.

v2->v3
- Reordered the function resources_init.
- Removed goto.
- Added dev_err_probe.

v1->v2
- Updated commit message.
---
 drivers/tty/serial/qcom_geni_serial.c | 38 ++++++++++-----------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 32ec632fd080..be998dd45968 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1882,15 +1882,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 
-	ret = port->dev_data->resources_init(uport);
-	if (ret)
-		return ret;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -EINVAL;
-		goto error;
-	}
+	if (!res)
+		return -EINVAL;
 
 	uport->mapbase = res->start;
 
@@ -1903,25 +1897,19 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (!data->console) {
 		port->rx_buf = devm_kzalloc(uport->dev,
 					    DMA_RX_BUF_SIZE, GFP_KERNEL);
-		if (!port->rx_buf) {
-			ret = -ENOMEM;
-			goto error;
-		}
+		if (!port->rx_buf)
+			return -ENOMEM;
 	}
 
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
-	if (!port->name) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	if (!port->name)
+		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto error;
-	}
+	if (irq < 0)
+		return irq;
 
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
@@ -1942,12 +1930,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
 			IRQF_TRIGGER_HIGH, port->name, uport);
-	if (ret) {
-		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		goto error;
-	}
+	if (ret)
+		return dev_err_probe(uport->dev, ret, "Failed to get IRQ\n");
 
 	ret = uart_get_rs485_mode(uport);
+	if (ret)
+		return dev_err_probe(uport->dev, ret, "Failed to get rs485 mode\n");
+
+	ret = port->dev_data->resources_init(uport);
 	if (ret)
 		return ret;
 
-- 
2.34.1


