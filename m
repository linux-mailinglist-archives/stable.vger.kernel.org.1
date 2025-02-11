Return-Path: <stable+bounces-114981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4084A31B10
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8376E3A3957
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E92940F;
	Wed, 12 Feb 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="byMPGyNh"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F15282ED
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322787; cv=none; b=VTjaiuWuQZ6vWDcEgBCbzHHLwCfWeV3AH7+H8xBu7u9sDZTgqSrRsdyHPZG4WiYbfWRhHyMvWZDZZIW4vjis/bsGPzqkw0UfwoXqBCjNf/StLrtJBuFAMLoJDIUL/6w75dpucwAKsAa2/y3LA+idWkIxfTg84AsPDRGuKtQ9rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322787; c=relaxed/simple;
	bh=btuuGAHN0yAwnIydrz9luogYPZ/niqFXv+Dh58AVsiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=luvjd9Fu3706lI21WlIzr/qMnHy1ciYJtipKWv+047mYAWBwUD2xwFdlONtZXgcnaqTusX4e0GKEReu+zGLdojjlnLko52IkaRshTa7667tuSeqChaQyoUnIF2Dl4iMIwoVnaSn1x+02Ls+s0dPJzmUI/frtZOtgZ2A8LazAUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=byMPGyNh; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250212011304epoutp0113284e46262c0e39bf8af5d70cfe36ca~jUNtZg2FU0340103401epoutp01Z
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250212011304epoutp0113284e46262c0e39bf8af5d70cfe36ca~jUNtZg2FU0340103401epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739322784;
	bh=xYvadG4L9+uv4OCgstcXZU5FpbGiAZUr3Y8c/BN7ytA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byMPGyNh2g+Cv8tnKEER8fPkRnxbdNl7c16baLwhfkAiJgRFI3noaEOm+Tbk+HmI6
	 szW6I84yClcHb0LGHaXkNh6aXFbZDVvcGNtLiJZ86oPgsLR90M3Gz9MHt20Xc8Onqz
	 pU3RtvqPQcPRMOHB4XsPQLGZxxsXX6SahpQFEVZg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250212011303epcas5p2e7202c409a581852a46b063cdd8d32c8~jUNse5J9e0370603706epcas5p2Q;
	Wed, 12 Feb 2025 01:13:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yt0g30jQHz4x9QF; Wed, 12 Feb
	2025 01:13:03 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250211115716epcas5p348e4f836ebc02cd4d0e6a2d0630da0f1~jJW5Sttkv2636626366epcas5p3z;
	Tue, 11 Feb 2025 11:57:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250211115716epsmtrp17322dc316189a68f4a05a1b50d65bcb4~jJW5NfdMe1464414644epsmtrp19;
	Tue, 11 Feb 2025 11:57:16 +0000 (GMT)
X-AuditID: b6c32a52-1f7ff700000083ab-4a-67ab3b1c3df9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.85.33707.C1B3BA76; Tue, 11 Feb 2025 20:57:16 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250211115713epsmtip1f278a783743b2af22e21a8640d655df4~jJW2cjSbX1898518985epsmtip1L;
	Tue, 11 Feb 2025 11:57:13 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
Date: Tue, 11 Feb 2025 17:26:30 +0530
Message-ID: <1931444790.41739322783086.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250211115635.757-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTlfGenW6wedfWhZvrq5itXgwbxub
	xctDmhZ3Fkxjsji1fCGTRfPi9WwWf29fZLW4+/AHi8XlXXPYLBYta2W2aN40hdXi/IsuVotP
	R/+zWjy7t4LN4sjyj0wWCzY+YrRY0QxUsmrBAXaLRz/nMjkIeyze85LJY//cNewefVtWMXps
	2f+Z0ePzJjmPX7dusQSwRXHZpKTmZJalFunbJXBlXL/+mLWgib3ix82VTA2MH1i7GDk5JARM
	JH4c6QOyuTiEBLYzSrTcmssOkZCWeD2rixHCFpZY+e85O0TRV0aJd09fACU4ONgEDCWenbAB
	iYsIbGCUuHpmNtgkZoFbTBIH/35gBukWFkiQaDrwHWwqi4CqxJW7a9lBmnkFrCQOT/CGWKAp
	sXbvHiYQm1PAWuLlyfdgi4WASiaf3ArWyisgKHFy5hMWEJtZQF6ieets5gmMArOQpGYhSS1g
	ZFrFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERxPWkE7GJet/6t3iJGJg/EQowQHs5IIr8nC
	FelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTMFnghTV
	Ja5N4Bd1ZnnWms2mOKW0+fmVsKT1r4+Frc1dmmrtWOM+6eS9A2dE2ZilVwu8Z8j1/Pn2rOmd
	JCflGRJNLhe5Xmdxne10Obg4uP29bX3ESpE6liuWZqYXEm26/dSkHbd0TqhY/L8kJ2D39X9l
	qxeel2faHScqt4iPp6LxJos/5wb272b2Oy/vztXtnHwlXXOTUseslOp8m/PvdPbxeV9S2Nb4
	wPL6m70Lm2qUDUI09ZpsjP++uX2ikyezLfjopdd7pk2ZYu7NE+vs/kTlZrfXvvmnv60v1vFr
	+jenW/nzus3nLm+cxPjOxPhlsXSDcYzTG+1Sn825viyvU6XCM27+f8K2alFZ+uYIJZbijERD
	Leai4kQAbuOPnRYDAAA=
X-CMS-MailID: 20250211115716epcas5p348e4f836ebc02cd4d0e6a2d0630da0f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250211115716epcas5p348e4f836ebc02cd4d0e6a2d0630da0f1
References: <20250211115635.757-1-selvarasu.g@samsung.com>
	<CGME20250211115716epcas5p348e4f836ebc02cd4d0e6a2d0630da0f1@epcas5p3.samsung.com>

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



