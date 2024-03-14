Return-Path: <stable+bounces-28117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BB87B85F
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 08:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C16EB2320E
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11905C613;
	Thu, 14 Mar 2024 07:16:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EE5A119;
	Thu, 14 Mar 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400616; cv=none; b=fE1Nuj6E5Rf0YmvdbOiHeyxwMmZauBAfVpzZdFxc+KlJpuMA4TK358/NwC0DWEkePxYfi1//Gd0XQ8ZrK1UuITIKS12EoCxa+nRjpDq6pfR9KmzBQzjWFSEpPGw+cqKYQN4NIUgNqaPjN2KtM/IlD+9yIqz7HrDkuWe8OXnJTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400616; c=relaxed/simple;
	bh=rWIeLb4RUhYpHhwwe81U3ahk3XwZPUa8yLrRX7/PgVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sso9pWMF8Tm+m5KMNLoa1G08csdmjiYsTRaBu5WYkQbva3ZPPhzPnvtXY0XOQ4oczq8bS8puKmWGTjvtB4mHnZT235Qt9qk505iJ+3yWIBlGwul/ZkB3j+8cbxxLIBbDWkYcMBv2N2XaGfozA04dwG5+hhYW6gYc2TvIn82rw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hihonor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4TwJBW109YzYsCZm;
	Thu, 14 Mar 2024 14:58:43 +0800 (CST)
Received: from w025.hihonor.com (10.68.28.69) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 15:00:14 +0800
Received: from localhost.localdomain (10.144.17.252) by w025.hihonor.com
 (10.68.28.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Thu, 14 Mar
 2024 15:00:13 +0800
From: yuan linyu <yuanlinyu@hihonor.com>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, yuan linyu <yuanlinyu@hihonor.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable ep
Date: Thu, 14 Mar 2024 14:59:49 +0800
Message-ID: <20240314065949.2627778-1-yuanlinyu@hihonor.com>
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

------------[ cut here ]------------
WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
CPU: 6 PID: 3839 Comm: file-storage Tainted: G S      WC O       6.1.25-android14-11-g354e2a7e7cd9 #1
pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
pc : usb_ep_queue+0x7c/0x104
lr : fsg_main_thread+0x494/0x1b3c

Root cause is mass storage function try to queue request from main thread,
but other thread may already disable ep when function disable.

As mass storage function have record of ep enable/disable state, let's
add the state check before queue request to UDC, it maybe avoid warning.

Also use common lock to protect ep state which avoid race between main
thread and function disable.

Cc: <stable@vger.kernel.org> # 6.1
Signed-off-by: yuan linyu <yuanlinyu@hihonor.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index c265a1f62fc1..056083cb68cb 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -520,12 +520,25 @@ static int fsg_setup(struct usb_function *f,
 static int start_transfer(struct fsg_dev *fsg, struct usb_ep *ep,
 			   struct usb_request *req)
 {
+	unsigned long flags;
 	int	rc;
 
-	if (ep == fsg->bulk_in)
+	spin_lock_irqsave(&fsg->common->lock, flags);
+	if (ep == fsg->bulk_in) {
+		if (!fsg->bulk_in_enabled) {
+			spin_unlock_irqrestore(&fsg->common->lock, flags);
+			return -ESHUTDOWN;
+		}
 		dump_msg(fsg, "bulk-in", req->buf, req->length);
+	} else {
+		if (!fsg->bulk_out_enabled) {
+			spin_unlock_irqrestore(&fsg->common->lock, flags);
+			return -ESHUTDOWN;
+		}
+	}
 
 	rc = usb_ep_queue(ep, req, GFP_KERNEL);
+	spin_unlock_irqrestore(&fsg->common->lock, flags);
 	if (rc) {
 
 		/* We can't do much more than wait for a reset */
@@ -2406,8 +2419,10 @@ static int fsg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 static void fsg_disable(struct usb_function *f)
 {
 	struct fsg_dev *fsg = fsg_from_func(f);
+	unsigned long flags;
 
 	/* Disable the endpoints */
+	spin_lock_irqsave(&fsg->common->lock, flags);
 	if (fsg->bulk_in_enabled) {
 		usb_ep_disable(fsg->bulk_in);
 		fsg->bulk_in_enabled = 0;
@@ -2416,6 +2431,7 @@ static void fsg_disable(struct usb_function *f)
 		usb_ep_disable(fsg->bulk_out);
 		fsg->bulk_out_enabled = 0;
 	}
+	spin_unlock_irqrestore(&fsg->common->lock, flags);
 
 	__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
 }
-- 
2.25.1


