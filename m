Return-Path: <stable+bounces-240183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFXuEXKN52m89wEAu9opvQ
	(envelope-from <stable+bounces-240183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:45:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE043C3EA
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 706A83067C93
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C13D8916;
	Tue, 21 Apr 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQmrcFGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FC212D7C;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782380; cv=none; b=SnBkukDUOsgzQGzy+Iq0RXxvTVTJNR1VlNugdIcc+6iWmXI2ZhVqS9Fxu8LsDDOFfvP+nv64IRH1y0K468quMaQmnZrm+mQ6h5C1dAOl5ymHm5R2QkntYstzKYOeP6mSH14EI6Kxs0m21n5vc6ix9XSbsHCAdt2r2l7MI7tjxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782380; c=relaxed/simple;
	bh=3kXk5bQkW8ZHGa/eebV3Ad1vkWgg5LsbbMFNDeYGrqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jENvi2QAhdKzrT4xkd0SQspDz2Wy7cfxBNM5DORidcRCDjZdYLj1/x4/4dEMGN8dLIbAYTE8xI3xysS90g7jPsHbLSZ3J04P9nJ20Fl3/OhdlLMrB/0ZRQuqYHKsYhvCcwMuyXw8bHDT2I8cV+F2yBW9X9S4NzaRg2pRnObjkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQmrcFGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827DFC2BCB8;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782380;
	bh=3kXk5bQkW8ZHGa/eebV3Ad1vkWgg5LsbbMFNDeYGrqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQmrcFGqba/gRMjzSuJUmMSbmnseBFA+7JJIYzs2ebjyiSDhiq8LhuG5Emc7z3efE
	 3ECCK9bPY2UjDKpAryp+S36X3BL40Jb4KJlZIre34myzg37dO6tMxVIHfxU4frn9WX
	 GmOfOwNOtaWe19nMVDnF30w/A09LC9vTGNbWGu/kYgIUSQydRmj3qNnil/bXqntLbT
	 PHC/WR9q1DRKmkVnkTnipXc1jsHLxEWJNHvrj4JFPfyYt+ifC61AfkgT30YiJWbror
	 8sG7AEadsWgTgBRPgsJHZuAL72aGOfqVqBmrcLrLm3wSfuGiTSVL89uhZkj06ae6R5
	 SkB8PvToWRFyw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFCGI-00000006VhG-19tL;
	Tue, 21 Apr 2026 16:39:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] spi: axiado: fix runtime pm imbalance on probe failure
Date: Tue, 21 Apr 2026 16:39:23 +0200
Message-ID: <20260421143925.1551781-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421143925.1551781-1-johan@kernel.org>
References: <20260421143925.1551781-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240183-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9BCE043C3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/spi/spi-axiado.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

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
-- 
2.52.0


