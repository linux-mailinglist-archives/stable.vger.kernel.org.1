Return-Path: <stable+bounces-54631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9F90EF25
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3149A1F21EBC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8A14D435;
	Wed, 19 Jun 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WyfZ5fRH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A314B07B;
	Wed, 19 Jun 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804305; cv=none; b=CqioQhuTWABGeK9n9jnjZiSqc0hjLnaks646PonRZHNkmSVykswFz38xOnxOrloV9256Z7VcQb+ReoA9MNbrNPpCHuru99TP97xWfSF8Z1My020GFyDwmKbZzI4dAbWmko/AaMQFGbMg6McFdi+oo2YcT6E/bh8/N888MQaBkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804305; c=relaxed/simple;
	bh=SvtuSt99Tk5wQnqOp2pO5wt2zrI2sqnYLig5J40AhFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UEpmf0QlfwrAMhaHPSppbfIfn1xKHiPcZGDCLhmpbanEC80ld6TNsbVWfVUy7nkYcPfwT5KhQf/bfOcXIjoVLemgpz0iLTEafIOlHx1U7JuFLqo+NJ40JUVXQp3SFOfeG9X6dMJ5A4KOyIJNwDFKlsQ5b0cZS5ArABM+eTcMpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WyfZ5fRH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J94TkR028107;
	Wed, 19 Jun 2024 13:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=wmc9yXm6YYelx2SveyXhM4tX8o/evlMO87kCjt5ozlw=; b=Wy
	fZ5fRHRHrkbU2G2iM/WSGHJLPG7nI7VpWb9DRoZ2JgnAGIN+xLcJh2BM2h23bOd6
	EsPXKHJRm2nCAk6lOJJVwvb8IlUU+yxv7BMgnHgp4yo+bXhpx7Zo18GT/lQkVAZk
	yL2gxSNzwWW/3PprS42EhvegU0qoVbswhRinEZ69iNVb5u98lsuiuhczRwVOkP5e
	Lydyqp4lv5PMAhN+RvvDmWqHEfj5TtuU16bjLUU+nAq+HP9ADTJb5ECCWT1yR5TS
	cM5Fo+/VEdXtOUDbE1MKUs5k0VoWN9YZksb4X9gJWjtfH/bZbGM4Y9qE6SQjHigO
	qFTUVLUECOICcnSVO8Yw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujc4hup7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 13:38:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JDcF3h011447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 13:38:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 06:38:13 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <davem@davemloft.net>,
        <madalin.bucur@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v1] devres: Fix memory leakage due to driver API devm_free_percpu()
Date: Wed, 19 Jun 2024 21:38:01 +0800
Message-ID: <1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1DDGqvlaRIoDyGUXpxiNc7iCsdDimskf
X-Proofpoint-GUID: 1DDGqvlaRIoDyGUXpxiNc7iCsdDimskf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=411 malwarescore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190102

It will cause memory leakage when use driver API devm_free_percpu()
to free memory allocated by devm_alloc_percpu(), fixed by using
devres_release() instead of devres_destroy() within devm_free_percpu().

Fixes: ff86aae3b411 ("devres: add devm_alloc_percpu()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..082dbb296b6e 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1222,7 +1222,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
 			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
-- 
2.7.4


