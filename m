Return-Path: <stable+bounces-247357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD6aFZqvBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C45498E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75596303E4B0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DC313532;
	Fri, 15 May 2026 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1vEfouHU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCD1E9906
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823042; cv=none; b=GQHumeHuJd6bRdFUZXbTszotU8iesgK2RPHIspHhiYsSobWq7FHJuC0sBT9EyS6Quy8RkNLVJk6CmSgP8/SrcGa4mqBxm6CP+AolEHrjLjDJnUtJbgvE94LxsZCxTx6XahbEyqgMHxV3hJ5DGVVT3zAlcCtgjQth1kcOJkOUtDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823042; c=relaxed/simple;
	bh=eBykWJ5V86N25wkbVvGBztOJcyqMgax6Qr/4NivQqYQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uE4uWf2h1Cdnguh6oKv4Q60MyzfUP3/tL0P6kSS6sZ0ixwE+95q6x4jFfvS9mRFLClJKPFOgiIxF9tYECz0FFXMfKFvtKCvp9+nE7sWRO8oPmdCSaDUs1Hbs55rIw2AutlF6iOoSjwUs8HlouO83tciuOWdGC5vvlc1LiBxoc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1vEfouHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F91C2BCB0;
	Fri, 15 May 2026 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823041;
	bh=eBykWJ5V86N25wkbVvGBztOJcyqMgax6Qr/4NivQqYQ=;
	h=Subject:To:Cc:From:Date:From;
	b=1vEfouHU7IqQKl5vtj1hFZxhFxkA/jd6IxYSoA3AtBraLa6RLpFDr9XQVuC6P0MC+
	 CeutzUGh78n81WHzJo/Cghg0LuOA1SSS2IukVeXqCTf7N9Siffa8KmSIm+ZznInbg/
	 tUn/zJSl3zVY+UQJcIs+KVlphc8k0nfUQieXVu1g=
Subject: FAILED: patch "[PATCH] spi: sifive: fix controller deregistration" failed to apply to 7.0-stable tree
To: johan@kernel.org,broonie@kernel.org,yash.shah@sifive.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:30:46 +0200
Message-ID: <2026051546-gestation-vessel-153b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE8C45498E9
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
	TAGGED_FROM(0.00)[bounces-247357-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 0f25236694a2854627c1597465a071e6bb6fe572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051546-gestation-vessel-153b@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

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


