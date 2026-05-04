Return-Path: <stable+bounces-243298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O7XMd2p+Gm5xgIAu9opvQ
	(envelope-from <stable+bounces-243298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0D4BEE47
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C00A3121626
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651E3DE423;
	Mon,  4 May 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xi1Irlgw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40B2E2F0E;
	Mon,  4 May 2026 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903526; cv=none; b=GAIF9DYz1oLJUO6KSmS4biCxjVfLpUVQQh41jYvCCvakAWKuCuCymZuJ+bVwDWdDOdAryv5FNUNybw/ZaXaeHEtMBFFNxpbgIiyPDtQmycvHUnEM6tqcWFG4m1CYIH29E6it2aCrxYCSihy1anZIp/1sMHAWjRzX63b09Xm4f+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903526; c=relaxed/simple;
	bh=1zkJusXOGbN0X6/x2hU5DhBQIRL3KRyLvvikX/fILkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQu2P9UBIQv+OrMLe0oJ4ijm117zKfFSfRTf1lszopMmVFnFmFfqVUA/iuzuFQGOzbtl21AYJ0XpSbh7MLcXOMD5IKYd+fLEbtmUrqKadhO2uIbEc26U6oKqQchRI2hvQdLDaXIfH64b6OwZ5KN2hAZJKYNqhQoYkz/1IVAIDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xi1Irlgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B21C2BCB8;
	Mon,  4 May 2026 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903526;
	bh=1zkJusXOGbN0X6/x2hU5DhBQIRL3KRyLvvikX/fILkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xi1IrlgwIHNEA+Fubh2jT1rLPcyEYnGCq9T0/nBta+rVDx0r6dM+xdw9/R33L2CEJ
	 Tb/WaQBAFS6uPWlmmnDBYahMCMPoaUDObhCLG7bDvZW7qF9qUQYz+XCRq4a9Mh4WmY
	 f0sRJD6nY0g5qDOkJIlAIPSWlxau31JnROxmBDi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7.0 268/307] crypto: nx - fix context leak in nx842_crypto_free_ctx
Date: Mon,  4 May 2026 15:52:33 +0200
Message-ID: <20260504135152.893127557@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1BE0D4BEE47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243298-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 344e6a4f7ff4756b9b3f75e0eb7eaec297e35540 upstream.

Since the scomp conversion, nx842_crypto_alloc_ctx() allocates the
context separately, but nx842_crypto_free_ctx() never releases it. Add
the missing kfree(ctx) to nx842_crypto_free_ctx(), and reuse
nx842_crypto_free_ctx() in the allocation error path.

Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/nx/nx-842.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -115,10 +115,7 @@ void *nx842_crypto_alloc_ctx(struct nx84
 	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
-		kfree(ctx->wmem);
-		free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
-		free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
-		kfree(ctx);
+		nx842_crypto_free_ctx(ctx);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -133,6 +130,7 @@ void nx842_crypto_free_ctx(void *p)
 	kfree(ctx->wmem);
 	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
 	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
+	kfree(ctx);
 }
 EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 



