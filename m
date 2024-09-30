Return-Path: <stable+bounces-78245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF0989FA2
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7B31F21FC7
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94C18BBAE;
	Mon, 30 Sep 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZhtrAZAb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900601CFA9
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693080; cv=none; b=qJ3G5X3Fqwta+U1pOkQYJduUyARJ7w/Jx10Y6xBscMtguog7ooQ5KLzz7hBQkK9d0b/qnwbope4kjNcZkd7/C9l3bPpint2H4AT6/zX4s2wxnYf+/aVESXia6AKEANZhr1c04je+/B4g70UxXOOJ/29atdAFFLHos8ITdW2H8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693080; c=relaxed/simple;
	bh=Brgos7CnbGWGJd2NtGmjE5E3I+CrnBntojNJAEtJTMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHjbl7SpAZ7jy9zj+hdMKpDuavOsDX3ZCiOAr0L+FQg3V/r3xEcJXCSGwpuZUSR77oAu3YjzgGxB2FUlgH9NrMHZxFIJRL9L+gYyr5mYSI0tAXYrcpcNoWmCAEGxVFnuhrDDIXhWCnkV2iwE68onDg2fLrhIn3ebgCXnOfgrx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZhtrAZAb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TMt4k2026709;
	Mon, 30 Sep 2024 10:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gqsoG9dX1i/Jsd1PxLP9Cg2HimFmmvo9dg/nrBtxc7g=; b=ZhtrAZAbgGBantsH
	raJjO6+oNrF67YgYot76HYbVmhOF1TjwdJeTadzJ0WL7lwm5cahh93Xb7s7TDI15
	UnkYO+OpcEKf0tg8uj4hNlgI9QX794HTDDS9U9d7w0j9oKOBvOTAdXcYEN/hHsyN
	RGieqBWKS92eQlMfeHH0D8VqeYz6ikzpXR1BV01pGjMmsvNU44djIx5z6ll8GLBj
	fj+K7ojwCATlCv6kP874+eZ5inrFTZQK98zoWGBDLX/NGWKtIQlkNRI2cR5O/8O2
	86dE4kxildhBNKNCtyTPyRHQa/5aPtLEaPmuggM2pvtWDjAlKYgndJuBJmKR2bH5
	ghb0Pw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xaymccd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 10:44:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UAiaCL006554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 10:44:36 GMT
Received: from hu-vikramsa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 03:44:34 -0700
From: Vikram Sharma <quic_vikramsa@quicinc.com>
To: <bryan.odonoghue@linaro.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH v3 03/10] media: qcom: camss: Fix potential crash if domain attach fails
Date: Mon, 30 Sep 2024 16:14:08 +0530
Message-ID: <20240930104415.16917-4-quic_vikramsa@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930104415.16917-1-quic_vikramsa@quicinc.com>
References: <20240930104415.16917-1-quic_vikramsa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ndJ9YVt46F_jEVa2k0bCcKLIMdFHU4TE
X-Proofpoint-GUID: ndJ9YVt46F_jEVa2k0bCcKLIMdFHU4TE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300077

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


