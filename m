Return-Path: <stable+bounces-245413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCmMK9LbAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4351C2F6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E3A3054CED
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C7F44D6BD;
	Tue, 12 May 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh+GcIeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921D3783AD;
	Tue, 12 May 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572098; cv=none; b=ivkcyKNtf00eWgmUEBxiwqaYbc49nCNqMSZj5BWRsWcAnYmpWeaGusviFFEQywzjz2u9gsBehYdUsOUQZhh819eXGMJ/CnnUuRvRCKHGYDkkL+om6bj33U8gzs+jL3F13uCgh5fkQNZ90dwfIpx66KPaiokmalLsNrdR0oYBdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572098; c=relaxed/simple;
	bh=5d10jHFNoRwlTZg99h2WhprNTtPVoYiBTiPJuqNfj1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/OZrEvuxQ3r2QSEyEhaET7JqPumL3AqAYNOzD1jBNkGbEbn7kRfDoyxGSPoYlzat6tyvfGcS6cX6cDhe24VnmABjIOGOZUOuYbySMp/zsSmhhM6C+lxUiNgubd8Sb1JubCRo2n7RtbNaoee7wYzlB8w5yLzd21G3kJ+WJHva3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh+GcIeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA8C2BCB0;
	Tue, 12 May 2026 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572098;
	bh=5d10jHFNoRwlTZg99h2WhprNTtPVoYiBTiPJuqNfj1k=;
	h=From:To:Cc:Subject:Date:From;
	b=Fh+GcIeJwxMCosNquiM/YWMNitZh9WNHs3JeOWVr/nAwLyWjPT4l9cwi6viQ7RXc4
	 bv+n1UqwmLeq5/jdfXTrk2uQj4W+T+14gjWmB1HelIxkv1yRWtaWpWzO/7F5UjEjI2
	 yKAuSxCjUHEgfZHqapVfs1tfhm5JY5ZL2daiRPrlV0VSwU2NNB27WQiRSzlZ7txBnk
	 rWr6lQrgaxGceHCaqV5Hx/SfG1KuwAqV5vlXOMe3K0oJRAeuorapsGXU/RV706Att1
	 O4GvrDeCIa2Zuo5TZxntZawtSERD1e1ANNklpHB0X1xK+yk3REQoJm7mlanNZdb8pe
	 EfTSvhNYa7GPA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMhqh-00000003q3h-3d5Q;
	Tue, 12 May 2026 09:48:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Vignesh R <vigneshr@ti.com>
Subject: [PATCH] spi: ti-qspi: fix use-after-free after DMA setup failure
Date: Tue, 12 May 2026 09:48:09 +0200
Message-ID: <20260512074809.915084-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66E4351C2F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245413-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,sashiko.dev:url]
X-Rspamd-Action: no action

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to clear the DMA channel pointer also if buffer allocation
fails to avoid passing a pointer to the released channel to the DMA
engine (or trying to free the channel a second time on late probe errors
or driver unbind).

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: c687c46e9e45 ("spi: spi-ti-qspi: Use bounce buffer if read buffer is not DMA'ble")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=17
Cc: stable@vger.kernel.org	# 4.12
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 1fbd710d616f..e3b413b9828c 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -867,6 +867,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		dev_err(qspi->dev,
 			"dma_alloc_coherent failed, using PIO mode\n");
 		dma_release_channel(qspi->rx_chan);
+		qspi->rx_chan = NULL;
 		goto no_dma;
 	}
 	host->dma_rx = qspi->rx_chan;
-- 
2.53.0


