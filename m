Return-Path: <stable+bounces-89333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4BF9B6587
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C078C1F21792
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5601F12E3;
	Wed, 30 Oct 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xBNqE/mR"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291901.me.com (ms11p00im-qufo17291901.me.com [17.58.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BADDD2
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297972; cv=none; b=NLsdgCiqo6LjQbrARnc3QJPk6eq6OPPS6YmI+CVTKLjzQl9eZCUY2eavdKx9laGg6nJoNJ5LC5cPGVtJzPYYXsGlW4Ceap8qKSjfBXGUQbKS2OAoUefctNbSCpHM1SAbD+7Nn2nZpJXG+vyPvE9/U6aGd2WQhKUqfSmvRKOyW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297972; c=relaxed/simple;
	bh=BxGlcQezFWQl4tzqPkJ+P+ewrSmqTZbTtmnndcK5vz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWJlkvzXew+d9Tk7Cy/kPhl6N38i5sDQDtZCKxUkopc3nLpfUtcgxXJPkk6ZiaxMiW/LWHlyu8RFZNs/vivIBjIpJLyP8WvbIIZ+d6CYmtSumjLbg3dH8cWca2KOZ7BUEK6/K+2ph+tG+N6IpRiPfygog3Zhffo6JNXvA82+JH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xBNqE/mR; arc=none smtp.client-ip=17.58.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730297969;
	bh=toeSTG1G9vSODnOMlPD25srU4vchWguh6NSK6vYSJnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=xBNqE/mRnPYdBHUItd2jTeo8Awi0MjU6q3H0rJPUixN+iRw5DSI0IXTARu0kHab0a
	 LPtRoimDpEuVtuFP/P6rf/LtCWcvPYSp2hUo/aIlgPR1Z0SBpvvx2dX89WtGsIQ4KG
	 M7ok35/gvIpXEEgY9qczKPt5leUa7DtmzpEBWYcoBNuPuI6Q+5HJ5W8KpWPVaob3EW
	 K4AYdo5VUfR1WXU/uCceH7vfzZs0Hia/3jEXGSIg5JBbswfwn6AUupWdWBHI5YwBuj
	 VekYuxyVPN/A5a1styNQF01BNs7Jf5P+Zpbjyi6Mjs3bqeiWOG3mFtJEO1orGqM4ac
	 GfaklE++PdzVA==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id 686A2BC026F;
	Wed, 30 Oct 2024 14:19:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 30 Oct 2024 22:18:27 +0800
Subject: [PATCH v3 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-phy_core_fix-v3-4-19b97c3ec917@quicinc.com>
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
X-Proofpoint-GUID: UGZtLvO1V-e2-nDBJPqX6d3Ah1CxpuBj
X-Proofpoint-ORIG-GUID: UGZtLvO1V-e2-nDBJPqX6d3Ah1CxpuBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410300113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

_of_phy_get() will directly return when suffers of_device_is_compatible()
error, but it forgets to decrease refcount of OF node @args.np before error
return, the refcount was increased by previous of_parse_phandle_with_args()
so causes the OF node's refcount leakage.

Fix by decreasing the refcount via of_node_put() before the error return.

Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 52ca590a58b9..3127c5d9c637 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -624,13 +624,15 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	struct of_phandle_args args;
 
 	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
-		index, &args);
+					 index, &args);
 	if (ret)
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


