Return-Path: <stable+bounces-91674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832679BF1BF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A561C246BB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6712040AE;
	Wed,  6 Nov 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="W6/p8tBj"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF883203704
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907073; cv=none; b=NcfrX2sychLas1+L6ux7Al1RPozsCWksEld9UprUezA/ze8iBjae1eLsmfFOP69AFIIk1esJ2ljXJOaaauezRan+t8aigZa/OPZtwnu0vEYRqX7aRbA4Kn5KG3eJKqpn9CcdNQY0752dUDlhOn9UKrMVFHOPHageV34pY1dwBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907073; c=relaxed/simple;
	bh=1FZpCdVnTqeQowpVcN/DVZ5XI+WsghCG8934Yyo6w0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQbZcAM/4UKrfIfxDjutd8qtxQ3tSmKNZn3J8IIwGanWKzq/cXcI5TpAGmfhQQuLmCdERbaTF91dYs/2A5rony+MWBTFeY3Cbo/Sg5DsYUGIsR+UUSCcY6ZYVQDWuWthW3XcEyxH8lGMNx5li1MV0nEKzah7Al0ZrE3YQoXCHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=W6/p8tBj; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730907071;
	bh=jRJAq6X1q0kmcyUpWLUZ36Ko6dovwQNaa0R6U7y4YOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=W6/p8tBjL9AUAg9Podk7POQ5vLnNEo8ef1bFmoIF4j/vVQSo+5kv7MbvN1ePRcSEO
	 sS5DYAU24u6IHuprUqLj+ZI8tCcRHDbkwdFlyuQgBnowvYcncNrroBPrVm2FFmbdhp
	 +5cpCuEE15Q1h81E8oUZGdTZr/0CjDSl5O/d9jxOi8bymvPuuYhjddbBz71lYHNbmy
	 HFsFINDT5t04LvUtkSHEe0tj0UK7J6VK5vmQu6z0+liT9S6SgiSycocnTPmZSDIhGE
	 LeFTe3cyw9z85whLCp5wNbhaV2CDSDQZlVn2zr1iww2D+5jopHeK89hII95xfvEIvi
	 HGQzJ9NZV+tdA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 9C3063A10BF;
	Wed,  6 Nov 2024 15:30:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 06 Nov 2024 23:29:20 +0800
Subject: [PATCH v5 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-phy_core_fix-v5-4-9771652eb88c@quicinc.com>
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
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: XhTcyP6hSKb-9YGDWtkqgALci_WdNh6U
X-Proofpoint-ORIG-GUID: XhTcyP6hSKb-9YGDWtkqgALci_WdNh6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060121
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

_of_phy_get() will directly return when suffers of_device_is_compatible()
error, but it forgets to decrease refcount of OF node @args.np before error
return, the refcount was increased by previous of_parse_phandle_with_args()
so causes the OF node's refcount leakage.

Fix by decreasing the refcount via of_node_put() before the error return.

Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 52ca590a58b9..b88fbda6c046 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -629,8 +629,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		return ERR_PTR(-ENODEV);
 
 	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
-		return ERR_PTR(-ENODEV);
+	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
+		phy = ERR_PTR(-ENODEV);
+		goto out_put_node;
+	}
 
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
@@ -652,6 +654,7 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 
 out_unlock:
 	mutex_unlock(&phy_provider_mutex);
+out_put_node:
 	of_node_put(args.np);
 
 	return phy;

-- 
2.34.1


