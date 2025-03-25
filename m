Return-Path: <stable+bounces-126005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147FA6EDC0
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C267A1AF4
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2957253F38;
	Tue, 25 Mar 2025 10:32:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEED19EED3;
	Tue, 25 Mar 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898757; cv=none; b=Nqy4kjNibTYvosAV07SgB/J+KQpnlOINrwi12IHGFKT4lWQs72o7esZMHsEgfUu4y9h7zvQSbU0rHKwHy06/drpbtHClDPV3LStm/oxP1Foy7S8E8RljsVdswJTEnfiwyUmjiNW0UJknlwD/dERuoVf0D8JlDjY6h511b581I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898757; c=relaxed/simple;
	bh=ew60cUY/d0eXJkY+4iTePB/PgLDVA0zWrxQ9y6Pct8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/sNA+zemiYgQRxMnJ1UdK3wHYtRwc7ugUZNf1yjhDp2LbTYVRIUpB8Nyia5Kq0qrL3Io4SaJOB1hkoj0UOXq2GjFEtnnQtg2lxdi7XfX67N6GL2pq6Agdcj2PV9XKrZVJt7O7Fv6tBv3VGuO3Z7B8spIu+pJG43YAuoh16QjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C4531A0D0A;
	Tue, 25 Mar 2025 11:23:40 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E5D901A0E5F;
	Tue, 25 Mar 2025 11:23:39 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 907F81800089;
	Tue, 25 Mar 2025 18:23:38 +0800 (+08)
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
Subject: [PATCH v5] i3c: Fix read from unreadable memory at i3c_master_queue_ibi()
Date: Tue, 25 Mar 2025 15:53:32 +0530
Message-ID: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

As part of I3C driver probing sequence for particular device instance,
While adding to queue it is trying to access ibi variable of dev which is
not yet initialized causing "Unable to handle kernel read from unreadable
memory" resulting in kernel panic.

Below is the sequence where this issue happened.
1. During boot up sequence IBI is received at host  from the slave device
   before requesting for IBI, Usually will request IBI by calling
   i3c_device_request_ibi() during probe of slave driver.
2. Since master code trying to access IBI Variable for the particular
   device instance before actually it initialized by slave driver,
   due to this randomly accessing the address and causing kernel panic.
3. i3c_device_request_ibi() function invoked by the slave driver where
   dev->ibi = ibi; assigned as part of function call
   i3c_dev_request_ibi_locked().
4. But when IBI request sent by slave device, master code  trying to access
   this variable before its initialized due to this race condition
   situation kernel panic happened.

Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
Changes since v4:
  - Fix added at generic places master.c which is applicable for all platforms

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


