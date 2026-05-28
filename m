Return-Path: <stable+bounces-255716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFftFWGnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C541D5F91B6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD6332DE10B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B63002A0;
	Thu, 28 May 2026 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byTv5kNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413482D9787;
	Thu, 28 May 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999687; cv=none; b=kfKzmTbbXIfm4v4jO1AOeslOKjc8Dwkky2UcNq5Qb2Ibl78+Gj8OL3OriocahPk/IvXCNKbVODWXtjcH49o8zx1VmGvTsRlRhNaSP9jRUKkv7eUR4MtrKYIdAvzws/YHXBq54UsypRk4ZIV9HNlNw7rPerCW8qcCSlPmRjwHC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999687; c=relaxed/simple;
	bh=iOHEIS167TwPLkC8cnaeTyWjTHhy8Fo+GcCvR8c023U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWakMMW3u1OGN6GU7bIGJZ9J8Vg3jiBTa1qksDdgDYGy53QTlKuRkjYlV1swvKjxSpDGIO+rECOmaZ9IxbFb18wE71ARrCqK63vwEg/fH8C4I3gRmy/f28GRdtcPDFq10LJMmqvfE2RIqpBpc5IzqHA+DgCp5myBg/7cdJZhhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byTv5kNQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFA1F000E9;
	Thu, 28 May 2026 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999686;
	bh=WfyMCF4k3qQ3Wd0hk22xW3tYHRC1VY7C42y4rV5HEf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=byTv5kNQdbHF0Mv/sPRUVx1u+MmrpWc5C/kKEHWSxX6EIsV+gk659HRoRVInF/+G2
	 naogwFS+gefloN8Z7K2VyQjBM+E7TnqB3sBmRKLLKvB8sNNUGurqHwLj9E0wBBp64c
	 qlSih4frF59K8CUckfv4bDELpgipPN9LCAE3oh9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 119/377] spi: ep93xx: fix error pointer deref after DMA setup failure
Date: Thu, 28 May 2026 21:45:57 +0200
Message-ID: <20260528194641.784081520@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255716-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: C541D5F91B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5e121a81667a83e9a01d62b429e340f5a4a84abc upstream.

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
Acked-by: Nikita Shubin <nikita.shubin@maquefel.me>
Link: https://patch.msgid.link/20260512074849.915143-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ep93xx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -582,12 +582,14 @@ static int ep93xx_spi_setup_dma(struct d
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
 



