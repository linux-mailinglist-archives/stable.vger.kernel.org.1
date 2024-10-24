Return-Path: <stable+bounces-88081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F819AE91C
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A3B22BD6
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611381E8857;
	Thu, 24 Oct 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0cta08Hk"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FF1DDA16
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780833; cv=none; b=SiPwk4r13OEs8Z7VyCV4820mb26gODTcCtH5UdtiOJXC6J8aL+FoJ1ZVUZRPm3kDIygCzG3qmsQzbi0h813+0+UzxWtP7uV2hcSJUSU8Xi6zzHFTRbZrO+MDKRazg0zYUTznGGS4RuWK4cQt5ARNLe4nyV9naL4UAXwCLO45iTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780833; c=relaxed/simple;
	bh=KuC8QJgWMDP0M0UYhUaMvuor1BX/HMv6T/muqE5kB7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FU1FhqYj9KCMTu9ihIr69TPf4oY9S+SMyCir+7kP8CB5d8QHO+NBRfUICspiiMjNDoNKqVvymC8LcrJXAImCVOzL9Z78xc71vspWPNMmUwNI9yfKO5ewsIb+0j+5vmjRXxBzuksLKcEMRuFXq2bIVxMbTFkN2SJuzIFqyIpYpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0cta08Hk; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729780831;
	bh=6mqxkWzrEpyKrm2lpF26RrivIenk/tZDn/SIHzzqvlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=0cta08Hk5UECwqRpw5sluAfg5bJQ6gK0HPTl9zMqQxM/V7njFvXlIb+fxlfYW+n9g
	 8aHVK2PtPjAV9FtP2sfCaCVJdJ3YEu6yJWYV7sW/CC3f2WV4eckB2rcbB9lF2L0CZI
	 6ZBtYp90HX8ZSycHjgNbbuNaaeJwjFxzSEPa1GxQFOUBhCSfMhXt1umDrX9i0WJzAP
	 B8VQybrGH6mrcbVlEwxFHSc9W4fcZmP0pWOStZ3UYQQed6WE0e/L+S8tyqOYO403UX
	 uylJ+x54W+NaG7vVrdwai1nmzw4WLunIA0m6L/VF00cGW0i8PVahs30cmYAROR/Wnf
	 8BKxKf6KBwQug==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 53724C8019D;
	Thu, 24 Oct 2024 14:40:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Oct 2024 22:39:28 +0800
Subject: [PATCH v2 3/6] phy: core: Fix that API devm_phy_destroy() fails to
 destroy the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-phy_core_fix-v2-3-fc0c63dbfcf3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: suBrFoxD-WoAD9TMyXHHqMf0w4lir4hd
X-Proofpoint-GUID: suBrFoxD-WoAD9TMyXHHqMf0w4lir4hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410240120
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
to destroy the phy, but it does not invoke the function actually since
devres_destroy() will not call devm_phy_consume() at all which will call
the function, and the missing phy_destroy() call will case that the phy
fails to be destroyed.

Fixed by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
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


