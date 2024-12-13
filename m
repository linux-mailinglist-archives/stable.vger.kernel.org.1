Return-Path: <stable+bounces-104040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1DA9F0C8D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FD416BD50
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A61DFE2C;
	Fri, 13 Dec 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GTPLGRqI"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF051DFE20
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093488; cv=none; b=tBrUR7tHqsFyG/JCjpHcwx/IVhnh9otTcCJOdO24w1Z+YAOKDmYzMgadUKL7EQru9/YwQa6QTLa4MO6RfFjqpi9J9JXqfVU5036kqYhvQTQU99GvQ5A1g2Xcwh2RHuzam+6qA/nTZdDeb6hCmF+uws4wDZxp7zryl118I0S2mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093488; c=relaxed/simple;
	bh=/W4oRREVfsIlOphdKX84ARTWcwEEFb+L2b7zPiB9Fck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey+AOPGX54lgHxhLJxwuVWvgAIZvWGCffVDsDpDIxq6w1iQIRewLzrwt0udMkgesZ+Wi3hqW94tLtD/1vV7+G4vtp6dRaE43Sp4hCK7GTY/W894UuCUxGk2YvlCZzcZN8ElL/g8XlXJeyDkXP2deNyj/t/ZmFoXIvnRt5ko4etM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GTPLGRqI; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734093486;
	bh=gAZiIBAW97iSqVxa0yzt2S2NKUuhI3+PKJU5sy0ohIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=GTPLGRqI7p1Ug1WY1aEwDN1yujO59xixCqprE1ZG56aOCN7U68v4cuc4Ch2zXZAkN
	 sg1zCwuNzK0bo1+vCD/XBDB6DBmyNkcby5lP8BWIwd2ZuWDSJBdh9T/nBh151AQw61
	 G9ec6MNgTav9ZpzCC7yhOC273s6iEocbnvYEF8ADLbNEjKSK5Cia+9h8C4KbH5NPfY
	 Jom59IwQG3XT7TUQXZahOaiP8XfmBWbPu89fq3gdCD9zGi3fbbneUL0JQyME7gV9Fv
	 97nNftPHguBSu6PI6oCin36dAV7X1olD48w8k3waOe8DiFLAL1u47yZlmc4wb9x1Wa
	 g4/RmMai0Lwwg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id E31592793D1D;
	Fri, 13 Dec 2024 12:37:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Dec 2024 20:36:46 +0800
Subject: [PATCH v6 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-phy_core_fix-v6-6-40ae28f5015a@quicinc.com>
References: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
In-Reply-To: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Johan Hovold <johan@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 stable@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 2JINNleipOqtTWVGoJDHTzZH0QuUezzf
X-Proofpoint-GUID: 2JINNleipOqtTWVGoJDHTzZH0QuUezzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_05,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130089
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_phy_simple_xlate() implementation by API
class_find_device_by_of_node().

Also correct comments to mark its parameter @dev as unused instead of
@args in passing.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Simon Horman <horms@kernel.org>
---
 drivers/phy/phy-core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 413f76e2d1744dd8ffb63a6c3a093f5c6cbead7b..8dfdce605a905d7f38205727151258af41f807a9 100644
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
@@ -760,21 +760,14 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
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
-	}
+	target_dev = class_find_device_by_of_node(&phy_class, args->np);
+	if (!target_dev)
+		return ERR_PTR(-ENODEV);
 
-	class_dev_iter_exit(&iter);
-	return ERR_PTR(-ENODEV);
+	put_device(target_dev);
+	return to_phy(target_dev);
 }
 EXPORT_SYMBOL_GPL(of_phy_simple_xlate);
 

-- 
2.34.1


