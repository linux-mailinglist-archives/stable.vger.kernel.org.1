Return-Path: <stable+bounces-247994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK6bOfhHB2qrwQIAu9opvQ
	(envelope-from <stable+bounces-247994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C155311B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63363059DBE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77B305689;
	Fri, 15 May 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JBSK8otE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0E305668;
	Fri, 15 May 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860596; cv=none; b=EdRY+8t6vvPS5Yx/5sSd4y54kbQJmG7iXYDkFQfxdjhD7TTHBTqAcrNlus46Sdakx+/YFCDYcnCFzpjHzwieV86WUbstiWGS2jXvyQNAx3kfNSJjlzTD86CCXyYTH8ud4KBrmv7d6ClE5Zjsb9qHBuX8tbSMTlg0y+e0nJwQP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860596; c=relaxed/simple;
	bh=ie57Zuy3mdIWHJYKa8JBGMa/dEfXLcCCq4tntZ4MyQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqJ54NT9nZjFfnShfb1aK+u5jCkMBBNR8ZMPcvnYPasYqq6dns2jdgJoTV/pbLDEsdHPWdHdVspajikRDUnWaCv19gwf8VevpTTbA+97Ps2rJybwYC9xqOb/CP55szqcym/zcpnYoV9XHp3yQNHdmdkzmlAFPfgEXrdKmDdztMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JBSK8otE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CFAC2BCB0;
	Fri, 15 May 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860595;
	bh=ie57Zuy3mdIWHJYKa8JBGMa/dEfXLcCCq4tntZ4MyQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBSK8otESyfaop0TmYrCIGtz3jbYibbnvAathSMUkLWbGP43cdEU4F3MTKVfoUT7L
	 L3cxfzTjTzuuzB4nV/2wCUQKAn9IOLtLXNLHm7PA4/LUqlJHuMp+aZjMtMtOr0dn7j
	 83XDuy3cKgG6lSyaedmOs8mrOnfG5ILkvs+RV93A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingoo Han <jg1.han@samsung.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 112/144] spi: tegra20-sflash: fix controller deregistration
Date: Fri, 15 May 2026 17:48:58 +0200
Message-ID: <20260515154656.087550612@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EB5C155311B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247994-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ad7310e983327f939dd6c4e801eab13238992572 ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: f12f7318c44a ("spi: tegra20-sflash: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-23-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kept the redundant `host->dev.of_node = pdev->dev.of_node;` line above the registration call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-tegra20-sflash.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -506,7 +506,7 @@ static int tegra_sflash_probe(struct pla
 	pm_runtime_put(&pdev->dev);
 
 	host->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_pm_disable;
@@ -529,11 +529,17 @@ static void tegra_sflash_remove(struct p
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	free_irq(tsd->irq, tsd);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP



