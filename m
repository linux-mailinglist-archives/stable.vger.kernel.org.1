Return-Path: <stable+bounces-248560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZwGCBNB2rJxQIAu9opvQ
	(envelope-from <stable+bounces-248560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 043FD553CAB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A3BF3021F53
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A423E00B6;
	Fri, 15 May 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9y8PcQn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE43E00A8;
	Fri, 15 May 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862043; cv=none; b=ski222RyKdIb0dSjSsOw0ZdscRH6Rg7B0b9Vwh6zk/pNQ6LrZYIa8tFNY0tmS3zkCfhbZiWOJMaz4GVcH8UmBIdX9O9k+whS335HQNwmzZthdZdeI3hR/jWZPcI9DqyjWKtvJFc0YTZX/rFM51HOreNBuZmpP1oTdqmKEQpPQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862043; c=relaxed/simple;
	bh=XqQHtz84Bf30w629F42AD5OlnVIBLTWoQ5KTPfHUqFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXvj1eWqRCpXJ0+BfgoHJVkT2ApEqj5kLCfryFgqgjLlnXkQPC3jBsPdz6WOPmQyDSvGODxWaTOoMbkfhvxfmxTbZd5aSDBtysCER0JlCJ84nkFS4+B+/oVl/GfhQseYb7f0OQ1d7Wk8DbqLXNRrDrCnAoZjSB2lH/6cypmB/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9y8PcQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E59C2BCB0;
	Fri, 15 May 2026 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862043;
	bh=XqQHtz84Bf30w629F42AD5OlnVIBLTWoQ5KTPfHUqFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9y8PcQnUwsOaN7BzHkKXfrj8IFx/aA/T5DvEOQNh7NiZ+eDMSy+Tk/CxcwuFGa33
	 T0ojco0ntxAvnauZ0BJybSAiY+oazVbmuf6VoRuFCgxZCkFNFJGcYlM5HwK3spcwMR
	 QuplWs7McDOJ0OF6SstrmxwS3XdF2G2tJTDsSpmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 086/188] spi: imx: fix runtime pm leak on probe deferral
Date: Fri, 15 May 2026 17:48:23 +0200
Message-ID: <20260515154659.191137565@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 043FD553CAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248560-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit a1d50a37d3b1df84f536a982f692371039df4a48 upstream.

Make sure to balance the runtime PM usage count before returning on
probe failure (e.g. probe deferral) so that the controller can be
suspended when a driver is later bound.

Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
Cc: stable@vger.kernel.org	# 5.10
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125632.1537235-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-imx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1948,6 +1948,7 @@ out_register_controller:
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);



