Return-Path: <stable+bounces-247453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOmrKATPBmqAoAIAu9opvQ
	(envelope-from <stable+bounces-247453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:45:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1654AC93
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F66930B85E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1624677B;
	Fri, 15 May 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vEnuu7WB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA413F0775
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830780; cv=none; b=UE2cMwqSu1aVVWj/2EZ2diQHbZ2MPL17jEiyJ7rm81U6Wbl7zRJXJBCFhfwDKUdIZN+IEcKveIIkZNagKNXSJqbPadJRxuL/Kqk7f6Fdo2Kz7upNO88uttLaqckuBF9wq5ijhEOmNaA63me49ZBZ7C8Bzfb43Fwy/7aVDIWF9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830780; c=relaxed/simple;
	bh=CF8h0j4Q1vHCZiv57pLXYrh1Uik/V3vvKa+EuFsAbTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z0Mx+Yj55uIJc0Gfkns6r/3qsesDg8mQ+T72G5o0aGWtSLj3koRwKYEuTvjLht4xIzGktIq+kM4Qb2dtfG+pC45yoHsgkxnIxzBXI6+6K7IU3GGoAXeSKqiAfoGigmMsrRAfoTsGLHC9IDdfSF7k2EU7zQY6SjY+qgZ/RdLst9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vEnuu7WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48898C2BCB0;
	Fri, 15 May 2026 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830779;
	bh=CF8h0j4Q1vHCZiv57pLXYrh1Uik/V3vvKa+EuFsAbTc=;
	h=Subject:To:Cc:From:Date:From;
	b=vEnuu7WBISh4vK8nJ0ieenrw6DVEhpRKqDekLC0lTATz4/S952hTmX5OCLdwck96w
	 a5BEvawCRAY+u0X9ZXkV43bkdpDiA5VXyycmTmNfOeE1CX4/BBBUSMyVTDPm+wpC50
	 655K1Du1ekLeIockOpYUsvdz6G0Rhb2QdlXuKcE4=
Subject: FAILED: patch "[PATCH] spi: pic32: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,purna.mandal@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:39:35 +0200
Message-ID: <2026051535-limpness-stoppage-cdd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFD1654AC93
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
	TAGGED_FROM(0.00)[bounces-247453-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6b627bfe0c44e064aba464839e430dc1ca2b0bb8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051535-limpness-stoppage-cdd3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b627bfe0c44e064aba464839e430dc1ca2b0bb8 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:36 +0200
Subject: [PATCH] spi: pic32: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 1bcb9f8ceb67 ("spi: spi-pic32: Add PIC32 SPI master driver")
Cc: stable@vger.kernel.org	# 4.7
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-7-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 369850d14313..70427e529945 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -821,7 +821,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	}
 
 	/* register host */
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&host->dev, "failed registering spi host\n");
 		goto err_bailout;
@@ -840,11 +840,16 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 static void pic32_spi_remove(struct platform_device *pdev)
 {
-	struct pic32_spi *pic32s;
+	struct pic32_spi *pic32s = platform_get_drvdata(pdev);
+
+	spi_controller_get(pic32s->host);
+
+	spi_unregister_controller(pic32s->host);
 
-	pic32s = platform_get_drvdata(pdev);
 	pic32_spi_disable(pic32s);
 	pic32_spi_dma_unprep(pic32s);
+
+	spi_controller_put(pic32s->host);
 }
 
 static const struct of_device_id pic32_spi_of_match[] = {


