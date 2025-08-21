Return-Path: <stable+bounces-172131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D659B2FD21
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19D51896070
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14E2D8DDB;
	Thu, 21 Aug 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CzkRkmsW"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1B219E8
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786419; cv=none; b=fxWwDmzYVdXoLHURSsprrqT0OfWxfL8aUJthnN5jnM/uMQfxGp16YQ0Jr25m5x5YDt9zknzPvrJ0CWaNJdSUR8iPwcFhoCzvm4fBj7wK8xZGrVQIJswcWIWX2+3LRFSTFqgy7hKHJUUkaBlqbHhfzw8UHxmsfHcUJG1OtASBzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786419; c=relaxed/simple;
	bh=I0YGUdkmmt6qwtAsyx6kbKe3778eYGyXjk0G7LNXHFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YlaqCnCFnEGgOT4P8Q/VHNBntJ51y7FF1LEM5CcFnu4kmHWNnwJ0QHFrkWy8V16vFRFCHvQjUSZwFImHn9Dps5Un9RZ1Q1FkGprvz5xjynYuem+HwCQ/17QZrmbt7yccukYW7LzdVtjkLshLqRob5kPAOciU1kJbWzuiC9QVeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CzkRkmsW; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250821142653epoutp011bc4cd56b0be4ba97bb9bcd81662d47e~dznDPqK831102411024epoutp01y
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:26:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250821142653epoutp011bc4cd56b0be4ba97bb9bcd81662d47e~dznDPqK831102411024epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755786413;
	bh=0tZJRqdRee94S/c4GB7S93x3TuokNwU2gnP1lBhNk8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzkRkmsWmiLUxalqmZ+mGxQ76xiKUkGW7W+K00SuZck7Y1xsHXMXYwj+iWJ8c5/Wz
	 i53xx/BdqPJu2inKgU6qVx5RIYqoo5OmNwhrwaBi/dfG9IKTmtAT+ceKT9LOmLCGxq
	 eqEDibEoe1gmiamGR+2fO1Zlg8lepFNDoWCfYWl0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250821142653epcas5p19102b213e7f93abf533924c66846f630~dznC2CQPI0045300453epcas5p1j;
	Thu, 21 Aug 2025 14:26:53 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c75HJ3mkxz6B9m4; Thu, 21 Aug
	2025 14:26:52 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250821142651epcas5p31ef97e0abe6d865fd9e756b6245c058f~dznAyFXbI3028930289epcas5p3S;
	Thu, 21 Aug 2025 14:26:51 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250821142649epsmtip2dd218a35c0442b138f5f4a4afa60eab8~dzm_6d3Wp2391023910epsmtip2t;
	Thu, 21 Aug 2025 14:26:48 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: stable@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com,
	Meng Li <Meng.Li@windriver.com>, Xu Yang <xu.yang_2@nxp.com>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH 5.10.y 2/2] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Date: Thu, 21 Aug 2025 19:56:07 +0530
Message-ID: <20250821142609.264-2-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250821142609.264-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250821142651epcas5p31ef97e0abe6d865fd9e756b6245c058f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250821142651epcas5p31ef97e0abe6d865fd9e756b6245c058f
References: <20250821142609.264-1-selvarasu.g@samsung.com>
	<CGME20250821142651epcas5p31ef97e0abe6d865fd9e756b6245c058f@epcas5p3.samsung.com>

From: Meng Li <Meng.Li@windriver.com>

[ Upstream commit 7838de15bb700c2898a7d741db9b1f3cbc86c136 ]

When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger system
to enter suspend status with below command:
echo mem > /sys/power/state
There will be a deadlock issue occurring. Detailed invoking path as
below:
dwc3_suspend_common()
    spin_lock_irqsave(&dwc->lock, flags);              <-- 1st
    dwc3_gadget_suspend(dwc);
        dwc3_gadget_soft_disconnect(dwc);
            spin_lock_irqsave(&dwc->lock, flags);      <-- 2nd
This issue is exposed by commit c7ebd8149ee5 ("usb: dwc3: gadget: Fix
NULL pointer dereference in dwc3_gadget_suspend") that removes the code
of checking whether dwc->gadget_driver is NULL or not. It causes the
following code is executed and deadlock occurs when trying to get the
spinlock. In fact, the root cause is the commit 5265397f9442("usb: dwc3:
Remove DWC3 locking during gadget suspend/resume") that forgot to remove
the lock of otg mode. So, remove the redundant lock of otg mode during
gadget suspend/resume.

Fixes: 5265397f9442 ("usb: dwc3: Remove DWC3 locking during gadget suspend/resume")
Cc: Xu Yang <xu.yang_2@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240618031918.2585799-1-Meng.Li@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9988424aa91f..118ab7790366 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1735,7 +1735,6 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	u32 reg;
 
 	switch (dwc->current_dr_role) {
@@ -1773,9 +1772,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -1792,7 +1789,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	int		ret;
 	u32		reg;
 
@@ -1841,9 +1837,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
 			dwc3_otg_host_init(dwc);
 		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_resume(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 
 		break;
-- 
2.17.1


