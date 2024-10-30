Return-Path: <stable+bounces-89330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50899B657F
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DF51C23613
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F91EF0A2;
	Wed, 30 Oct 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tXyTUqNb"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291901.me.com (ms11p00im-qufo17291901.me.com [17.58.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430D1EABD4
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297943; cv=none; b=oswUSY8L9zpSw+fRpDOJ240f5RcTUoSzMRlLvxKVfnSs1z1qXBQf3iWZqujCiHBP3cA9Sh4r04TAi9RhrTb+Qu/B6IHpBoiEacLYgigsuDSwuuHgiqfGiAI6b7Jxe0iwxCwKWDPPCgTjeMwc3ALoG5uvHfik64vFUWWiL2aweXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297943; c=relaxed/simple;
	bh=sdBwJWQ6ygdWuveJ5bfLElwUqgfCsYWhRjFOQhi7j/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzlP92YylT+ewvYc0mTXyt8hEhTduVS/4cVDGSZ73ifIP5LAl9A+ExemLF3nSJvZT3n6qI6idEk01P72D6lbK6E3eaCDE1w5J2htucfR+DEJ/cFcdPArlgDUiqN1e7VKRXfQGDfK3nt4C3RFoiqm4LRUSTx7x6/HosBtNlaXE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tXyTUqNb; arc=none smtp.client-ip=17.58.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730297941;
	bh=vWvPGu251oYkL+PTVEWgGIZl7f0hmGMZGCDwAIm43uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=tXyTUqNb9GzwXBeGIjBFuP3FgoddBjM3dEHOyk5xWqJELN0ofD0Uc4/uB5m5MRZV2
	 qi+S+UX3DqUYD4NlEf5lXp6ocQ1qX3k0GqA+6+8bS61n/jr15FHcl3L6MoE0Vsoadl
	 2pKbhKV+f4c3xnx1pFsdPjH5H8Agt72PX8yRP3rWLWSXFFcmPeWqEDARYaf8HTJBe/
	 iEGeEanlazDM8YOaB1wzFNrjwP85Jiw8gpLmH3us8DF3PknJ4OocMLWHeOT15MdmwL
	 z3m9Gyu2AZ0tnWUODSJ/7x6pWQc9CIdiSu5EEtzpgoaxAeR9ZQHyH2i4gZblItnUL/
	 yB32jqw1HJ+zQ==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id 107AABC02AC;
	Wed, 30 Oct 2024 14:18:51 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 30 Oct 2024 22:18:24 +0800
Subject: [PATCH v3 1/6] phy: core: Fix that API devm_phy_put() fails to
 release the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-phy_core_fix-v3-1-19b97c3ec917@quicinc.com>
References: <20241030-phy_core_fix-v3-0-19b97c3ec917@quicinc.com>
In-Reply-To: <20241030-phy_core_fix-v3-0-19b97c3ec917@quicinc.com>
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
X-Proofpoint-GUID: KRcO9NduntJ9G_8WHU6EzaOnEuZhFdSC
X-Proofpoint-ORIG-GUID: KRcO9NduntJ9G_8WHU6EzaOnEuZhFdSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410300113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_put(), its comment says it needs to invoke phy_put() to
release the phy, but it will not actually invoke the function since
devres_destroy() does not call devm_phy_release(), and the missing
phy_put() call will cause:

- The phy fails to be released.
- devm_phy_put() can not fully undo what API devm_phy_get() does.
- Leak refcount of both the module and device for below typical usage:

  devm_phy_get(); // or its variant
  ...
  err = do_something();
  if (err)
      goto err_out;
  ...
  err_out:
  devm_phy_put(); // leak refcount here

  The file(s) affected by this issue are shown below since they have such
  typical usage.
  drivers/pci/controller/cadence/pcie-cadence.c
  drivers/net/ethernet/ti/am65-cpsw-nuss.c

Fixed by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index f053b525ccff..f190d7126613 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -737,7 +737,7 @@ void devm_phy_put(struct device *dev, struct phy *phy)
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);

-- 
2.34.1


