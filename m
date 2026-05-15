Return-Path: <stable+bounces-248305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPteNF5NB2rJxQIAu9opvQ
	(envelope-from <stable+bounces-248305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39413553D4D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED803141094
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679CA3E0096;
	Fri, 15 May 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzV2XxUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267423FD97E;
	Fri, 15 May 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861392; cv=none; b=YcWPyxMYRkwAavE+KdMNhc2qCmNWpCb1vCpFkQoO2zoZTU+v7eDwOhM6TJOw+Z/Eu3T388Bulbtv0Qx5NdEqTz8BdsgGV2gzegT1ZcQ0iJ2Uvx56hcjX50nskKCdeKgpkW8EVUTHCRT5E54m63Hyh2vaGbAYZbKYNqPbe+ZqoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861392; c=relaxed/simple;
	bh=T8C2l0z+dGNT9XXzLsq/xhd19KoienjlyGARPS1fovk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W85KIKfsyOrIucrttqg62CDzQwBPtmSWya0boXA45rSfYmD1OIdQ9fEDFBT/3BQKdLRXUUGCpM65N44Zpw9hXUabKV8SJRJyrjaf3DnlT5Kx3LurJ4+ogKIvnXv2C2+2xYaUJxYtggw49EzScsLkAIJPHOdpBxAHaTRq4TFbdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IzV2XxUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8628C2BCB0;
	Fri, 15 May 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861392;
	bh=T8C2l0z+dGNT9XXzLsq/xhd19KoienjlyGARPS1fovk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzV2XxUe63whv1nq4c0ESbWLySpJcWa6EMVcgzqCwfNgRgxRrUkqXgMJ+6y16QUtl
	 IYt5au9Wkw+CpZMX1sD4h7GkQ+uuy1/Yn0xoI0dmvq7e9xTPFmOStJ/a0dwLg90nXO
	 HcBFk368k0VSrnHS1FR4Hm6/iCp3RSZ2fZCxe5Kc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 311/474] spi: lantiq-ssc: fix controller deregistration
Date: Fri, 15 May 2026 17:47:00 +0200
Message-ID: <20260515154721.737641569@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 39413553D4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248305-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit b99206710d032c16b7f8b75e4bc18414d8e4b9f4 upstream.

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Cc: stable@vger.kernel.org	# 4.11
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-17-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-lantiq-ssc.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -998,7 +998,7 @@ static int lantiq_ssc_probe(struct platf
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_controller(dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(dev, "failed to register spi host\n");
 		goto err_wq_destroy;
@@ -1022,6 +1022,10 @@ static void lantiq_ssc_remove(struct pla
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
+	spi_controller_get(spi->host);
+
+	spi_unregister_controller(spi->host);
+
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_CLC);
 	rx_fifo_flush(spi);
@@ -1031,6 +1035,8 @@ static void lantiq_ssc_remove(struct pla
 	destroy_workqueue(spi->wq);
 	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
+
+	spi_controller_put(spi->host);
 }
 
 static struct platform_driver lantiq_ssc_driver = {



