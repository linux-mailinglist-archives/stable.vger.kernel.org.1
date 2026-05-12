Return-Path: <stable+bounces-245414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGtEL33bAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:49:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6651C29C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C090300FC38
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF847DF82;
	Tue, 12 May 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceQ1t0th"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD410D08;
	Tue, 12 May 2026 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572141; cv=none; b=Ef1l/+oVDxOHDVJPF0Eot3HnmpjjMRXXKARFMYbBpR4qIjkqpeL8SaO70evo+pKNYwzylBgLKKWuInkOvWM9VFcBXR2/dmS30iNbVjitW7DN/0JueyIBqArgVTWtEgo5m4+ryjlgwtSWqD7E2S89d0NGG9/TA6u61Lmkysw8MSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572141; c=relaxed/simple;
	bh=C7+2tlfJt+/60Cg5T2oLZMZSQjrjNWEbEFuBQH9/ZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qo1boKC7CM77zqg5SkIU/YMp2qhMTfZ76QzWy/DnKduzC10pktEkkwuw8SAsfMR9EaRhVcSXjADhkJUh95qkA6/Hbt5L7EciM/T3liww4JOsz9lQvdX3xG7pvbGpsh/avgnQw9+J8gBfEKxp9a66qFMHj8wxVQDqExRegmoFm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceQ1t0th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFDC2BCB8;
	Tue, 12 May 2026 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572141;
	bh=C7+2tlfJt+/60Cg5T2oLZMZSQjrjNWEbEFuBQH9/ZBI=;
	h=From:To:Cc:Subject:Date:From;
	b=ceQ1t0tha2wzT/2FtJ+na72a9e0WSaA5g0kh81LEe3Kr+OJ1AMfSexegLUyUPpvlk
	 xxyULB7rUfTPrBvnELy2q5TfIloV0r4uHB7H0pUn6XyDweyO7QFruUgTQTpvpTnz/F
	 S3vSQUbpgzsuJHAjC01JGWBJBKVGEtzy1pG1LYjP5ZFdQSeroLHwIvGIfLBYwBLzaM
	 XpNJrSz84oeZQo54M13Gnhq7s0iutyLlGQwhI/rrY/70UPOHk+5eJCkKOvKgsp3oLX
	 dbstAmTQsA+WoiHCs2cS9IR7YqbOAFH47DEt7DjbBafo4ibpGo90nRNqM+yau8eStP
	 poQzGy5s758Ng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMhrO-00000003q4e-33xq;
	Tue, 12 May 2026 09:48:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH] spi: ep93xx: fix error pointer deref after DMA setup failure
Date: Tue, 12 May 2026 09:48:49 +0200
Message-ID: <20260512074849.915143-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBA6651C29C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245414-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,maquefel.me:email,sashiko.dev:url]
X-Rspamd-Action: no action

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer on later probe errors or driver
unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: e79e7c2df627 ("spi: ep93xx: add DT support for Cirrus EP93xx")
Link: https://sashiko.dev/#/patchset/20260429091333.165363-1-johan%40kernel.org?part=10
Cc: stable@vger.kernel.org	# 6.12
Cc: Nikita Shubin <nikita.shubin@maquefel.me>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index db50018050e5..f716c9607be4 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -582,12 +582,14 @@ static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 	espi->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(espi->dma_rx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx DMA setup failed");
+		espi->dma_rx = NULL;
 		goto fail_free_page;
 	}
 
 	espi->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(espi->dma_tx)) {
 		ret = dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx DMA setup failed");
+		espi->dma_tx = NULL;
 		goto fail_release_rx;
 	}
 
-- 
2.53.0


