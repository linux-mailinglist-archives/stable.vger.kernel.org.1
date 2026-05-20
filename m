Return-Path: <stable+bounces-250305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH4gOp0ODmo35wUAu9opvQ
	(envelope-from <stable+bounces-250305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:42:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C6598A0D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E2C33D3F9F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3E36F421;
	Wed, 20 May 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0YhKCGd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1F36A357;
	Wed, 20 May 2026 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295065; cv=none; b=PbjbquGJAUqma3NeE5EJZx2b+K8Xq9F+TNiSGhJohWKmSij2QSpG76G73SXhrig7opc0w/v162r4omlF+5u3KAO7e9ENvYgYXsHeNjD2OAG50hGyBjxPC/V+cAoErC2ozPt9hitD8RhmCfyi7zRMe5JMTHQ9bF6DlWwpZIXW3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295065; c=relaxed/simple;
	bh=ouw84jTx1lF0CmI8Nh15P1sbPjgAP1LtZkxxziR2T7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faaEPJyTGOyOBoE7wpdwRIJoUJ+JU1nUg8LVv7oi8WclSWrwIvKf5yU7HhYC0x7AT+NDAc7u7eP8abKNjB3tnosNa1OUkv+tV09Zf2sMPckjpKXY5Oi39qZsDiZWDSdSBPhu8HZAdIMeGjF29Ww3YqmEG3pswNNqH2ZZcPRxFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0YhKCGd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439F31F000E9;
	Wed, 20 May 2026 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295063;
	bh=DetRn9n4Len2mou6CXsPVfgqPq3TZ4aafB0tY7F0hwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0YhKCGd16t2xpcDsCTmeocUO8MtPHPd1NUt0eX77uv+BiKpbpKAnVSS4nnu2Xlc1
	 UB7bVyfpBFPlFylrphGop0Si2WqE7MSwDR2WXLHT5SJzw92ELbCYPXL+za9PbNMqbJ
	 5AyaYst3021nAa3tf935dvPMZPgHe2gBv+O54Td4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0277/1146] spi: axiado: Remove redundant pm_runtime_mark_last_busy() call
Date: Wed, 20 May 2026 18:08:47 +0200
Message-ID: <20260520162154.486703820@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-250305-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 797C6598A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit ec6c2e15a42fc8fb63baadee0e8a3257e37fa90c ]

The pm_runtime_mark_last_busy() call is redundant in the probe function
as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally to update the last access time of the device before queuing
autosuspend.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-axiado.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 8ddcd27def22b..dc55c55ae63c8 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -842,7 +842,6 @@ static int ax_spi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	ctlr->mem_ops = &ax_spi_mem_ops;
-- 
2.53.0




