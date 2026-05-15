Return-Path: <stable+bounces-247511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGKGLtXaBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:35:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58254B684
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57D230A6420
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F03E4C6E;
	Fri, 15 May 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJazq903"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36573EB816
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833814; cv=none; b=ftS0b/ZdiWvCfPoxlr9VYwPnq039qDRreXz5zREfl3xiAo1Hv/07uffhJq7defOC5Dt3oyk/OENic65c9nnQNqXaNaerixYwgEyaF50TO03Q3e75Yy617Iy4eOFn7eO0J/WVPP/ZrjAzGPDExRlQv6c+49GLJhDP4dKOL6RT9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833814; c=relaxed/simple;
	bh=Nqt3HwaXJ/tWUP7PCdwqnIRugiWCNlIqccDmCzlzcH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z9ac7oSbkLD4KfQqezgrWmpYG+2gJnLw90gmHeoXhW9tyoMQG4VohxfNBw5/gcJQo9c1ghg4hBe70LEqH9dmJfdwlgwd3TKW5pdb/iMcDYD3HspayTP6V8CbxvJYDKHp7rbzSO+5X/uRKslFcmcuBFVCvjpfCWG+sDzSZEkT4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJazq903; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDDFC2BCB0;
	Fri, 15 May 2026 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833814;
	bh=Nqt3HwaXJ/tWUP7PCdwqnIRugiWCNlIqccDmCzlzcH8=;
	h=Subject:To:Cc:From:Date:From;
	b=wJazq903ygzVK3HtbhU85a0QEHoQ7whzaqMn4V/VIOxVzne9oSBBvOQl1EhySMSR1
	 fKHJZ93cLeNZNi1O9IqAXSAh+amLuPmdwsWH0kt3bchsf9tblOx4ut33HdL6zPxxnK
	 BdB8iZC/eGsm7nKyRNvoMAzn4qsPe/CcH1KSLVPQ=
Subject: FAILED: patch "[PATCH] spi: sh-msiof: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,geert+renesas@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:55 +0200
Message-ID: <2026051555-schilling-chaste-3ecd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E58254B684
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
	TAGGED_FROM(0.00)[bounces-247511-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 45170f67a08b912ead6ccc387ba06954d1d4e53a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051555-schilling-chaste-3ecd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45170f67a08b912ead6ccc387ba06954d1d4e53a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:43 +0200
Subject: [PATCH] spi: sh-msiof: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 1bd6363bc0c6 ("spi: sh-msiof: Use core message handling instead of spi-bitbang")
Cc: stable@vger.kernel.org	# 3.15
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-14-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7f3e08810560..f114b6313f4f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1289,9 +1289,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err2;
 	}
 
@@ -1309,8 +1309,14 @@ static void sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
+	spi_controller_get(p->ctlr);
+
+	spi_unregister_controller(p->ctlr);
+
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(p->ctlr);
 }
 
 static const struct platform_device_id spi_driver_ids[] = {


