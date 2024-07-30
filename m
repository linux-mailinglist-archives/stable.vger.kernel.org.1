Return-Path: <stable+bounces-62635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3E940867
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F11C22836
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366B169AE4;
	Tue, 30 Jul 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U6NbEj7Z"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC3524C;
	Tue, 30 Jul 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321089; cv=none; b=KFTeCx5Cgsmjl1G+WHbC7GglL+qGRrGHueFKBjHH1bVD+cVossgF67gAYBJL4V3nAlddtF8GCGCIqFNLFp3SHjiTD557z4ITOhh2McXu87fYaPqPanRuYtp0MRRyU14iajjiytqhDNqtU9uhvE1U1OqHgbelKpCMGHEw7cI42zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321089; c=relaxed/simple;
	bh=mql6NdwGBe1Qe69m/PuXETcyOj1uy1ngSHMd8WhM/ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGtBKJL7ebkBHdn0tI1r5pVf6J05J7vaekhOZpBIgLncQx5Du4dwddLEBzRN9EW5dAaMneY8odNxaymRHZrEcuDu1PDJHP3alv/B3NWBA5da+XVsuS6AztTRsHR7rIc5RlSDsgPV+kvdF0zvRW51Vqs4+AS88ar58OJqXNbh3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U6NbEj7Z; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 274B21BF205;
	Tue, 30 Jul 2024 06:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722321078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CDtINm72N0vmrhW2aX5v9ObO9VZbS1J4o9kH7/qY2Eo=;
	b=U6NbEj7ZAY4gFtn0Z8a5KpEuI21GSLcS17ZTTbHPpn1lbpKMTFM2ytcG1+y5rxCyktd5fv
	kEqX9mDQ2pkpkPQxndTBhwOLAVr0gBESxa95WBx8mLH1WMWKkKvejW+ghveBKCgrpa8wYD
	H41CvKRQhIpDDOpGA002e2oYllIYDKNLC4fcElsPm1fp00qLYG7zpt0KTA7tM9dsgvRjJE
	lpeXr1vNK4/mquej3R2gK7z0JvehxzawhsKh1O/GkgRtC4jmP8NdNlodLI/DSr5f6HlgtX
	bS9Gh/9ojcNjsINhOTrS9fnr+SSFyCOEgBiJ3nX2x2e3KgW2AiV+4HWe9JINDg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH net v1] net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex
Date: Tue, 30 Jul 2024 08:31:04 +0200
Message-ID: <20240730063104.179553-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The carrier_lock spinlock protects the carrier detection. While it is
hold, framer_get_status() is called witch in turn takes a mutex.
This is not correct and can lead to a deadlock.

A run with PROVE_LOCKING enabled detected the issue:
  [ BUG: Invalid wait context ]
  ...
  c204ddbc (&framer->mutex){+.+.}-{3:3}, at: framer_get_status+0x40/0x78
  other info that might help us debug this:
  context-{4:4}
  2 locks held by ifconfig/146:
  #0: c0926a38 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x12c/0x664
  #1: c2006a40 (&qmc_hdlc->carrier_lock){....}-{2:2}, at: qmc_hdlc_framer_set_carrier+0x30/0x98

Avoid the spinlock usage and convert carrier_lock to a mutex.

Fixes: 54762918ca85 ("net: wan: fsl_qmc_hdlc: Add framer support")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index c5e7ca793c43..64b4bfa6fea7 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -18,6 +18,7 @@
 #include <linux/hdlc.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -37,7 +38,7 @@ struct qmc_hdlc {
 	struct qmc_chan *qmc_chan;
 	struct net_device *netdev;
 	struct framer *framer;
-	spinlock_t carrier_lock; /* Protect carrier detection */
+	struct mutex carrier_lock; /* Protect carrier detection */
 	struct notifier_block nb;
 	bool is_crc32;
 	spinlock_t tx_lock; /* Protect tx descriptors */
@@ -60,7 +61,7 @@ static int qmc_hdlc_framer_set_carrier(struct qmc_hdlc *qmc_hdlc)
 	if (!qmc_hdlc->framer)
 		return 0;
 
-	guard(spinlock_irqsave)(&qmc_hdlc->carrier_lock);
+	guard(mutex)(&qmc_hdlc->carrier_lock);
 
 	ret = framer_get_status(qmc_hdlc->framer, &framer_status);
 	if (ret) {
@@ -706,7 +707,7 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
 
 	qmc_hdlc->dev = dev;
 	spin_lock_init(&qmc_hdlc->tx_lock);
-	spin_lock_init(&qmc_hdlc->carrier_lock);
+	mutex_init(&qmc_hdlc->carrier_lock);
 
 	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(dev, dev->of_node);
 	if (IS_ERR(qmc_hdlc->qmc_chan))
-- 
2.45.0


