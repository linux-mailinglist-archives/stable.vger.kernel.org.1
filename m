Return-Path: <stable+bounces-28226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641B87C758
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 02:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38181F21F95
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9316613D;
	Fri, 15 Mar 2024 01:59:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA024C91;
	Fri, 15 Mar 2024 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467941; cv=none; b=F24sG9bc9C5wSe7ckZOkIqqGlDQL9TsK+tOuQE0WJFg1cCeHohMqksqf61JAXGWiXwdqHH85SRufw11CYMl3kMjSJt21y2FphliU4qJmLoXXRd7gDtFWD/4Z0RhNGXfiljfHcsuw3bV3kUqZlQtLmD08OEq0owB9WRsGqIVzZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467941; c=relaxed/simple;
	bh=E+kVg+u+0gUmQN7fnsiMnl7B7ytJ+CvjexhkgnNwF/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVvdu73XMcG6N9HDbAxsCXS6C+7zmeNd4oCPG91OvGUne5B5ZRiJAp3PFkn/904ohLULAztJpqKGZNf7SxmMgweyuRYYbd6JL4Y+qUYUUJqohdL8kXPFVPi4TXCLCIoxWwhIMxjMCBzzuzoDqLOE5T98aKcrfIDu4AryKYKSGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4TwnSN3Mq2zYvRnD;
	Fri, 15 Mar 2024 09:57:24 +0800 (CST)
Received: from w025.hihonor.com (10.68.28.69) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 15 Mar
 2024 09:58:57 +0800
Received: from localhost.localdomain (10.144.17.252) by w025.hihonor.com
 (10.68.28.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 15 Mar
 2024 09:58:56 +0800
From: yuan linyu <yuanlinyu@hihonor.com>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, yuan linyu <yuanlinyu@hihonor.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] usb: udc: remove warning when queue disabled ep
Date: Fri, 15 Mar 2024 09:58:54 +0800
Message-ID: <20240315015854.2715357-1-yuanlinyu@hihonor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To w025.hihonor.com
 (10.68.28.69)

It is possible trigger below warning message from mass storage function,

WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
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
v3: add more debug info, remove two line commit description
v2: change WARN_ON_ONCE() in usb_ep_queue() to pr_debug()
    https://lore.kernel.org/linux-usb/20240315013019.2711135-1-yuanlinyu@hihonor.com/
v1: https://lore.kernel.org/linux-usb/20240314065949.2627778-1-yuanlinyu@hihonor.com/
 drivers/usb/gadget/udc/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 9d4150124fdb..b3a9d18a8dcd 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -292,7 +292,9 @@ int usb_ep_queue(struct usb_ep *ep,
 {
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+	if (!ep->enabled && ep->address) {
+		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
+				 ep->address, ep->name);
 		ret = -ESHUTDOWN;
 		goto out;
 	}
-- 
2.25.1


