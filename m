Return-Path: <stable+bounces-244909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELtKNdKv/mkqvAAAu9opvQ
	(envelope-from <stable+bounces-244909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC24FDF86
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0362F301A73C
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B41381AEF;
	Sat,  9 May 2026 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld6aDZD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FE23D2A4
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778298818; cv=none; b=uH/7HDUePDMiWTu05EBOPHsfQ53Izy0wOHEQFajXnk/lFO4NAS+qYGNN0TMa1E8amP/o9bmEFaCvXTsqD4xG6JzoGKiZ/ZD2JNMA60sZLXdLfyq1Tp/oTouO7puz+Td9BfmrLm/ULL03fpx5AaxCg91KJpuMW6Ev52eRJDFL3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778298818; c=relaxed/simple;
	bh=jR/Tcg7+EQw+SWmztdurSsXsg5sin9MQ7p2HAWdstsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7gapq3PWubgpp2vI80W89j4387HpSym8eh4JfJ6bI0aLjuB3HJU9nOV0Dg4K9+fBm9Ne6qTJHTQ+GyU0jNLKORHQ37bkrb5TwBhSQ4EbkGcd0dBaDOOsbvGNyTACb19AZvJkN79oz9umvu2AH12yR2zUJ9KKwnU/YNslzOhNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld6aDZD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92DFC2BCB2;
	Sat,  9 May 2026 03:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778298818;
	bh=jR/Tcg7+EQw+SWmztdurSsXsg5sin9MQ7p2HAWdstsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ld6aDZD9ye76DmItrXEvRGq24TZu/CO/f+ulaGWO761XZDJekF74a6TiF4g0KBpWF
	 4aJCEYUXGI/wJ9GjdvHg+bkUhpOG7zwuz/DZHtdVbZBdjWB9hEVmvptBeUFrGy6FV0
	 BjgZ7FdJ+RoW1P4+yDZhTd/Sa0qzPZekywy9UcRZ4NYcKzQge4rn4GBzB/mu3VSupx
	 VMVeIhYP+ytjxXmPD+mkju9R7L4R02XLIyy0Bz1nD2y6VQDfRs8uvGc6w5Kt0Ov32d
	 fWeNjr0sAKP0gtVogfZmb4hozDTyMjqzt3Pj40U5eIp3XUzCCPLcqa8Kt/qewNItHX
	 CPnb6jop1X7bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
Date: Fri,  8 May 2026 23:53:33 -0400
Message-ID: <20260509035333.3119717-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509035333.3119717-1-sashal@kernel.org>
References: <2026050440-badge-crushed-0fc1@gregkh>
 <20260509035333.3119717-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EBC24FDF86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244909-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit adb3faf2db1a66d0f015b44ac909a32dfc7f2f9c ]

The bounce buffers are allocated with __get_free_pages() using
BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
path and nx842_crypto_free_ctx() release the buffers with free_page().
Use free_pages() with the matching order instead.

Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/nx/nx-842.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index b950fcce8a9be..1f5005fcd69a9 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -116,8 +116,8 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
 		kfree(ctx->wmem);
-		free_page((unsigned long)ctx->sbounce);
-		free_page((unsigned long)ctx->dbounce);
+		free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
+		free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
 		kfree(ctx);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -131,8 +131,8 @@ void nx842_crypto_free_ctx(void *p)
 	struct nx842_crypto_ctx *ctx = p;
 
 	kfree(ctx->wmem);
-	free_page((unsigned long)ctx->sbounce);
-	free_page((unsigned long)ctx->dbounce);
+	free_pages((unsigned long)ctx->sbounce, BOUNCE_BUFFER_ORDER);
+	free_pages((unsigned long)ctx->dbounce, BOUNCE_BUFFER_ORDER);
 }
 EXPORT_SYMBOL_GPL(nx842_crypto_free_ctx);
 
-- 
2.53.0


