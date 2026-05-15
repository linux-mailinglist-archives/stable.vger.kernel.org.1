Return-Path: <stable+bounces-248547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI52NOZXB2oozgIAu9opvQ
	(envelope-from <stable+bounces-248547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:29:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524155516A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D5983120238
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC530569C;
	Fri, 15 May 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DhPk7LR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693730566D;
	Fri, 15 May 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862010; cv=none; b=PkUk4UevP66RtHwRLVOlkHcSL7vYOCGXwZdtC4wLvoDXEFfr84rZIJAsZ6nLdC4zuVcjd6h4aWuOOCpkgOoOBohDsWuwrXlzw4ErrXFXx3zq4we7qd7UUJxSVOk/hpq2ifGnGwfirP+dgHrtywDZKkBlTLM5TwGvzrAZ2K6bnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862010; c=relaxed/simple;
	bh=HlxLkh4hnDdRQY1p8MMWi88o09RQblPseD+Es/Kg7fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjPWPxJuSVqz4A6uUsr9b2PD4j9rGRucOEia1y+XkDDZxMQMpmXhTMGmg/ghvv/QlXNgpl/DzLNLFh9gxG6cVQinapB64zcSKYRPNajZifexqXHtlhReKpZvXVRRn3iP+PLu1pluhw1zHeaarJFfvsaMzDBjKUf/yBy62D3c5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DhPk7LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC2BCB0;
	Fri, 15 May 2026 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862010;
	bh=HlxLkh4hnDdRQY1p8MMWi88o09RQblPseD+Es/Kg7fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0DhPk7LRTTSMtVYTsUE+HVCX92lT0PLOj0iCItJFSwpxD1zfkleb776GrR0DA72M9
	 XufjoT+u2HYIDARMlckYxpwlc095ME1AeyIjxop9dm78sjBZFEc8vrZCPbXPcHd6D+
	 Bt8+mvKWRVlHv5eAvuMsO2shoEZDExDlfaHqZAO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 074/188] spi: fsl: fix controller deregistration
Date: Fri, 15 May 2026 17:48:11 +0200
Message-ID: <20260515154658.923416948@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3524155516A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248547-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9b7abfed4c3754062d1f3ffd452e65a38667f586 upstream.

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 4178b6b1b595 ("spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup")
Cc: stable@vger.kernel.org	# 4.3
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410064749.496888-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-spi.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_pr
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_probe;
 
@@ -705,7 +705,13 @@ static void of_fsl_spi_remove(struct pla
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -751,7 +757,13 @@ static void plat_mpc8xxx_spi_remove(stru
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");



