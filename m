Return-Path: <stable+bounces-247861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK81A/xpB2oJ2QIAu9opvQ
	(envelope-from <stable+bounces-247861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:46:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B67D55677E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0792F3141B52
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74923FF1DA;
	Fri, 15 May 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3gjllUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C63FF1A0;
	Fri, 15 May 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860260; cv=none; b=pRwfYt5hdqMghQraQEhBej9Sdp0jsqgfUM5y8t+haKoa4jIteeyOpogY+J4zYi9P/0j3vVeXilXwEjXNvUajHtkxZ5AsDo69J1sOua9lYF1L9zMYyTJcKxHP3gY2Oz6vSILNFxAiiQIleRyd8DkRhf5duF3jb4xW2i3zN/iNwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860260; c=relaxed/simple;
	bh=tpkED+ZCoh3quozrbYkVyPUX3vR4wvC7m7K9Bs2ZWP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMIxTNFG8e7/P27wq/qwWNl1b4WdcuwCukRUGXlBNTQcvYG0vvC0LXF++1tYeDCE8KW1NavPBZZ4tSiVC4dmIGDOGniGqaZ0eGZW04uWKBMJ+0V+OexmZeMLP0FUXHEchrxpTVoktbeV/AoUEBZ9rXS5OItpb/Jt3zyQ6sPzUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3gjllUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC7C2BCB0;
	Fri, 15 May 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860260;
	bh=tpkED+ZCoh3quozrbYkVyPUX3vR4wvC7m7K9Bs2ZWP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3gjllUE0twOIN28lMMrjj17QYF3eWPazNnQUJEaefmu7vFgh3YuGYM9PozV6jFMy
	 4ZUHX5RY/mE2WxoowSTuvc3QrqVIBZgRpc6wIufdWDImQCAuFw+wqasUuOsuk414q/
	 zZlbMF8kOmiWsKqP4pcLzJZPmJ7yXhnpPrhTkrCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 009/144] spi: atmel: fix controller deregistration
Date: Fri, 15 May 2026 17:47:15 +0200
Message-ID: <20260515154653.703173005@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9B67D55677E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 8d4de97e83520be89d0ff40610ca633b3963a7de upstream.

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 754ce4f29937 ("[PATCH] SPI: atmel_spi driver")
Cc: stable@vger.kernel.org	# 2.6.21
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-5-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-atmel.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1640,7 +1640,7 @@ static int atmel_spi_probe(struct platfo
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1672,8 +1672,12 @@ static void atmel_spi_remove(struct plat
 	struct spi_controller	*host = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	if (as->use_dma) {
 		atmel_spi_stop_dma(host);
@@ -1698,6 +1702,8 @@ static void atmel_spi_remove(struct plat
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static int atmel_spi_runtime_suspend(struct device *dev)



