Return-Path: <stable+bounces-202108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D2CC3303
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 949B23052508
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EA135F8C4;
	Tue, 16 Dec 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MD6T8har"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214535F8BE;
	Tue, 16 Dec 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886840; cv=none; b=ptmvKP55+cRxLHXiR9hP7IozGMiZG4+QWcLFSx9i9sknif+24FJEmJgYC22LKk4Cuqb6Prh+UhzFocgUP7yEotyHuX4RsFyN+iXFvS3CwTf8fErb6R5HBoxVCnaTd40rhBWiZJD2FJeB/rN337Nt/mIatP9v9bQQBSvhTbOYKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886840; c=relaxed/simple;
	bh=WfoG+jTrp2S5zCP5HnpPp1aU16nG/c2X4YEJIGJDlMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCVBkUqLLsObcXo8wuvzhbD+FCFE8U8hwUa8FlQCj39jHblI054usp1siQdR16o+SjafV82oLJspRRZWUZYVRQipI0xJJNXzVyY8WC46snu/c1QDjqyYrhKB4CGiXhRtdkDrx1qGtEpnSGsQiSw/4AMX683bP9RWGVEjZ4g5M/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MD6T8har; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754EBC4CEF1;
	Tue, 16 Dec 2025 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886839;
	bh=WfoG+jTrp2S5zCP5HnpPp1aU16nG/c2X4YEJIGJDlMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MD6T8harBoMB+HEZtYNsxi06O+RNsQIqqnDBp4xLmFVpv8EtltedIlpndQLxandYD
	 yaBNjwSKhALgqSMRNX9QWLUPtGBm7eQQcfCp4maCBfvR1VtcTSRi1KLyDUoOBOkvav
	 ZH9ED5Re3SxWkLWVVnfLmy/lO1+qvXQbhKx7lD24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/614] irqchip/irq-bcm7120-l2: Fix section mismatch
Date: Tue, 16 Dec 2025 12:06:55 +0100
Message-ID: <20251216111403.050153220@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit bfc0c5beab1fde843677923cf008f41d583c980a ]

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: 3ac268d5ed22 ("irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-bcm7120-l2.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ff22c31044018..b6c85560c42ea 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -143,8 +143,7 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_7120(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	int ret;
 
@@ -177,8 +176,7 @@ static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_3380(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	unsigned int gc_idx;
 
@@ -208,10 +206,9 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_probe(struct device_node *dn,
-				 struct device_node *parent,
+static int bcm7120_l2_intc_probe(struct device_node *dn, struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
-					struct bcm7120_l2_intc_data *),
+						      struct bcm7120_l2_intc_data *),
 				 const char *intc_name)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
@@ -339,15 +336,13 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	return ret;
 }
 
-static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
-- 
2.51.0




