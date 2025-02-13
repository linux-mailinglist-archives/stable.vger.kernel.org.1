Return-Path: <stable+bounces-115098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80600A33709
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 05:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311E1166320
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 04:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD3C2063F3;
	Thu, 13 Feb 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QYaM+0B3"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043761487F4
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422387; cv=none; b=blWa9LYdUFapLMQlzcL5GjJrtAM2PHNlRFoCXr7WXfF95oZDvPtiB9up2BfOvrsnbdbgXoWZK85BkfRuQ3LgPaKarFhLucUbJU9I6mGENRKn8cxgG17HM9NeUnifbX+0gh04gR0hV+hmNubDjuDgoErIPRZGB0fjhkSypR3V2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422387; c=relaxed/simple;
	bh=btuuGAHN0yAwnIydrz9luogYPZ/niqFXv+Dh58AVsiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FvhMNv36kUd1lAfEDaQYWDhp+ltYJGQ+dsoLjdu6z5YlmQS/W1xhji1N78ev7AJmvn155ExXHX6AEKOxA0JKo8ox/O/T6DU1mNMCTvlzQDZjPsB81pO9PmlvxMWtWcxjyzdymDWq0wmSxzCqIXg+WgjsgDJ5O0+oHjDZ161EJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QYaM+0B3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250213045303epoutp0416a90f631c8577c366ae3386981effd2~jq3E1uvqa1835918359epoutp04A
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 04:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250213045303epoutp0416a90f631c8577c366ae3386981effd2~jq3E1uvqa1835918359epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739422383;
	bh=xYvadG4L9+uv4OCgstcXZU5FpbGiAZUr3Y8c/BN7ytA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYaM+0B3j9pjY1TchDSszmCugRCkRiXQwm5wy3XOQifa1U+f5EuYFZON/x+IbH6UP
	 EC8tRPtMHM05s0b3x5o+yqShojCi7Zd/rIbFesI8sRnAoCWFaK/r0NDNKnreHxkI9Q
	 LBHnp6fGUCwOiVw6aavtMjtvOlbVYvGLsRWqbKbI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213045303epcas5p19913f8bc0828c7d50bca0a2cd6c5c8fa~jq3ETvyCN2465924659epcas5p1E;
	Thu, 13 Feb 2025 04:53:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YtjVR1cyBz4x9QN; Thu, 13 Feb
	2025 04:53:03 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d~jqciYgmG22763127631epcas5p3Q;
	Thu, 13 Feb 2025 04:22:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213042240epsmtrp1b8af1613244bed48759d265c9aeff182~jqciXf9BW0967609676epsmtrp1E;
	Thu, 13 Feb 2025 04:22:40 +0000 (GMT)
X-AuditID: b6c32a28-9a4e470000005bc0-f0-67ad738f2189
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.C6.23488.F837DA76; Thu, 13 Feb 2025 13:22:39 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213042237epsmtip16ed2c89451a5e8a08fdec56d33b3a3b1~jqcftTghr3115331153epsmtip1M;
	Thu, 13 Feb 2025 04:22:37 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] usb: xhci: Fix unassigned variable 'bcdUSB' in
 xhci_create_usb3x_bos_desc()
Date: Thu, 13 Feb 2025 09:51:26 +0530
Message-ID: <158453976.61739422383216.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250213042130.858-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTre/eG26wef3NhZvrq5itXgwbxub
	xctDmhZ3Fkxjsji1fCGTRfPi9WwWf29fZLW4+/AHi8XlXXPYLBYta2W2aN40hdXi/IsuVotP
	R/+zWjy7t4LN4sjyj0wWCzY+YrRY0QxUsmrBAXaLRz/nMjkIeyze85LJY//cNewefVtWMXps
	2f+Z0ePzJjmPX7dusQSwRXHZpKTmZJalFunbJXBlXL/+mLWgib3ix82VTA2MH1i7GDk5JARM
	JJbMmsjUxcjFISSwm1HiyJU9UAlpidezuhghbGGJlf+es4PYQgJfGSXWrDbsYuTgYBMwlHh2
	wgakV0RgA6PE1TOzWUEcZoFbTBIH/35gBmkQFkiWWPf9FhuIzSKgKjFvwgYmEJtXwEpi++sz
	UMs0Jdbu3QMW5xSwlrjYeQFqmZVE/9bVjBD1ghInZz5hAbGZBeQlmrfOZp7AKDALSWoWktQC
	RqZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBcaWlsYPx3bcm/UOMTByMhxglOJiV
	RHglpq1JF+JNSaysSi3Kjy8qzUktPsQozcGiJM670jAiXUggPbEkNTs1tSC1CCbLxMEp1cA0
	cQvPtUoVDuMHs9VrBGt++7+YYX7YeO2Rzlrn89HyF+ZWV1l4Pjw36UZffqfNcwW2m7dU9R5a
	Ns7q03wyn8PUmfusp+hPletK+qzO/luU15zneKlxa73mb+6XzjLOgjfeVboa7DYVerorMdvP
	MWDBvlV8tkLrLwZ6C2somMprmm82mML859BW8XmJUus/XObqmcQ8IcqlWbG08MN3uzIHabm5
	j4/m/Yy1O3Qv7PzF3Nz3AUde2O6asyDTy7n4cOgyvpmTHjOJhiewip4Knrz13s/96gZ6uV6P
	g31W1hjWNJ++1B+Z5+rEMrXjbv7xVMaitZHHPmx6v6nvXEDhd9O7RcVNm3MZVBdHGNUf6FVi
	Kc5INNRiLipOBADwarM9GgMAAA==
X-CMS-MailID: 20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d
References: <20250213042130.858-1-selvarasu.g@samsung.com>
	<CGME20250213042240epcas5p3c1ac4f97ebf36054abdccc962329273d@epcas5p3.samsung.com>

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



