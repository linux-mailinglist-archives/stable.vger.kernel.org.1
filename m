Return-Path: <stable+bounces-126706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CEDA716D2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C5188C0D6
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A81DE2A8;
	Wed, 26 Mar 2025 12:39:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD31A072C;
	Wed, 26 Mar 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992749; cv=none; b=EczcjwJytzJBb0UutwyOi+6uEF616UMtoINMfBD3VdJH0IQeLZBxOFHXokXz5A5sfFcXltqCqx1ltWXEd2LfchXQrcfFmv1YeCej8B43VvOxOBVzem7Cet6ArRRHHDu21mWBNKk+h2Ja2zoK+DZFH0f2w47y/pUQ7E4aQwbcou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992749; c=relaxed/simple;
	bh=6e+77XVzjGIr2FQqdqP61PJFEmYdLdA3NSK+T5RU3yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g09/OlX3YdnOzisXKPenDsT+rXE66gSgFwutUQzCgEgV7TkW7FLwzM69uH/ow9/0HDLd37P2ib8rCyeS/9KlH6bW6XD2Avsyz1/Gw6LiLeu2wN9Y0GzIjkUnxyz8UIKwdHlFXJM8/ZFRun0X9mB0yRuaZD7txGzfUKEJVtfTVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 613AF2022B6;
	Wed, 26 Mar 2025 13:30:56 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 21774202163;
	Wed, 26 Mar 2025 13:30:56 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C472B1800092;
	Wed, 26 Mar 2025 20:30:54 +0800 (+08)
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: alexandre.belloni@bootlin.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bbrezillon@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com
Cc: rvmanjumce@gmail.com,
	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v6] i3c: Add NULL pointer check in i3c_master_queue_ibi()
Date: Wed, 26 Mar 2025 18:00:46 +0530
Message-ID: <20250326123047.2797946-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

The I3C master driver may receive an IBI from a target device that has not
been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
to queue an IBI work task, leading to "Unable to handle kernel read from
unreadable memory" and resulting in a kernel panic.

Typical IBI handling flow:
1. The I3C master scans target devices and probes their respective drivers.
2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
   and assigns `dev->ibi = ibi`.
3. The I3C master receives an IBI from the target device and calls
   `i3c_master_queue_ibi()` to queue the target device driver’s IBI
   handler task.

However, since target device events are asynchronous to the I3C probe
sequence, step 3 may occur before step 2, causing `dev->ibi` to be `NULL`,
leading to a kernel panic.

Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent accessing
an uninitialized `dev->ibi`, ensuring stability.

Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
Changes since v5:
  - Updated subject and commit message  with some more information.

 drivers/i3c/master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d5dc4180afbc..c65006aa0684 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2561,6 +2561,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	if (!dev->ibi || !slot)
+		return;
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
-- 
2.46.1


