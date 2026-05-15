Return-Path: <stable+bounces-247484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIYaH3nZBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:29:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235F54B4A8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65B5E3026378
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A903FE647;
	Fri, 15 May 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="un2GlUUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181E3FAE07
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833736; cv=none; b=XaiI2qgB5J6HxJdMGIZpHdY9LGT7ntGyvU4uWSexvgPM8ddF+6djUpOEv3CpgVzLm0PawCALFWWq7/8QaFk1xnhAhwpot/1X0xekOCmW1iDoWuOQz0PTcVQ6ZDApVsYLLCqXx6g8XgRW6KqV5nfgcSoY0T2ruqgwuBwyBuEObQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833736; c=relaxed/simple;
	bh=StsJI519oJ30ghWRHBox3Ln505nKsxrKCKgpFR455ts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S+zmqeG2FVuvIHpmwVNW7qYHs+tJHJAMJMPPuKkEG7Fok8n4yJCmh5OUh9l0rKuiIQCskoo10Codiv96KuZ0kBfCvAyL9Fw+JlRu+nUqKi6FCsLZxwUlSjrjQ6GLDp4SISNCbCpKqB+FWlxcMw2G+vhuCy89zytm1+42hX635Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=un2GlUUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C8FC2BCB0;
	Fri, 15 May 2026 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833735;
	bh=StsJI519oJ30ghWRHBox3Ln505nKsxrKCKgpFR455ts=;
	h=Subject:To:Cc:From:Date:From;
	b=un2GlUUM+igT6s7then7egUm5855RoMUN0h+z4KXlgdys8029SsIHbtDdcworbbwN
	 D6/wOKDbmImYCEdA3XDJKkZwb5Fpydt13EWQRTQ8yR0bH/aSjCO+gKudlH2egy9zc9
	 fsuDLTeOyNOLRrd+A/emNIeH5dq3fCWpGHi3FkhU=
Subject: FAILED: patch "[PATCH] spi: bcm63xx-hsspi: fix controller deregistration" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org,jonas.gorski@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:28:32 +0200
Message-ID: <2026051532-virus-chevy-4583@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9235F54B4A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247484-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ab837c51899d7595c1165a45dfb631facad49461
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051532-virus-chevy-4583@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab837c51899d7595c1165a45dfb631facad49461 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:05 +0200
Subject: [PATCH] spi: bcm63xx-hsspi: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind to allow SPI drivers to
do I/O during deregistration.

Note that clocks were also disabled before the recent commit
e532e21a246d ("spi: bcm63xx-hsspi: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 7d255695804f ("spi/bcm63xx-hsspi: use devm_register_master()")
Cc: stable@vger.kernel.org	# 3.14
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-7-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 266eabd3715b..e935e8ab9cfd 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -857,7 +857,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -880,9 +880,15 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP


