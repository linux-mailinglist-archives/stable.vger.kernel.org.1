Return-Path: <stable+bounces-255717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNgcGmWnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E791A5F91C4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338E331F1893
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304BA3002A0;
	Thu, 28 May 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4eo7CFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CB2D9787;
	Thu, 28 May 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999690; cv=none; b=uzcmZVIxNkmTaXcFwlHmav14wWZYVY7ODsE2OPbuCiptaCBMelBq/G93dwiz9PgN8MPAV0a5i1I6RVRzM2MkXhObSbbWNaw5Bq+SXEXyiuqo91UnCWX4+IIPFYGE+rJuB0/3laQStqF29UdSYAnPZNmaJu5LWRP8aK4ZCDrMB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999690; c=relaxed/simple;
	bh=NWmC8TzrtJ6aIqUAS08rAT0sPNxJ5ghIsxijFkXjJUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adp0ijbG0FfMp110cgVg3269wpjac/4MqKz/ydiOgIWT0A5A8QdcEYqHqNB+IrEWQTWAIdUAE4E4vl2ck/sqQbrlkGTV5fjEs4svuTWxnHSP4PpkxWMMwKd7P/PgCTQTwZ/jnwRpJC74mzdZt0ayzrqr3pZiX1Rf6fTcpi3FSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4eo7CFL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D57A1F000E9;
	Thu, 28 May 2026 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999689;
	bh=bwyvlTeH1pDgxN++Jta/+3x1SgQVfQj/Zl+1gvBtvko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4eo7CFLa+QU1gjNFZo9SBwFsgIgeQld/ca1x5fdlNV5LVI1Kdxaqoe4Nvz0bLAK5
	 EM/FNzHtEEWIjtlOpSGqYdxGB+5mCo+tII2eOBMFnJXBYSLed3sHo9kHNbcW1+5L53
	 QnrI1vBSIh8Htqrb6P+6STYa3bcQjTJckOJ4r86k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lanqing Liu <lanqing.liu@unisoc.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 120/377] spi: sprd: fix error pointer deref after DMA setup failure
Date: Thu, 28 May 2026 21:45:58 +0200
Message-ID: <20260528194641.814121444@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255717-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: E791A5F91C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 3d67fffb74267772d461c02c67f1eff893ad547d upstream.

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to check the dma.enabled flag before trying to release the DMA
channels also on late probe errors to avoid dereferencing an error
pointer (or attempting to release a channel a second time).

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 386119bc7be9 ("spi: sprd: spi: sprd: Add DMA mode support")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=10
Cc: stable@vger.kernel.org	# 5.1
Cc: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074733.915029-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sprd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -992,7 +992,8 @@ err_rpm_put:
 disable_clk:
 	clk_disable_unprepare(ss->clk);
 release_dma:
-	sprd_spi_dma_release(ss);
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
 free_controller:
 	spi_controller_put(sctlr);
 



