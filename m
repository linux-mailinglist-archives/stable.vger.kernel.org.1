Return-Path: <stable+bounces-220673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGf1GNpCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:32:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC41C71A6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8331317B4EC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68A3F5285;
	Sat, 28 Feb 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7hEfR0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9793F527D;
	Sat, 28 Feb 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300555; cv=none; b=rGVtNbz5GhSrDZ61i7F/XLaGPXU3fkQmHrDCdrxmijXpPHrFeIYPXrVimmdoQqoufIcuoeJ9dHLGAIF4oOv3+t/3C7P1qUzKjfCs5QroDcZe8Kpm/kd+u8dpL/BrWkPRngWwMrRXK2zuKzRa5odPlug7rFJ0jhqyR1PrSoyM3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300555; c=relaxed/simple;
	bh=j7XjfcggW9wTKQ9kVivPmHRe+sslZnI9iWCZg1j7h3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9CU/j5x8B1mKi1IdpBo3gk405mgxHdfWxIv9WM1xO/7QngbzT+UdEMJnbmpmUCUGszhIkHnCR8A03i6h4glFHNWAzMlXTVIT6qGtmh1xiUgbGRMM3mAoIR0I62k+PDgf1LE+WYvBLwzY0bwgJOzgmTwHLx6bnJ16HfS0l0UPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7hEfR0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A70C19423;
	Sat, 28 Feb 2026 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300555;
	bh=j7XjfcggW9wTKQ9kVivPmHRe+sslZnI9iWCZg1j7h3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7hEfR0EIocDsKhACI0IQjt9f1iimId25Y9XO7ew37mKVkvbHmXF+A09ti7m+xVwp
	 3Ye35Y7G8l9b7X5/83QT5/pKhL1mYsit7yPQcyrNa0xZLwm0D4rSMi0TEkCsaR7qON
	 ijjJhhypx6WBcA0KuYj3Zf8n7g6bU4a4x8h4SNCM3bMjBpBZZcJUi/DhaZceDw8lIy
	 0ay1uDoj9RyVUHNFaBDfUWto4rTiqOk2I0+USVOxfgtz8NlcEeAR0B7la4PjcRiymL
	 CGE5jVUYkeRzl+9/8VRFixfGPY1YM8fUoab9pFZBUw9syuVYPEIqKzQp4mH+uaFiQa
	 IFSdyb7IMBQwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 594/844] media: staging/ipu7: Ignore interrupts when device is suspended
Date: Sat, 28 Feb 2026 12:28:27 -0500
Message-ID: <20260228173244.1509663-595-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220673-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDEC41C71A6
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 9ad65684b9285c5d66fb417d50e91a25ef8c994d ]

IPU7 devices have shared interrupts with others. In some case when IPU7
device is suspended, driver get unexpected interrupt and invalid irq
status 0xffffffff from ISR_STATUS and PB LOCAL_STATUS registers as
interrupt is triggered from other device on shared irq line.

In order to avoid this issue use pm_runtime_get_if_active() to check if
IPU7 device is resumed, ignore the invalid irq status and use
synchronize_irq() in suspend.

Cc: Stable@vger.kernel.org
Fixes: b7fe4c0019b1 ("media: staging/ipu7: add Intel IPU7 PCI device driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu7/ipu7-buttress.c | 17 ++++++++++++++++-
 drivers/staging/media/ipu7/ipu7.c          |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu7/ipu7-buttress.c b/drivers/staging/media/ipu7/ipu7-buttress.c
index e5707f5e300ba..40c6c8473357c 100644
--- a/drivers/staging/media/ipu7/ipu7-buttress.c
+++ b/drivers/staging/media/ipu7/ipu7-buttress.c
@@ -342,14 +342,23 @@ irqreturn_t ipu_buttress_isr(int irq, void *isp_ptr)
 	u32 disable_irqs = 0;
 	u32 irq_status;
 	unsigned int i;
+	int active;
 
-	pm_runtime_get_noresume(dev);
+	active = pm_runtime_get_if_active(dev);
+	if (active <= 0)
+		return IRQ_NONE;
 
 	pb_irq = readl(isp->pb_base + INTERRUPT_STATUS);
 	writel(pb_irq, isp->pb_base + INTERRUPT_STATUS);
 
 	/* check btrs ATS, CFI and IMR errors, BIT(0) is unused for IPU */
 	pb_local_irq = readl(isp->pb_base + BTRS_LOCAL_INTERRUPT_MASK);
+	if (pb_local_irq == 0xffffffff) {
+		dev_warn_once(dev, "invalid PB irq status\n");
+		pm_runtime_put_noidle(dev);
+		return IRQ_NONE;
+	}
+
 	if (pb_local_irq & ~BIT(0)) {
 		dev_warn(dev, "PB interrupt status 0x%x local 0x%x\n", pb_irq,
 			 pb_local_irq);
@@ -370,6 +379,12 @@ irqreturn_t ipu_buttress_isr(int irq, void *isp_ptr)
 		return IRQ_NONE;
 	}
 
+	if (irq_status == 0xffffffff) {
+		dev_warn_once(dev, "invalid irq status 0x%08x\n", irq_status);
+		pm_runtime_put_noidle(dev);
+		return IRQ_NONE;
+	}
+
 	do {
 		writel(irq_status, isp->base + BUTTRESS_REG_IRQ_CLEAR);
 
diff --git a/drivers/staging/media/ipu7/ipu7.c b/drivers/staging/media/ipu7/ipu7.c
index 5cddc09c72bf2..6c8c3eea44acb 100644
--- a/drivers/staging/media/ipu7/ipu7.c
+++ b/drivers/staging/media/ipu7/ipu7.c
@@ -2684,6 +2684,10 @@ static void ipu7_pci_reset_done(struct pci_dev *pdev)
  */
 static int ipu7_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	synchronize_irq(pdev->irq);
+
 	return 0;
 }
 
-- 
2.51.0


