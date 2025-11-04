Return-Path: <stable+bounces-192333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1BC2F56C
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBE41892CB7
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 05:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C372BE7B5;
	Tue,  4 Nov 2025 05:09:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAF2550DD;
	Tue,  4 Nov 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232956; cv=none; b=lnrayXAT3es5Jd/q+MMUk08fhKY+CC9xHj3pXICk4j4yqoxx9TEeInKkiiwphuJK3juCd7xMSXP2FA4Bpwnlbc67A9wnT52GhNZXbq3ZNpzw4rlZSTr/IJZMufiSSxq9a2e3l+Yh//UOlk+lJ4vjcMurX/dAEUhlzNIXwoVUtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232956; c=relaxed/simple;
	bh=aiXr5mQdW1SRlBtbOlfIFB3idye0bDaqhEcQ0E6Euxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TB8wa/2VyEgS2r2M85dzoLfFoQuMK7IszPZJRCmWGBbFU6v9JO7+QSfdLEDh0iWAv8Jl4Yy1kteI/+xHp08AKJFK6k9K0ETnZSCniIreo0XcBEgchC7o5mZAkGoCWu6i/AVqKqlTOgFnFZi2VMTK63R61RtL+6cQ8XtMP04hlzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: ekRX7IviTxGKE11LvZct/w==
X-CSE-MsgGUID: 4klFz8bcTnOs0ajpBRWaLQ==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="131450290"
From: guhuinan <guhuinan@xiaomi.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Rohloff
	<ingo.rohloff@lauterbach.com>, Christian Brauner <brauner@kernel.org>, "Chen
 Ni" <nichen@iscas.ac.cn>, Peter Zijlstra <peterz@infradead.org>, "Sabyrzhan
 Tasbolatov" <snovitoll@gmail.com>, Akash M <akash.m5@samsung.com>, Chenyu
	<chenyu45@xiaomi.com>, Yudongbin <yudongbin@xiaomi.com>, Mahongwei
	<mahongwei3@xiaomi.com>, Jiangdayu <jiangdayu@xiaomi.com>, Owen Gu
	<guhuinan@xiaomi.com>
Subject: [PATCH 6.6.y] usb: gadget: f_fs: Fix epfile null pointer access after ep enable.
Date: Tue, 4 Nov 2025 13:08:56 +0800
Message-ID: <20251104050856.998-1-guhuinan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To BJ-MBX05.mioffice.cn
 (10.237.8.125)

From: Owen Gu <guhuinan@xiaomi.com>

[ Upstream commit cfd6f1a7b42f ("usb: gadget: f_fs: Fix epfile null
pointer access after ep enable.") ]

A race condition occurs when ffs_func_eps_enable() runs concurrently
with ffs_data_reset(). The ffs_data_clear() called in ffs_data_reset()
sets ffs->epfiles to NULL before resetting ffs->eps_count to 0, leading
to a NULL pointer dereference when accessing epfile->ep in
ffs_func_eps_enable() after successful usb_ep_enable().

The ffs->epfiles pointer is set to NULL in both ffs_data_clear() and
ffs_data_close() functions, and its modification is protected by the
spinlock ffs->eps_lock. And the whole ffs_func_eps_enable() function
is also protected by ffs->eps_lock.

Thus, add NULL pointer handling for ffs->epfiles in the
ffs_func_eps_enable() function to fix issues

Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
Link: https://lore.kernel.org/r/20250915092907.17802-1-guhuinan@xiaomi.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 08a251df20c4..04058261cdd0 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2407,7 +2407,12 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 	ep = func->eps;
 	epfile = ffs->epfiles;
 	count = ffs->eps_count;
-	while(count--) {
+	if (!epfile) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	while (count--) {
 		ep->ep->driver_data = ep;
 
 		ret = config_ep_by_speed(func->gadget, &func->function, ep->ep);
@@ -2431,6 +2436,7 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 	}
 
 	wake_up_interruptible(&ffs->wait);
+done:
 	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
 
 	return ret;
-- 
2.43.0


