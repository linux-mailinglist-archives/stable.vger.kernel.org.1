Return-Path: <stable+bounces-243587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHuBK6Kq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3AD4BF068
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BF3730162A6
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01423DE443;
	Mon,  4 May 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0aG0grx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E235A3AD;
	Mon,  4 May 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904267; cv=none; b=tdCoOzxBXVWP5/Eq2BRCE8Xni1QhBu2ZyfhF3eWxYW8Le3jqon+PZQiPel+FdI7lJe+cUSvUliTbLLwLeCpmy0TmiSz5f7ukd1Y7E2YBSbT7VrWD64ZS//sbECRLrwSlWEBXOsyNpeNxtrtF2lwyar19tRMM/mPs2TZ596ZOzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904267; c=relaxed/simple;
	bh=LJX2rXXAR9IZlshoFfc4r01R5ZOsQqhk0i0q5L1Ihjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8XPtn/HdNzR3vdC17mJaQUsizGwA2zrAv/UXbKXZiyOZmtbegVyegR7no/G+3SKtubAVlGNZaD0IXNyF42WVbyGNJE0MDDUWfuwS2fzJtcxy4usK52extOiMMS5gGGkaJ8fdNc72UyjESct+3H9gwMT1mzfNn70ufPX6MmwjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n0aG0grx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BD6C2BCC4;
	Mon,  4 May 2026 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904267;
	bh=LJX2rXXAR9IZlshoFfc4r01R5ZOsQqhk0i0q5L1Ihjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0aG0grxoynFwRgfSk/33ziVIGRSJBfQVKwQRCc5G6giYJP/t5Z3KF1R7aOoUU6N5
	 GgDoZrJMw3x3SJzbbloQEQFiSJs3gDPdX3QKNAR/72nOBKAdi1PkZwXf7ZtNrXMAZc
	 3jll5Rh3JYcO1Wl2oBgCn14hrIqSFWvBm4btuTHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 231/275] crypto: nx - fix context leak in nx842_crypto_free_ctx
Date: Mon,  4 May 2026 15:52:51 +0200
Message-ID: <20260504135151.637458170@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2A3AD4BF068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243587-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/crypto/nx/nx-842.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index 661568ce47f0..a61208cbcd27 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -115,10 +115,7 @@ void *nx842_crypto_alloc_ctx(struct nx842_driver *driver)
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
 
-- 
2.54.0




