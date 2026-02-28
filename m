Return-Path: <stable+bounces-220188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M45HqIto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6F1C5595
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81CF530F729C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295234C6F09;
	Sat, 28 Feb 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzLjjhkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F14C6EFE;
	Sat, 28 Feb 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300094; cv=none; b=KssFmOJE1I1+mLqSSS4uExPFW4eSnUTBph2zzNwfAlNeCJVMsS8xlRoqvowO6tpJ4OJLYWznxoXyfsUvhinyiuduJdX0E9F+cOS6fFggRh6wNciw/z6vTY8aBvvwZOBoGfJielhuPvOk7u4VHD/NfkVEM8lYO5uNYLxsC9YEA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300094; c=relaxed/simple;
	bh=qBb3984FcUVkn6ObiM6blPgcfp4SWEUhlMD4uB277ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VotNrJZqjr+zsio2P7dRfUErH8ClA8NkxbjXFytHcoKGcGK8hvJ67hX6mFUWiotlFcPhiYIKAiwLKR2YSGmZd9EqZkWiwVWZyGp5wn2ZJtvCMfZWpvZFhB77xNcj8c5GLG3Rm7FU17OiMJUueFDaaN70p7rGqBwqfrMB2cbmmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzLjjhkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C95C19425;
	Sat, 28 Feb 2026 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300094;
	bh=qBb3984FcUVkn6ObiM6blPgcfp4SWEUhlMD4uB277ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzLjjhkTVIkurwRXqePBbIKwuU7JolT+rdxIRW9Ho4/DQQ/dPhRZjFh2RJlKnE4IU
	 lnCuWOkFO/pyu2jURgHpEe3v/k3SHSoiGvP3EbPrlyIW+aqXjOozOm5M2NYrurXVGF
	 iuNPiM6D34IKiGuZVk6QZFRL9ImFU9fLjFOlgvRFMTjk9VssHfdHzqquqJnxYIj2q1
	 VtkG8SCz+wXXCS9m8bcuDpH/GokyNfgBh3f3qwhTABf/3Msw7q9Wc+ZsEgcZgaaIsy
	 Q8jYMB2Aj1QrwaqX6EHsCMbYetC87cwpJpd7e8bnmEIAqdnQMDIAq7KwI3QhRhRc+i
	 JRVi8oW/ACI1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 110/844] char: tpm: cr50: Remove IRQF_ONESHOT
Date: Sat, 28 Feb 2026 12:20:23 -0500
Message-ID: <20260228173244.1509663-111-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220188-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email]
X-Rspamd-Queue-Id: 19E6F1C5595
X-Rspamd-Action: no action

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 1affd29ffbd50125a5492c6be1dbb1f04be18d4f ]

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-10-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index fc6891a0b6936..b48cacacc0664 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 
 	if (client->irq > 0) {
 		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
-				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				      IRQF_NO_AUTOEN,
+				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
 		if (rc < 0) {
 			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index f4937280e9406..32920b4cecfb4 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
 	if (spi->irq > 0) {
 		ret = devm_request_irq(&spi->dev, spi->irq,
 				       cr50_spi_irq_handler,
-				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       IRQF_TRIGGER_RISING,
 				       "cr50_spi", cr50_phy);
 		if (ret < 0) {
 			if (ret == -EPROBE_DEFER)
-- 
2.51.0


