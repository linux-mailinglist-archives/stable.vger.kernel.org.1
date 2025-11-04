Return-Path: <stable+bounces-192330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA9C2F362
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 04:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 042404E2AEB
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 03:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A129D26E;
	Tue,  4 Nov 2025 03:52:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB823EAB6;
	Tue,  4 Nov 2025 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228346; cv=none; b=FF4ajbgpPtLl3ArMpkzVBf0i+CdxARfypG9/cGGz5LYZ2iI+OIZsr65+YRmtapxrAvzROPN8KDVRiqxul3n9Y5q4PIILm9ULoVt4jV3QgJIztXpW7dxlIBzET18mtBb3CVkb5hpZHwUexQNHD2DSYhEoV74l5CICZ42jPei/EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228346; c=relaxed/simple;
	bh=aiXr5mQdW1SRlBtbOlfIFB3idye0bDaqhEcQ0E6Euxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BqJ9ggnzpyWvcv3mYFyVaPMdtK43pBKs6nRILu416oreoYa4DLRXtWDDH/7rHVL/+2UaVlLAcrmm4B0S52gebcJykTlw3/QeAgcY7prkbgHsInJuJq90xYLk07Y1sAXm3cMSyPKNFhmu+FP5QAvZdDw6WvZsOMbKcmMKKaBcl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: AjIFP/HpQ+Kya90ttsvp9g==
X-CSE-MsgGUID: PCTeVc7/RiKqRvYkgRMFqA==
X-IronPort-AV: E=Sophos;i="6.19,278,1754928000"; 
   d="scan'208";a="157242641"
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
Subject: [PATCH 6.12.y] usb: gadget: f_fs: Fix epfile null pointer access after ep enable.
Date: Tue, 4 Nov 2025 11:49:46 +0800
Message-ID: <20251104034946.605-1-guhuinan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX06.mioffice.cn (10.237.8.126) To BJ-MBX05.mioffice.cn
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


