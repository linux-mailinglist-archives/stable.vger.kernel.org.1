Return-Path: <stable+bounces-89551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08879B9C94
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40859B21D4A
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413813D897;
	Sat,  2 Nov 2024 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Pkkz/Tij"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C771494DF
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519687; cv=none; b=BoIb7rg7G68wjE2Pkk53GUWgH2w8AkvOhMrC1yUm/THp0DglbXx+k03xk2/sn9Vy/8E6jy7QOkjh4/gAeVwd5OkNHufY7fg/q+mS5joMS33tjgK6Wn/lTSLls08Wuf42jXuSGPJgNy8OzDcXwFPLMxxROXQHijomzRhIwhvCre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519687; c=relaxed/simple;
	bh=92EGOINSOaGj1I0u/RpgR5u33MAN5rnUxszAui8+GlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9lCKOuLMY+cuLTnTapGob0KnU0WyBoo9MS4ddHu29SXx5gDaWjtwWESgaa5E8IUt6cRYJ3q3Hhhl2u1PufBmRgX28SLTI7hcXmfzMcChc4WB42vANuVQHGpMa9A+RR2/g1LtPXOMfifw6hx3yU9aulYJ9FTSWCPpzQ8RbZvxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Pkkz/Tij; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730519686;
	bh=JH4PLE2Ueuk57jBTrJMy1byNBdSHe/p/HgNBwh/Fobs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Pkkz/TijAgnlXHMysDyZoxIen2kUVvBkL67RqJFoSWxpHDWjuy6M+68/l30P0B0yd
	 jNgzlGAuPB3glYvS/UkIbpyBm0n6VtzUskfICRzL476UH5DvPDnyNnu0qFch+CWbCJ
	 XksM+UkxhxRZQeY30rIS+t4H55V1TCmtrc0cDaqBZyFvMdnemJZ9BhGnuoCAKmz21f
	 /s25IXVV+I+QZ3J3MVuTQemcH0xbhVMn5qu4o5qW/R1Aex5yRCz4e1l54K3j8V6X1v
	 IozOhGxENeMWWKRi13SAjpAL6yX7yLCIdwq2NqjDmaxiTWUGJd3t8SRaR/RxTz2jgI
	 NoUH9l4CJKhtA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id E00238E01D3;
	Sat,  2 Nov 2024 03:54:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 11:53:45 +0800
Subject: [PATCH v4 3/6] phy: core: Fix that API devm_phy_destroy() fails to
 destroy the phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-phy_core_fix-v4-3-4f06439f61b1@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GhmL4pJC9aQs-aNsLgPM7SwBPrZlx_Gt
X-Proofpoint-GUID: GhmL4pJC9aQs-aNsLgPM7SwBPrZlx_Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_02,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020031
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


