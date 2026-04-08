Return-Path: <stable+bounces-234783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH5aJ5ih1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5533C14AB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C916C3029A19
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97D3D75AF;
	Wed,  8 Apr 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAE9qdoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C063B0AFC;
	Wed,  8 Apr 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673751; cv=none; b=DozEu8ok8A85DeYwE/kU++ABiMLHnuNulIg2EFgo91BpNwcxpVWJ9oG05s5XxHX9vG1oYb0cmjKMcGQinPqWhx0uQQPB37cU97TiJtBzE5D2w0mkNlRYkVB4bOWJbkx1V7rXFmFK1xrwQRmELwxmBRrCQ9V4/ogrO9SmVrkX5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673751; c=relaxed/simple;
	bh=cl/HefTZwC6ZcBrFJbpIILahK0ggyw5uME+OdteULq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxjFZgsDuwWlfJVAA3PAoQJB85U/lq2bGAUjUTbpIBqkqr5lOuHIb3bSapzayoHspg4pc3jMGLc2WQLdglazBylb+0ZnrhmgQxxfColVZyhWkkwm4XxRgi7w61mihujrOwO7smFz2ec//4SaDFRgX1WyCOsW21rsfLtM3xI8Z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LAE9qdoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A95C19421;
	Wed,  8 Apr 2026 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673750;
	bh=cl/HefTZwC6ZcBrFJbpIILahK0ggyw5uME+OdteULq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAE9qdoJIqFTszuAodRUtl17Q4hmunSMVZZd44GiCEAG8mtMvnRx/33Dq02JiPksX
	 QyQKl5hTBtXcOfHMWEapzH0TcCP2Y1S5+qpm3zOfNRY4R8sFrx9SyR0IE2DzfoS98U
	 mIJNJAMHIftqsHbnMCS+3bQ6mOf6i32uKkc3b2Sw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 043/242] crypto: caam - fix overflow on long hmac keys
Date: Wed,  8 Apr 2026 20:01:23 +0200
Message-ID: <20260408175928.684563440@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234783-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6D5533C14AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horia Geantă <horia.geanta@nxp.com>

[ Upstream commit 80688afb9c35b3934ce2d6be9973758915e2e0ef ]

When a key longer than block size is supplied, it is copied and then
hashed into the real key.  The memory allocated for the copy needs to
be rounded to DMA cache alignment, as otherwise the hashed key may
corrupt neighbouring memory.

The copying is performed using kmemdup, however this leads to an overflow:
reading more bytes (aligned_len - keylen) from the keylen source buffer.
Fix this by replacing kmemdup with kmalloc, followed by memcpy.

Fixes: 199354d7fb6e ("crypto: caam - Remove GFP_DMA and add DMA alignment padding")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index ece9f1e5a689f..9ef8ee77c52aa 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -3325,9 +3325,10 @@ static int ahash_setkey(struct crypto_ahash *ahash, const u8 *key,
 		if (aligned_len < keylen)
 			return -EOVERFLOW;
 
-		hashed_key = kmemdup(key, aligned_len, GFP_KERNEL);
+		hashed_key = kmalloc(aligned_len, GFP_KERNEL);
 		if (!hashed_key)
 			return -ENOMEM;
+		memcpy(hashed_key, key, keylen);
 		ret = hash_digest_key(ctx, &keylen, hashed_key, digestsize);
 		if (ret)
 			goto bad_free_key;
-- 
2.53.0




