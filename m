Return-Path: <stable+bounces-47546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E48D127A
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 05:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4161C21B3E
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56110957;
	Tue, 28 May 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l6IbzZrC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427616426;
	Tue, 28 May 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866363; cv=none; b=X4RPCyzQPx2q3APhiriWRxtQVlmQkzn1t77cIeYfy10m5LsSEZbuGWFLNRn0c+IojR59GXeG//D/91Pryn/YtsQQqkY88N3YaJ2k3HUkNSOLo/501w4zMQYJ6FQ8P3KPpelBY11f3XoPzE8BWKpKDkxn8aEwy/I+3EzEdmhaDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866363; c=relaxed/simple;
	bh=VWJNgBha+MdLZW4KuBTIsRu3l1hPwoNUzhpFf4na7Ks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JO9eHH9W+WKD2gNUX7TkhV8JXAbrKDMRnFVxg/VfsH0EFqcpsZHiE4jnpqQDXs6X8Sp7u03I9kX06sA8qkmIfWjnqsFlYhxtrynVRw0ESSEojbUr/77hFE3ACWRM3XloqYDTef5xZ3d9tGRMZr2FuHbSJ6DQgvbM6Zvzo/ogt6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l6IbzZrC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RJasUK022704;
	Tue, 28 May 2024 03:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Pe5ZMcYeU7gDMNUUWz1AxChcullgJDypFw+3sEWfQ+4=; b=l6
	IbzZrCSYcfmOO4Hj1ive4IR75F199K9fEyuaqpNqTmD5GLRFBs+WkoHWCf2nYllm
	4zI42afiW4TgjKIz7LupqtSICba+6O9YrLzYbw/kx3a/dPl8mEHe864E/uBLfzbj
	8X7oXnu05WgG8pGx0MX5khKjIcMBWjFPvvXYkIxJ4VLv6AIzBfsoTKNgjD8+6WoV
	dtHZYNH3L2Yz7RiTkHBTehJo6GR1e2R2Mb1jBgkwYQTgbHVGU31HFdVY5dXyaAvt
	2GDN+V9LS9pk8dq27oBifmMh1Vtrd9MwhPCz2Y/HlU9zew4bzqwluSCCmTxyoqOc
	oM15eh0H0k7EPvl16oQQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj513b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 03:19:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44S3JDXq030865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 03:19:13 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 May 2024 20:19:10 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <dmitry.torokhov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v2] kobject_uevent: Fix OOB access within zap_modalias_env()
Date: Tue, 28 May 2024 11:19:07 +0800
Message-ID: <1716866347-11229-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: -dMAhVfl2qXrg3So5GHQq4jY2Eo-3Gtw
X-Proofpoint-ORIG-GUID: -dMAhVfl2qXrg3So5GHQq4jY2Eo-3Gtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=784 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280024

zap_modalias_env() wrongly calculates size of memory block to move, so
will cause OOB memory access issue if variable MODALIAS is not the last
one within its @env parameter, fixed by correcting size to memmove.

Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
V1 -> V2: Correct commit messages and add inline comments

V1 discussion link:
https://lore.kernel.org/lkml/0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com/T/#m8d80165294640dbac72f5c48d14b7ca4f097b5c7

 lib/kobject_uevent.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 03b427e2707e..f22366be020c 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -433,8 +433,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
 		len = strlen(env->envp[i]) + 1;
 
 		if (i != env->envp_idx - 1) {
+			/* @env->envp[] contains pointers to @env->buf[]
+			 * with @env->buflen elements, and we want to
+			 * remove variable MODALIAS pointed by
+			 * @env->envp[i] with length @len as shown below:
+			 *
+			 * 0          @env->buf[]      @env->buflen
+			 * ----------------------------------------
+			 *      ^              ^                  ^
+			 *      |->   @len   <-|   target block   |
+			 * @env->envp[i]  @env->envp[i+1]
+			 *
+			 * so the "target block" indicated above is moved
+			 * backward by @len, and its right size is
+			 * (@env->buf + @env->buflen - @env->envp[i + 1]).
+			 */
 			memmove(env->envp[i], env->envp[i + 1],
-				env->buflen - len);
+				env->buf + env->buflen - env->envp[i + 1]);
 
 			for (j = i; j < env->envp_idx - 1; j++)
 				env->envp[j] = env->envp[j + 1] - len;
-- 
2.7.4


