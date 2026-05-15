Return-Path: <stable+bounces-247499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIasIgLaBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34054B55D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD08B3082AC5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E213FCB09;
	Fri, 15 May 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vKwPuFkl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24781311C32
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833780; cv=none; b=iyzBhdVvY1r/A0XYWXst87yqUMlFIVwiJVdZnGryNAA5t8ac5ic8wPh54xXznIWmKOJIjOLhQ1wQLt+t8HQRtQDTNqDeutlw5f8AnUneyMdUh5FgTxqXd6O487YcYYIHBBC9I2BYetDDrSn8AbYdmP6xJ3Bam+RaWfpA299nVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833780; c=relaxed/simple;
	bh=bVCcx8mnoURikN3qQi/EYfzhSpBLGLrixVFT1WAS5Gg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gnXlHnGeGZpuUnAMyCqbH7Gm6GHPiqTeZ5ODGFdyy2k+y3R/0FDIF3NKNMRuYR1Q6hFmwUh0tMMJQFs6SekXSROtEGYYzsV/IDb5T7dTaoyjRry5x/O0Tkk+aQyqU/+waLH2xcqUJ4Y/KrSvaXuwDFyYkNv1jdZ3wzM+Sby+cyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vKwPuFkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D7CC2BCB0;
	Fri, 15 May 2026 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833780;
	bh=bVCcx8mnoURikN3qQi/EYfzhSpBLGLrixVFT1WAS5Gg=;
	h=Subject:To:Cc:From:Date:From;
	b=vKwPuFklrunGHfzORsO0MRpuLpBN39zSXuZuw6CPwmtXqkkhomQEQtqwuma06H86j
	 vt/2YMuexvPKTFUa8sDmJZS9jhs7C/BNoFoCooU3S6KBwGJiz0F6we9Dvp0NSD8bM8
	 0NiwxZvjWz1kEZJnBz4PLjmtwJLLUlUFpzw/Pb2o=
Subject: FAILED: patch "[PATCH] spi: cavium-thunderx: fix controller deregistration" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org,jan.glauber@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:12 +0200
Message-ID: <2026051512-encounter-trimming-bd25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A34054B55D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247499-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dbb6b01267c0c866eaac4019cec19f414beec61d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051512-encounter-trimming-bd25@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


