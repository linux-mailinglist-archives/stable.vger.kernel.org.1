Return-Path: <stable+bounces-111186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D0A22105
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F65B1884076
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7B1DE8B2;
	Wed, 29 Jan 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JegPAI6V"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6161DE880
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166184; cv=none; b=H9lTyJYvrkHuTifIK+BhusM5OVD9+Jxm9tKRU8KpW3BczkW8VRSRmov8ZgRz8kmHBBpIKqKADyxS/sreDZOuwU9s4g+COFxzAdbOb1CNPhfqTbHVS4tC6Opo2MSoOyS+dLQfYSXkW43km9dvm5zoY7Wu8P551plXGhQzzjhvLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166184; c=relaxed/simple;
	bh=Dt7xkAk4I2Scvbht6IKyvbEclkFIJDnQUwr7f8DbyTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hX5CbbIpFVS7EI9H4/lhAzj3sMohM5Y6wDJiGY7a9TiC5t9vRVPzVaWKQKuYb+JNvk0h1RhDjPI6IoOkqEb5ltFFUPCXik84PMHGa5GgLNMug0jHlXJoH+3e993ftWp2G1XcB1PmmrHzMo1n12aFxvy6N4tGBO02FoypzqRNRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JegPAI6V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEqhdD004511
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DxY0icfYFDPYpLy0SN45Y3l8ipVx2gW7otJ
	CvY2psTE=; b=JegPAI6VLv/mjpZGwYAIvo4eRCROAsoZpDS6YXmEpZLTukASaZv
	NoVT4yrXIbsmFWMmm9nTgPod+qJ6PazaDvd3gHcU/sbCn/hJkYhN2+Ak9IIAj9jI
	nJsQOiJLRge7WVz3qfTv2K78W35fL7rl0elpnpUTim2k7etoRDXzawhPmwFuhSq4
	KYE+cZmX/Mv1PM6iNzQVwhg5xVRlabDAlE5TmZWaDAAkXdsl7HTlwKQEmRYErjgZ
	9LiUJQ7N6MSssjNOPLLn13Py8OIIAT3tpZozzoqiCqU6gOvTI5/MFvNKr+TcUomC
	UQ8nEWooVrknm9A6XWELtfqi2P+u4S48oGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fpfu850f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:56:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2164fad3792so122735315ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 07:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738166181; x=1738770981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxY0icfYFDPYpLy0SN45Y3l8ipVx2gW7otJCvY2psTE=;
        b=XgJIdwx7Zuf8owIIf7CuO5b7DK4RfW3bXCANXveWRBxsUJtn+p+IDwsOU8n5Q9Njk2
         hRzivrDSjEVUeMJKsZVDAwHIgdQB6icBTnu3i6EafDwSWBU53ukyQc3X3pJAoEDyLvbo
         ROsxyalSWk9YGCT3PE4P5V4V0Qh/JC53hUmXQ6CneM08nI7T7KD4Vy3bESQfPGXAjIIE
         xpLSqIjtnRR9sMoNzjjyKsnunQCAZ0+T9db5jfBEyzqvlrwWHvV8ATZbstc1fT6PMgcD
         tEUxIPiKKId1zpUx5NQhJD8SzlcI7VOvksOECVaEZR8srm4kj+SlS8Aof1O2rYnUO5i6
         5wJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQGwkKr8aQb0MMdLae3ycJ0gM36y33v+M99IgEYtF4ROvefOsQhsGGqan7BwUICNV9qeDUgnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyay3KpmDxewRbOvOpEDI9B2o76i+OguncsNsk6xlbyPbOvojOk
	gx6SbMOFpapIBTt6KPbjYCI5JpnN+S9sC7/c/OuzH/FUPnTjtyCRL8p89h2SWetXxPczbtzrL3d
	qTvW5c+WXDt9UV0A/q1TxR9U159O4eBeXWPcwlS8XNHrW3J4j50J3ZjY=
X-Gm-Gg: ASbGncscATYQZDvFOZvc9MAhoex+hJTUw+v865tUKeVFxYccM0IysfGW20z6U5a+NNR
	opNfKFTP0dkDGRitgPY1qp/Z6QIimTHRGv0ZB3bavq9UKluaKJwipVJ25viusZtSGLvr/9cbKI3
	owZ4INq5zZ6Wc98/2eAeC/gQ/F9OZiOMzjWJ4t4JrNre2wW9n2E7atsOMgdIPHJzt0L0MkC52gt
	xFdWEAlrxTefkj4Yu1y4VcqxCVhjRDeSoS+NkDCLU26RfGBJWZItbUM0BGVUBozvHUczssBwKZl
	hdt+DsJseQtnnBPcZMtTg7jeiY48HKhP
X-Received: by 2002:a17:903:244b:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21dd7df2d21mr59553665ad.44.1738166181314;
        Wed, 29 Jan 2025 07:56:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2B4B+YcV7qGpZDw1PDGvvKfkjXAwRuH8rb5D436/nFHKW3TBRf6iKCQFl+v3k5Lh4v3r6VA==
X-Received: by 2002:a17:903:244b:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21dd7df2d21mr59553325ad.44.1738166180910;
        Wed, 29 Jan 2025 07:56:20 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414edb3sm100898975ad.202.2025.01.29.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:56:20 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org,
        Saranya R <quic_sarar@quicinc.com>
Subject: [PATCH v2] soc: qcom: pdr: Fix the potential deadlock
Date: Wed, 29 Jan 2025 21:25:44 +0530
Message-Id: <20250129155544.1864854-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q8fL23kIllOSYkpWA33zrp7qBEWKrlQ6
X-Proofpoint-ORIG-GUID: q8fL23kIllOSYkpWA33zrp7qBEWKrlQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290128

When some client process A call pdr_add_lookup() to add the look up for
the service and does schedule locator work, later a process B got a new
server packet indicating locator is up and call pdr_locator_new_server()
which eventually sets pdr->locator_init_complete to true which process A
sees and takes list lock and queries domain list but it will timeout due
to deadlock as the response will queued to the same qmi->wq and it is
ordered workqueue and process B is not able to complete new server
request work due to deadlock on list lock.

       Process A                        Process B

                                     process_scheduled_works()
pdr_add_lookup()                      qmi_data_ready_work()
 process_scheduled_works()             pdr_locator_new_server()
                                         pdr->locator_init_complete=true;
   pdr_locator_work()
    mutex_lock(&pdr->list_lock);

     pdr_locate_service()                  mutex_lock(&pdr->list_lock);

      pdr_get_domain_list()
       pr_err("PDR: %s get domain list
               txn wait failed: %d\n",
               req->service_name,
               ret);

Fix it by removing the unnecessary list iteration as the list iteration
is already being done inside locator work, so avoid it here and just
call schedule_work() here.

Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
CC: stable@vger.kernel.org
Signed-off-by: Saranya R <quic_sarar@quicinc.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - Added Fixes tag,

 drivers/soc/qcom/pdr_interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 328b6153b2be..71be378d2e43 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -75,7 +75,6 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 {
 	struct pdr_handle *pdr = container_of(qmi, struct pdr_handle,
 					      locator_hdl);
-	struct pdr_service *pds;
 
 	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
@@ -87,12 +86,7 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 	mutex_unlock(&pdr->lock);
 
 	/* Service pending lookup requests */
-	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (pds->need_locator_lookup)
-			schedule_work(&pdr->locator_work);
-	}
-	mutex_unlock(&pdr->list_lock);
+	schedule_work(&pdr->locator_work);
 
 	return 0;
 }
-- 
2.34.1


