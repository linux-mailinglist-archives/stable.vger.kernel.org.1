Return-Path: <stable+bounces-91673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814479BF1BE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474122831B6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AC204080;
	Wed,  6 Nov 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fr3HZQ01"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BE203709
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907060; cv=none; b=rJc7+90/Y7ErK0b5CfOr2xW+CRT2y3Q0tK96zH4bOokq0zdFyD//d/+VVQniO7Y/FpRVKSPJqzWhTxXqZA04HuY+YuaA71dapZQOXoLSF+IQLjIih1KQWVhLWP4JPBGMVfA+IyB/8Vq6krHk2K7X4fONnJyievVzTMFOs92PMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907060; c=relaxed/simple;
	bh=1KhAN6Up8LvxWkGYnnnz9w9v3VZ1k1LEOJafT0KomhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uw50iq2lt2bsk/7pUPynXXESWm+fY6dgcyPm2NWOIIlJZhaN7hEfeEQPuATCMlwDNRZe8vDlwG6j/AGE26B3N/Owt2Jb4XAE0DJAQIC8e1ZA9WYb47rPNyDLuP0FTwkLPn7UuJiVKx5iWU8cYyXmSAyDT1HpX+Tb1XvT2ffVp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fr3HZQ01; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730907058;
	bh=D4p/ONPwsChgPFkyQAZ67fVmHAM1m6iVzlq7cFn+C6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=fr3HZQ017dFCBGKqttkIsUH2i3owsFsG+7gLZMNXsBYZ6xXhGy1yl47UdUlea9o+i
	 SS97zM/WqTgmQyJdYA4IcPffxaBC4vYN+GBtVGU3Jg9XE0zQvBN/vCenJA+Vko+3NL
	 nAhSmKNpW7tRrvaj56rNGr/Y0EOILd6vBAs9D+vq6DohmC+aCalDqYasiRYoKlxuM+
	 oXQ7mBd/49q5AoyJP342heXsninLXoChVvECmbwtfEU+uH1LmtkjqxFILH2LOPK4He
	 OAzdE5i63FqwQIoXdL8v8V/WLDXVefW2vQBikf6ZrQ2oG6Im/XZvIwTiJPd0Bk3gv6
	 LvNNbV7npFOEQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id A9D853A1115;
	Wed,  6 Nov 2024 15:30:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 06 Nov 2024 23:29:19 +0800
Subject: [PATCH v5 3/6] phy: core: Fix that API devm_phy_destroy() fails to
 destroy the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-phy_core_fix-v5-3-9771652eb88c@quicinc.com>
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
X-Proofpoint-GUID: IspyCmIlreuz43qiXRwdWu5eepWx8eoK
X-Proofpoint-ORIG-GUID: IspyCmIlreuz43qiXRwdWu5eepWx8eoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060121
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
to destroy the phy, but it will not actually invoke the function since
devres_destroy() does not call devm_phy_consume(), and the missing
phy_destroy() call will cause that the phy fails to be destroyed.

Fortunately, the faulty API has not been used by current kernel tree.
Fix by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Why to fix the API here instead of directly deleting it?

1) it is simpler, just one line change.
2) it may be used in future.
3) ensure this restored API right if need to restore it in future
   after deleting.

Anyone may remove such APIs separately later if he/she cares.
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index de07e1616b34..52ca590a58b9 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1121,7 +1121,7 @@ void devm_phy_destroy(struct device *dev, struct phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_consume, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_consume, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_destroy);

-- 
2.34.1


