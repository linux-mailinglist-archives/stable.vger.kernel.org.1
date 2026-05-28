Return-Path: <stable+bounces-255205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMpaDjaeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E15F7858
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F5123015701
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD53403E7;
	Thu, 28 May 2026 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9MO6NM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4093290B0;
	Thu, 28 May 2026 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998256; cv=none; b=P4aPMDK8nEhG/OYjsg8JaNT04QuukNZOY+9QbyI6DYptRH5io4iCMl+Z+6tQd6KE1xO2tkPWLEjNFSJBrXtYuHnl+kSOP2jBPHLHQIpZxwWdSjM5fJ8OpbbU5Sntwbq/4R5rcvnSX3fuewByF+25m6QkDC+dgOssK83uF6Q9JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998256; c=relaxed/simple;
	bh=+/4B4RhKb/8+BliyzQsjM44OJnYaSH+HsoLV0/ZfLd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIUbvFgc8SvHEf6Uz7gRZq8C7myfwYO8DfNmgW90e/Hf3xsNhIVEg6C+iSNupGLI+iI6WQxb8XLjol+c+IGTVJX4byCNYC+N0uOQBbuFIVqI76NiMOE+rRVPYGD3pXMYJaCNTQBkl/ifb+2Nv3L4z5TlQvASZw+PGiSd1pM3wsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9MO6NM8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2801E1F000E9;
	Thu, 28 May 2026 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998255;
	bh=UkXIt+vAKrrjkcEHq8M6ztz0AzHQxAPyVxKg+lzzLic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r9MO6NM8e9zGKTeRpHe5XpnSVmdmPNNygOA+jmnTPhoAM32wI/MhgaADTJam1Rqqh
	 m0EdLfxHwhV2SPMRzF8d3LlJ2MmypShtxTYUl/91uPs7+u5k3AQeTOF+8PTcjLDgmc
	 IhAQzRNS5U6c5WzXys6XlQ/Pwo0e5axy+lPax/fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 108/461] spi: qup: fix error pointer deref after DMA setup failure
Date: Thu, 28 May 2026 21:43:57 +0200
Message-ID: <20260528194650.092418605@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255205-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D16E15F7858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit a7e8f3efd50a165ba0189f6dc57f7e51a7d149db upstream.

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer (or attempting to release a channel
a second time) on later probe errors or driver unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=4
Cc: stable@vger.kernel.org	# 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074334.914735-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-qup.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -996,8 +996,11 @@ static int spi_qup_init_dma(struct spi_c
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 



