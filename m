Return-Path: <stable+bounces-220435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDGVMY5Jo2nx/AQAu9opvQ
	(envelope-from <stable+bounces-220435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DC1C7C2B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B557F30E2E93
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8A3B4CE3;
	Sat, 28 Feb 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crXwxs4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567B480DE3;
	Sat, 28 Feb 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300325; cv=none; b=q4a6C5ct2CyMTe/76F1gdx1q9Zj8Sz3j4A+bkHrQwRS096bkus46fAV43UlX+Co4GtliBs0HNzR2Hlhve+++1f5qgRPSO6Tq4d8tLmyn0xZ85GGSYiDzLdYcBylR7ZektV8q//u6rRA/biRd2YER6hNtHTDGmHDZ9K+7ECS6ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300325; c=relaxed/simple;
	bh=NwjbWlJVFuM2LLQdrqo6HtOXS/ngQ5Uh0I5P+jPDxCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X43vw2jVxxHavd38XvmzLeifF4ZEqcc2zNC1GDZswIDOq4dzQ9OnsGvpeRBnfUMAr4iwCJ+0UdoQAW2ijHQcOghcS8RX1SNtxsJJ3yjPqka+NwG4K2W5YH4Dn+z4rzb8ldCTgo3WW4DxsjXYUnfF9hocUw/6saDMqL6oj+v+p7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crXwxs4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250E4C19423;
	Sat, 28 Feb 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300324;
	bh=NwjbWlJVFuM2LLQdrqo6HtOXS/ngQ5Uh0I5P+jPDxCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crXwxs4Ly7S3oKZUXNrOwcICKXb6kKFE9qKATSFIPED5aoB+62ysk2ZviFzF3Edsm
	 7E1LARVVqEBOiSFvunWSREvcuc85tjZ4vVpyXhksibJ7iuBe90ChJp7oLZTZC+c0IV
	 TQPfoUjdwccR4zqlfGrssD8q+5OXWdq5BSsuf2BMQpT1Zbk8M2SsEGY3WMKbEsdQYS
	 lGaoA3n9ImMYNBcJ2j7RNmirmb5tkhcmTZbWkWZHUCQtRhz1H0XA035VE+I/zuGFr4
	 T4JlkI+RJYbapvWmlkEx/b6ncQh34C4zi02tM512A5S8KmNzHX//cz4fPkHkZ422be
	 8TT2tqZnLiRZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 356/844] mailbox: sprd: mask interrupts that are not handled
Date: Sat, 28 Feb 2026 12:24:29 -0500
Message-ID: <20260228173244.1509663-357-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[abscue.de,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-220435-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110DC1C7C2B
X-Rspamd-Action: no action

From: Otto Pflüger <otto.pflueger@abscue.de>

[ Upstream commit 75df94d05fc03fd9d861eaf79ce10fbb7a548bd8 ]

To reduce the amount of spurious interrupts, disable the interrupts that
are not handled in this driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/sprd-mailbox.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index ee8539dfcef54..c1a5fe6cc8771 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -243,21 +243,19 @@ static int sprd_mbox_startup(struct mbox_chan *chan)
 		/* Select outbox FIFO mode and reset the outbox FIFO status */
 		writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
 
-		/* Enable inbox FIFO overflow and delivery interrupt */
-		val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
-		val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
+		/* Enable inbox FIFO delivery interrupt */
+		val = SPRD_INBOX_FIFO_IRQ_MASK;
+		val &= ~SPRD_INBOX_FIFO_DELIVER_IRQ;
 		writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
 
 		/* Enable outbox FIFO not empty interrupt */
-		val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
+		val = SPRD_OUTBOX_FIFO_IRQ_MASK;
 		val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
 		writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
 
 		/* Enable supplementary outbox as the fundamental one */
 		if (priv->supp_base) {
 			writel(0x0, priv->supp_base + SPRD_MBOX_FIFO_RST);
-			val = readl(priv->supp_base + SPRD_MBOX_IRQ_MSK);
-			val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
 			writel(val, priv->supp_base + SPRD_MBOX_IRQ_MSK);
 		}
 	}
-- 
2.51.0


