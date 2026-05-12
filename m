Return-Path: <stable+bounces-245556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMYPOG8wA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45722521AD5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1A530A33FB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E13A719B;
	Tue, 12 May 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thzRs8ag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D073A48D8
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590223; cv=none; b=NXw3M/aNQz7YeI4HjUNVQoZH0G3lRztzc4p0PePePtC9qpAEtwOKi5hs322mrdjPeqZCZ6uhOKkE4sZqze5BepY0bBypDeTReChPAmZxO/7xnZ1EMOHDRMz8lOYWcHGDgJWZUmir6IXgMJtag5ITBAEqYSt22AfRhjOVyKiZn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590223; c=relaxed/simple;
	bh=vGA5ubgDS1qlX+eYukWZHtfobRRjNsseCPvwJbUQCH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ARfQFPEd2NFD8aSe1vBp53M5gEdjVctC/yKbFX6E3+lgoMoETjjzKScs9kCUhE+O8kputNmMhG2mH0nuD7TyzaYfzEWCzvoxxgsV3ZWV9Zs2zd27C0CKzSx2yPLM7uHI3B/yyhMYOdDRU7SeF7LFZSkMPOpoFhPvyylAkjaL3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thzRs8ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87851C2BCB0;
	Tue, 12 May 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590223;
	bh=vGA5ubgDS1qlX+eYukWZHtfobRRjNsseCPvwJbUQCH8=;
	h=Subject:To:Cc:From:Date:From;
	b=thzRs8ag0rKRPyXbyeLzRVnGUMLsl2OyPqwVd8sZ5QQPfz5QZ2H+FmSO67zcoI6Q5
	 FL289EsWS3nbIx1P+8w6P4izGCt5ALqikHegCKI04nkEQbSI3M8Af0NoqJKh3J6WPh
	 kVrmf9WiPeW0/ahEp8t7y8+e8qiN9mGgCAbQr3MY=
Subject: FAILED: patch "[PATCH] spi: uniphier: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,hayashibara.keiji@socionext.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:47:14 +0200
Message-ID: <2026051214-aching-old-35ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45722521AD5
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
	TAGGED_FROM(0.00)[bounces-245556-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,socionext.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0245435f777264ac45945ed2f325dd095a41d1af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051214-aching-old-35ed@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0245435f777264ac45945ed2f325dd095a41d1af Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:54 +0200
Subject: [PATCH] spi: uniphier: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Note that clocks were also disabled before the recent commit
fdca270f8f87 ("spi: uniphier: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 5ba155a4d4cc ("spi: add SPI controller driver for UniPhier SoC")
Cc: stable@vger.kernel.org	# 4.19
Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-25-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 1b815ee2ed1b..eac6c3e8908b 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -746,7 +746,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	host->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_release_dma;
 
@@ -771,10 +771,16 @@ static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id uniphier_spi_match[] = {


