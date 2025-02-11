Return-Path: <stable+bounces-114982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BDA31B13
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F743A3844
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EC35956;
	Wed, 12 Feb 2025 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RTiG0Mb5"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902541DA21
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322788; cv=none; b=LiYu4fDOrYQB7EZ9k+BwGovNXbhl2r+0dBLc277plDCAvntAFEiqlybT+kYYkkL38Sxug7Si11Mw0lefPOKAiwIOtYymnbHBr7R1whUEOtz4w/NeXns4V+EFKv3Cd0AkQ1GagFu2ny3wxkWx8jInJV/EKc8H7pN3KmdDrMFI0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322788; c=relaxed/simple;
	bh=dficntmdLBv88Uvc4N5XgHBbu1lCoeFFI/9KziADYdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dl7hkkQRfA5isl5TXATuP8Gya5Ts6rMKtZdhVnUXsXyrQ2E8u0NqOh+krVnnpTw0jXUTil/i93LsXWb6IhAsc7kHIlofDD5q//M9USU7QGggpNxD+ZwtLqA3Hrxq+OhwtQ1mp/uzbhtk3powW1umFlkOmsmiU/O/INTRe9bcQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RTiG0Mb5; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250212011303epoutp015263b87be79e7cba5dc8d6e40ff8a339~jUNtDoeu60340103401epoutp01Y
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250212011303epoutp015263b87be79e7cba5dc8d6e40ff8a339~jUNtDoeu60340103401epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739322783;
	bh=3HLbLMPJmzSucOlsqmhUhAS8S4GVvP2o0xrz+vP8sis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTiG0Mb5p2MtZr1TdjddPxTC2KxaBgkE1rOnXtf8UcANI8/Q2AEfRi6/oxPoyN7bd
	 6aevd8iAeObxqRdCWzV2mBZxcQyQlMpSypfl/soy+OrQZry9oKwoIt7hr0yrNZBk46
	 4qBlomJI4C2SzKxtzNJfbjDjkUHgdk7o8OCzlCeE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250212011302epcas5p28020604cdb00c19235513d3ef565a4ea~jUNsRLknA0371103711epcas5p2_;
	Wed, 12 Feb 2025 01:13:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yt0g26By2z4x9Q5; Wed, 12 Feb
	2025 01:13:02 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250211115711epcas5p46b72b2670571d636c229d80378284ed9~jJW0YLaLe0222102221epcas5p4T;
	Tue, 11 Feb 2025 11:57:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250211115711epsmtrp258739bba45f10fb2728bb34917757df9~jJW0XQ6h60217602176epsmtrp2j;
	Tue, 11 Feb 2025 11:57:11 +0000 (GMT)
X-AuditID: b6c32a52-1f7ff700000083ab-40-67ab3b17898d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.85.33707.71B3BA76; Tue, 11 Feb 2025 20:57:11 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250211115708epsmtip1711c2c42544aa172628f5a287620cdbc~jJWxnQNma1948519485epsmtip1U;
	Tue, 11 Feb 2025 11:57:08 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: Fix unassigned variable 'tmp_minor_revision'
 in xhci_add_in_port()
Date: Tue, 11 Feb 2025 17:26:29 +0530
Message-ID: <1296674576.21739322782868.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250211115635.757-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTlfcenW6wdnNchZvrq5itXgwbxub
	xctDmhZ3Fkxjsji1fCGTRfPi9WwWf29fZLW4+/AHi8XlXXPYLBYta2W2aN40hdXi/IsuVotP
	R/+zWjy7t4LN4sjyj0wWCzY+YrRY0QxUsmrBAXaLRz/nMjkIeyze85LJY//cNewefVtWMXps
	2f+Z0ePzJjmPX7dusQSwRXHZpKTmZJalFunbJXBl3P9zlK3gAnvF/mtHWBsYj7N1MXJySAiY
	SPzc9p6li5GLQ0hgO6PE5SM72SES0hKvZ3UxQtjCEiv/PWeHKPrKKLF88nfWLkYODjYBQ4ln
	J2xA4iICGxglrp6ZzQriMAvcYpI4+PcDM0i3sECSxKyfK8AmsQioSizf8IsJxOYVsJKY/uY8
	E8QGTYm1e/eA2ZwC1hIvT74HqxcCqpl8cis7RL2gxMmZT1hAbGYBeYnmrbOZJzAKzEKSmoUk
	tYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcERpBe1gXLb+r94hRiYOxkOMEhzMSiK8
	JgtXpAvxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwucvk
	9WWlfsjX/zJh5jMux+vr+cvabSbm7i65degzG1/UvGPGezbpTniWUqdTezdMqETpyKUtmU9j
	wu/tWdZrdtiOU0OilLmzerpV/5P8y4nSd34I751y13IGL7ORdcJPVuZoT91k3xNTg2/q5PQf
	zk9d2Cp0ebLzlV+PJ0bt+uUUt99v0S2J9hfzS0OrfPcUMoo5+e7K3cId6brpXeGPexxSLyuD
	PO0W1Z7/5BvKX68bcKXmcE5plZF47T/DVds/6/64Z+pV+ivqDlf+Frc5Ps0rz1n+403ffevT
	vVUvs+PvxQMT6oa5awN0Ck/qmilorjjc5710kvFBbu+12ecjI2PK+ZpsvAr1Zy9Y9leJpTgj
	0VCLuag4EQBhLhm7FwMAAA==
X-CMS-MailID: 20250211115711epcas5p46b72b2670571d636c229d80378284ed9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250211115711epcas5p46b72b2670571d636c229d80378284ed9
References: <20250211115635.757-1-selvarasu.g@samsung.com>
	<CGME20250211115711epcas5p46b72b2670571d636c229d80378284ed9@epcas5p4.samsung.com>

Fix the following smatch error:
drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'

Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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



