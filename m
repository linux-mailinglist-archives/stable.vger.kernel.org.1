Return-Path: <stable+bounces-220437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oArgAZI3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C531C6360
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEFBF325A52E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB53B4D0E;
	Sat, 28 Feb 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns7TJavv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A483B4D06;
	Sat, 28 Feb 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300326; cv=none; b=QgtF15CbnWwlLz8zEEvGiNQeGpY2WGoJMhr2TUosdgJlcqi2WlF+9xlVVj0me5+J370afPM63nWmDjJd7cuXBYGK8VoIjgcahnVrb+bKmYyBmI/XbtWXQ6hJascw0lxeCi5HGFkWuJUB8S1JFwyB71hkhzGORfQQwE0H5TDf8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300326; c=relaxed/simple;
	bh=XEa/VH/PEJZzdsCFQkRXMz14ayIsfwmMUepq86+UQWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIErqMKazovt9IIHtSl0M0zcAfnJEOFI9AEcctAXKxDWz8HwE75xztSOwFZ0qbyzikFrOJcvAvraKDFEGG2B2ZXnO7kQWUjm43x8099Jnex1vBWisG0HRcghxnGLnfR7nv5+wdKhFRbB+jVu0MddpWtEopDWfsivEC3X7S2ZGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns7TJavv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA7C19425;
	Sat, 28 Feb 2026 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300326;
	bh=XEa/VH/PEJZzdsCFQkRXMz14ayIsfwmMUepq86+UQWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns7TJavvSRfdAhclFXjM8KJ21i+BB2K4JLLlOlylp6JCfI6wtUJrhnx8NzQ1bL/EY
	 FLDbeRK007apfyJqfuMJF+szVqmlIbrk5HiSRQvlDPUllxDEDHkFkEAsDHykpWEQ4M
	 SZeXU8A+L/zVpeZ27t8zlgeZe4rWr3FenvjNJ6OmWrapTy8RxPCks+7AoXVDCQkACb
	 Q+V28AiEARQjxjbiboXHh3OnmtKJcgnHBDMHWd+wEnjX09BiFWL7FR6crtagH9FDEh
	 21geNhl/xrEXR3JF2ql1R3GqtOIL+CRKfL0O3wPfCHXjZIgN2r0GY3VOqeUaSUag23
	 j/qJMSktQOgwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 358/844] mailbox: sprd: clear delivery flag before handling TX done
Date: Sat, 28 Feb 2026 12:24:31 -0500
Message-ID: <20260228173244.1509663-359-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220437-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[abscue.de,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 91C531C6360
X-Rspamd-Action: no action

From: Otto Pflüger <otto.pflueger@abscue.de>

[ Upstream commit c77661d60d4223bf2ff10d409beb0c3b2021183b ]

If there are any pending messages in the mailbox queue, they are sent
as soon as a TX done event arrives from the driver. This may trigger a
new delivery interrupt while the previous one is still being handled.
If the delivery status is cleared after this, the interrupt is lost.
To prevent this from happening, clear the delivery status immediately
after checking it and before any new messages are sent.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/sprd-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index c1a5fe6cc8771..46d0c34177ab9 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -166,6 +166,11 @@ static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
 		return IRQ_NONE;
 	}
 
+	/* Clear FIFO delivery and overflow status first */
+	writel(fifo_sts &
+	       (SPRD_INBOX_FIFO_DELIVER_MASK | SPRD_INBOX_FIFO_OVERLOW_MASK),
+	       priv->inbox_base + SPRD_MBOX_FIFO_RST);
+
 	while (send_sts) {
 		id = __ffs(send_sts);
 		send_sts &= (send_sts - 1);
@@ -181,11 +186,6 @@ static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
 			mbox_chan_txdone(chan, 0);
 	}
 
-	/* Clear FIFO delivery and overflow status */
-	writel(fifo_sts &
-	       (SPRD_INBOX_FIFO_DELIVER_MASK | SPRD_INBOX_FIFO_OVERLOW_MASK),
-	       priv->inbox_base + SPRD_MBOX_FIFO_RST);
-
 	/* Clear irq status */
 	writel(SPRD_MBOX_IRQ_CLR, priv->inbox_base + SPRD_MBOX_IRQ_STS);
 
-- 
2.51.0


