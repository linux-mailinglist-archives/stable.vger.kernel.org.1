Return-Path: <stable+bounces-91676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904C9BF1C3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3E1C24B05
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA63204F76;
	Wed,  6 Nov 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PPNC1YMJ"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D218FDD0
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907098; cv=none; b=jj2OcmVq0sJyk/DmEu+KToL6e33R+hYQl4SnCMXt5GEjEY786KxCAF+P93cUOeCH/EfpVd8FrXlef9hPSATI7DEFK+jxNmXsAdDjhWegSNBHCW5TK2hFXHeHb9fSIj1wDxgTuf/1k3HgqddPCukFauqFKvnBo9dW0stj6hBAx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907098; c=relaxed/simple;
	bh=gXaXARKv5b4OWg1hPek1EmKa2Ed3DJsIdKbNZu4ebFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBB2r8nxjzw0bcifBa1z58/ZMC4z/ZlPRW0GDCuCGJ5Xy93v6kT4ddfS1C1ZBlbHYowUEeK2XTghBROLJtGmKXvM7LFEXz5dLaJRo00ox4STKK4QK2jFX32K4aM85UQ2DNODf140a5n6B7tygOozpHePR0ltURnQGyGJSewYTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PPNC1YMJ; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730907097;
	bh=SyatfIV8TYuY4KBrfs0SWiSBpZQ2QH8QB6djYTU8Jpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=PPNC1YMJJZheWJEXr7hFXaJvYx12jTX11+AiqxIoWfpiyRDWf8b6Zn8qhDYt4W8bJ
	 XMRxsmPdWip/GMN8wiREpHiurL8lF+Uplbd+yuEqxRqTcsMaotIb984+Oa/JNqZUF5
	 TD+r6kQ0fpIydMPPbAsG9kimntUytQ8vFYeGC6WgjxORjEeEFF+NqR+xhwFwmrV7RC
	 VQ9WLC1nbi+xRwChBF4EGxbnckMqL2DgOKPdSzBgFmuI7gYDbnzfswd6o0pY97nziE
	 WxI3LC4VDTkuYpXf1l/E156ZkweAL0gU1GYGQgSwQH6gWVWi/i3yfqGJQ2d4gr5hXk
	 rRWJjXdOcts9A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 77F483A10B8;
	Wed,  6 Nov 2024 15:31:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 06 Nov 2024 23:29:22 +0800
Subject: [PATCH v5 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-phy_core_fix-v5-6-9771652eb88c@quicinc.com>
References: <20241106-phy_core_fix-v5-0-9771652eb88c@quicinc.com>
In-Reply-To: <20241106-phy_core_fix-v5-0-9771652eb88c@quicinc.com>
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
X-Proofpoint-GUID: zwvertWuy8IcK0I14C7v_mzF4MXFQOMu
X-Proofpoint-ORIG-GUID: zwvertWuy8IcK0I14C7v_mzF4MXFQOMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060121
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
index 413f76e2d174..1dbb854672d3 100644
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


