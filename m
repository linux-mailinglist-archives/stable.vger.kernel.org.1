Return-Path: <stable+bounces-88082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332959AE91E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D121C2156A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB41D9A72;
	Thu, 24 Oct 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0+NSNjFn"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2E1E3DC1
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780840; cv=none; b=nsYrI0BfNlnNJL2s2S5Ecawz3x0mY0B+0pdz2bTX6KZ0vdBkmnjH/JUz5EuldkwKhDTpGLLpImeErzfR0/Kh3B4J+SivRzumwmHCv80h8ctNJkIimnsnVgkWSQ35UaRQ9UYgZkSJVrPORyjglescx6fQJAh8Zr+wsjjbEuPeBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780840; c=relaxed/simple;
	bh=Z6xTQmbM5bDzK6tXlwcDv8PR4b6kBhxB2kA1wRjXxiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUL8ASPApHe4gOuFYV1eVMa3Im+RK3HB6LUfj2EBhn/mXNkkNAqO04blssieKWKea6km82Xkuj76Z2vh2QGiVi14MCtLzKvG8vFfWFHqtXQQcOjlmwuWXj3LJohi7NX1f+BwOV15v2JHPncD6omjS0wFwE9wvFPjjT2+f4DRez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0+NSNjFn; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729780838;
	bh=7SUVDbgSA2VfVZU2rqgQuLCciZm9GwyAD6JqO4qnFgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=0+NSNjFn68dgCW5i+v659pv1usu51fd/8QHQfjydDrEI8ejVud+tearBU0ObxZTVf
	 JpNieaL0NLuqvGSOw/15WMy26cetH4U/OujVejp+bEe1+iSRkZxTvLJnX1jeIGCFF4
	 ZglqrvNS9Lagq+8K5LqGe+yTTdI9gEg4iCExgDAuNA3FVxh/7aCxzquFFfDtS0wwMG
	 28XxVJR6ciRKinzYnBgNYhOMR4sOTQFGPd0oLj5snh6yP2LMvWF1Ik5zLaa5+NhwBp
	 khLKBDAESVRkVZO6OPu5NHVlqiDQb+uomDxmo39lD0beHHGS4/C9XJmP56DWWuysEN
	 LexEakwQIrZUA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id A1A1FC80102;
	Thu, 24 Oct 2024 14:40:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Oct 2024 22:39:29 +0800
Subject: [PATCH v2 4/6] phy: core: Fix an OF node refcount leakage in
 _of_phy_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-phy_core_fix-v2-4-fc0c63dbfcf3@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A5fzWN84D0-VXZjY7cEVmNuokoA0ioi1
X-Proofpoint-GUID: A5fzWN84D0-VXZjY7cEVmNuokoA0ioi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410240120
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It will leak refcount of OF node @args.np for _of_phy_get() not to
decrease refcount increased by previous of_parse_phandle_with_args()
when returns due to of_device_is_compatible() error.

Fix by adding of_node_put() before the error return.

Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 52ca590a58b9..967878b78797 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -629,8 +629,11 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		return ERR_PTR(-ENODEV);
 
 	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
+	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
+		/* Put refcount above of_parse_phandle_with_args() got */
+		of_node_put(args.np);
 		return ERR_PTR(-ENODEV);
+	}
 
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);

-- 
2.34.1


