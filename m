Return-Path: <stable+bounces-179710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4CB59275
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F111BC4AF0
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBFF29B217;
	Tue, 16 Sep 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZMzOkBu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196A286890
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015618; cv=none; b=ug+mmBC6yBKzWhv464RlS42JfJFBp/IggayHzqiYkBTWMw8iDpQmkdsE5w6/1gk6W6et28+N3/a/IJUNMHO3c4UKSw3xt2oZbqsSmv0wkBP5EJTijbreU/OZsixSZpDLq1iH0pda/9BDOB9ViQ4X+jUfsM9GP/BAKzGtaIFbCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015618; c=relaxed/simple;
	bh=/AN0edio5MaldEncQLvD0kSKxTKUGpgRttz9iXUqZxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofI9DiQCW+il1k65srDa+iN3YHX5hPnZCcnSv8t+ziL8g36Y4LhxjI2fCfo+kueTI65vGnGnclxjKFzduJK7+n/7aiecpmNbAZnn2ZCF9VXEAEwiW5pd2X4dK2waQV1DNVbIrGtzPu9Mr3bMpwhlXXy4ocHaaTFz9u+UbfAR7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZMzOkBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3ptnl012590
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SdbaG+qQMcuHskGeXqpUq0AHk1Ukw/1hxqZ
	/MRYhBG0=; b=EZMzOkBufAGzt8zUKa+ntj9/CVAth93d+7cckdcF8ZTiDToWPuG
	CscdwL+BVXtjmkPH0VohXQCskDnrtjelQBRHsrha1Cs9tEyIWYdcx+bvt/YTwIo7
	Tin5+4pB3Oc2wxQuRsMZGrJn5YRJgZJo5guCmcoihIMAXTLOOx/MRnR0qS4yReuS
	GNvFAdqE4tox4iHAJajKJfi/VtG4Dr7Fcs9QIJxiHMeP6B2Lj7yzjU2DyoCOseku
	2q/AqJ50zm6NYDacIUl5AOgoIBShsjEGQO0bAEL9WMkQLLMO9OKdDSGTTHU0NvPx
	9DnReY10lUbGmEO7gucYkowJ2aJP7ilAylA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12m164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2675d9ad876so23319855ad.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 02:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015615; x=1758620415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdbaG+qQMcuHskGeXqpUq0AHk1Ukw/1hxqZ/MRYhBG0=;
        b=CnrllQj1+GKOGS0K/0o6KuJYdFxJCk4WjcPSkDPQ79Wa7tzUrtXh96QI35jdEe6yq8
         PEauLVfJibTPz0JDfpL9XMugpl1qJr89wXjVm9RDOQswzymhNaG6Kuofcf7eKG20dfY3
         +mom4v+tynsYWZ/7ZpuSGZwU3c7OopWu9jO/XD3C/2uBYadwAlbEMK2FYHTwbrwGSwex
         gpA0ZWCBUmpdjO9oEQqN7FeG00xou0zeIMPTAhMkKAty5/kb+pMZ8v7ZWF2GYdoZBrRE
         H1044/66AzShoT4NTHODAPZmvP7PefDB4DAl+IC8LQwzut/F69T+BJO0AgY1TElaE2aj
         e+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkEhlyTr73dx/ATRJxHhs6I/CT5V4OIXuWACR95CPZj/iwF4uzUYweKxC9FHdenIpg26QzeaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxtdkajtV3Gxbc9X/S3PeETqbF79M5vNocCA1slEIDim8Stk5
	mt3SvQ1Nim3/YnXB1Wt7mZmJc48gv5SHN4AZ27/hNh63S3yX8ZxQnSa38NatEGjcO9lcJ9xIZoU
	J7eP14pqpBTvsd1ebivpJRkYUKYLNNlljygxqoXEb427ECLXXwSLJ7g2R7NY=
X-Gm-Gg: ASbGncsS/KGeMYNq+i65E6WmqSN+ZUa6FoBp1fniEut4oLgbrxWXwX73LHg5pR1vAOd
	AwNxUsrRGEMtfgIho4uXqn4MbhfPBS4e9fi4PrhPiaeCRK/MxWP/NfDMBIhMIvSw18gDcomGr7E
	Mr6X6nBdy0KDN5zTrdt0wHdT6IkdM+0fX+exElGnR2Bo8p4lNx7GcvzncvCzEUVS442pD23i9Ts
	TpWO9hrupFlD7c3TbzmcQ24Zg0jp09ZNS0HaTCLUkFbmWHzBEZwq+avACG9ITV4eGrsQpB/ZjBN
	tArKNljDzjboE6LDyBPi/+0ZQ2WM9vvU3AQbYACU7gzVWfFYOL5dT3Ye/ZvoZ++wxJymz43QFg=
	=
X-Received: by 2002:a17:903:3c2d:b0:25c:b543:2da7 with SMTP id d9443c01a7336-25d2528c254mr178027555ad.9.1758015615270;
        Tue, 16 Sep 2025 02:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iRujT5RyN/Y70BYxNaVIMPtLsc7G5+gxIL9VhuL7Lh/nsZi48blzFd7jfvLmyl8MB9cHzg==
X-Received: by 2002:a17:903:3c2d:b0:25c:b543:2da7 with SMTP id d9443c01a7336-25d2528c254mr178027315ad.9.1758015614822;
        Tue, 16 Sep 2025 02:40:14 -0700 (PDT)
Received: from hu-anupkulk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2663f633893sm55434465ad.119.2025.09.16.02.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:40:14 -0700 (PDT)
From: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, quic_ptalari@quicinc.com,
        bryan.odonoghue@linaro.org, quic_zongjian@quicinc.com,
        anup.kulkarni@oss.qualcomm.com, quic_jseerapu@quicinc.com,
        quic_vdadhani@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for RS485 mode
Date: Tue, 16 Sep 2025 15:09:57 +0530
Message-Id: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nHYgsIja8vbyOw9jvHmqMwKhtUnVsKFB
X-Proofpoint-GUID: nHYgsIja8vbyOw9jvHmqMwKhtUnVsKFB
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c93080 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZXCm3_ECWB7Dsui8_W4A:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX8QOOlPJwQ1fT
 6Rq1FwAeruCDLy4rWI6Fzyd0fGf19JXlzQ2wMK/OVWEI06LkoKVQ1lHWFAYjT5zXRAJ8UCm6a1/
 lg8qhSII14tgsiutIlnJLPSyi4u1He7ER8Fn093p85HoPr6T1JESMh0Z3jHJccqRyZikBH3PJXT
 GoSGRjeyBsyi68EGdPJlKZY7EtcmfkH4BdEk+tB0/5+z7preKJclgAdvZDg8GqFJK039C7xJCce
 9yxtqY+DpjbtlfvH8InWQCR8fDwCuxrTXMwV+MtOTMMCHgmcR64aETBhTHANJpiQgxiBKm0Isk3
 Q81dKb3GbcLRBEbNtsZB0SZ863ieQFJjweclMrtULJn3fd8g28tjf3ym4OoTXoe08xLe7KnPvei
 imc6sOAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

If uart_get_rs485() fails, the driver returns without detaching
the PM domain list.

Fix the error handling path in uart_get_rs485_mode() to ensure the
PM domain list is detached before exiting.

Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9c7b1cea7cfe..0fc0f215b85c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1928,7 +1928,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	ret = uart_get_rs485_mode(uport);
 	if (ret)
-		return ret;
+		goto error;
 
 	devm_pm_runtime_enable(port->se.dev);
 
-- 
2.34.1


