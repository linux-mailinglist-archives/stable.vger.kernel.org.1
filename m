Return-Path: <stable+bounces-247545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NwnIwnaBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455654B565
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91D96300AB39
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBD3F0AA0;
	Fri, 15 May 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DifRi7xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676011A2C04
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833927; cv=none; b=hcC+AvSYtSVQYZpWlXbh8/0M4Gb36ip1WZzbmsCkM2syZiyDGjb0u6qscUzpOUed7D2+FwIvUYp7ISPeMpjYxRTSob6IgF9WUfhdhB9XqwgAYfj+zo7RB5DfdItC4sLneinoBcUt/IQ/Xi6C9u740RjTIfbPkQdrFqh8XfY2Ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833927; c=relaxed/simple;
	bh=hqipvd6ePwy2zJgcIz1gNaVrS20jEiBxTvuRM4PhdNA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Igbogu1AsTJL7L62wkNRnKkM/O6JzWUDFD9VCHEKzn9N6Pru/YiozrtWMKQy7mmSTVljczudJOac88NmTJQREa3UrcV4tonRq0ocCcl3Q/pQ3HUPB5Cb/Zq9y3M/taThDVUvpzgjVfSBpJdb9k0+MRgMXvgFy4z5rQMGrfQ4iE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DifRi7xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7BEC2BCB0;
	Fri, 15 May 2026 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833927;
	bh=hqipvd6ePwy2zJgcIz1gNaVrS20jEiBxTvuRM4PhdNA=;
	h=Subject:To:Cc:From:Date:From;
	b=DifRi7xd/VEBOO67BerevD9W1FpbCOb9EmIDUJ3sD8f+oVhPfAeTDd718roqu9FY8
	 HXYbgB8c/v2yawvCnRRQ5Ou9egGRsh0ZPkbzmUo2/rWns0Y/6ONsf4rKKVoUmyXKeN
	 AurogAcSkllw2nwVF64FYuO4QCJ2xzbsEEmucI9s=
Subject: FAILED: patch "[PATCH] spi: mpc52xx: fix use-after-free on registration failure" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,grant.likely@secretlab.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:32:03 +0200
Message-ID: <2026051503-fetal-untrimmed-5c64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2455654B565
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247545-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f62c060272b9d7423b1650b844e8e4e7b8f9f925
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051503-fetal-untrimmed-5c64@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f62c060272b9d7423b1650b844e8e4e7b8f9f925 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:58:00 +0200
Subject: [PATCH] spi: mpc52xx: fix use-after-free on registration failure

Make sure to disable and free the interrupts in case controller
registration fails to avoid a potential use-after-free and resource
leak.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
Cc: stable@vger.kernel.org	# 2.6.33
Cc: Grant Likely <grant.likely@secretlab.ca>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=3
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125800.1537361-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index c8c8e6bdf421..924d820448fb 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -498,6 +498,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
  err_register:
 	dev_err(&ms->host->dev, "initialization failed\n");
+	free_irq(ms->irq0, ms);
+	free_irq(ms->irq1, ms);
+	cancel_work_sync(&ms->work);
  err_gpio:
 	while (i-- > 0)
 		gpiod_put(ms->gpio_cs[i]);


