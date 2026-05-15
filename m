Return-Path: <stable+bounces-247500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eORXNwnaBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE8354B564
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 735223083A9A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707EB37BE8E;
	Fri, 15 May 2026 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y9LK97y9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9D3FADF4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833783; cv=none; b=fqTU58lVaMrlO3BAI8xM1rSasoLKVvhZPc+GWWFoPTtTF848vXJ/U/SxviSiJJ2Wawa1iEgMadDl8sq7p2dpeqL0fuJ1YrPoFkZjp8jp73Gh6wEAko8JXwRNlkC/gQPEdhJyy6aMAbEelxEuoie9lEFVmhkG3r73rohng5Pn2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833783; c=relaxed/simple;
	bh=ApA/CcDcz+N7/uHWIABklq628YvrkCjGc1heIONUemU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BZQj/l+esHvknnH+o8zRvcrB+OICx4mA9ZisR3d/wuXklPnYLdDFDiGcTzGxgTkI1HQMEixTAYSLxlXFFe8kORUiVTZqsCXXkIxDQv3WVyqALIXknCn9sSHCfUsDH8QU+upW58CYM+QEH+mt/ZkT/QNe/dWar/Ma+M5Oj8Of44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y9LK97y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC7C2BCB0;
	Fri, 15 May 2026 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833782;
	bh=ApA/CcDcz+N7/uHWIABklq628YvrkCjGc1heIONUemU=;
	h=Subject:To:Cc:From:Date:From;
	b=Y9LK97y9/CKox6hXkQapY6QyHGsgKAwduxFVeTX6lPh2e9cDzx8DGojDPb6iSXGLJ
	 vc0wugMBoLjk1BPdX857pFUwZatq+o3tWmGZoZUr5YRIw7hf3rMt3dO/TGGueQ/y5Z
	 V/EO6ricNBJ74Jcij8vTGhu9kL8tqAivxKU/Ugok=
Subject: FAILED: patch "[PATCH] spi: cavium-thunderx: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,jan.glauber@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:13 +0200
Message-ID: <2026051513-modulator-penalty-0c57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AE8354B564
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247500-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dbb6b01267c0c866eaac4019cec19f414beec61d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051513-modulator-penalty-0c57@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbb6b01267c0c866eaac4019cec19f414beec61d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:08 +0200
Subject: [PATCH] spi: cavium-thunderx: fix controller deregistration

Make sure to deregister the controller before disabling it to avoid
hanging or leaking resources associated with the queue when the queue
non-empty.

Fixes: 7347a6c7af8d ("spi: octeon: Add ThunderX driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Jan Glauber <jan.glauber@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-10-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 99aac40a1bba..f1a9aa696c87 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -70,7 +70,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto error;
 
@@ -90,8 +90,14 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct pci_device_id thunderx_spi_pci_id_table[] = {


