Return-Path: <stable+bounces-115099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112AA3370B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 05:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EE4188A6EC
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC12066D4;
	Thu, 13 Feb 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ryBbWOHb"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044411F8681
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422388; cv=none; b=B5ZuinwEfOf8tGCnWsFiO39eVLiwA1zYp5jVGqiqyhk3ZmtzA/oXPL2WngW33Y4LEoevHXgIe5SxMbFMBXrdQvpXdKPs1gLXwmfM2JaMlFEt/5YJ3DIbTl9xUbBA0G+FbZ3LcxtGY5WoxBzrhZuoMVcIuypiBZGkkZ/C+OcU9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422388; c=relaxed/simple;
	bh=dficntmdLBv88Uvc4N5XgHBbu1lCoeFFI/9KziADYdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dsMCW1KtpIS/kJxsaxc3m1nsxp/GNzVH1DN9xJfDEOPpBwtnoz8OPzM7CoTsX99ziMqBKfYioXrfdD9i0VehsECvzUSO5dWgswUS5I7kAZRm83xCT+7X2Y4DjA/vL/Y5D45LEEsByWtD48fty+44pP6E8o897PWXCpTCR6zZGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ryBbWOHb; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250213045304epoutp046301a11d36f9610019cfa54261710f7d~jq3FGGV8y1837818378epoutp041
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 04:53:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250213045304epoutp046301a11d36f9610019cfa54261710f7d~jq3FGGV8y1837818378epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739422384;
	bh=3HLbLMPJmzSucOlsqmhUhAS8S4GVvP2o0xrz+vP8sis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryBbWOHbrvcBhp8YrAHqsLoPSkKQT+D8KCbSNBUDcRWLT/zjyaiwqKxIxqX9NpfLR
	 vuWBl2LOwv/iKxSO7wx+15Dr56qTUTI6NODUIsvFX3C6+VzikonTMty5zzLRXJiuUC
	 moo9hUaAodMgPo6DwuuqQx9CCUny19kb/JGelUlE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213045303epcas5p1552f1b30bdd4d34992df8b75296555fb~jq3EI6ECs2466024660epcas5p12;
	Thu, 13 Feb 2025 04:53:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtjVR08WMz4x9QF; Thu, 13 Feb
	2025 04:53:03 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250213042229epcas5p1a3080b21423a43f2e71ab7f631604b1d~jqcY4hMzT1614116141epcas5p1j;
	Thu, 13 Feb 2025 04:22:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213042229epsmtrp19e2f1b217faee08df2e182fbb84372a3~jqcY3fIXs0967509675epsmtrp1J;
	Thu, 13 Feb 2025 04:22:29 +0000 (GMT)
X-AuditID: b6c32a29-63df970000004929-13-67ad7385f598
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	39.A5.18729.5837DA76; Thu, 13 Feb 2025 13:22:29 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213042227epsmtip19447e7ac3e84c7c4f39138bbe3015dc5~jqcWPA9Oe3205632056epsmtip1h;
	Thu, 13 Feb 2025 04:22:26 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: xhci: Fix unassigned variable
 'tmp_minor_revision' in xhci_add_in_port()
Date: Thu, 13 Feb 2025 09:51:25 +0530
Message-ID: <1931444790.41739422383013.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250213042130.858-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTre1eG26wbs/ehZvrq5itXgwbxub
	xctDmhZ3Fkxjsji1fCGTRfPi9WwWf29fZLW4+/AHi8XlXXPYLBYta2W2aN40hdXi/IsuVotP
	R/+zWjy7t4LN4sjyj0wWCzY+YrRY0QxUsmrBAXaLRz/nMjkIeyze85LJY//cNewefVtWMXps
	2f+Z0ePzJjmPX7dusQSwRXHZpKTmZJalFunbJXBl3P9zlK3gAnvF/mtHWBsYj7N1MXJwSAiY
	SOy7Xt/FyMUhJLCbUeLA3r1AcU6guLTE61ldjBC2sMTKf8/ZIYq+MkrcuboDrJlNwFDi2Qkb
	kLiIwAZGiatnZrOCOMwCt5gkDv79wAzSLSyQKnFtzQMwm0VAVWLd04vsIDavgJXE622/WSE2
	aEqs3buHCcTmFLCWuNh5AaxGCKimf+tqRoh6QYmTM5+wgNjMAvISzVtnM09gFJiFJDULSWoB
	I9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzguNLS3MG4fdUHvUOMTByMhxglOJiV
	RHglpq1JF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cBk
	Vzb/6Onrs9J7v3v0ykuo3Vx+IPB2/de8dcI3f2/nWHmL9/WD60J1jIwftnAaPfv4cRrPrz/2
	sz/61q5JnGB/a9ZhfcaCjpUs9ibb/y7zOKT/g1HeVMzJm6Oo3n31qo6fNewBE5KZEvWFZuyc
	ztElznmk7X2AEZubcnnPsS1CVtyS96e4LSl0qU+ZZZkQP3ETs84jz8TConN93M90jew2/O5U
	eVX0QcE8+mxAw07Na039PwXDitzqdilx8kSy31RS2pxzr5yPqd6j/Omkzd3b1k4y+XrO3sD9
	ac6s9kPrqxa7Lf6VdWRJeNV3F82FV4+2zFb/nbUt+d+xp5sUr0ybfvX35P8fd9TGVe0KOtGo
	xFKckWioxVxUnAgAY8kW/BoDAAA=
X-CMS-MailID: 20250213042229epcas5p1a3080b21423a43f2e71ab7f631604b1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250213042229epcas5p1a3080b21423a43f2e71ab7f631604b1d
References: <20250213042130.858-1-selvarasu.g@samsung.com>
	<CGME20250213042229epcas5p1a3080b21423a43f2e71ab7f631604b1d@epcas5p1.samsung.com>

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



