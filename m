Return-Path: <stable+bounces-254874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA1vE2crGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:47:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016455F1832
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E400530E5DEB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F533E556E;
	Thu, 28 May 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PTmYTVLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690283E5560
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968623; cv=none; b=sU58ADzqnALolnodO783DoBTvHe3f79Rxg3ylVJtGTHmQ3RI3axDJbNDRY+hTnA0iVKp3QoUi4g2dtSxx4X9tgQc+435b27VCKmmJK+OmbrVAsAotHzhrVQz7bJ2T5YJHLIxTXDNDo9FcbamDPOpL0k6+W2qLMFyu65VV+MTssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968623; c=relaxed/simple;
	bh=L3czWc5OMWxvEzTuKO0X2tjwXVfj7cmBOjy43p0W8SM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bzF5lgr4krU+RAMS6Y2ofpETCktAKeUEZQryWj8GIrq9nLDeUlFpXb+frpNJVjF5TK2RCr/Oooa5w6NYCL98t7lfFSxIvs/8VY2WSauUpmm0FE/LQtta8jc2fE3vhY17UizR73BIAKxQ/bH2WZMHblkvL/xyrxWdcpojvUmU750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PTmYTVLt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95141F000E9;
	Thu, 28 May 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968622;
	bh=YtUMvv+dvankXVgAzRgDpVYHVj30Zf4Rjf2xm2mOUrQ=;
	h=Subject:To:Cc:From:Date;
	b=PTmYTVLt+i2GQdY/p8T3cGDq5NiorM4Ls86FuiCi1Zin71v7PNNskMRYnXQ9x9lmB
	 ALPC8aGdiXQM3+bu7l4vm1F1a5s8bLfLLNLzMCab6eHjp42cj1Nlt8wUPHaD1UUJVZ
	 /Rr0BEvVZR9g8Vk79m2Lf40NDYowFWqUTl/xsZ8E=
Subject: FAILED: patch "[PATCH] spi: qup: fix error pointer deref after DMA setup failure" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:42:38 +0200
Message-ID: <2026052838-tank-lucid-17e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254874-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 016455F1832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a7e8f3efd50a165ba0189f6dc57f7e51a7d149db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052838-tank-lucid-17e8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7e8f3efd50a165ba0189f6dc57f7e51a7d149db Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 12 May 2026 09:43:34 +0200
Subject: [PATCH] spi: qup: fix error pointer deref after DMA setup failure

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

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 45d9b4cb75e4..50bb7701b9d5 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -996,8 +996,11 @@ static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 


