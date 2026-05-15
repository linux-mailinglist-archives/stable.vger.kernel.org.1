Return-Path: <stable+bounces-248546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCpeKQNNB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A6553C7F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D8CB301A9B3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC63BB68B;
	Fri, 15 May 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="espXrAl3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEE2949E0;
	Fri, 15 May 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862007; cv=none; b=MFx0Mmi03Y8tGqJUAeyDcHL0MQPuBG8a7apmavp5NgVr9SE94mR82oH0izCAVE6Ccy1LQ1JvzNzTuCzEfoehi4NYeJFgtFnobRVhh3l5UQjWDor5wySiR8fAGzrAMDsPQz4eIC0FxNC8gsKg/LJKfjPmk+Jv4gvTlexZLHoJf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862007; c=relaxed/simple;
	bh=Z6g96brAYGOpo8Y7RmnuU0AoIhBAkC/FLI2ANlLxSY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP63JO1RPBTY4fUEfM+ljO4rG64c8P8bwpuASZs8ykuqVvFQP06rKqm/ttgf/M4JX+YCJD6XGMTLDiWFsEH7l60Q6kZ56zD4XycAbDNwEgQlV+rRN3zHd1qJrjkLrGmOKZzUefHeUWXkLpQTKA5o8X138Hyzmytfxi/qSbdurCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=espXrAl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9EBC2BCB0;
	Fri, 15 May 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862007;
	bh=Z6g96brAYGOpo8Y7RmnuU0AoIhBAkC/FLI2ANlLxSY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=espXrAl3MDNpq1MXUe7IASGq89saOxSYtbnvGpm3OdR8+9Srn9WYmQK2NY6c8IXo8
	 7BH2pMLlI6RSDeQZDs4QCOVqBl1eg/8rVAHmeYugwHYDIeSl4eNzKIQSloLDq5qgNc
	 e3aYu31l6AP+Ci8YKQ10C6Oh3jC0TepNv/hP3kIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 073/188] spi: sh-hspi: fix controller deregistration
Date: Fri, 15 May 2026 17:48:10 +0200
Message-ID: <20260515154658.902805251@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 811A6553C7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248546-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit e63982e6392e45a6ecd68d6c317a081cc8e70143 upstream.

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 49e599b8595f ("spi: sh-hspi: control spi clock more correctly")
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-13-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-hspi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -258,9 +258,9 @@ static int hspi_probe(struct platform_de
 	ctlr->transfer_one_message = hspi_transfer_one_message;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error2;
 	}
 
@@ -280,9 +280,15 @@ static void hspi_remove(struct platform_
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



