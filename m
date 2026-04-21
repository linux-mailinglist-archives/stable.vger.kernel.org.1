Return-Path: <stable+bounces-240147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxiGoh052lE9AEAu9opvQ
	(envelope-from <stable+bounces-240147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:58:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61843B04C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC57F30457E2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299273D567C;
	Tue, 21 Apr 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyFIIbi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F83D16F9;
	Tue, 21 Apr 2026 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776287; cv=none; b=ddqUdRtuLLGwPlv1O5e8DrZpYdj3KgHUYIEJavT7cS1CMsK6UAMDxTB+qhLP6cZ6olICn4Y/sclL+QCpq8gqsXTjPQ/akdaZzucTOqCu5iH4lq+BaP8xnqVa65oL4bi+AbcnFQMU/RCoHHLktm8g5MtxlTrgGJvNg+RjdB3dEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776287; c=relaxed/simple;
	bh=w/01nej5krlUL3Rda8ubn7vqwoMF3KeBQaClTbmMBvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/UtrQEmYmNepUOKWtYmcJS5UvpGFpSOwN747hkOEr5iggp7FOgWhDMEIvMPzVaovWAgQd40ZWxR5IdGHiIILk+ywx7/fOqQ2OA2I82+HkvkOjRWjDC35OpZVJDoq/LJjkS/plL18GzxsUdmAhjOrJGA/IA1k3sTYX2mBbekNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyFIIbi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88450C2BCB0;
	Tue, 21 Apr 2026 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776287;
	bh=w/01nej5krlUL3Rda8ubn7vqwoMF3KeBQaClTbmMBvU=;
	h=From:To:Cc:Subject:Date:From;
	b=EyFIIbi6DGnjDXiAgJdkllIbqCWc69GvFp5mJWXhlwUjQtiS5oy8qe8c15L3mrCW+
	 ulEMZslkeQWfHVUdLPcE03nYzhjp+iDlnkQGuw5k7YwV+enFo3lazPPyK7V1cM/Fih
	 fn3eMCWkqfw/O5aUy5C7JsOkE29Y358MnZveLyXC/btfAq+m8B+rjylk+PR+51Clg0
	 XZDf1qKHZSUyg9835uNSdJcgsRx9IaPFYtkpxXkdI4jT7Ipn4SNIWIqV49nFcO/bk5
	 4M21rBcULk4Q/eMHlfqKp/jSmlHnolUx5QZBf76znJiW4gspZ3rtoQ/d5VJZWaX7lM
	 8KESAo3M5sp4A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAg1-00000006RwQ-0sSI;
	Tue, 21 Apr 2026 14:58:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] spi: mpc52xx: fix use-after-free on registration failure
Date: Tue, 21 Apr 2026 14:58:00 +0200
Message-ID: <20260421125800.1537361-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240147-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,secretlab.ca:email]
X-Rspamd-Queue-Id: CD61843B04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to disable and free the interrupts in case controller
registration fails to avoid a potential use-after-free and resource
leak.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
Cc: stable@vger.kernel.org	# 2.6.33
Cc: Grant Likely <grant.likely@secretlab.ca>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index c8c8e6bdf421..924d820448fb 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -498,6 +498,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
  err_register:
 	dev_err(&ms->host->dev, "initialization failed\n");
+	free_irq(ms->irq0, ms);
+	free_irq(ms->irq1, ms);
+	cancel_work_sync(&ms->work);
  err_gpio:
 	while (i-- > 0)
 		gpiod_put(ms->gpio_cs[i]);
-- 
2.52.0


