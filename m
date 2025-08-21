Return-Path: <stable+bounces-172130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A2B2FCD8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB82F6804EB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D0266595;
	Thu, 21 Aug 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YLMZ3cyF"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7E1DE3BA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786417; cv=none; b=Mxk2fid8A0I44XQ//R3wVA3kpTYjf759pJ3GLmQnJeenXwaveHg4qBOvsWvVpS1kMfZeHopMSlzQq223D+VT3j7rsUWzZg+mgCYxhAKhf0RCaBCHlmG0/WxDw+w0MPTY+Qq+iWvaxMNqTFhfoZCIDZsq84dlINKhvRQvw5Aifl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786417; c=relaxed/simple;
	bh=N1dbmuDrpZLysL/mFBvcj9JvEKnZ0h8DV9PitVq7d/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=iRcaHbs9MctlXLk+/rgXhriLpIAeyCic0vzsIuG4nrQwevVhm5PIiak7ZTAeySbc55UhXh9OPkxcCjX7brMeseVgcWL0nDCOUF3JL3i4Vf7bE4znKwWDAJ+pc5ksAuY+XWWMeu1XGfKfVAF2JIsGMfihGi7XVVukoMQB/+GS0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YLMZ3cyF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250821142645epoutp013fb0d9531e915ba107f07ad53a2d35aa~dzm7bEB_p1102411024epoutp01t
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:26:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250821142645epoutp013fb0d9531e915ba107f07ad53a2d35aa~dzm7bEB_p1102411024epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755786405;
	bh=GSGqNf8gmDF/br6ITaqLLUg31wA2io50xipwOOlQ1MI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YLMZ3cyFXqdScxXtM5HKBkWo+FsQpsL+Wdu2VWMZHD99y11hoFksS4TBxHeG59nJE
	 BOmbTnn9Zx9nsGUjPX9B67w4qwyNF3sSNwxTtoJ8NHCfLTvTtCuO/Het35z8+Ry/iu
	 /pZPHj+YJxEafpTK8UdSrmhWlksIvDF+nO+vkXe8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250821142644epcas5p2bd8096f2a806ec3906406da28b59e726~dzm6c5EAP2797427974epcas5p2w;
	Thu, 21 Aug 2025 14:26:44 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c75H73p9xz2SSKX; Thu, 21 Aug
	2025 14:26:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250821142642epcas5p286aae2b66fc8b5fb82678332302af2d5~dzm5QSL2q2797427974epcas5p2t;
	Thu, 21 Aug 2025 14:26:42 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250821142641epsmtip2bd048f9231cfe4588188410e6c845b68~dzm3nF34K2441224412epsmtip2J;
	Thu, 21 Aug 2025 14:26:41 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: stable@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com,
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 5.10.y 1/2] usb: dwc3: Remove DWC3 locking during gadget
 suspend/resume
Date: Thu, 21 Aug 2025 19:56:06 +0530
Message-ID: <20250821142609.264-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250821142642epcas5p286aae2b66fc8b5fb82678332302af2d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250821142642epcas5p286aae2b66fc8b5fb82678332302af2d5
References: <CGME20250821142642epcas5p286aae2b66fc8b5fb82678332302af2d5@epcas5p2.samsung.com>

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 5265397f94424eaea596026fd34dc7acf474dcec ]

Remove the need for making dwc3_gadget_suspend() and dwc3_gadget_resume()
to be called in a spinlock, as dwc3_gadget_run_stop() could potentially
take some time to complete.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20220901193625.8727-3-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.c   | 4 ----
 drivers/usb/dwc3/gadget.c | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1264683d45f2..9988424aa91f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1742,9 +1742,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -1805,9 +1803,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			return ret;
 
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg)) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e1e18a4f0d07..d0016faa4599 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4065,12 +4065,17 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	unsigned long flags;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
 	dwc3_gadget_run_stop(dwc, false, false);
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
-- 
2.17.1


