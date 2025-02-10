Return-Path: <stable+bounces-114712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3BA2F939
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F40169545
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C882505BF;
	Mon, 10 Feb 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cG3g2vHX"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8522505B3
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216587; cv=none; b=KqKn+CREbX0h/6vnWXNwoFU/TenhFSnBIVwb315O+vug66w2/KGEsgFjsXSzyFu99G7xt9VYGFTMxBfziaVCuiQ/4OGK438f/ewcFSAtfpjfImY1UEjgaEryF70JbPGjfKK/qr51ldM6TTTLMbCd24490HxujK7OcUagjVn7aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216587; c=relaxed/simple;
	bh=zDOdwrtEgqL5utC5zX/sNmBwQ2znbX6ktSuLXgQgpws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=LzMCVMYkx1LuW4ukF2SNCkzxfAN2KSmsdJzOnVc+I9FIvrQVawl119TakC9AzwYQ3psmdh2MeBbibRyAo3KyTlFnGZEPqbrCnSMloreeNW89wRL82c1ZfKaJdMVg/nEzitWxUPeqGEZEeIwUkDL88+NRrFHA7mnAPPf/G8PP5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cG3g2vHX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250210194303epoutp02966dbc0e0cd4401e96e56cf6118a4336~i8ESRTw5c1750417504epoutp02u
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 19:43:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250210194303epoutp02966dbc0e0cd4401e96e56cf6118a4336~i8ESRTw5c1750417504epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739216583;
	bh=Qrsvwbm83TIa/72fQltxAnMshkLGTHgkRYY1/Dx1x1g=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cG3g2vHXZeNr3vRTI7qPxp094UfOoioi7+9R5n65bPh6mt2WJELuuEnwDdU0iYgD0
	 npUPkmq4w0hb8bddgWlOcMyJxJkoXIwrpaD8L4kzGMIrgUf6WmcLzit4j6CP2sAnGR
	 p4+Q6bei/PLEUE7iIhG6ZncSbv28LbHWna8TL5XQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250210194302epcas5p3e69da3238905af70a86a3e58b7ef2b49~i8ERiHxZl2476124761epcas5p3b;
	Mon, 10 Feb 2025 19:43:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YsFNk45Txz4x9Pr; Mon, 10 Feb
	2025 19:43:02 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250210131144epcas5p4a0599050f5973b495db0371021c21e27~i2un9NPY-0918109181epcas5p4D;
	Mon, 10 Feb 2025 13:11:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250210131144epsmtrp2efd616cee279f5e2c67f7838543d9d5d~i2un4wzLi1237012370epsmtrp2G;
	Mon, 10 Feb 2025 13:11:44 +0000 (GMT)
X-AuditID: b6c32a52-1f7ff700000083ab-83-67a9fb10fe47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.B4.33707.01BF9A76; Mon, 10 Feb 2025 22:11:44 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250210131141epsmtip2d289bc772427d32592ed474915e32c75~i2ulW1MWr0730507305epsmtip28;
	Mon, 10 Feb 2025 13:11:41 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] usb: xhci: Initialize unassigned variables to fix possible
 errors
Date: Mon, 10 Feb 2025 18:41:23 +0530
Message-ID: <1891546521.01739216582564.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvK7A75XpBusuyli8ubqK1eLBvG1s
	Fi8PaVrcWTCNyeLU8oVMFs2L17NZ/L19kdXi7sMfLBaXd81hs1i0rJXZonnTFFaL8y+6WC0+
	Hf3PavHs3go2iyPLPzJZLNj4iNFiRTNQyaoFB9gtHv2cy+Qg7LF4z0smj/1z17B79G1Zxeix
	Zf9nRo/Pm+Q8ft26xRLAFsVlk5Kak1mWWqRvl8CV0bNwIXvBdN6K5avmsTUwzuPuYuTkkBAw
	kXjbt52xi5GLQ0hgO6PEkcc7WSAS0hKvZ3UxQtjCEiv/PWeHKPrKKHH36HSgIg4ONgFDiWcn
	bEDiIgIbGCWunpnNCuIwC9xikjj49wMzSLewQJDE1Sdr2UFsFgFVicM7VoBt4BWwkrj24BAT
	xAZNibV79zBBxAUlTs58AlbDLCAv0bx1NvMERr5ZSFKzkKQWMDKtYhRNLSjOTc9NLjDUK07M
	LS7NS9dLzs/dxAiOEK2gHYzL1v/VO8TIxMF4iFGCg1lJhNdk4Yp0Id6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBib13qfhsvzJDyerf8zfw2Dl6MV8aukm
	O+HG4gmrtzNZZVtsdPJ++4Dtq9Cdy4GLz/qz8GhfjHRlbgjkFm+ZHFYanrFauifl5KqanRun
	bFqlFRb/6FXeejFehfgELa72VYHVy7/eSH3ZaBGc4jnhb07hr6d56rN5TfdtPrOg9pfHtdSJ
	X/QsU78z1ZdK/8s7/s7J8OlaxRtBM0IcelKeF39ri3t/aDP/pvkR4rvji25fenvQXODCqQuT
	1YQt9JPf/Dxo/fjWbOZHV2en686O5FFqaHs51TRkQa5kT9yc29pce1Z6rWctPGAf66S8KU2G
	ayp7tu/NJ7m7l/+T/nv0vAc/1xWNPz8y14j1ywhkbVBiKc5INNRiLipOBABUBjE1/wIAAA==
X-CMS-MailID: 20250210131144epcas5p4a0599050f5973b495db0371021c21e27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250210131144epcas5p4a0599050f5973b495db0371021c21e27
References: <CGME20250210131144epcas5p4a0599050f5973b495db0371021c21e27@epcas5p4.samsung.com>

Fix the following smatch errors:

drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'

Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
Fixes: eb02aaf21f29 ("usb: xhci: Rewrite xhci_create_usb3_bos_desc()")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 drivers/usb/host/xhci-mem.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..8665893df894 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1980,7 +1980,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision, tmp_minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision = 0;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
-- 
2.17.1



