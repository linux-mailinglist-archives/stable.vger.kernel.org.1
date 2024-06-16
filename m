Return-Path: <stable+bounces-52306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BC909D23
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EF1B20CFF
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5446A008;
	Sun, 16 Jun 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CwvfXfgi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72F20309;
	Sun, 16 Jun 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718537481; cv=none; b=KUAzZGyKe3FKU/+1HipBFkfGE/Gy1OVZVp66d3dpxsaMG334X+DtMWTcJDRc46Jti0TcgKt5gvjYMsJuIIdfCnE4yoE30IMUi8PrNbJ1W0Q5F56u2kFbufw1pfn5ThrCirwkAAidPK35gP+IScTER3Pu7jN/wMrmPnzVCIi6MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718537481; c=relaxed/simple;
	bh=JYVDLUuTRisE6xXsI9cLm0lSmf2HQqVruI59IzfON7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TdTBgJcPlLkPmmO+GS1O303eMZi5uxxzRH9/sC9WzS7mse7v7ZzF2ReQEhSxz36Qr2uu8MoZH0YTh9SAyMo8TgLUFczzqEcKxc9tFJkwezHFG37SZpOnfCjP6XiqM512MPj9nBo4AjYLi4fIqAwvputsZyATx5QMnEBdjepRHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CwvfXfgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G8vJPm017119;
	Sun, 16 Jun 2024 11:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=LxztBRBbmjpRI281WcE7w7nkUX5fPIocW/xm/+0rMWw=; b=Cw
	vfXfgipEAbMcFj/u42jX0DcONG/1sdavtI3irk0fg8N246fy8IrruREGrB8Ygr0t
	CqgyJwao6NYiwXbj8ejHmFqJSaoX/rqChE0efRKW6aw01zGQT8mdt+Miljsj40sd
	3YfNPOFuhyZBhyfLJAKT/8Gb5WJwMKLMYL/fMLyKrXjsgIK3RWZM8S5V1E9iMgHw
	A80xgpe77DjLXeK3ob/mRPXOsPA74s1GfP4P/SLZuDmy/IqL75m/IzY8Gzf49kWB
	A/tEM6zMJSylxLjcHw8TjsA5TXMjs3RzVsXKSsp2dwG5lNEAgZfWXTWTxdqXbG0g
	SbqCaEbPnlVz+YpYbwDA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys44jsnf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 11:31:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45GBVCEU014434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 11:31:12 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 16 Jun 2024 04:31:09 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v2] devres: Fix devm_krealloc() allocating memory with wrong size
Date: Sun, 16 Jun 2024 19:30:55 +0800
Message-ID: <1718537455-20208-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: 5FaZFxJMzHBPkUl2OX9-bdTIpsBkXJ9O
X-Proofpoint-ORIG-GUID: 5FaZFxJMzHBPkUl2OX9-bdTIpsBkXJ9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_10,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=737 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406160090

Kernel API devm_krealloc() calls alloc_dr() with wrong argument
@total_new_size, and it will cause more memory to be allocated
than required, fixed by using @new_size as alloc_dr()'s argument.

Fixes: f82485722e5d ("devres: provide devm_krealloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
V2: Add inline comments and stable tag

Previous discussion link:
https://lore.kernel.org/all/1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com/

 drivers/base/devres.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..0d4e5d1b9967 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -896,9 +896,12 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 	/*
 	 * Otherwise: allocate new, larger chunk. We need to allocate before
 	 * taking the lock as most probably the caller uses GFP_KERNEL.
+	 * alloc_dr() will call check_dr_size() to reserve extra memory such
+	 * as struct devres_node automatically, so size @new_size user request
+	 * is delivered to it directly as devm_kmalloc() does.
 	 */
 	new_dr = alloc_dr(devm_kmalloc_release,
-			  total_new_size, gfp, dev_to_node(dev));
+			  new_size, gfp, dev_to_node(dev));
 	if (!new_dr)
 		return NULL;
 
-- 
2.7.4


