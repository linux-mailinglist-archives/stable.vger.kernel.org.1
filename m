Return-Path: <stable+bounces-248693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC0jLUBRB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6B554528
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D4A31613C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B413FBB43;
	Fri, 15 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9mbom69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC33E0094;
	Fri, 15 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862385; cv=none; b=IzT18hnma3aZGSC95/wUmFigHYL5NFUanfS2NbnHDDXa6QW62bC/AewkXzZQ2iu0D8dRLVY2SELLU+lRCEhQ7ybkLylxsrvhik9wmRfThJAZ3NfexQPM2xuacn1y4+SDdrexob6uUruKJPVzPqv99wowBNqrOf+wUmY0d6i2w58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862385; c=relaxed/simple;
	bh=p7sRwcVK6ylO/ONNFgIFGWJkRzUmb4NCJqY/N+ppCSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qB0a1ZYVENIue575AxXslg/PZOVkoKVOZfBXpOmxQPHIm7SJSdSZoGPSrFjYuiUjYY2f2xLbGp/s2YvHVWI2ol8z1CjjMo3UNxmXPU63Ww3DZSv7rfIixVmjfTwO0WyoArLiCf14jLjUolKpEb/hOn6fU9pySdthqzAXTSTf4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9mbom69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CFC2BCB0;
	Fri, 15 May 2026 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862385;
	bh=p7sRwcVK6ylO/ONNFgIFGWJkRzUmb4NCJqY/N+ppCSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y9mbom69Ar4pDsElZU4N/67KzK3UI/cKxUjKFZgnV39fiurl1u9p+pnIK+VQnSDvO
	 sRKfK5qYQ4cn5kBuqISilVOzMFhznHn/cVFb1gGk1V59MbxmQ1UV8rStzwK3Zk6qZ9
	 Vhu5A5bBlHu7RaQJWYykUIA5qY1MIRZ3FMKg2v/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian@openwrt.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 028/201] spi: bcm63xx: fix controller deregistration
Date: Fri, 15 May 2026 17:47:26 +0200
Message-ID: <20260515154659.142888584@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4DC6B554528
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248693-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openwrt.org:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit c39e65a4e3b8e764efed0b2f5152a1a8547b80fd upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org	# 3.4
Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-6-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-bcm63xx.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -602,7 +602,7 @@ static int bcm63xx_spi_probe(struct plat
 		goto out_clk_disable;
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
 		goto out_clk_disable;
@@ -625,11 +625,17 @@ static void bcm63xx_spi_remove(struct pl
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
+
+	spi_controller_put(host);
 }
 
 static int bcm63xx_spi_suspend(struct device *dev)



