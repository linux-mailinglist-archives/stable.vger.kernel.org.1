Return-Path: <stable+bounces-172830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCBB33E66
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357C21A8241B
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4982E8E00;
	Mon, 25 Aug 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U7jazKps"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B82E7BD3
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122738; cv=none; b=VEAi0SKMZw4MneNo+JjIyhe7crTysdLEVlq5OA6gLbNwWiMNv+qIQAVS60FvsNBgyx4yTks3+Fw+4aHftBIPzq9/Rx5PqHGBLuECPnXTDm2rRwD+TbDeS+jVpaDO4grlPcpDplyLlsKnAANTJ9Y/Tj8oq9ufiuRlHbl3cRZnwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122738; c=relaxed/simple;
	bh=y5Bq2C2XFu4tjzarifro/c1pTg5lvkE0QF25A4Uh1EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2mlvJa35mI+A95XIgepkfiupSGPUpp32oBNJ7Z/GLUZM1BW7efrf1YsA2C5cxrZy3OA/QSai1b0eZM28lPoVGhI25YBY0Dx8RAsCofsJc+qQhDDpAzOJUq47AwlHXmApi/AHoKGhW/eukT53OFK6itDptXWvu1F0k+Gf+L3wVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U7jazKps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8UGxX018243
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HpYASGZZmsu81nylw1xU5enO2W10dco2kzYUMmfi47I=; b=U7jazKpsZDXXnFpp
	bpXf9dA3wQ3+RLo6cy5nsIr9jH0A+fZJu9ecSGUclxGo4pep2aUhDXYsFI9Nno2f
	AasAc7WhtKeezpxohqPF3VhAhmBoh4bBXWim2yokuGTwt2RyO2fp19l/7IqLN7Cq
	oNNGTojrzGVTrxvYs71ZL7obyuBaRrAgigpOnuhu71SIxRl4PEETqUj7cIKo+HrM
	fdRQWLH5KfKRwtYS2CTHtC1dkdzRNNoU4D5fMXt8S6b1DQ0qKs1F+wF3+0nE8NTY
	xNx0VwOFjeTxXcDhB2i717xVtrXaIuPvsG++veTrcKD7lVGw3peagHF3p5ulQhYO
	9CtOOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615cvw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581c62faso54029985ad.2
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 04:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122734; x=1756727534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpYASGZZmsu81nylw1xU5enO2W10dco2kzYUMmfi47I=;
        b=VB7AytyiC9HX2qgHEWL/6ks9POzYGFh9YhW0keQ9k1QXCcojrQ/OO/+caMeNzr6pOb
         CESKDDzRvgaYr1DzCQEZilQ47x4WwNBHoEEx+31gnkRcnizDSp42cRC4QyDRVYhylU/v
         MjPXRYGpXaDuCx6+TA+gsNVnILl32TjF0McGDFrt9sKE1ciFwEuyZrS+bE1UM7Jdf1FN
         AOjKEK1q4KErjAeE8JlkWLK2SJ9nvdYw2p2bE7jcGRvGSUXMqz7tIBzCPQTLf1vFOaW3
         a91J/WNIZDAD1Qu/B2qGQyAvhqQhOjfE8D1EFL9zvHM0Ko5B1iHD3penEFAKz0M768sA
         QP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7rM8uomrdvmn3+G7rNTUsKA70b0PYq94eslCdQ9Zt1zv/JBqyOVXlRPZ6vMm8nTfPejrSW1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8lmPE0W+yJjiRV2andzS15bzXaXIEfAqsKtzrQaaLbzLlyZ3
	XMVZFhUJ7jFZeB5gJVS84QdT/QZxfFXJIjygk7S8kf+6oIJbnLluxUQrbii6GmDn0xYflPG30RO
	G0i+x0wYQNJG5iS6bUcqJwEXN/gkeLnDE40SXqc3BZHCQfWIOLhpEf2iEo4A=
X-Gm-Gg: ASbGncsisAODEePoye79id7oIVwtxTDBiiHptN1AwuXUFzGexaBRsltXX+Pvmbyu4NR
	2e9/mgTfhH8HX4wPWFq+eduyPsOjAci2D3TuCt+fRYAslFqN7dgYmmmWa5snM7vkdSsq13pRgce
	mYcF5enHhmjxozaFiXj3sVOKOFqaryws5LRv/IbZRmxsTrw2Ifk739Akd7RPE6axi5XlGXkK4GV
	08hTI47mJ+/RS6Z82V8wzK/amnhTdevnOpWj5ynBoSOpM+UGkH9YX72hdXB/GR53YSCcmLj7bVT
	iRCxx0gcYRw+P3nsrj3fihfeZBX/Ih4o0nDWkr9hJvy2lMh9zYA1WSk05mMfPbCkb0EEgeHqoON
	q+FK21gPl1rY+r7EkbBWF2K/btpc5qP+90rsuNt3f1HCP/gVPPspX3za8waGXoKDCYAT9PxZOxU
	c=
