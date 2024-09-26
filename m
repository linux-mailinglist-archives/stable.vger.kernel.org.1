Return-Path: <stable+bounces-77776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39E987100
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 12:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C61A1C21AD2
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6518E34D;
	Thu, 26 Sep 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyNOjoyf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E618786D
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345206; cv=none; b=YM23LaS+SMTofDDe9RQNjyIBmlJsmYNaQ5+SypkB8ZQ8FM9Nx91PIXB7LlMRKMcoLbA0iMw37mrvSb/QV8TTeTunL7aDikwFcnSc3zmO2VRCUKJS3nZe5R0fyB3jq0OPWDHrGsaZppifIIiTEJB3Eu9SdVzONa4W1C+5arUeY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345206; c=relaxed/simple;
	bh=Brgos7CnbGWGJd2NtGmjE5E3I+CrnBntojNJAEtJTMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiNsT2JFNw9jvEdBTJmF9T9uMlZS0Fe5rA6LQmvEApWMS+8mJqR7IgfZPg3Ua3YVWBY8kLvOIgyDJ77CJuFHppUBsju5PdCKs1IFpMiH64WtNqezv7HOXfC1yH+UUwK8F8LVNig2njVyayw8e6fgEnBrKUxcMGDsXezny4EaKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IyNOjoyf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q7LqcP012448
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 10:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gqsoG9dX1i/Jsd1PxLP9Cg2HimFmmvo9dg/nrBtxc7g=; b=IyNOjoyfayfHL1lz
	nF4ZB5NgVp5Oia9GneUgiJIY6uFOfuIzdNaQYTnwVPPBsIwZ7v9Vpcl8snb8AzMx
	0AZEB7G9wdb6+UWirJckuTmIvW78vJRo9i373hCkX/whYl//YQW6lux04MSVTpAw
	9Ica/pj+v254SM01NZ5W2MzN3X4V28WMQ049CD785Sv1HJ8kqN3letO/c+xPxSFP
	Q1U3oznBDdVbseBQHjH0EnSMq5d/oBN5PhIEivANVOzXMofhvc93VgfZhpphzcYV
	3omKUzYTeMkG3fg0quQLIPnrMzTBUAfb3Gs3u6mqcE+sk38DZGc4c2a4/GjL9d85
	I4JlXw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgnfje2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 10:06:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48QA6gxo026307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 10:06:42 GMT
Received: from hu-vikramsa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 26 Sep 2024 03:06:38 -0700
From: Vikram Sharma <quic_vikramsa@quicinc.com>
To: <kernel@quicinc.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v3 03/10] media: qcom: camss: Fix potential crash if domain attach fails
Date: Thu, 26 Sep 2024 15:35:30 +0530
Message-ID: <20240926100537.1900411-4-quic_vikramsa@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926100537.1900411-1-quic_vikramsa@quicinc.com>
References: <20240926100537.1900411-1-quic_vikramsa@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6wQHu57P-mG0s2p7RU4DPaMSDixOzmkQ
X-Proofpoint-GUID: 6wQHu57P-mG0s2p7RU4DPaMSDixOzmkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260066

Fix a potential crash in camss by ensuring detach is skipped if attach
is unsuccessful.

Fixes: d89751c61279 ("media: qcom: camss: Add support for named power-domains")
CC: stable@vger.kernel.org
Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index d64985ca6e88..b6658df37709 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2131,8 +2131,7 @@ static int camss_configure_pd(struct camss *camss)
 		camss->genpd = dev_pm_domain_attach_by_name(camss->dev,
 							    camss->res->pd_name);
 		if (IS_ERR(camss->genpd)) {
-			ret = PTR_ERR(camss->genpd);
-			goto fail_pm;
+			return PTR_ERR(camss->genpd);
 		}
 	}
 
@@ -2149,7 +2148,7 @@ static int camss_configure_pd(struct camss *camss)
 			ret = -ENODEV;
 		else
 			ret = PTR_ERR(camss->genpd);
-		goto fail_pm;
+		return ret;
 	}
 	camss->genpd_link = device_link_add(camss->dev, camss->genpd,
 					    DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
-- 
2.25.1


