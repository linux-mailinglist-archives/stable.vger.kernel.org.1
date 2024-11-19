Return-Path: <stable+bounces-93943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C19D21B3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BE0B22B1A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614C198A07;
	Tue, 19 Nov 2024 08:39:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BF197A7A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005545; cv=none; b=Ef24yzBkLw0w1NpBZv2Slk08f+ctZiLA77pt+qGxFWuf1OI1reQQLg3lejAYStOlL21pkabTQkGnpcpv6dpcktA8nsDSmZzLvI0QJwBbk8B4bG7xSawzKm/OwCkOceuSgjKUXQ1ZRprVOh7lpwaTHKAw+XJPAizkZ//gCH2rqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005545; c=relaxed/simple;
	bh=4qAfmfhuAuZBQ7G1wAdODRnYWfHpHzcYYEJG7gdcpvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o6oCu2oiKV7d0udWen0+kcZRBY8BMZok0SykzGUVPNip0FKn/vieaobJJSh4dbISzzbuA+vkuKbCGAD3OAuQh84h7CgsBntXuMsXD6pRXNzGfG2C4fyo/kNnQL3mRkqqhhLN/JLTzkokIt/5vOIMg594bIPoo7Za0oR32s/yBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7p9w6006003
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:38:59 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8arw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:38:59 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 19 Nov 2024 00:38:58 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 19 Nov 2024 00:38:57 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.6] leds: mlxreg: Use devm_mutex_init() for mutex initialization
Date: Tue, 19 Nov 2024 16:39:19 +0800
Message-ID: <20241119083919.2490177-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o3MGmCZ4kFwLgcio1OCXZJoWolw0wMQW
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673c4ea3 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=oIrh2ZjCAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=XpvTgcSfuN2lSBDXnSgA:9
 a=PybRJKj6JLd7Pqq7RWh6:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: o3MGmCZ4kFwLgcio1OCXZJoWolw0wMQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_01,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411190061

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit efc347b9efee1c2b081f5281d33be4559fa50a16 ]

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240411161032.609544-8-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
[ Resolve minor conflicts to fix CVE-2024-42129 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/leds/leds-mlxreg.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index 39210653acf7..b1510cd32e47 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -257,6 +257,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int err;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -268,28 +269,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&priv->access_lock);
+	err = devm_mutex_init(&pdev->dev, &priv->access_lock);
+	if (err)
+		return err;
+
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
 	return mlxreg_led_config(priv);
 }
 
-static int mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
-- 
2.43.0


