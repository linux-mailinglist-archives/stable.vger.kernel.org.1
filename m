Return-Path: <stable+bounces-225105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJlKJQEhs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D42278FA6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4D6302AD1E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76836C9F9;
	Thu, 12 Mar 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ezqimX98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566B35DA6A;
	Thu, 12 Mar 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346980; cv=none; b=Iz/tJuwd+1UA0FBvJsps9unBMZMrNlHT6WYiQW/4jvsSCU2bAEluaZp0PjPf0u5kshamHe7Mgb0e5xb2RFgRXV18sjj+cyC9JyTX1oyHPdOmSoGXcUE64uyC4GZ3/x44g57sVmD22wIS2EbMtvZxychPpyQILgxQeWp670uBiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346980; c=relaxed/simple;
	bh=AsOLSBoCq1jSqtvKyLBtxl6J6V+mWb7gY0Q6Bav7Ooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh8CHsUuF4iYKQly2O3hV7q/FxcFZZP6Z0dTELmun95Nq/2dWquEbrsZnLKzlF+W1QXElsiklJAvgxCsD0WiuPyjupFFwYsuSbtTpO0EXhlVnSCzkjV/jdW1JOlVinu7pgCfIdH8xyvOAgjkSxsK4tB0QkW9N3KKjRD7COPn/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ezqimX98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD4EC4CEF7;
	Thu, 12 Mar 2026 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346980;
	bh=AsOLSBoCq1jSqtvKyLBtxl6J6V+mWb7gY0Q6Bav7Ooo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezqimX98Oo+TaRlMtbWTkmt+ohYKFs5xVJj3rPWdTf0bEklWdi6aAM1i+WYm/fIOe
	 qRwTr7T1UfpV3crEYcf+RGsXKZZsgCTIILD09YE6k+Wr6P5e0v0Oc9t1xdsgYJ1/l9
	 Vj31HpAQ/GLlC6O690b/qAukwkxXdZNJxYaDrIFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Eckert <fe@dev.tdt.de>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 172/265] pinctrl: equilibrium: fix warning trace on load
Date: Thu, 12 Mar 2026 21:09:19 +0100
Message-ID: <20260312201024.493948788@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225105-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,tdt.de:email]
X-Rspamd-Queue-Id: 08D42278FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Eckert <fe@dev.tdt.de>

[ Upstream commit 3e00b1b332e54ba50cca6691f628b9c06574024f ]

The callback functions 'eqbr_irq_mask()' and 'eqbr_irq_ack()' are also
called in the callback function 'eqbr_irq_mask_ack()'. This is done to
avoid source code duplication. The problem, is that in the function
'eqbr_irq_mask()' also calles the gpiolib function 'gpiochip_disable_irq()'

This generates the following warning trace in the log for every gpio on
load.

[    6.088111] ------------[ cut here ]------------
[    6.092440] WARNING: CPU: 3 PID: 1 at drivers/gpio/gpiolib.c:3810 gpiochip_disable_irq+0x39/0x50
[    6.097847] Modules linked in:
[    6.097847] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.59+ #0
[    6.097847] Tainted: [W]=WARN
[    6.097847] RIP: 0010:gpiochip_disable_irq+0x39/0x50
[    6.097847] Code: 39 c6 48 19 c0 21 c6 48 c1 e6 05 48 03 b2 38 03 00 00 48 81 fe 00 f0 ff ff 77 11 48 8b 46 08 f6 c4 02 74 06 f0 80 66 09 fb c3 <0f> 0b 90 0f 1f 40 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
[    6.097847] RSP: 0000:ffffc9000000b830 EFLAGS: 00010046
[    6.097847] RAX: 0000000000000045 RBX: ffff888001be02a0 RCX: 0000000000000008
[    6.097847] RDX: ffff888001be9000 RSI: ffff888001b2dd00 RDI: ffff888001be02a0
[    6.097847] RBP: ffffc9000000b860 R08: 0000000000000000 R09: 0000000000000000
[    6.097847] R10: 0000000000000001 R11: ffff888001b2a154 R12: ffff888001be0514
[    6.097847] R13: ffff888001be02a0 R14: 0000000000000008 R15: 0000000000000000
[    6.097847] FS:  0000000000000000(0000) GS:ffff888041d80000(0000) knlGS:0000000000000000
[    6.097847] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.097847] CR2: 0000000000000000 CR3: 0000000003030000 CR4: 00000000001026b0
[    6.097847] Call Trace:
[    6.097847]  <TASK>
[    6.097847]  ? eqbr_irq_mask+0x63/0x70
[    6.097847]  ? no_action+0x10/0x10
[    6.097847]  eqbr_irq_mask_ack+0x11/0x60

In an other driver (drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c) the
interrupt is not disabled here.

To fix this, do not call the 'eqbr_irq_mask()' and 'eqbr_irq_ack()'
function. Implement instead this directly without disabling the interrupts.

Fixes: 52066a53bd11 ("pinctrl: equilibrium: Convert to immutable irq_chip")
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index e8b2efc7b41a0..5204466c6b3e6 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -63,8 +63,15 @@ static void eqbr_irq_ack(struct irq_data *d)
 
 static void eqbr_irq_mask_ack(struct irq_data *d)
 {
-	eqbr_irq_mask(d);
-	eqbr_irq_ack(d);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct eqbr_gpio_ctrl *gctrl = gpiochip_get_data(gc);
+	unsigned int offset = irqd_to_hwirq(d);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&gctrl->lock, flags);
+	writel(BIT(offset), gctrl->membase + GPIO_IRNENCLR);
+	writel(BIT(offset), gctrl->membase + GPIO_IRNCR);
+	raw_spin_unlock_irqrestore(&gctrl->lock, flags);
 }
 
 static inline void eqbr_cfg_bit(void __iomem *addr,
-- 
2.51.0




