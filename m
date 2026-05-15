Return-Path: <stable+bounces-248555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM82JTBXB2pVzQIAu9opvQ
	(envelope-from <stable+bounces-248555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:26:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B1555018
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD7E3336C033
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32F3D1A82;
	Fri, 15 May 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TsXONuQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4F2949E0;
	Fri, 15 May 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862030; cv=none; b=Jry9HZ+kBkGAfSZLIrCDA4LB487D2RYkjVLp28MUYAtsEisHHuZluu7n7nljIVq/7lIKg4A9SSlJuKbw99wMLwEg95oxIuHXSVZf/85jHb2Tc/Evlvcc7z0n25wWUQTbplcya77IPmAtrjE0K/mJrTuGdC6MuDv/rZc90CvDkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862030; c=relaxed/simple;
	bh=fJ5ITDNbWWQSWxMLkbLxcI/XBmswRRFozBpOVryuoOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6ecbZDcu+dH9Jrmekw8qUO0zFz9RE0mTI1dX7c6JUap1X26AzUChHbK5JbQXANLBtSxtu5+vtHnk63di4CjxyNZvot7IDMWKmlaQ5xe5UrAGyOQ0RRQAMiJmVmyzEugrsadnZYqWq3t2/7sIvq63BxrRqQ0sw05PyeEc4lQmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TsXONuQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46327C2BCB0;
	Fri, 15 May 2026 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862030;
	bh=fJ5ITDNbWWQSWxMLkbLxcI/XBmswRRFozBpOVryuoOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsXONuQ5o8hfkdV5ECSrsuOEFksseeVjV3vLi6aeN4J+pWESuFwwluovhSQynSX78
	 zHwlvwJXVFBsAtxUbjJI+r0t9nCPl8TfoLmEdTDzPoRCr7qGDLa7n/rcZUBl44NNkb
	 MVfWLWJlQbzENM5GBssQgkV10vrekib+FPkpXERA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 082/188] spi: sh-msiof: fix controller deregistration
Date: Fri, 15 May 2026 17:48:19 +0200
Message-ID: <20260515154659.099977517@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1A8B1555018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248555-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 45170f67a08b912ead6ccc387ba06954d1d4e53a upstream.

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 1bd6363bc0c6 ("spi: sh-msiof: Use core message handling instead of spi-bitbang")
Cc: stable@vger.kernel.org	# 3.15
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-14-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-msiof.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1290,9 +1290,9 @@ static int sh_msiof_spi_probe(struct pla
 	if (ret < 0)
 		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err2;
 	}
 
@@ -1310,8 +1310,14 @@ static void sh_msiof_spi_remove(struct p
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
+	spi_controller_get(p->ctlr);
+
+	spi_unregister_controller(p->ctlr);
+
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(p->ctlr);
 }
 
 static const struct platform_device_id spi_driver_ids[] = {



