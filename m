Return-Path: <stable+bounces-221003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDUVKjZNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:16:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69C1C8224
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43AFE3204B51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E104BC023;
	Sat, 28 Feb 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdkhVrda"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791204BC01F;
	Sat, 28 Feb 2026 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301347; cv=none; b=BamKWRssMSzXv6Jnos70TcCauiNu95KcCzxGi4dK5YLb10yAZ8AxigS7ciHLB+wGioI5lgHokX2otnwszb6zjSpgbsa60OQcFNgXGNq4lCdzc67GJun4WfOcNzRNNodL5Zgo6M9AOHfLusroh65AQQG1ATWGlfp6XrOT1/Z/aWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301347; c=relaxed/simple;
	bh=j7XjfcggW9wTKQ9kVivPmHRe+sslZnI9iWCZg1j7h3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg+sqs+BNGuEa6U3voeB3/BN/F48ZuqKSpyRS0T2Lxm2VkJq+srQwWx8CtOoLXVhR25gbvLvYaJgBEqt12JAZBuqt084s591AmRnG7dXN42jGxAXwfo1sqmKjdKgYnh7vyHl1Ujg1AE6BT3OKKM191rsnic7URiHZkRZ7dFcSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdkhVrda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0698C19423;
	Sat, 28 Feb 2026 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301347;
	bh=j7XjfcggW9wTKQ9kVivPmHRe+sslZnI9iWCZg1j7h3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdkhVrdaAw8FFuPj2Y9cOvlkiJRtvLELN1VoTlqQ5bh0jcZjiHmlMZojDstYcOLoi
	 zHqxTxJ0O5GlwVl4YHP1uid5eYs5m9IV1FHRqQxsrFt7AW7kaDlRcX2Wa5ZcnWNblx
	 rZtxBUFaYUrfG7ecWImqpMTRy36wC8E6odlrjiLJ0ZmBbqSUnGxhHv0RNHA2BjJJrS
	 UzNI1EGdcHqbGuDvC92aDdiu7FrTN+zOE6QZpSr2BxMyWOUccdjTk5aPr5O7fUs9Zn
	 GqzURTb//dQ9rK/P8XjO+QVTXgtQFTuPNovEvb4o9fB+omf69z80vjtC+3UCkB0CbL
	 PvOcy+AoTOU6w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 534/752] media: staging/ipu7: Ignore interrupts when device is suspended
Date: Sat, 28 Feb 2026 12:44:05 -0500
Message-ID: <20260228174750.1542406-534-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221003-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D69C1C8224
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


