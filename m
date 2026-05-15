Return-Path: <stable+bounces-247350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB+MG/euBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:28:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1154989A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D405E3023072
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E03358C2;
	Fri, 15 May 2026 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSJEGlan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D83033FC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822899; cv=none; b=cSvhhvNRcT2rQhkElcrKWfmeePPg0bIJgE3/qPq2y0p+NlVtlz37wYnfHj+/kiHcYJK87FUmGobX24ICis/9P/4V5m3JUXmlmdNlg+hlx191ozXRyoQYKxmRx8xj3tgawA04zifPOA6SXQgrtzWkT7KOlrgAPJVWq958q67br3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822899; c=relaxed/simple;
	bh=rzOTTK4u6GrpMqLShH239LLy4K6LlldfPoKpQOnmDeg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SJCF+Nfuc0bU/2hvsVzkou3l6Wm4jUJp9K4sSikTtJY/gvlo7eMyM1+FvekT912XMxTfCRquGfKH2dPM7RZXvl5SXBRp17JYQ15uvRwohr8Tq6Y5SGqt9qaoT6OBxudtRhpJqIYqUTTXS9D9EjfQA9gcSWL4hlW4ZkAgluSKiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSJEGlan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8864EC2BCB0;
	Fri, 15 May 2026 05:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778822898;
	bh=rzOTTK4u6GrpMqLShH239LLy4K6LlldfPoKpQOnmDeg=;
	h=Subject:To:Cc:From:Date:From;
	b=tSJEGlanGp3v155gmZfrC7+jAJ1O45jywmneRCM+SRRYv07CRFUJrmhhFaV168Tek
	 j74ZiPULB+cheUWeEaLR3ETQvs+XozcJTf4PLdtPzLXB/XXIwMh8uS5DoHSORSkYAQ
	 SDGuwe11XxjvC0932jj7DmydYU47jVkg/OCCJGOM=
Subject: FAILED: patch "[PATCH] spi: atmel: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:28:16 +0200
Message-ID: <2026051516-reopen-penny-d698@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECA1154989A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247350-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8d4de97e83520be89d0ff40610ca633b3963a7de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051516-reopen-penny-d698@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d4de97e83520be89d0ff40610ca633b3963a7de Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:03 +0200
Subject: [PATCH] spi: atmel: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 754ce4f29937 ("[PATCH] SPI: atmel_spi driver")
Cc: stable@vger.kernel.org	# 2.6.21
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-5-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 445d645585bf..42db85d7ff8e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1654,7 +1654,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1688,8 +1688,12 @@ static void atmel_spi_remove(struct platform_device *pdev)
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
@@ -1716,6 +1720,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static int atmel_spi_runtime_suspend(struct device *dev)


