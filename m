Return-Path: <stable+bounces-88084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B19AE926
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C356B23FE0
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D971E7660;
	Thu, 24 Oct 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hYcgBkly"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6A1E7668
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780856; cv=none; b=tri85WnKQD9C/okaNvDD/Hca6OFDNEQ/TZ1HwWOGv9Vl+5MpcRVh7exu5t4cwqeebmVguzlmtUruKc+RgpUlP8gayFflYoqQx0gagBJl73s3IVq8qnXxLGNUrT5EU2YNV1V1BfmncWIr5hdlGniM7e79icsY6fIa3FSUrnvzytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780856; c=relaxed/simple;
	bh=MJbrB7W8kX/cyQEalTTmjsZNEab1KL1hzlNY1ejl9U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l08MkbZWBlO5/WRsRqHfsB7ntjXpWB1J23EJMJ2TsaL8iPyMikcej7scc8iQwcHD5WVTQkaldmzniOW7PlCHUi+HPgZcIoH5gRJcH7tHm9lQF/JiaSoLrvP8eIjwLotZRCcJqnW0pb/UTR4NvlgJhWP67klZ+ygqCQAzDElGy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hYcgBkly; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729780854;
	bh=WmCswZRvkq5WGhabYEyPR/NmcnJ9vmObxp5kPrfpCBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=hYcgBkly1dOfQwz/FwLHxlli7FRnHINaxmitJN2ytTrAZ2i9555OuGsPe4Ncwd6Fn
	 VnkaxwSrnzBu1FVjNp6cQ8KyRIRI1zgj4wvf6wxpl4P1vVkt1VvEZZwzz1pP5i7tYb
	 4vRN1/0dUg7i+QOicQKLdnsNBv+X6miGqmH9Ke8XfnHK2guU8A+AWsWxSm8XefV1TH
	 fdJaxQhta5amcUls0goL57b4ZLJBK5wee9/e+CYViqg5u9wuaEwGDzzIScp3sQIsCk
	 79a1ZksS3iRgmWYGM6xoQkuwXfCIxDl3xbGf4ea3C3BqT3qwNO2E1/iua/lbMG8ibC
	 N+sMxp6fMJiUA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 636BAC80102;
	Thu, 24 Oct 2024 14:40:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Oct 2024 22:39:31 +0800
Subject: [PATCH v2 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-phy_core_fix-v2-6-fc0c63dbfcf3@quicinc.com>
References: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
In-Reply-To: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Zijun Hu <zijun_hu@icloud.com>, stable@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: bMZgaXaVPFhitUgiIfVpQoWbRlqMPNO3
X-Proofpoint-GUID: bMZgaXaVPFhitUgiIfVpQoWbRlqMPNO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410240120
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_phy_simple_xlate() implementation by API
class_find_device_by_of_node() which is also safer since it subsys_get()
the class's subsystem in advance of iterating over the class's devices.

Also correct comments to mark its parameter @dev as unused instead of
@args in passing.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index de0264dfc387..b83c6aa0287d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -749,8 +749,8 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
 
 /**
  * of_phy_simple_xlate() - returns the phy instance from phy provider
- * @dev: the PHY provider device
- * @args: of_phandle_args (not used here)
+ * @dev: the PHY provider device (not used here)
+ * @args: of_phandle_args
  *
  * Intended to be used by phy provider for the common case where #phy-cells is
  * 0. For other cases where #phy-cells is greater than '0', the phy provider
@@ -760,20 +760,14 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
 struct phy *of_phy_simple_xlate(struct device *dev,
 				const struct of_phandle_args *args)
 {
-	struct phy *phy;
-	struct class_dev_iter iter;
-
-	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
-	while ((dev = class_dev_iter_next(&iter))) {
-		phy = to_phy(dev);
-		if (args->np != phy->dev.of_node)
-			continue;
+	struct device *target_dev;
 
-		class_dev_iter_exit(&iter);
-		return phy;
+	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	if (target_dev) {
+		put_device(target_dev);
+		return to_phy(target_dev);
 	}
 
-	class_dev_iter_exit(&iter);
 	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(of_phy_simple_xlate);

-- 
2.34.1


