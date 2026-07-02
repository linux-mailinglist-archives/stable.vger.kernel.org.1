Return-Path: <stable+bounces-270652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /TbGHpKeRmowaQsAu9opvQ
	(envelope-from <stable+bounces-270652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:23:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EECCC6FB451
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:23:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2U1xvVcB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270652-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270652-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A753F323ED6A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199894DBD98;
	Thu,  2 Jul 2026 16:25:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530C4BC025;
	Thu,  2 Jul 2026 16:24:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009502; cv=none; b=R1z2iwpnTeud3fzXXtU2ccwzmk5Rai1Du5cpEd1mVVvXM9CSBRLLpbb31QGyWNkunke4niRG27UTfXIpGhCvJJppn6KrGJqQ0yf/KVA/gYmVqM1PwCBYIQvELCzdx2+H+fH4hXSwZs3fVMSBMGLRUBWpwCz3zzOqMfD9cjQr5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009502; c=relaxed/simple;
	bh=b1E2lnowTeg7MSuOM1mdJlGmaQaBy2UCZ0MRKsgjnP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t576oCD9/RgyM6grl8MNmDh0MYHJGtcpsU5e1wjtOiNQ12eWYRo1aICDoHGw+G6ehmmOpIkzbSiYsCNfwCDIJnNkpADJLpE21RVbrD5VDi0CHzQXnlJEuhS0XiNItYyNiivyGktZNXjaZ/tOTDGZmZs+KLD2vaTkpeEhHwWxs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2U1xvVcB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3C71F00A3D;
	Thu,  2 Jul 2026 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009494;
	bh=plZECvTBlH4NrW3echAaWjcKeWCrCAygwBuKpbpqOVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2U1xvVcBXRnlYGzyC8wF9i6O8WLwBdZI7/YNv/5vFJ1SUEEfewYh8BZVGjTiwTqFB
	 AWeiSHxkNCJdgm8iUhKjf3F2xyqvCaVRrfZF4XG6lIW7tE+gWJIOq4BXVyhu0mTuja
	 u4Sis0jlNDbO7QVXhAvrG/6mThuhYT3wL6V4jIzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingshuang Fu <fuqingshuang@kylinos.cn>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 5.10 73/96] irqchip/imgpdc: Fix resource leak, add missing chained handler cleanup on remove
Date: Thu,  2 Jul 2026 18:20:05 +0200
Message-ID: <20260702155110.517513316@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270652-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fuqingshuang@kylinos.cn,m:tglx@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EECCC6FB451

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

commit 37738fdf2ab1e504d1c63ce5bc0aeb6452d8f057 upstream.

The driver allocates domain generic chips using
irq_alloc_domain_generic_chips() during probe and sets up chained
handlers using irq_set_chained_handler_and_data(). However, on driver
removal, the generic chips are not freed and the chained handlers are
not removed.

The generic chips remain on the global gc_list and may later be accessed by
generic interrupt chip suspend, resume, or shutdown callbacks after the
driver has been removed, potentially resulting in a use-after-free and
kernel crash.

The chained handlers that were installed in probe for peripheral and
syswake interrupts are also left dangling, which can lead to spurious
interrupts accessing freed memory.

Fix these issues by:

  - Setting IRQ_DOMAIN_FLAG_DESTROY_GC flag in domain->flags, so the
    core code automatically removes generic chips when irq_domain_remove()
    is called

  - Clearing all chained handlers with NULL in pdc_intc_remove()

Fixes: b6ef9161e43a ("irq-imgpdc: add ImgTec PDC irqchip driver")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260618021352.661773-1-fffsqian@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-imgpdc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -385,6 +385,7 @@ static int pdc_intc_probe(struct platfor
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
 	}
+	priv->domain->flags |= IRQ_DOMAIN_FLAG_DESTROY_GC;
 
 	/*
 	 * Set up 2 generic irq chips with 2 chip types.
@@ -472,6 +473,11 @@ static int pdc_intc_remove(struct platfo
 {
 	struct pdc_intc_priv *priv = platform_get_drvdata(pdev);
 
+	for (unsigned int i = 0; i < priv->nr_perips; ++i)
+		irq_set_chained_handler_and_data(priv->perip_irqs[i], NULL, NULL);
+
+	irq_set_chained_handler_and_data(priv->syswake_irq, NULL, NULL);
+
 	irq_domain_remove(priv->domain);
 	return 0;
 }



