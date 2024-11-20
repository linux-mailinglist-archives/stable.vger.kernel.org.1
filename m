Return-Path: <stable+bounces-94084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A19D322D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1AB23B97
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272241C62;
	Wed, 20 Nov 2024 02:30:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82139ACC
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069836; cv=none; b=AXvBQ2kNRZkAGq9+1G3csMjeETCtwSTEu5N6y9VicHhGpmtc43qi5VBU0M6ae2pmbaTqim1k7/bvRmG0VE3b1MJf1mfQsGxDcxyErjmExI46z2FSFrkxb99AB+9QDg/w1F87VCO0vWxbH2vJ0NdozQcwOLG7hxA4/q2IsMFE+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069836; c=relaxed/simple;
	bh=9RWTxhMnpLA4TKCmsIRysJiPac6MC09zAjMp0ZHOZjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTBADHBWRFjgsOCLf9XwGx+q7BVwHhAiq+BEb0NrH/KDwW1MiJ+1bIdRJXDoRRd1UfKWDe/vLDwFN60SjVtDCbc7RaTGOeURHKQXjvJ8wvWT3RJyusnJtix4I1xsFgJjE0PlKHXE2Fqp/0xFjTHvf7mekFRDHKSMBCaadUgeni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK0NXao019047
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 18:30:32 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7up1x-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 18:30:32 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 19 Nov 2024 18:30:30 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 19 Nov 2024 18:30:30 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.1] drm/amd: check num of link levels when update pcie param
Date: Wed, 20 Nov 2024 10:30:51 +0800
Message-ID: <20241120023051.2591465-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j8lA2XljFJSHLuhfrfuscJyoW-7jN4Ei
X-Proofpoint-GUID: j8lA2XljFJSHLuhfrfuscJyoW-7jN4Ei
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673d49c8 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=J01iPmk1YeOixm8d0wkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411200019

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 406e8845356d18bdf3d3a23b347faf67706472ec ]

In SR-IOV environment, the value of pcie_table->num_of_link_levels will
be 0, and num_of_levels - 1 will cause array index out of bounds

Signed-off-by: Lin.Cao <lincao12@amd.com>
Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Resolve minor conflicts to fix CVE-2023-52812 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3aab1caed2ac..e159f715c1c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2498,6 +2498,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
+	if (!num_of_levels)
+		return 0;
+
 	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
-- 
2.43.0


