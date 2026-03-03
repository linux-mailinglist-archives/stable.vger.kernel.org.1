Return-Path: <stable+bounces-222858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IASIHMnNpmntWQAAu9opvQ
	(envelope-from <stable+bounces-222858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:02:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AAF1EEE28
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A1631E9EF9
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D433449EC4;
	Tue,  3 Mar 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaW/HJOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D344266AE;
	Tue,  3 Mar 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537072; cv=none; b=qoBExjQq3qzhime8k+iU6OFUJf9vbpsjYa4XdDVWtX6NEv13lA9nI0Mgd0oPwJeH1tSkTDFmZjp6Cw2pt6GJ0GmJ/f8+1zh10UUEZwGCf/8cfmvfVlppZH2slb/qmYntlDh0vmZXXBdqt7DIsmHGlRO4wArA7nqNvixr8bFuTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537072; c=relaxed/simple;
	bh=pMMiu99TNrwY1z//uGbZky2NfxAc1NletcO6hCwNjTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkTl+ZCaeehPGZYdCBl1COAQ3lnLZYNNiTWRh6EsQNDHSjaPfdUyikD8DdsKw6mOPKgz/cx3mJlzuLo1EYBb2J8XW2YhJlb2sPJe/XZ6rmXfCb2rqomovcZL5iJBhNgb0BtC0zXSQJ2tmAmwoFf0hIxeDf3dvhVciYlfrsus2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaW/HJOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DC2C116C6;
	Tue,  3 Mar 2026 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772537071;
	bh=pMMiu99TNrwY1z//uGbZky2NfxAc1NletcO6hCwNjTU=;
	h=From:To:Cc:Subject:Date:From;
	b=BaW/HJOAID9pJeLh1LWVMlEj9XhIWwnWYRD8qsFI7bamyFpz7wxNKt9h1CmKeAOfP
	 WrkxUS3l/R+TqE6SpZEYdv1wJPy4AzaBp7iEloT7U8xPc9sS9ElsRS0yPLfzZh/OmF
	 4lWtbnYvwLoblbk6GYs53UNk36Y8b8BQv3D4QNtNWfxPPSjyPDb/axk1hJRgtY4FlL
	 wsedRG3A3QogdklUSsQjvhBP7GNsYClJpRWLKg085re8mHq0xTAcx3CEgAk/i7GLMk
	 X2ZOth1FZcjDjJPIKwowkjcQsOFW++bR+WCWeZrHeHko0xxeGOXySAmBGQ5jPd71x2
	 G414qZPgL+cQQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] firmware: microchip: fail auto-update probe if no flash found
Date: Tue,  3 Mar 2026 11:24:06 +0000
Message-ID: <20260303-emphatic-roundness-8fe5cd8c3159@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XscQ8ymkf4EFPKmo5acF1NOwZBJtkSmMiuGUtgB65Gs=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnLjlzvd7y0OMG+pi3+cL7v+tqWzXIPJP5qGDyY9O7JZ EvO9RP2dZSyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiuzUY/pcsK+iac1PzzTul fKfzJsec0su2qVzU5L/ykydu1ubegiZGhh8nOubtOfDLYs21oAOC/s4sP3Mjzh3rWdPooJ6pZKG XyAcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7AAF1EEE28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222858-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

From: Conor Dooley <conor.dooley@microchip.com>

There's no point letting the driver probe if there is no flash, as
trying to do a firmware upload will fail. Move the code that attempts
to get the flash from firmware upload to probe, and let it emit a
message to users stating why auto-update is not supported.
The code currently could have a problem if there's a flash in
devicetree, but the system controller driver fails to get a pointer to
it from the mtd subsystem, which will cause
mpfs_sys_controller_get_flash() to return an error. Check for errors and
null, instead of just null, in the new clause.

CC: stable@vger.kernel.org
Fixes: ec5b0f1193ad4 ("firmware: microchip: add PolarFire SoC Auto Update support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Valentina.FernandezAlanis@microchip.com
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 drivers/firmware/microchip/mpfs-auto-update.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 46b19d803446e..05ac82f1498b3 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -113,10 +113,6 @@ static enum fw_upload_err mpfs_auto_update_prepare(struct fw_upload *fw_uploader
 	 * be added here.
 	 */
 
-	priv->flash = mpfs_sys_controller_get_flash(priv->sys_controller);
-	if (!priv->flash)
-		return FW_UPLOAD_ERR_HW_ERROR;
-
 	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
 
 	/*
@@ -427,6 +423,11 @@ static int mpfs_auto_update_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->sys_controller),
 				     "Could not register as a sub device of the system controller\n");
 
+	priv->flash = mpfs_sys_controller_get_flash(priv->sys_controller);
+	if (IS_ERR_OR_NULL(priv->flash))
+		return dev_err_probe(dev, -ENODEV,
+				     "No flash connected to the system controller, auto-update not supported\n");
+
 	priv->dev = dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
2.51.0


