Return-Path: <stable+bounces-211811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE/rGna+eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:32:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F994EFB
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05483045A8A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14C357A49;
	Tue, 27 Jan 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ak6kKzBP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFF34EEE9
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520603; cv=none; b=UOcK6vq1R10kcjU3xa0nA31YI6CRJosxLQAXYpqgWIVGU4zW/UKHdPs3Nyx1jdY4R23oGsgD7rnkMNj61SfiQl07qT1so/OkIZ8+2wF1Kd1XxOvyh2jrmum12e7UmGEf0dtaEcD2LkUSBFLrooFX+V0Uo546rpMtHQ+8dA7SZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520603; c=relaxed/simple;
	bh=ZxS6mVMl02tCZcLszLviDD25ZebJilQKHPVRc/pEsIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y/x1yoke1dT1CrWtXnty+6piVWp8WbpoKLTVavKYa+D0wZJEYd309sukBp8lTqjyLfInPlQ7MrsfnBMn/KolPSbqBy0JfT/pZfMvvWyY6AEssGyewaK/bGG8THvoADAexiYHZv0W/WL1qzDnEaxH+mut7LDJRLXjSXSZIUubugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ak6kKzBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2896C116D0;
	Tue, 27 Jan 2026 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769520603;
	bh=ZxS6mVMl02tCZcLszLviDD25ZebJilQKHPVRc/pEsIw=;
	h=Subject:To:Cc:From:Date:From;
	b=Ak6kKzBPoasNh3Ylq3mwpy3HTffkeAIcSZ8AsbdgOGpHmepYnH2wN4qUl7lOHnBHy
	 PbbJQNT5DE5urHab2tl8Zn0KjshE2VmmSNnmizRTXooLyPAUFPAAUMaffQUcJIRyWQ
	 rdBPy7HGQA6lLiKRp+bmeDq6DgOkSQ25Rt9rLqPg=
Subject: FAILED: patch "[PATCH] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during" failed to apply to 6.18-stable tree
To: biju.das.jz@bp.renesas.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:29:59 +0100
Message-ID: <2026012759-decrease-extinct-45cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211811-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E78F994EFB
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cd4a3ced4d1cdb14ffe905657b98a91e9d239dfb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012759-decrease-extinct-45cc@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd4a3ced4d1cdb14ffe905657b98a91e9d239dfb Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Tue, 13 Jan 2026 12:53:11 +0000
Subject: [PATCH] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during
 resume

A glitch in the edge detection circuit can cause a spurious interrupt. The
hardware manual recommends clearing the status flag after setting the
ICU_TSSRk register as a countermeasure.

Currently, a spurious interrupt is generated on the resume path of s2idle
for the PMIC RTC TINT interrupt due to a glitch related to unnecessary
enabling/disabling of the TINT enable bit.

Fix this issue by not setting TSSR(TINT Source) and TITSR(TINT Detection
Method Selection) registers if the values are the same as those set
in these registers.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260113125315.359967-2-biju.das.jz@bp.renesas.com

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 899a423b5da8..9b487120f011 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -328,6 +328,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	u32 titsr, titsr_k, titsel_n, tien;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
+	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -376,12 +377,18 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	guard(raw_spinlock)(&priv->lock);
 
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
+
+	tssr_cur = field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width), tssr);
+	titsr_cur = field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
+	if (tssr_cur == tint && titsr_cur == sense)
+		return 0;
+
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
-	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
 


