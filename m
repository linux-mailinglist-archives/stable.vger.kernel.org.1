Return-Path: <stable+bounces-46027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740FD8CE057
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CC81C21A99
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F243612D;
	Fri, 24 May 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pBKap7kJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386B320B;
	Fri, 24 May 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524428; cv=none; b=XQPdrpNi6EryxAv5Lj/o9jaFTo7ONpyGmi3ShjyCKviSHA1vHHi7RGpw3m3uwYw5MgGKU5HustRsWRBcDBxhNQBZv6vWXuwBrAROLsDWhOfuk+bOVvQBCL7MjePBn1UEH9Qg2nV8ulDglxhkuiZFCHmXqhWV4hOcrTNoEE+bCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524428; c=relaxed/simple;
	bh=5PBtEQl5cFDGbUns2n64HmM1axyfDG0Gw1kM3+JUFX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7zM6ANYEKfV8rye3TznjD2khDyCwbH6yfe0RC45J8/7/DC3ju3hWAjp1x1fW5CRU8QDSs+iFQ9E5hsC4j5tmeJi+cuOqoiCFo1ZGj9Ch2BW8QLtNeA073sQEsNziwh/JthOIO8r4Vr7NPX7aNyLomUwj5iFOhQpfXjmhPwIitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pBKap7kJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNQrCD017986;
	Fri, 24 May 2024 04:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=v2yoV2qfekkWI6UKkdHc2+vVpxUneBsyoHQefNacdjA=; b=pB
	Kap7kJgP4UFple6Rp06O8+SV7u8bUXI1JhMmRasfIDNWN79qpY8w6hP3rBuYkCGc
	OjPXLy70gFl7Q3tzirwmOvwwMTwce4FeWQbAVwE/2h7P5YDb7K/sdUl1Yj7WuQIv
	bK6Nnsa6XT2s8M9fu2HVHvvQxC69jgAbSC4BACHnhOU75uymjRJsRKvxNIMo6A3j
	E7vGRciBWMzk8PZwyf2//EdTTX2sOfwfZW8uOKtgf5IPhadzJ7mKchjGja13qkcD
	Veg3t7Tl1JGIE1DOjJmEHbRYttAS5aWbZjKBRF4j2XyF4FYhwMPcWUoFDFGDCVR0
	TeyaUfQhHvz3/h+kmA+w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8hs5wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 04:20:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O4KKWa010428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 04:20:20 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 May 2024 21:20:18 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <dmitry.torokhov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
Date: Fri, 24 May 2024 12:20:03 +0800
Message-ID: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: j3qsMNSByXNjTkVnPSErFtHIRPDbzSxb
X-Proofpoint-ORIG-GUID: j3qsMNSByXNjTkVnPSErFtHIRPDbzSxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=798 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240028

zap_modalias_env() wrongly calculates size of memory block
to move, so maybe cause OOB memory access issue, fixed by
correcting size to memmove.

Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 03b427e2707e..f153b4f9d4d9 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
 
 		if (i != env->envp_idx - 1) {
 			memmove(env->envp[i], env->envp[i + 1],
-				env->buflen - len);
+				env->buf + env->buflen - env->envp[i + 1]);
 
 			for (j = i; j < env->envp_idx - 1; j++)
 				env->envp[j] = env->envp[j + 1] - len;
-- 
2.7.4


