Return-Path: <stable+bounces-247549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PswJKncBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5354B9B0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF9230ED8D7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E13932EE;
	Fri, 15 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hb4YkCa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83F625
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833943; cv=none; b=j2M2XaQwOHa0QNHy7+nR1PbLC2o098NbsjslSIeQ7o9dmWHnE2QqUC0OjM4ke0nHhmUIXQsXBDDv/3gm26L4Xg27kXeBUduEYduFjbjMpZTjisiXX/HT4aLT9IQSzxIKeaqxiSPEwjDLz9b12u1nQ0vEk41FsNjtOYzFzlN2fw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833943; c=relaxed/simple;
	bh=FKvJ7ACtgs17sVm0HSy+Ra6yGXTyW66rSB730qbKX8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qJsXKq72p/ffyDuKqUvK3GlhX2XKrGIm8Iy4nLpTWik/WgsKkEOpdO8u/CKdpE0NeELSVT+Nqo7mqEstA5uCNPzUBHG7bIoMujuZISaFYHf2sABvBLHqIH1KPHi6CljytKSoQyuOq2AvYVIP2kxKfmQP86PPWW70GCuStBA/htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hb4YkCa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACA2C2BCB0;
	Fri, 15 May 2026 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833943;
	bh=FKvJ7ACtgs17sVm0HSy+Ra6yGXTyW66rSB730qbKX8o=;
	h=Subject:To:Cc:From:Date:From;
	b=hb4YkCa1JmFjGE2fXSv9UKTLzpgygRAqAtWDyMWsPnGI1wg7COIJZS7CsT0TJW0L3
	 VNKyVIFrQxY08gU2gFuHv7BHniUYxGHEpAjHKDUMuuvYXmRD63rUcq9zs5dzmowMNd
	 pCT6yCBABYNcVnKgbocY1HrL8ccz7f+xsEBYtZLs=
Subject: FAILED: patch "[PATCH] spi: mpc52xx: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,grant.likely@secretlab.ca,l.fu@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:32:20 +0200
Message-ID: <2026051520-pluck-freeing-2437@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19C5354B9B0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247549-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,pengutronix.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,secretlab.ca:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0f997fdae819a8c2cc83bd4ff7d935ad76c727c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051520-pluck-freeing-2437@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f997fdae819a8c2cc83bd4ff7d935ad76c727c9 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:14 +0200
Subject: [PATCH] spi: mpc52xx: fix controller deregistration

Make sure to deregister the controller before disabling and releasing
underlying resources like interrupts and gpios during driver unbind.

Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
Fixes: b8d4e2ce60b6 ("mpc52xx_spi: add gpio chipselect")
Cc: stable@vger.kernel.org	# 2.6.33
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Luotao Fu <l.fu@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 05bbd3795e7d..823b49f8ece2 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -517,6 +517,8 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 	struct mpc52xx_spi *ms = spi_controller_get_devdata(host);
 	int i;
 
+	spi_unregister_controller(host);
+
 	cancel_work_sync(&ms->work);
 	free_irq(ms->irq0, ms);
 	free_irq(ms->irq1, ms);
@@ -525,7 +527,6 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
-	spi_unregister_controller(host);
 	iounmap(ms->regs);
 	spi_controller_put(host);
 }


