Return-Path: <stable+bounces-95506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F279D92BB
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D42F285613
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5EF19342E;
	Tue, 26 Nov 2024 07:47:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED94964E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607226; cv=none; b=HY8HfCaue/ne0oSXmrpW9zzNKyuB9JUMjYAqXDDACi/oUujMd21z0Sa3Dh3VGrcSuiS6gckyUdUN7ZKrnkubMc2rKp6c8sKQFiMDQLwvSAHDrr5sbuzHiAVeNESuxOIBUy0R/6ZZ9jMzVG0hY56ZZzUt1mgXVTY4zF/m8jN0SV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607226; c=relaxed/simple;
	bh=hewom8eg+/772euxT0DF1BUKYUF4vXN5omPl6opwDKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzLio+W/BAAL8qBSKcP/B9eHebhlha9/1rTuV6nfmPA8eHUfgOaa54zk+PRSgarM7rxvcqEJp21NR75lEdaOkLMBmwyf4pkJBLxweYUufVeTCNZ7ILFjOH0cl3CYawAmjuRWHoddeUJEA/ZDssaW6boI0Z+bDtVx7Rlv6jjsiGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ6U8b1006833;
	Tue, 26 Nov 2024 07:47:00 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491b0ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Nov 2024 07:47:00 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 25 Nov 2024 23:46:59 -0800
Received: from pek-lpg-core3.wrs.com (128.224.153.43) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 25 Nov 2024 23:46:58 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>, <kbusch@kernel.org>
CC: <bin.lan.cn@windriver.com>
Subject: [PATCH 6.6] nvme: apple: fix device reference counting
Date: Tue, 26 Nov 2024 15:46:57 +0800
Message-ID: <20241126074657.2003279-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=67457cf4 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=t7CeM3EgAAAA:8 a=es4VZMpIhlFVq_PfrAAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8WzxI8HuWh7GlQHzCO1Tg3UmGGlY_MmS
X-Proofpoint-ORIG-GUID: 8WzxI8HuWh7GlQHzCO1Tg3UmGGlY_MmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_06,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260061

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b9ecbfa45516182cd062fecd286db7907ba84210 ]

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The apple driver had been doing this wrong, leaking the
controller device memory on a tagset failure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/nvme/host/apple.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5..396eb9437659 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1387,7 +1387,7 @@ static void devm_apple_nvme_mempool_destroy(void *data)
 	mempool_destroy(data);
 }
 
-static int apple_nvme_probe(struct platform_device *pdev)
+static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct apple_nvme *anv;
@@ -1395,7 +1395,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	anv = devm_kzalloc(dev, sizeof(*anv), GFP_KERNEL);
 	if (!anv)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	anv->dev = get_device(dev);
 	anv->adminq.is_adminq = true;
@@ -1515,10 +1515,26 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
+	return anv;
+put_dev:
+	put_device(anv->dev);
+	return ERR_PTR(ret);
+}
+
+static int apple_nvme_probe(struct platform_device *pdev)
+{
+	struct apple_nvme *anv;
+	int ret;
+
+	anv = apple_nvme_alloc(pdev);
+	if (IS_ERR(anv))
+		return PTR_ERR(anv);
+
 	anv->ctrl.admin_q = blk_mq_init_queue(&anv->admin_tagset);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
-		goto put_dev;
+		anv->ctrl.admin_q = NULL;
+		goto out_uninit_ctrl;
 	}
 
 	nvme_reset_ctrl(&anv->ctrl);
@@ -1526,8 +1542,9 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	return 0;
 
-put_dev:
-	put_device(anv->dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&anv->ctrl);
+	nvme_put_ctrl(&anv->ctrl);
 	return ret;
 }
 
-- 
2.34.1


