Return-Path: <stable+bounces-114866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC0A306EB
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3DD7A1092
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39361F150B;
	Tue, 11 Feb 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SyNdxhaj"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8941E4106
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265906; cv=none; b=IfhNdYL+88HfjxhrvuEnBxgXEi8R2wAyqhYG3YTUmjziW5CxLMzfW5/8+xJ068JQM4hiullc4Cs1eM2tV9ECGeeA2lSLeqw+OOcEd9GJ6x/CMIK3bKXcvDZNRdxTVq72l7oeVTU5znpBcT5N43VPCRhmwOrRU27ZL8RcW+alzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265906; c=relaxed/simple;
	bh=btuuGAHN0yAwnIydrz9luogYPZ/niqFXv+Dh58AVsiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pfswwvwBmIkoeLy8M93sE8E+B5YFm/dcXR1CSL1FTXCfcUNDirnVcEre4WQfVBQKW/y5HNmA36pQL6bwtcL04L+zCU1FQMu8KnETeMd6ynhA+4Jkq3/UdGsMUAyhBVf6ySfslqWaCNCPGOs0uol1LPHamblv2Zt9/4ij/9tr6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SyNdxhaj; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250211092500epoutp04c03cd958f795c5c8ca3b2229f02220a6~jHR8yJmLR3212232122epoutp04X
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:25:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250211092500epoutp04c03cd958f795c5c8ca3b2229f02220a6~jHR8yJmLR3212232122epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739265900;
	bh=xYvadG4L9+uv4OCgstcXZU5FpbGiAZUr3Y8c/BN7ytA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyNdxhajVN8CJLiKw2mZsjZegpfE03gJmp4vGrgW7V7CMFFX2WLZBp2MbBKTT4Y5T
	 xFfCSQQErAIKBXF+1UlItxH5B1+nvZGOG8lWtgj4Ruw53bu7V2bdToWT91X8CspfOq
	 4AvPEoD54Hy3Kq/1e73BcPeHG1CQmb166R4/5iuM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250211092500epcas5p2943131243b93ec51e576eda06d4a8056~jHR8jp-cN2828128281epcas5p2l;
	Tue, 11 Feb 2025 09:25:00 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Ysbd71w95z4x9Q1; Tue, 11 Feb
	2025 09:24:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.94.20052.B671BA76; Tue, 11 Feb 2025 18:24:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa~jHR66ATql2787027870epcas5p1i;
	Tue, 11 Feb 2025 09:24:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250211092458epsmtrp2c38eaad29f64f394db7786c95d34ebb7~jHR65ZyIO1011310113epsmtrp2t;
	Tue, 11 Feb 2025 09:24:58 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-cf-67ab176b936e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.2F.18729.A671BA76; Tue, 11 Feb 2025 18:24:58 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250211092458epsmtip2a05281605fd6beefd31ed7c163d826c2~jHR6Z4jVd3218032180epsmtip2M;
	Tue, 11 Feb 2025 09:24:58 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: selvarasu.g@samsung.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
