Return-Path: <stable+bounces-104038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12E9F0C86
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A701416C006
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB961E00B4;
	Fri, 13 Dec 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JdwMQie4"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66201CEAAC
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093470; cv=none; b=ZKp0jbJDeru6XrXBntQSqyaauh91aDyjAkASHQTdv4Y/vJDFUopV83+ZVW9biIQ4AJvGKjSjrqQEpRFpETw3onWNC1VSnWD3afLxlUcj2frJbJOkYDEynIjzf3CoC8TmE32JHy8x+Sh4ujTbpT7Td2OYsOZpzOx/Nj9i9ZJhY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093470; c=relaxed/simple;
	bh=NZbAFdxpeagqFtzm5bKwXXLXgiLiEEZnFNLrVcYjWOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwtAPph5HJAhoEHcf5e+gsJ56HAPmasME8Jc8NKxDYRdxT9HTkW35A5PKtt9ToyY2YMaqGlPsP24QjdAv+Ds2O1T2c5p+DwSC7viNw7b8GfO8+d4gHDePgEh31fzLHLpeyPbY7cP+byZwdBj6I3qLP6ihzEI+L+WVyox/Q/wgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JdwMQie4; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734093468;
	bh=wyxreJ8ZOeQ11pLqAphuyUs2BXs2kHLB0q1+hs7nobY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=JdwMQie476kqVi74Ijs0Ss090VYMx6tic88LobqilcAt3RITK8waA2pkp5mEP5S3A
	 YFtfXESe51cCYKEoM2YBQZHlq62VKEAaIQt8a56F5cISDJ4+AhH4x0Qlm1PILREY3w
	 6/nrS3GD7btp/WZhkuPTfUOl6gPyfuSmDgcZyKalGk2GvvwvZOseDHAiNkAZmdEUWo
	 paJjCHcyGZix9I6MmoQgLd+xP3OWcA3HS+adQq3BMBwkCYg6DftlebYynQfn/7pV1w
	 sVKV9q8WF9LdY4e2++BDeR3uJofpG5KU/1JlKCzSaIMVh6o0xnaHHkbmWd6JO+3G2B
	 cONLFD2EqodtA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 2C22A2793DC6;
	Fri, 13 Dec 2024 12:37:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Dec 2024 20:36:44 +0800
Subject: [PATCH v6 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-phy_core_fix-v6-4-40ae28f5015a@quicinc.com>
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
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: JD-pS1O41hgJIkTIlLV-MtOWkkjA_jIb
X-Proofpoint-GUID: JD-pS1O41hgJIkTIlLV-MtOWkkjA_jIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_05,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130089
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
index 52ca590a58b9c303b21bf892565612a7ab92c095..b88fbda6c046174b7abd0a0435ec54763e9f42bc 100644
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


