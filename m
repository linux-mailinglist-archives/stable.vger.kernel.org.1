Return-Path: <stable+bounces-98745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1E9E4ED6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011641880820
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318E1C07C0;
	Thu,  5 Dec 2024 07:46:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED31B87C0
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384765; cv=none; b=jb2VZMn4UYpPCWpUjLRHPlQcLwcGtr6qIF2Cxl53QL2ogYBNsbE9gB0+9SqGHtsAY3UxDmEp6eIbOBYC21v8ZBooDP7QngAkgAUK0AF8zXj/2lprkRs2P9M7kGrpUMo/JmUMjCmNgx40/23igYHR3IB+962wtGQT6XI0wQSKvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384765; c=relaxed/simple;
	bh=zjNi37K9gDPteihWlKV/NyV2+G+ddXlWk/GJ28X/61o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f7D45p/WPiD3OoRZPbNPyWfAOdmtkzqCoaeaQTXse1JLjG5XSzm1AVmmbco2KkNrXjJMIamAYUnkirQ5lL0VWa0jZvNIJGKKl6QqcLfK09sKoPQ89FjJ+zVhZjQG0WpcAzM6u43A/WMQn0shrrlywmu1go1qOfj9Rtz+nLjV8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56fOFp030368;
	Thu, 5 Dec 2024 07:45:41 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437qx15t58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Dec 2024 07:45:41 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 4 Dec 2024 23:45:40 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 4 Dec 2024 23:45:39 -0800
From: <jianqi.ren.cn@windriver.com>
To: <n.zhandarovich@fintech.ru>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Thu, 5 Dec 2024 16:43:29 +0800
Message-ID: <20241205084329.1748881-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _uAkun2EG2LpjwnaAQ9XdtEIKkhN8OyD
X-Authority-Analysis: v=2.4 cv=EuYorTcA c=1 sm=1 tr=0 ts=67515a25 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=DFC7gQDcAAAA:8 a=HH5vDtPzAAAA:8 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=TusaAkCut-tyimdG5pgA:9
 a=6mkBMmtgJpxIRZlSFNLW:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: _uAkun2EG2LpjwnaAQ9XdtEIKkhN8OyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=894
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412050057

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
before the call to dc_enable_dmub_notifications(), check
beforehand to ensure there will not be a possible NULL-ptr-deref
there.

Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
Clean up by combining them all under one 'if'.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dc0f70df24f..7b4d44dcb343 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1882,14 +1882,14 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	if (adev->dm.dc)
+	if (adev->dm.dc) {
 		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-
-	if (dc_enable_dmub_notifications(adev->dm.dc)) {
-		kfree(adev->dm.dmub_notify);
-		adev->dm.dmub_notify = NULL;
-		destroy_workqueue(adev->dm.delayed_hpd_wq);
-		adev->dm.delayed_hpd_wq = NULL;
+		if (dc_enable_dmub_notifications(adev->dm.dc)) {
+			kfree(adev->dm.dmub_notify);
+			adev->dm.dmub_notify = NULL;
+			destroy_workqueue(adev->dm.delayed_hpd_wq);
+			adev->dm.delayed_hpd_wq = NULL;
+		}
 	}
 
 	if (adev->dm.dmub_bo)
-- 
2.25.1