Date: Tue, 11 Feb 2025 14:53:55 +0530
Message-ID: <20250211092400.734-3-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250211092400.734-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmpm62+Op0g1V93BZHln9ksliw8RGj
	A5NH35ZVjB6fN8kFMEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
	Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr
	5aWWWBkaGBiZAhUmZGdcv/6YtaCJveLHzZVMDYwfWLsYOTkkBEwkZm34zdbFyMUhJLCbUeJS
	yztGkISQwCdGid4mA4jEN0aJrzdmwXV0HHoE1bGXUWLq3CfMEM53RonJrbeZuhg5ONgEDCWe
	nbABaRARkJaYtfEsM4jNLCAlse7TITYQW1ggSWLu+WdgNouAqsS3+Y1gm3kFrCTWbHzMDrFM
	U2Lt3j1MIDangLXEyelroWoEJU7OfMICMVNeonnrbLAbJATWsUs0PpkG1ewiceXlfGYIW1ji
	1fEtUHEpic/v9rJB2MkSeyZ9gYpnSBxadQiq3l5i9YIzrCC/MAMdsX6XPsQuPone30/AXpQQ
	4JXoaBOCqFaVONV4GWqitMS9JdegYeUh8enoG1ZI8PQxSrStXs82gVF+FpIXZiF5YRbCtgWM
	zKsYJVMLinPTU4tNCwzzUsvh8Zqcn7uJEZzItDx3MN598EHvECMTB+MhRgkOZiURXpOFK9KF
	eFMSK6tSi/Lji0pzUosPMZoCw3gis5Rocj4wleaVxBuaWBqYmJmZmVgamxkqifM272xJFxJI
	TyxJzU5NLUgtgulj4uCUamCqklQRsH6jqv5ZrSddrGDxI5Ptf1/u7/gkU3s8Ntqiahfr7GCF
	w//LCounVH9jPaGmw/SQt+Ln2dWOkvNzxKWdPm9TTz7s+INrW6d9zhGf02vcmV/MMoz8F/6K
	x4KHNerR45wTS2pWPbE+7Ldl2YPfjH032H9EJ176nP9C6ob2Fyu2PctVjsoYbGeYcfqV5Jdw
	85UHfINeWu3RFNzAudr01sL6WdNc95yaMvXPCt+WEzpLwn2envgzZ/PqxSqVDF6nH6aEJemG
	7C8TbBW3rZl4tTfK/GmlReTpXyptPM/Msn128X5R+R5d8u4VX+qugwfk3Ptv+2dyLbTp2DVx
	3RTz/0ymIvrdmRVazJt/dYQrsRRnJBpqMRcVJwIARapZ+e0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvG6W+Op0gwX3DC2OLP/IZLFg4yNG
	ByaPvi2rGD0+b5ILYIrisklJzcksSy3St0vgyrh+/TFrQRN7xY+bK5kaGD+wdjFyckgImEh0
	HHrE1sXIxSEksJtR4nF/HztEQlri9awuRghbWGLlv+fsEEVfGSVWP3vP0sXIwcEmYCjx7IQN
	SI0IUP2sjWeZQWxmASmJdZ8OsYHYwgIJEk0HvoPNZBFQlfg2vxFsJq+AlcSajY+hdmlKrN27
	hwnE5hSwljg5fS0jyHghoJoba10gygUlTs58wgIxXl6ieets5gmMArOQpGYhSS1gZFrFKJla
	UJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcglqaOxi3r/qgd4iRiYPxEKMEB7OSCK/JwhXp
	QrwpiZVVqUX58UWlOanFhxilOViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpjY772I6NUx
	ebUxt8BSpO1evtUC3quMVyrTXiVoLBSdnrbDMi6Hc/OqiEsej1wVvxYLbYk68vrWU88zQovf
	XJqxbr/+sZpS43dcnb5R19ZOnTmbIY3vhfVk39f8e3lmygjsvefyTpn92Z8loR+CYk+E/LFe
	96Z03y5m0QbGN+52gXblc7NzRXxVvif/mBa+ZKmmfNbpJyWOH70+MG/kWHKHXXL7lBfO122V
	ni7czu/eHOn6Kzjw0rvQBc6CqoIhcg92hmSG6aq5MLGd5Zq+YE3NlZfvSlP7Xe++y72qzuCX
	VGBXE7r3gsW5xBz199vL5Gduf23Bub/mirncxrLF599ktGlsSmPQX2gfcsP5HIMSS3FGoqEW
	c1FxIgBcF639sAIAAA==
X-CMS-MailID: 20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa
References: <20250211092400.734-1-selvarasu.g@samsung.com>
	<CGME20250211092458epcas5p1a00969c88bb6db8d885b3b11c37c9cfa@epcas5p1.samsung.com>

Fix the following smatch error:
drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'

Fixes: eb02aaf21f29 ("usb: xhci: Rewrite xhci_create_usb3_bos_desc()")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 9693464c0520..5715a8bdda7f 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -39,7 +39,7 @@ static int xhci_create_usb3x_bos_desc(struct xhci_hcd *xhci, char *buf,
 	struct usb_ss_cap_descriptor	*ss_cap;
 	struct usb_ssp_cap_descriptor	*ssp_cap;
 	struct xhci_port_cap		*port_cap = NULL;
-	u16				bcdUSB;
+	u16				bcdUSB = 0;
 	u32				reg;
 	u32				min_rate = 0;
 	u8				min_ssid;
-- 
2.17.1


