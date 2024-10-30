Return-Path: <stable+bounces-89332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CA9B6585
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2145FB213F4
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694A21EF0BD;
	Wed, 30 Oct 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w/MkvKd+"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291901.me.com (ms11p00im-qufo17291901.me.com [17.58.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B841EABD4
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297962; cv=none; b=EZSAqHSJNaaxeZ2t1U65I9YHNwX2Mjjv29naejhAXNwH9Pz1NYCSxNLZXS94VrA5eUW8mdL4lJrVwai6TLldOzgL26zusw0zvaWGhs9uliCG7mRdjadid/zmIWrafvFZ3LsBQXy8mZm+FZgDkuaiW//WG8dE+kwgYxxGpdokXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297962; c=relaxed/simple;
	bh=92EGOINSOaGj1I0u/RpgR5u33MAN5rnUxszAui8+GlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgkW0sYk7QCkZW+GQKZ9TLbE7UeNmkqd1Zaz5coFj9JEZOUUVepnwMpI8mWQUtKyZIHs46ln5OnkLbTw2M1uUXp5QWa1MgIeoOQFfjVYvDcXE/nnU/AcedQXFoTeyBN0wPOU4/Z8YKGLwSG3m5xay39XJYbr0NlmpPXW9R2zo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=w/MkvKd+; arc=none smtp.client-ip=17.58.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730297959;
	bh=JH4PLE2Ueuk57jBTrJMy1byNBdSHe/p/HgNBwh/Fobs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=w/MkvKd++gMbvMJ5HDABsoY27t2wunTOtksLTGmI86sGe6tK1WEKNlPqhlmij+eaV
	 lJvKPzoYCm/3Co2yWFUXoWMhaXKHoK2jYUNnCU7Ek97GJ5X++a2mGufxvlvR806m1M
	 TQaFtOQUY6c7K+MtTqJR+5LHizXLihmxiFPvAx22fXr8FD7yFiTZw7qUYEUGw3WKZw
	 WOjolM5a5rHL8K62xOhj5ZSqlfLn/ltWGz7wekg2XhZBLfH5hJDkprEA+sw+yPuusI
	 WqBDKP17vRAVd6BqUYvW/tE7+7JramKkVPTvLp3G6agbwXFazrC3F7raANqN9CL5tT
	 SJR0dkT4qPfeQ==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id DA7ACBC001F;
	Wed, 30 Oct 2024 14:19:10 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 30 Oct 2024 22:18:26 +0800
Subject: [PATCH v3 3/6] phy: core: Fix that API devm_phy_destroy() fails to
 destroy the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-phy_core_fix-v3-3-19b97c3ec917@quicinc.com>
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
X-Proofpoint-GUID: 3vi5sPVEyGfQOu8B4zInxOY8iBdXU74h
X-Proofpoint-ORIG-GUID: 3vi5sPVEyGfQOu8B4zInxOY8iBdXU74h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410300113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_phy_destroy(), its comment says it needs to invoke phy_destroy()
to destroy the phy, but it will not actually invoke the function since
devres_destroy() does not call devm_phy_consume(), and the missing
phy_destroy() call will case that the phy fails to be destroyed.

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


