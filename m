Return-Path: <stable+bounces-89554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2429B9C9A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F59928214C
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E734CDD;
	Sat,  2 Nov 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="COvujrbR"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE02482DD
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519739; cv=none; b=NAcg/tz0akhvB6l2BWk+rr8cMCINMxS6yqE5yz5nUAGFH9NHOt85frA6XJw0+MEnoGQx7kI1+KWejsIjtCbpQPk1hWeun5Bj+Sj3MDnMJeliywnpJ+ef6cReLQG4xg9MNRBgQaxbijwoC7RstALH4R8dBs61uqacCMIjp8Ay+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519739; c=relaxed/simple;
	bh=zi+AC3aNmGewTjTQMimffXRimaWmbxs2lSQyYUeplow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEL+dfm92P1kqm4mSqK10dabjQiqHKW7QyU50GMvQWB2b0Bn7oRfJBNn8Fltvmt3nzfDPwk7BQMeLv+WNRQwBLqjLSl/V7l/un3hhbiLTYz7kn6xpU+MaqKjKJFXMCdtEDEMx9SvhM8784Xw0TaL6Ha7VIu74/09utEbiK3leWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=COvujrbR; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730519738;
	bh=06XEXE3RdGyDqIVZgj7Hd7CzsKtHn4L7U6k0cu73Blg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=COvujrbRwoQZyFJcH82UdPbs47EQ+luVL7mkAfhryXRBczX/QWQRmgDECixzcxqRo
	 1SlWhQeNOrCeNJ3hHTep0rEWseWyK79yQpNXSn0jj//D6IpsS8rFdg0WnNNRFWl/Ti
	 Wct4fUKlINGdKRZzpsT1i6P7ztYIEEw7LyfCqy934fKFffDVEWZlrJ4ivYDWwJ/AN4
	 LOfTS9tpSD0THAr0q87ppBFNJF19WkiugENQPD1MSAeYZSB/XnTR60T1Ap00I6G/G9
	 HKgPOB5d3maht5SBOo82ePwGiz/lIPG8I+pqrdwrn6MMPvM6R0WbmqVe1WClcm6kqG
	 hbQLd5tYdvv5g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id A67858E01B7;
	Sat,  2 Nov 2024 03:55:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 11:53:48 +0800
Subject: [PATCH v4 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-phy_core_fix-v4-6-4f06439f61b1@quicinc.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
In-Reply-To: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
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
 Johan Hovold <johan@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 stable@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: QuSC-0nx-vVo5COz6hbbnQz0mp8EobP4
X-Proofpoint-GUID: QuSC-0nx-vVo5COz6hbbnQz0mp8EobP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_02,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_phy_simple_xlate() implementation by API
class_find_device_by_of_node().

Also correct comments to mark its parameter @dev as unused instead of
@args in passing.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 9d4cc64a0865..39476ca9e51c 100644
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


