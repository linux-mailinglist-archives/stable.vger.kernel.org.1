Return-Path: <stable+bounces-220187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGTEFC8wo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C44011C58A7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106C43252300
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CAA4C6EED;
	Sat, 28 Feb 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shOwYhfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB44C6EE5;
	Sat, 28 Feb 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300094; cv=none; b=Km98v7fG90sHWtWtjnvwvxlS0aFqQs08JK9DsGYFhXycYs+IaPIr92MbsvLTH+2ZwkhnE8LTMqVTm9ogvC/a7dMi9vo2rYpt4pvIY6XVxk99zCZa04x2msghZpNQ1+D76KkXPi+4oM0pKprgd95aVlCNqtgG4w9nHJ6/+muZsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300094; c=relaxed/simple;
	bh=qmhSjwrAXFUSiHBCb2qH3lHoG/iFuO65+VBFT9ezRaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNJr928OZxBP9V/8M4REfXYkNp9kxhC8Man8VYYXAqDfO5TcOZdNN/m2TESIYbosnDeVqlANsACj4NG9hzw8LlpS9RI6aB49MM1crBHnYfXVynq/YSP6XEcGv7iuBrNyYsIr9O/WccTuGxP7NmeWmsLJd3whmYNFCnBPPn7Z+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shOwYhfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444DEC116D0;
	Sat, 28 Feb 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300093;
	bh=qmhSjwrAXFUSiHBCb2qH3lHoG/iFuO65+VBFT9ezRaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=shOwYhfMsdInbH0TCgKHGRy6D4fZJBurHSspKO2bUNIcYQDQx4myijh2pejKHtDkT
	 JNU99iseN9PUhhjMAN0O4SiTOasBysSAYV/tsuzY4L5zul7+7lvvDk839RNq+XzYuD
	 +NFPPEgSusTTJj/QEsvhHBDFpvoumgh+bvrhxYJ8SdAjxK7Cwjaotf7ohmlpoB0mfa
	 /8zJMbBHeKcPkattk5cLGJIJCLYz/VUcXs/9GaEMaOfHkc0OdqV4aMy8LQ9rYsUAet
	 4ozkt8nN+A40DWPP0mE3z+eAlevx1EA7HdiWCIE3VAIvJiIZlrJNZxMQVUoTGHGuVb
	 vu5RvPLtDVEWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 109/844] mailbox: bcm-ferxrm-mailbox: Use default primary handler
Date: Sat, 28 Feb 2026 12:20:22 -0500
Message-ID: <20260228173244.1509663-110-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220187-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,msgid.link:url]
X-Rspamd-Queue-Id: C44011C58A7
X-Rspamd-Action: no action

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 03843d95a4a4e0ba22ad4fcda65ccf21822b104c ]

request_threaded_irq() is invoked with a primary and a secondary handler
and no flags are passed. The primary handler is the same as
irq_default_primary_handler() so there is no need to have an identical
copy.

The lack of the IRQF_ONESHOT flag can be dangerous because the interrupt
source is not masked while the threaded handler is active. This means,
especially on LEVEL typed interrupt lines, the interrupt can fire again
before the threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary handler
is done.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-5-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 41f79e51d9e5a..4255fefc3a5a0 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1173,14 +1173,6 @@ static int flexrm_debugfs_stats_show(struct seq_file *file, void *offset)
 
 /* ====== FlexRM interrupt handler ===== */
 
-static irqreturn_t flexrm_irq_event(int irq, void *dev_id)
-{
-	/* We only have MSI for completions so just wakeup IRQ thread */
-	/* Ring related errors will be informed via completion descriptors */
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t flexrm_irq_thread(int irq, void *dev_id)
 {
 	flexrm_process_completions(dev_id);
@@ -1271,10 +1263,8 @@ static int flexrm_startup(struct mbox_chan *chan)
 		ret = -ENODEV;
 		goto fail_free_cmpl_memory;
 	}
-	ret = request_threaded_irq(ring->irq,
-				   flexrm_irq_event,
-				   flexrm_irq_thread,
-				   0, dev_name(ring->mbox->dev), ring);
+	ret = request_threaded_irq(ring->irq, NULL, flexrm_irq_thread,
+				   IRQF_ONESHOT, dev_name(ring->mbox->dev), ring);
 	if (ret) {
 		dev_err(ring->mbox->dev,
 			"failed to request ring%d IRQ\n", ring->num);
-- 
2.51.0


