Return-Path: <stable+bounces-247552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MNnKMnbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:39:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4154B82B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D313082B30
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996240245C;
	Fri, 15 May 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qT95YR9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C383402450
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833957; cv=none; b=AGOcRIaZjG1SRReaCCOSe0jgUzg1sMhDzJ7rCA7rOq/nGK7yjkSxv+QSnyoIbLdUY45t2d7WEceNX8JD45Ma2uHtXkRY9SKtn6p2zqRzjL/IisxF6nJCr1KLixJlhrbOh9kV5He8eqk3PSPXfY4p8eXC8aiW1UQIKymigEBPiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833957; c=relaxed/simple;
	bh=l4nJhBQEriH37jSl/1UAfBzAh5HC1vK8AEv1as57p34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nhIX/FxKOhVY/Zhywd7eMXpVytkaYH2NixUhyByuiW/IICVT9W9ZAJ2l2gYjqIu8kQ+8vWqE3hIe4wFAJYSk39abWWjoq4b6BmudNMIGqKczjT8MUNHi4Az+eUm8JctVO5Idy9qGOJGy2uL8oV43FfOjy9eu/zJ43PJU8mpW2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qT95YR9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92A8C2BCB0;
	Fri, 15 May 2026 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833957;
	bh=l4nJhBQEriH37jSl/1UAfBzAh5HC1vK8AEv1as57p34=;
	h=Subject:To:Cc:From:Date:From;
	b=qT95YR9xFYv9lhFQNCwzN6oAO8fTpkDoMrJYbmSyozzqJnVCATOePl1Zj3qOQVdLu
	 QIqFrW/ABwp7JPvTrFawTvjRqC4HCRRPeg5h817H7yYKf9MrdgwXfth/RaweI0h30J
	 fo9drUnS8glG5uR24E2oL0v9SQQjG7N9CXTQN0xw=
Subject: FAILED: patch "[PATCH] spi: axiado: fix runtime pm imbalance on probe failure" failed to apply to 7.0-stable tree
To: johan@kernel.org,broonie@kernel.org,vmoravcevic@axiado.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:32:41 +0200
Message-ID: <2026051541-scotch-province-f205@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BC4154B82B
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
	TAGGED_FROM(0.00)[bounces-247552-lists,stable=lfdr.de];
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
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,axiado.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x cde1a784e4d55068d8dd7ee9bf4794898a2ac410
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051541-scotch-province-f205@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cde1a784e4d55068d8dd7ee9bf4794898a2ac410 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 16:39:23 +0200
Subject: [PATCH] spi: axiado: fix runtime pm imbalance on probe failure

Make sure that the controller is active before disabling clocks on late
probe failure and on driver unbind to avoid a clock disable imbalance.

Also make sure that the usage count is balanced on probe failure (e.g.
probe deferral) so that the controller can be suspended when a driver is
later bound.

Note that the runtime PM state can only be set when runtime PM is
disabled.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Cc: stable@vger.kernel.org	# 7.0
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421143925.1551781-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index dc55c55ae63c..6449b376a3a8 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -842,8 +842,6 @@ static int ax_spi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	ctlr->mem_ops = &ax_spi_mem_ops;
 
 	ret = spi_register_controller(ctlr);
@@ -852,11 +850,16 @@ static int ax_spi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return ret;
 
 clk_dis_all:
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
@@ -877,10 +880,14 @@ static void ax_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	spi_unregister_controller(ctlr);
 
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);


