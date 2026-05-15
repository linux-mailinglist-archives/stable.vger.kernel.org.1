Return-Path: <stable+bounces-247530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFmUFtTZBmoGogIAu9opvQ
	(envelope-from <stable+bounces-247530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:31:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2906254B503
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFE8D300B1CA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24773E4C6E;
	Fri, 15 May 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4lnjmQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D413AA1AE
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833869; cv=none; b=haCFhklDVgiP5QG9S6CnVAtGR6sPJ+LSj39LZtNK+rRvUouOOMm4AztdvFqZHvSEGppF9HEbzk/Z6dHJ+RQ5T939PiV0N/tIJfwBJk4e+jDW1zaSIDPOhOzZjHe3wpuq7sJxD01kxZjFPuJLUGadrH9+dpPQU6OO2ik1dtzAizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833869; c=relaxed/simple;
	bh=vlGQkZPEpGr9/Zc/FWJqn45Xlyw4PYsWhGV0pmCZ180=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QJScPIHiN8s0ZjSIU98VKMa4nMHslpCeZafahNzxR4KTiPnqI71+4i/9L4g2PViTP9663vcbz0sUfyEobR9ermIobGYxZbk6l6sRncf37TRSjwLhdEW+pV8aUf2Qabxd44dLDGjZCrSBcUdhyO9OdjiJf/EjrJjsZJ+e1fDXU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4lnjmQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA1C2BCB0;
	Fri, 15 May 2026 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833869;
	bh=vlGQkZPEpGr9/Zc/FWJqn45Xlyw4PYsWhGV0pmCZ180=;
	h=Subject:To:Cc:From:Date:From;
	b=p4lnjmQMOVp2o98ZPhnbTEg6w2dQLOOoykX/qyB/UpiQm5Zvnk0QZ7Ymnf7QmzwZe
	 z/IZM2nOaqeVQ2AS8Cklv9VXYHqRQoLIT1ue6biIv4Io87P9v8ufZYacocEQfSWpL0
	 aTK196gdy2K4C5UZ16M1HRG04ebuLvjoviYH8gYs=
Subject: FAILED: patch "[PATCH] spi: octeon: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,jg1.han@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:30:37 +0200
Message-ID: <2026051537-boil-stress-506b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2906254B503
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
	TAGGED_FROM(0.00)[bounces-247530-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3c49a4d8799bee423a80f392ba95b26af8e9ab91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051537-boil-stress-506b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c49a4d8799bee423a80f392ba95b26af8e9ab91 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:07 +0200
Subject: [PATCH] spi: octeon: fix controller deregistration

Make sure to deregister the controller before disabling it to avoid
hanging or leaking resources associated with the queue when the queue is
non-empty.

Fixes: 22ad2d8df77d ("spi: octeon: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-9-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 155085a053a1..b95bfa6a3013 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -54,7 +54,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	err = devm_spi_register_controller(&pdev->dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "register host failed: %d\n", err);
 		goto fail;
@@ -73,8 +73,14 @@ static void octeon_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id octeon_spi_match[] = {


