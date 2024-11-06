Return-Path: <stable+bounces-91675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A69BF1C1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C243C1C248A7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBFC204934;
	Wed,  6 Nov 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="E+MspX7W"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52320401B
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907086; cv=none; b=rdEaceb2MjG4dPk4X+aB2o5gy1bA9dd+3+bqVvq+uYKZHf97yfDuBHhR0KlH2UWmpTKWXWz+g9dGH3VKKWIP3OaNbExigHPBgdlhrhj6vJr8IOfcqPczvfmjCLXOeb/Wy4Eno62bnsq2nqUh3+2XyHGr55cYxQ+LIdMFMrc5P8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907086; c=relaxed/simple;
	bh=n1clbFDxKveXazVTIlX8rYcw1NpLYuAEBm5zoMt1+oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rL6f1K7VaxUXow29JckgdryXqkxaTXuy1Ikb1s8al5to78pXVXKazjj8Aih+Orl1QKdaTfx9XKIHA0zE1zLu/OUdMH/sLaLCDmcayh05ofM8Ikkx6JepYUoGQXCdJlLaqItmp5Alo0diKUrhHrpnJFB20AoOrfIOSXSn44dEHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=E+MspX7W; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730907084;
	bh=vn7YLlTMs35v/+bzgOIOZMQXRYeYPFiSPDi8rm2sJcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=E+MspX7WdtzMGksSBtYzuCb3l2CAHvMSFZM2LLyF+T3joqiOZ/rDl5PlWfxbRUHvS
	 oP5y/QQjPOVahyAoGRYDaALJoRVazqjCd+A5jcOmlL7eybgY20DgPeN0WeYqMvXdn/
	 eYasYgV5yfNSbMUVUOqRPdyGDDPqexbJRUYI5X7zyYm1tcttn23HUU+FgeCta6GFOd
	 JA1reKNHhUiveMC6c5AK+nIhRs41A9M8PysGcgRuCSqIyQSRtLAP9h7OPIG5UVU7tf
	 D3xE01op17lutnlWIg0mn+LNRhqzdCCKGK8OXhi2+pVHrTNFH5SO5UbMg0cmVxdszF
	 ZWunrT5nuMGNg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 932873A0A06;
	Wed,  6 Nov 2024 15:31:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 06 Nov 2024 23:29:21 +0800
Subject: [PATCH v5 5/6] phy: core: Fix an OF node refcount leakage in
 of_phy_provider_lookup()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-phy_core_fix-v5-5-9771652eb88c@quicinc.com>
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
X-Proofpoint-GUID: sPXWQqURoU3m9fe4K3pZkqREUZjSNIng
X-Proofpoint-ORIG-GUID: sPXWQqURoU3m9fe4K3pZkqREUZjSNIng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060121
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For macro for_each_child_of_node(parent, child), refcount of @child has
been increased before entering its loop body, so normally needs to call
of_node_put(@child) before returning from the loop body to avoid refcount
leakage.

of_phy_provider_lookup() has such usage but does not call of_node_put()
before returning, so cause leakage of the OF node refcount.

Fix by simply calling of_node_put() before returning from the loop body.

The APIs affected by this issue are shown below since they indirectly
invoke problematic of_phy_provider_lookup().
phy_get()
of_phy_get()
devm_phy_get()
devm_of_phy_get()
devm_of_phy_get_by_index()

Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
The following kernel mainline commit fixes a similar issue:
Commit: b337cc3ce475 ("backlight: lm3509_bl: Fix early returns in for_each_child_of_node()")
---
 drivers/phy/phy-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b88fbda6c046..413f76e2d174 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -145,8 +145,10 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 			return phy_provider;
 
 		for_each_child_of_node(phy_provider->children, child)
-			if (child == node)
+			if (child == node) {
+				of_node_put(child);
 				return phy_provider;
+			}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);

-- 
2.34.1