X-Received: by 2002:a17:902:d603:b0:246:a42b:a31d with SMTP id d9443c01a7336-246a42ba453mr73367125ad.44.1756122734556;
        Mon, 25 Aug 2025 04:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf+8bmXr8Korpvwp3mX4WK/6McGdstI2tyTFrLp1MRPj7QLOOcYirhdLAQzg0QNUqxZUKcpA==
X-Received: by 2002:a17:902:d603:b0:246:a42b:a31d with SMTP id d9443c01a7336-246a42ba453mr73366755ad.44.1756122734086;
        Mon, 25 Aug 2025 04:52:14 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:13 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 17:22:02 +0530
Subject: [PATCH 1/3] phy: qcom-qmp-usb: fix NULL pointer dereference in PM
 callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qmp-null-deref-on-pm-v1-1-bbd3ca330849@oss.qualcomm.com>
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
In-Reply-To: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=2291;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=5tHHmTTWnCLhPgSdJhVTTRMV12QfK1s/7g0qLan1GPM=;
 b=+4h5dOsKc93rJTyxtpkASa9VdaD7psJ6QMS6m9i1mhrHVmyUqXzUcMpMjcXA2aa3vT7uXpa0F
 VdoBdRAqnuNDB1vN7nu0jdjIoAsFEZ+3XsCh4rwsmmT8F4sKZ2dsDpl
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX3If9BtnjOYr6
 2Q61YyKj2mIaV55xRTjTJjPfbgFqf+uui6yuvNDgk8gmYP1A/vER9HMyySoI0/aZw3Sdhp3ckKE
 yCdazclEujpHK2B0r449vsV97H9KbbRYwM6t7eB0kkvPbBJQFNVjv9SvfnlCYUM068j5PWMMeeU
 r4JcuF9Ap09sDmTg5P32sqlcjHU3HmnA2+pUwrMCmJZUkz/y1fNR/MgcPHeC7O8KxwzA1ifCfWO
 a1QzgYIakqhcrFZ2h1NVvqffqZXF1PLoHA4mefv/rPzZN6wxx9DsQuINKQz5BkppypX6ERzkM98
 daniuLbZuw39f4tqNO4vGiuhTXyPb5qixgkl4jFERX/jPQpWyh3s2+jlfqvtszRdR0lJOGkPbdr
 WvbmdA+C
X-Proofpoint-GUID: a6kVq2x1nEgnocrsnbs-RHIVCyZAfBu6
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac4e70 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qjlM38Vp9SSmJgUIidoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: a6kVq2x1nEgnocrsnbs-RHIVCyZAfBu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

The pm ops are enabled before qmp phy create which causes
a NULL pointer dereference when accessing qmp->phy->init_count
in the qmp_usb_runtime_suspend.

So if qmp->phy is NULL, bail out early in suspend / resume callbacks
to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
qmp_usb_runtime_resume.

Below is the stacktrace for reference:

[<818381a0>] (qmp_usb_runtime_suspend [phy_qcom_qmp_usb]) from [<4051d1d8>] (__rpm_callback+0x3c/0x110)
[<4051d1d8>] (__rpm_callback) from [<4051d2fc>] (rpm_callback+0x50/0x54)
[<4051d2fc>] (rpm_callback) from [<4051d940>] (rpm_suspend+0x23c/0x428)
[<4051d940>] (rpm_suspend) from [<4051e808>] (pm_runtime_work+0x74/0x8c)
[<4051e808>] (pm_runtime_work) from [<401311f4>] (process_scheduled_works+0x1d0/0x2c8)
[<401311f4>] (process_scheduled_works) from [<40131d48>] (worker_thread+0x260/0x2e4)
[<40131d48>] (worker_thread) from [<40138970>] (kthread+0x118/0x12c)
[<40138970>] (kthread) from [<4010013c>] (ret_from_fork+0x14/0x38)

Cc: stable@vger.kernel.org # v6.0
Fixes: 65753f38f530 ("phy: qcom-qmp-usb: drop multi-PHY support")
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index ed646a7e705ba3259708775ed5fedbbbada13735..cd04e8f22a0fe81b086b308d02713222aa95cae3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1940,7 +1940,7 @@ static int __maybe_unused qmp_usb_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -1960,7 +1960,7 @@ static int __maybe_unused qmp_usb_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}

-- 
2.34.1


