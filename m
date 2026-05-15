Return-Path: <stable+bounces-247507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIIPBy3aBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5F54B57A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03B3A3022BA1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4913E9F98;
	Fri, 15 May 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kLnS+/01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D63DFC60
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833803; cv=none; b=jeT+2VkMvAl5twq1kfRN+CXN1bd6tM5B+4ZhZy9KS6lxHifoQq2cdG5GaufTA9t07w4RB0ubYp9iiKVPt4O46HDvjwMiFqum/HIBO3EMLVnuQ4k6UtQ9I8Zucb6XJAl+7XzND469chiGz4QezubJmHWC+kcofzOjFU8XJ/HQoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833803; c=relaxed/simple;
	bh=Irntxvmmun6MIiMOgBUuTf+BXsPYbFPEga66CHHqqa4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jsv600mg9tpb96DPwCwps5TZnZKyKT9I39WIzSyEGDE7BhED6rJp91ZpEGq7+4cqtW4FoylNPPPzsxuAVUbGRL6tYHNTNVxXtqidlOOl1WYSjPJNN+2zriZ822hQ56Jaa33GNqZCiAsWL4fTpNXJ5mq4+IXo52C4NG+oUj8vDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kLnS+/01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB7EC2BCB8;
	Fri, 15 May 2026 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833803;
	bh=Irntxvmmun6MIiMOgBUuTf+BXsPYbFPEga66CHHqqa4=;
	h=Subject:To:Cc:From:Date:From;
	b=kLnS+/01EZvpFpTmhb6kEi32GDwUv/KqH1JQGzrP/OLFiYB/3BR/cwBxJVn/18KGk
	 A4mBG8JNGJoUeV6ULPO/5uDajtfYV87L7dt6p+Sz0EcriM4HBDg1uBr0St31IFNTPr
	 yY7WFrQQUmeGV4P18sBO8TTpY3KZDHotkG6fLE4I=
Subject: FAILED: patch "[PATCH] spi: sprd: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,lanqing.liu@spreadtrum.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:34 +0200
Message-ID: <2026051534-resale-vanity-d4b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CB5F54B57A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247507-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,spreadtrum.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 123d17dbc5f07059752fa5e616385ca29a8f935a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051534-resale-vanity-d4b8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 123d17dbc5f07059752fa5e616385ca29a8f935a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:46 +0200
Subject: [PATCH] spi: sprd: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Note that the controller is suspended before disabling and releasing
resources since commit de082d866cce ("spi: sprd: Add the SPI irq
function for the SPI DMA mode") which avoids issues like unclocked
accesses but prevents SPI device drivers from doing I/O during
deregistration.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Cc: stable@vger.kernel.org	# 4.20
Cc: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-17-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 0f9fc320363c..fd3fd0ce122c 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -977,7 +977,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		goto err_rpm_put;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, sctlr);
+	ret = spi_register_controller(sctlr);
 	if (ret)
 		goto err_rpm_put;
 
@@ -1008,7 +1008,9 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 
-	spi_controller_suspend(sctlr);
+	spi_controller_get(sctlr);
+
+	spi_unregister_controller(sctlr);
 
 	if (ret >= 0) {
 		if (ss->dma.enable)
@@ -1017,6 +1019,8 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(sctlr);
 }
 
 static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)


