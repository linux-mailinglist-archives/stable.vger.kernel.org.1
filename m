Return-Path: <stable+bounces-247361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJttJM6vBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D25549924
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD4630474C7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BC33893D;
	Fri, 15 May 2026 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eW8ADDL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B22313532
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823058; cv=none; b=FllepnBhdJc0/2ZjoOhniatgtStG7/2puh064LATqBuguqxKnRFOxjfX/AyI0S2vKQJjpSEh2vd6UsYDHOne1xA8mKjG/DncFnnUlAJaVkgt4UBF3FsibqlAb7oBw8YYxVNMjv4mjgl9xERqWj/a25RvyBRVayFX2fNs+CUTgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823058; c=relaxed/simple;
	bh=gSSU4B8mxt1+fSdr9xiUNH9QuYs4KsxynHAjiVQc1pg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=to8qd3TMFMEaujrAx4GEe2IerUWMPnmlPniEDbIW0sF1SHuYs0Yw0U96NsH25ikIKLjQM2djH2VrZ2mAKex2xa0NhQlFKM97JRrsSIx0hj2jOAQjPEQIM1IDVl21beCBqD19g95MTZmW0+yKoJKH2PzcvvgduwYdz4OFOHpUXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eW8ADDL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA88C2BCB0;
	Fri, 15 May 2026 05:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823057;
	bh=gSSU4B8mxt1+fSdr9xiUNH9QuYs4KsxynHAjiVQc1pg=;
	h=Subject:To:Cc:From:Date:From;
	b=eW8ADDL2KL0vQfam4tZ0ZtSVUHzE+gHPuU/kCP3iSPtVN4urAnK2upTjcKOiFM/9J
	 2+TLBYTKjaUsvvU+lhQtXf7XmZHan3W6td4cQiUD/Divtd3g3FgkwN1k9i1xgqveoy
	 /BOIN60EQZp93lWCGomRi2e9aArQ7PKyl4YjTMuM=
Subject: FAILED: patch "[PATCH] spi: sifive: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,yash.shah@sifive.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:30:47 +0200
Message-ID: <2026051547-mortality-galleria-2a2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30D25549924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247361-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:email,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0f25236694a2854627c1597465a071e6bb6fe572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051547-mortality-galleria-2a2a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f25236694a2854627c1597465a071e6bb6fe572 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:44 +0200
Subject: [PATCH] spi: sifive: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Note that clocks were also disabled before the recent commit
140039c23aca ("spi: sifive: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 484a9a68d669 ("spi: sifive: Add driver for the SiFive SPI controller")
Cc: stable@vger.kernel.org	# 5.1
Cc: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-15-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 54adbc057af6..74a3e32fd2b5 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -392,7 +392,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
 		 irq, host->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_host failed\n");
 		goto put_host;
@@ -411,8 +411,14 @@ static void sifive_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct sifive_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+
+	spi_controller_put(host);
 }
 
 static int sifive_spi_suspend(struct device *dev)


