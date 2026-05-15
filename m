Return-Path: <stable+bounces-247882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLlICQxFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-247882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B4552BAE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFE91306EA1A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85343FF1DA;
	Fri, 15 May 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2vw0Vad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04D3FF1CD;
	Fri, 15 May 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860314; cv=none; b=nbBEj9Gk+EhRDu7yv3qBhlE+FgDmgJgjQ/Xjr0wVWfQ00JyKfZbLfZMXc9pznxkz7g2huWlbbhw0jwh2Wa7BlNiuM9y5ISFAPciF1WsQIoGZAU+mh1Sr5wjHRqIxpC3aXb+44okfnzzI635gI5gm22qab8Cf9SlEYz9hPzKSK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860314; c=relaxed/simple;
	bh=SZYq78d3DE//C5eO1IqTkG8ITkWDd7XtP09JTy8PVJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lekfYCpMLtgsR2cmMj9mvx3cpAyKbTkEgmyBsDcNKrvqqHdjIiw8DkA29ljmvwsTKjKfu0nqLR710Y4btLdC31uerTmzzfsvFywfrKymIWm8sA25AfJgassKSK6hDqQfBMNxdtKE0uzYujcJbMwWlbnjr5+oyvtvLqp/qOqMf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2vw0Vad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B4C2BCB0;
	Fri, 15 May 2026 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860314;
	bh=SZYq78d3DE//C5eO1IqTkG8ITkWDd7XtP09JTy8PVJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2vw0Vad2LUkmXc55sfdsBhMWQSiB7anHkIApGhE1hWNUtP7b2vEHjYIOYzZNB12f
	 Z05YkPkCSTUfJ9oz0X4qzqv+nl+a3VG2+rd4scDU+97SOGTbGD+UjjdaRVy/lsTDeO
	 h8bjTdwHcpHT5hGSsvMu9dfqdsMcMuHmb4rcv2tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 041/144] spi: fsl-espi: fix controller deregistration
Date: Fri, 15 May 2026 17:47:47 +0200
Message-ID: <20260515154654.477986855@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 039B4552BAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247882-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit e506a700a7ad229f5c8f01f4b8350119cccb4158 upstream.

Make sure to deregister the controller before disabling runtime PM
(which can leave the controller disabled) to allow SPI device drivers to
do I/O during deregistration.

Fixes: e9abb4db8d10 ("spi: fsl-espi: add runtime PM")
Cc: stable@vger.kernel.org	# 4.3
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-14-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-espi.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -720,7 +720,7 @@ static int fsl_espi_probe(struct device
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_pm;
 
@@ -785,7 +785,15 @@ static int of_fsl_espi_probe(struct plat
 
 static void of_fsl_espi_remove(struct platform_device *dev)
 {
+	struct spi_controller *host = platform_get_drvdata(dev);
+
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&dev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP



