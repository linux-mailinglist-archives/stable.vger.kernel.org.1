Return-Path: <stable+bounces-89331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C29B6581
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4CA1F22129
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868F1EF0AB;
	Wed, 30 Oct 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JPzuB8RR"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291901.me.com (ms11p00im-qufo17291901.me.com [17.58.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE291E47BC
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297952; cv=none; b=s5LHC8iARkxIh6Eq0yaV8QhKPA4qDlchAfYTUEFUDhAI1vNOgHFF6gAcPVMY93UobemgXiORy37ibG8gZ0syKxfeqc63wKVrNf5EcN9llVkuFqipX5ycFI9SQS8aKZDclJmm1f3o2eSVQPg/DpDUwze9SWZ8F2EfFYa3Y+7YqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297952; c=relaxed/simple;
	bh=nGsaVSj3Or+PJCrL5rwS3AkSAQW59whRTC5OEgG+xXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsVLhzQx0p3x9ZIbuP/Vi2ZUY+EFxQlYxqjkHoZLfMEeH4uwqd/mD2v+mLajOhH/yBMKmkPBDuVeylaiTkc9/qShsiw+812TR4e5SZ40D/C7Oclq+oji9WaaFPxjj/OIcvBA0aS+ZxyWx2Ys6vGj4J/Br8i6sKGYqe9Fmshs50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JPzuB8RR; arc=none smtp.client-ip=17.58.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730297950;
	bh=4SuEXx9ddfkxQj1AQp57UC2HOKADg1X3Q4LCag85EnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=JPzuB8RR8ju6RXo4slRR6W1puQ5GkMLV2K7ukB8u/M+LA2ugS1vNPS/or5pzy5IQH
	 7JazL2KGyeL2eNeHAaYsmAU44qelXY4PEYtbrFCe32ksTQgB68J9guhmnyDtyWnQ5e
	 Qp52rMERG7Eebxi3WBubJrueORfCRwnKmP9G7kNpWmmG4SBDcZrCMvP3+QKocuP3JB
	 0khd4r0YizjlSby/F+vJc2//kCIGW8lub72qhwgr7mFVFSiVOgZoZHRZxIE5a6I9XO
	 grbwhy+GueSjznm75/UIETpCxsvx4YQ4in0iipu5aZzTDYiO3X82eHY9JZAz/xOr61
	 dMlDCpEz2J21g==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id AB880BC01F4;
	Wed, 30 Oct 2024 14:19:01 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 30 Oct 2024 22:18:25 +0800
Subject: [PATCH v3 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-phy_core_fix-v3-2-19b97c3ec917@quicinc.com>
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
X-Proofpoint-GUID: a0_zSuWftRCGpbUEWyLL5C6M9dq2C0ZJ
X-Proofpoint-ORIG-GUID: a0_zSuWftRCGpbUEWyLL5C6M9dq2C0ZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410300113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_of_phy_provider_unregister(), its comment says it needs to invoke
of_phy_provider_unregister() to unregister the phy provider, but it will
not actually invoke the function since devres_destroy() does not call
devm_phy_provider_release(), and the missing of_phy_provider_unregister()
call will case:

- The phy provider fails to be unregistered.
- Leak both memory and the OF node refcount.

Fortunately, the faulty API has not been used by current kernel tree.
Fixed by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Why to fix the API here instead of directly deleting it?

1) it is simpler, just one line change.
2) it may be used in future.
3) ensure this restored API right if need to restore it in future
   after deleting.

Anyone may remove such APIs separately later if he/she cares.
---
 drivers/phy/phy-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index f190d7126613..de07e1616b34 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1259,12 +1259,12 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
+				     struct phy_provider *phy_provider)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-		phy_provider);
+	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
+			   phy_provider);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);

-- 
2.34.1


