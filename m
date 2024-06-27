Return-Path: <stable+bounces-55981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838691AE0A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F02B24F97
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F919A292;
	Thu, 27 Jun 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVmJucoB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B71199225
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509363; cv=none; b=opO13houHHXY/BkAWmkeylgkaZ7m184pzCc2XZyIqmj5EeOCbLsgPUrMW6MUfDyrZKC4S/Za7sJqwAxf+2938oFjg8EtihKno9HrahZc6RGqUjdXQPKe0p6qN3SZxEGevsxxzzUNN/pqlgAPFXGI77uRuzW3ROJXEjMwxExjAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509363; c=relaxed/simple;
	bh=3RrqBmS5c8RUCizOpeYhIa4uKUZME6KtQG9XaURR8JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImIk+5r0vdj+pavCPUffB2RqGGw/hL2Y5BL2ZADKcHugJYO8x+njELKmNELesWUHl66KbxqfgYRAI3/OpbAGgi8yqIhOEz8ux5qyLrgqATDfYvm+Q6vb6XRqanUHlz/+jhfgWkUNbVPcZ1WVVDjcvdBdv3fcwDd+0dNpOyPzI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVmJucoB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R9xVZL030226
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9ArLdRS9liG
	wuuyVMdCWxF73MDGk5jRaUhbN7VrUxUw=; b=jVmJucoBEM2oETGGcT6XYvlqAAF
	qEtCoLj3Y0bWvM2UYQtB2SnhgzaQgL/vcJ84ALhdaqXXOVxHN6ES0d4GXhtUVTXy
	xVCSukQz4pM1pq1IHqcjPSDhza7GdSBBW5+Ht9Dmlh6AkNM+z6I83u7bVnwxc0fx
	JKtHvA6GigF4Hi5JlDtX5/+N3WVyEitvgBEMxbOh9fjtDSCcLIjAegUFb03j/Pj/
	uSLOgfPNxaeneFa7xI++yrhU0GRC9FmYAJAE8Xm3MFlMR/vjg/78bis6IpWzScmc
	WEOy7gbdbsir8JICXzAv/6Dxlob0+bsMMgiU6iE3Ki/unOWCPOR0lsPqOWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46cvc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:19 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RHNLXR002951
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4000p0mjn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:18 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RHTIcY012093
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 17:29:18 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-uchalich-lv.qualcomm.com [10.81.89.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 45RHTHIv012089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 17:29:17 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4184210)
	id 287C664D; Thu, 27 Jun 2024 10:29:17 -0700 (PDT)
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Trilok Soni <quic_tsoni@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>, kernel@quicinc.com,
        stable@vger.kernel.org,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: [PATCH v7 3/3] firmware: qcom_scm: Mark get_wq_ctx() as atomic call
Date: Thu, 27 Jun 2024 10:29:05 -0700
Message-Id: <02cbdb290d6a66ddc6e82b0839b007b9bcb7a6d1.1719459967.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719459967.git.quic_uchalich@quicinc.com>
References: <cover.1719459967.git.quic_uchalich@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XhTRNLrHJu9LCTUXyqR7E56DlctJAs2h
X-Proofpoint-GUID: XhTRNLrHJu9LCTUXyqR7E56DlctJAs2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406270132

From: Murali Nalajala <quic_mnalajal@quicinc.com>

Currently get_wq_ctx() is wrongly configured as a
standard call. When two SMC calls are in sleep and one
SMC wakes up, it calls get_wq_ctx() to resume the
corresponding sleeping thread. But if get_wq_ctx() is
interrupted, goes to sleep and another SMC call is
waiting to be allocated a waitq context, it leads to a
deadlock.

To avoid this get_wq_ctx() must be an atomic call and
can't be a standard SMC call. Hence mark get_wq_ctx()
as a fast call.

Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
Cc: stable@vger.kernel.org
Signed-off-by: Murali Nalajala <quic_mnalajal@quicinc.com>
Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..0a2a2c794d0e 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -71,7 +71,7 @@ int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
 	struct arm_smccc_res get_wq_res;
 	struct arm_smccc_args get_wq_ctx = {0};
 
-	get_wq_ctx.args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+	get_wq_ctx.args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,
 				ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
 				SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_GET_WQ_CTX));
 
-- 
2.34.1


