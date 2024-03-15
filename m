Return-Path: <stable+bounces-28224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D387C73D
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3335B21F5A
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756479D3;
	Fri, 15 Mar 2024 01:30:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A246FD9;
	Fri, 15 Mar 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710466230; cv=none; b=eHbcIGXvr8erN/3kk76KjksnLfmC4RXOfxNapMbpjW9Z8x6DC5oYwC4DJIEJph3rcNLh+w94NTNAr8+GM1tEAdcaHqxmOYAlaQjLv+oOCxUSjgtnIKM/vATqWqEq5cpjOLnCjeMvE8hjSOGpwYK1/jPmJewGkPLQ1RI3qo7jMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710466230; c=relaxed/simple;
	bh=8S/ecPeV2bW+Ze7igOxMY8ZFQ0EIdJsq6oKUib915D8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AkHKJ6nfbHzjjlESI3aWo23qYgKyWDuWbI4i5OUz5mPez5SCvhAe4MaFrl4i3ayS7B4/cAlKfNtFukySZViWG56H1VOd0OjcGL+Z/0Wq2ajHXaBhjTqfNsoGEPAlC5Yl5r1tviN0dcuR3oYZ5qKoB0Ysl+hDnD2dA846Iykkgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4TwmrW2ns4zc03FQ;
	Fri, 15 Mar 2024 09:29:47 +0800 (CST)
Received: from w025.hihonor.com (10.68.28.69) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 15 Mar
 2024 09:30:26 +0800
Received: from localhost.localdomain (10.144.17.252) by w025.hihonor.com
 (10.68.28.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 15 Mar
 2024 09:30:25 +0800
From: yuan linyu <yuanlinyu@hihonor.com>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, yuan linyu <yuanlinyu@hihonor.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] usb: udc: remove warning when queue disabled ep
Date: Fri, 15 Mar 2024 09:30:19 +0800
Message-ID: <20240315013019.2711135-1-yuanlinyu@hihonor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To w025.hihonor.com
 (10.68.28.69)

It is possible trigger below warning message from mass storage function,

WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
CPU: 6 PID: 3839 Comm: file-storage Tainted: G S      WC O       6.1.25-android14-11-g354e2a7e7cd9 #1
pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
pc : usb_ep_queue+0x7c/0x104
lr : fsg_main_thread+0x494/0x1b3c

Root cause is mass storage function try to queue request from main thread,
but other thread may already disable ep when function disable.

As there is no function failure in the driver, in order to avoid effort
to fix warning, change WARN_ON_ONCE() in usb_ep_queue() to pr_debug().

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: yuan linyu <yuanlinyu@hihonor.com>
---
v2: change WARN_ON_ONCE() in usb_ep_queue() to pr_debug()
v1: https://lore.kernel.org/linux-usb/20240314065949.2627778-1-yuanlinyu@hihonor.com/

 drivers/usb/gadget/udc/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 9d4150124fdb..2fbe5977c11d 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -292,7 +292,8 @@ int usb_ep_queue(struct usb_ep *ep,
 {
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+	if (!ep->enabled && ep->address) {
+		pr_debug("queue disabled ep %x\n", ep->address);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
-- 
2.25.1


