Return-Path: <stable+bounces-80722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BF98FF46
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D24B2155B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1121140360;
	Fri,  4 Oct 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QaRllJzD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCB136671;
	Fri,  4 Oct 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032708; cv=none; b=PRwyK/RArW/isnB/eCXO+vqe/kY7le0hl0J7U/q4YAAfTB/LdlG/7l9N3HSJVtmjsU7dldTUIkusEs6KFqLSoj/9NRg6iMXdt1HhHq3arTKiSnzXw7nCKnzAh1/BJGAvIZeQII/4lR3uTE7Q63qB5zJN/7yEt3Zygx0dPngKSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032708; c=relaxed/simple;
	bh=ekrJAzQHgmb7SrlgSVzWYYeMB5Dtk+b5F9HcO2t22eE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbSmAkSBeeoqeH/WBdxfMl1HPnR6m5EZBOTkv18uQBI5twxaJfgjrRbojmCRKHG8xI2G7Ero+GU3N64EopeM97LVI7SRpFoUYDP5XMLKnwcMYJNj+1Np/QINR3u5uc+U9++o+8mI8L+wgkD2uSbpxyVBcu0r4l1KqaHCDjJ556o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QaRllJzD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493HxP4Q022359;
	Fri, 4 Oct 2024 09:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=TKAMJCGYluAljQZ3DGnwueN7JfG9iy5KF83bzr85e4g=; b=Qa
	RllJzDxovvPEpYVu5Vf9g0NWU+DPtanMPay77VXJNxG8M/9lQY46RtTAu9zsbwnx
	1EeR6aUFuQb4YBGL72W3MnB69Bde2UjnmoDLwr8ylom866YhHJQCjy094qWBjW0i
	ZPbnw8pr4y1bGl2iGv5Q2GOd9F386G2RVwbusXv9cBUXQJV2gZpcKYS0tV8vDs/j
	Qdo7l9jF/FaDRxHQG9XsGqpS2ou/Sy++avw0eYTD71yP9Mm5lQQLg0pBZwpFnFpb
	TCThpYYrec03SggP5tUUlkQMNeV2ppuhcIS1byLLLAPKvVKHhA0nWI6JOoRknI7z
	Duq5HBy9pl2IHK2tvBhQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205d9k0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 09:04:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49494oD2015431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 09:04:50 GMT
Received: from hu-pbrahma-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 4 Oct 2024 02:04:45 -0700
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@ziepe.ca>,
        <jsnitsel@redhat.com>, <robdclark@chromium.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <quic_charante@quicinc.com>,
        <stable@vger.kernel.org>, Pratyush Brahma
	<quic_pbrahma@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>
Subject: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Fri, 4 Oct 2024 14:34:28 +0530
Message-ID: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ckNOfJst3dsdkrxNv-SatKxSmw7sAbLX
X-Proofpoint-ORIG-GUID: ckNOfJst3dsdkrxNv-SatKxSmw7sAbLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=978 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040065

Null pointer dereference occurs due to a race between smmu
driver probe and client driver probe, when of_dma_configure()
for client is called after the iommu_device_register() for smmu driver
probe has executed but before the driver_bound() for smmu driver
has been called.

Following is how the race occurs:

T1:Smmu device probe		T2: Client device probe

really_probe()
arm_smmu_device_probe()
iommu_device_register()
					really_probe()
					platform_dma_configure()
					of_dma_configure()
					of_dma_configure_id()
					of_iommu_configure()
					iommu_probe_device()
					iommu_init_device()
					arm_smmu_probe_device()
					arm_smmu_get_by_fwnode()
						driver_find_device_by_fwnode()
						driver_find_device()
						next_device()
						klist_next()
						    /* null ptr
						       assigned to smmu */
					/* null ptr dereference
					   while smmu->streamid_mask */
driver_bound()
	klist_add_tail()

When this null smmu pointer is dereferenced later in
arm_smmu_probe_device, the device crashes.

Fix this by deferring the probe of the client device
until the smmu device has bound to the arm smmu driver.

Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
Cc: stable@vger.kernel.org
Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
---
Changes in v2:
 Fix kernel test robot warning
 Add stable kernel list in cc
 Link to v1: https://lore.kernel.org/all/20241001055633.21062-1-quic_pbrahma@quicinc.com/

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 723273440c21..7c778b7eb8c8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1437,6 +1437,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+		if (!smmu)
+			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
+						"smmu dev has not bound yet\n"));
 	}
 
 	ret = -EINVAL;
-- 
2.17.1


