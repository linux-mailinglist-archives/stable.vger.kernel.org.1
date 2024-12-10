Return-Path: <stable+bounces-100301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD519EA975
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DEB188B1CF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BB22CBEB;
	Tue, 10 Dec 2024 07:23:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54B227574;
	Tue, 10 Dec 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815391; cv=none; b=J6Z3VEyPM4e+PwTfXQ9quPFvtx2Xn8P8FIGFkPl5bdExJUwP6qAf3aizDw0AGyjVH7iuGu1iibjDpfU06dtojf+O3dpVUzQWf5dLvToNlNDzfGyDig7+T0ljIT05tItVDdicQFVhmQtsocsyMsIJVGUWQWiqGKxjNtAfXq8KZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815391; c=relaxed/simple;
	bh=JgEyWt5hzpzISIA1DUDRlAo9FVhj6vvqe5FuuP/r7VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T8JtNXkG1EWJIoXM550IeLIPG7XjL0X2rpHbsN06sJjnTcEi3l4paU9MqF4Ms7sQnmTzEeLWLfP+QXY1ahZelVs7HcTvcFdsbRLmrQirAHTko3M6i5AMM3p5aiWnkMh/zjoXE/08dFAiBJEpWHq2HPRBvSrRDEOw569W6in0Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA4j9rW000635;
	Mon, 9 Dec 2024 23:22:57 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1tdst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Dec 2024 23:22:57 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 9 Dec 2024 23:22:56 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 9 Dec 2024 23:22:54 -0800
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <kxwang23@m.fudan.edu.cn>
CC: <pgaj@cadence.com>, <alexandre.belloni@bootlin.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Tue, 10 Dec 2024 16:20:47 +0800
Message-ID: <20241210082047.3808378-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: J-rdcZUDSnM8hpHQkYyCXeD11pTQ7pEn
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6757ec51 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=t7CeM3EgAAAA:8 a=7vRtop612t4TABFKEpQA:9 a=d3PnA9EDa4IxuAV0gXij:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: J-rdcZUDSnM8hpHQkYyCXeD11pTQ7pEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_03,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=888 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100055

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

[ Upstream commit 609366e7a06d035990df78f1562291c3bf0d4a12 ]

In the cdns_i3c_master_probe function, &master->hj_work is bound with
cdns_i3c_master_hj. And cdns_i3c_master_interrupt can call
cnds_i3c_master_demux_ibis function to start the work.

If we remove the module which will call cdns_i3c_master_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                     | cdns_i3c_master_hj
cdns_i3c_master_remove               |
i3c_master_unregister(&master->base) |
device_unregister(&master->dev)      |
device_release                       |
//free master->base                  |
                                     | i3c_master_do_daa(&master->base)
                                     | //use master->base

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in cdns_i3c_master_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Link: https://lore.kernel.org/r/20240911153544.848398-1-kxwang23@m.fudan.edu.cn
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index b9cfda6ae9ae..4473c0b1ae2e 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1668,6 +1668,7 @@ static int cdns_i3c_master_remove(struct platform_device *pdev)
 	struct cdns_i3c_master *master = platform_get_drvdata(pdev);
 	int ret;
 
+	cancel_work_sync(&master->hj_work);
 	ret = i3c_master_unregister(&master->base);
 	if (ret)
 		return ret;
-- 
2.25.1


