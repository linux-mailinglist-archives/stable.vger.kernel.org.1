Return-Path: <stable+bounces-88083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7669AE922
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E11C2220B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0EB1EF0BB;
	Thu, 24 Oct 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="puj7eOkv"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B71EC01B
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780848; cv=none; b=kapi6gbLQ/xO8c08lzxMY4vuQsrgm+RkUvOV6lm0+oPMu2WHF5FqPxUREbSrDxa/NKozJoAbPxMLMyydblMu2cCmTJrbbUjayHgSi17ieLPdgo0BSmjrBNGnEwAHl7Nt+ZEzE9AxIYGRXuIZTQiCJMwZqexDQfy7EIScNm/HBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780848; c=relaxed/simple;
	bh=iZKDw8ZYl2r+PnmmzzqcjTPuBPeYAfMiAPoDOy7IBj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttIVx6nbIp9zyzmn/mBIlU3xRDSHZjY7auNiN6Qz+DzKaHYg0ZwVdt30gceRzmo0m4LImjOZmOpKquayG4PPqxrVgGT7OjnQNPNzZNPQMsPZ9CZLwjR8zrtHo7Iea8qKX+6n9nilgjrSTt5HGNwwngHdfjvaT7eMdKEYIRrdbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=puj7eOkv; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729780845;
	bh=Ao26SUIb49PEusAusFKVqbKwYbs2RGsKMlMvZlYTPaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=puj7eOkviFui+XPsW59+5X+gEPwLIDDj0ip2kCBMb9ckgcCVO9y5WMle8LC90hCgo
	 TVnZsLZyu+M8qJMqsedVLqBZIsZI7w+GcPbPl9B8vijaUh8TQq6f7bZKcc1wEMHy4G
	 BaVir5Mv6CGeSFFjByPwTi7MM8ollBCiM/IjgLK09hanfsj9Ra0iP7aUlsoQbDvdnP
	 DYoB8GcELq6Iyu+G6mnSZetOJpfw6oZ198ec1wI+4YRE/f+LI4Rcm2qow2hTurNpe8
	 aDairxQYm+uLUxJitzL2TqyOfd0VGNNs/7wH/EJJvN9sFT1LSsHCzyPamlyF0Fmn7E
	 syLDcInm2fFqQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id F3D3EC801D5;
	Thu, 24 Oct 2024 14:40:38 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Oct 2024 22:39:30 +0800
Subject: [PATCH v2 5/6] phy: core: Fix an OF node refcount leakage in
 of_phy_provider_lookup()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-phy_core_fix-v2-5-fc0c63dbfcf3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ljF3k-k6RczWgU4HR65qjNpZTcRZvZNQ
X-Proofpoint-GUID: ljF3k-k6RczWgU4HR65qjNpZTcRZvZNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410240120
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For macro for_each_child_of_node(parent, child), refcount of @child has
been increased before entering its loop body, so normally needs to call
of_node_put(@child) before returning from the loop body to avoid refcount
leakage.

of_phy_provider_lookup() has such usage but does not call of_node_put()
before returning, so cause leakage of the OF node refcount.

Fixed by simply calling of_node_put() before returning from the loop body.

The APIs affected by this issue are shown below since they indirectly
invoke problematic of_phy_provider_lookup().
phy_get()
of_phy_get()
devm_phy_get()
devm_of_phy_get()
devm_of_phy_get_by_index()

Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
The following kernel mainline commit fixes a similar issue:
Commit: b337cc3ce475 ("backlight: lm3509_bl: Fix early returns in for_each_child_of_node()")
---
 drivers/phy/phy-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 967878b78797..de0264dfc387 100644
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


