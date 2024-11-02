Return-Path: <stable+bounces-89549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9B9B9C90
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0CC1F2200E
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7213D897;
	Sat,  2 Nov 2024 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WAs1oex0"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8334CDD
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519666; cv=none; b=oDTdWf4PbfLIm9mTteYbqqRpTMmLqpvfKhgflXlnA9avdejmEpyCEbPEqo49ExJTovpoiZF17bJwdowR9Jc1utGwkUi6s4jnoxzKP1OVsECwvlhLHI3B+TmO3O3ycH2KWqk5WQVC2v0KU4nt48njqOzPfWHTcXf9qH1dNeUudh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519666; c=relaxed/simple;
	bh=sdBwJWQ6ygdWuveJ5bfLElwUqgfCsYWhRjFOQhi7j/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwf/eDRobGQ5vJ7a/5DJxwZPt3ixsuTtakhlFYVOENj8x5Ik9F2NA8qlRy9zzi5jvkF4hPjSb04N7GxLWNDCNwdIdUTOMsFhaXkm7o7Z5JIA8NJbqPpan/05SCr92x8TD6UAiMpyQc1eb+JbReh2q4lISF2LBn05166VU+HdLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WAs1oex0; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730519664;
	bh=vWvPGu251oYkL+PTVEWgGIZl7f0hmGMZGCDwAIm43uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=WAs1oex0c+Y78h6SmNmO5co6vwP+jQkLG+ugKTnU/0AYwjHcJfYrvoUcq2U/6xbHO
	 x1JUdPWeTYsiqlf1PK6843DP09jSgl4ViTWB7UkgWQC6QD4xVJ1DluZxQCr7wk1nX2
	 noDRKempXMpKHrHErWExO/78F+C+1b1rCN/92FLE0+Pvgp0qdYkujPp7Ls61ufKtVq
	 WieY8/XiVJa4kAzNGEfD1Gss8pIUjyY+jCcw69B3oP160143IgVSE9tzKSckEzL3RX
	 eVZQSmAsBRixa6wnFT8GVCPIzD/phS9bMeSQMr6QJR2EJB6osfEpeZYEnqf+0Qb8cK
	 Tt1CwHuDB/mRw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 07AFC8E00B3;
	Sat,  2 Nov 2024 03:54:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 11:53:43 +0800
Subject: [PATCH v4 1/6] phy: core: Fix that API devm_phy_put() fails to
 release the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241102-phy_core_fix-v4-1-4f06439f61b1@quicinc.com>
References: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
In-Reply-To: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VBFZYkbd-yy1qVXFeyW1gt5AEzHJi56C
X-Proofpoint-GUID: VBFZYkbd-yy1qVXFeyW1gt5AEzHJi56C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_02,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020031
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


