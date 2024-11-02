Return-Path: <stable+bounces-89553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D59B9C98
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A0E1F22032
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA613C914;
	Sat,  2 Nov 2024 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XLqkagHW"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EA335D3
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519728; cv=none; b=ADcaJmhBVYfkTA1g+Vz4NiEoebtTTHquWbm7UsWSMwDJYV3u1nttbqtgAqWVCDBadE6Bv1KWJXpbvXiR7EuA4Gm/za40s5I08gfQ3uePjAQBxzY8Qps6AYpx6G/Cq5FwnUu1dXi1POUTw57CnvObrnHQgEIvT2bZiSJfJDo2tYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519728; c=relaxed/simple;
	bh=GtU76M6i2RKZjVJicBblCUDWJFIYTPUiNzBHNlGbmqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEAE78cPfBXtT5SnHdOZqfdvytlf/UJOcYc67WmB1fFLBEC9myRVqapgRV2J7wGSSzDy2NQIdk5n583FsQd4gAe4Jyl5ll7yB9xiIgGSqt6f0gtFsbLiV3XV0ToegudC6xGbwzhuRixLnL0n7rKwkVp/53En7m+63eX+hic8rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XLqkagHW; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730519726;
	bh=/xDAp1FMKoohjXNf6SYzu0enHw6XyaRJMqxsvwCqpAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=XLqkagHWDgslVODtuCdwUwXOZWM1RDuXiT81J+teNOc+FfQsnozA7SY1wod56mHCS
	 EaaCsjCwvdTTQi7Fk1GJioLzrkQpfuJtdJ5vNTMkxk3vWg26D3P7/CAww0LzGKAjBt
	 63mKjAJRrK8SRQmOY0taxJa6HP+tsZ2lpm1XoMrMhKBpFgx1fzYXHskvs5Bedum1q9
	 2zi+wy4AtHNWg1owsfp5/xd3sNPgPuB/e/uhW9Tb8Gm2SuvABMKZis6lqS4WY03yu7
	 jc4lFUiz/t2QAIIOztMHFzQJuZ25M1122f8I7SH+r0l+wKt9481JjVGtTZhEaKP4pb
	 FAWC+kZ11xsjQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 167B88E025C;
	Sat,  2 Nov 2024 03:54:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 02 Nov 2024 11:53:47 +0800
Subject: [PATCH v4 5/6] phy: core: Fix an OF node refcount leakage in
 of_phy_provider_lookup()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-phy_core_fix-v4-5-4f06439f61b1@quicinc.com>
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
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: DYGZfXmOFcG85eyxohgP_TfPVQasc3AF
X-Proofpoint-GUID: DYGZfXmOFcG85eyxohgP_TfPVQasc3AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_02,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020032
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
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
The following kernel mainline commit fixes a similar issue:
Commit: b337cc3ce475 ("backlight: lm3509_bl: Fix early returns in for_each_child_of_node()")
---
 drivers/phy/phy-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 3127c5d9c637..9d4cc64a0865 100644
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


