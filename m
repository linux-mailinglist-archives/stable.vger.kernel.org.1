Return-Path: <stable+bounces-247478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMGoEIDaBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:34:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FECA54B60B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46173032F49
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B96401481;
	Fri, 15 May 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YKvXaja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38060382396
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833714; cv=none; b=ZNduY9I4haLYTXKVPNyY9qMhx+cEMVztRchi9QbsxlYBqZD2ka8qhaeR+2tAoLQcxDiaTEkEbj2aA4iNN/avdnJDGEA6cphUo1uuZbevoMc4KE1PmREwNuRVnc8alm1NfU4uFsk1drhZRpp1BZWMhfHOR1wkdk0MGMICImlAGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833714; c=relaxed/simple;
	bh=1SpF9jmULIAx/xKXNpFMukIYKUODPJ/5OzgBD/+8vJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fgV9hphT5GaQU5yVEYrKXBUoqJwJIViFmkkRoczfGOYB7wLRVx/q/1x5exajI2tD3psHnbLGp03gkTxQ3Lw4ulo7xboQDl4IbahH8eIcsZ5FEcfUDY4N03ERJlGGNA8ikIFKfHdmZv4CB1t60+U6C/tceK7l5Jds8Teo0PIJjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YKvXaja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BDC2BCB8;
	Fri, 15 May 2026 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833714;
	bh=1SpF9jmULIAx/xKXNpFMukIYKUODPJ/5OzgBD/+8vJg=;
	h=Subject:To:Cc:From:Date:From;
	b=2YKvXajaSR+iHJbOAZIsazlv25oUpMjmdcKNoiImTktM87xI8Fb6Xd5OpFi9ZG8/V
	 dUYsdNA5a5mOoirTpFannWSyzeYoqqGrrxy2ntKbUdF1TFeCHcsMRXr4HONHP+mZgw
	 7cEIbop+XZjehnEQVycwMJF0i2wHDMBeTJDNo+94=
Subject: FAILED: patch "[PATCH] spi: sh-hspi: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:27:56 +0200
Message-ID: <2026051556-tighten-basket-e33f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FECA54B60B
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
	TAGGED_FROM(0.00)[bounces-247478-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e63982e6392e45a6ecd68d6c317a081cc8e70143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051556-tighten-basket-e33f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e63982e6392e45a6ecd68d6c317a081cc8e70143 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:42 +0200
Subject: [PATCH] spi: sh-hspi: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 49e599b8595f ("spi: sh-hspi: control spi clock more correctly")
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-13-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index e03eaca1b1a7..1e3ca718ca73 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -257,9 +257,9 @@ static int hspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one_message = hspi_transfer_one_message;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error2;
 	}
 
@@ -279,9 +279,15 @@ static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(hspi->ctlr);
+
+	spi_unregister_controller(hspi->ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
+
+	spi_controller_put(hspi->ctlr);
 }
 
 static const struct of_device_id hspi_of_match[] = {


