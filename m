Return-Path: <stable+bounces-244900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFgULbGq/mkyuwAAu9opvQ
	(envelope-from <stable+bounces-244900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:32:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192234FDE10
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4203018BF9
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140B33998;
	Sat,  9 May 2026 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxp7q3uu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F82F8E8D
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297515; cv=none; b=NyzE8g9Ho4ihrEEXckl/bkd+HrAJmjZohXwYrVWGt4vEMUf+dXDYue0UXiVaG9niMXdJmmV6QgGXXFnmCRXNU/rLHJlLqIUlKAKvhSTqUNm6Pc/5tqfgfIPWIg14BQpeDmdXdM4aeL3S+a5ZIvtRir0AFjDyZZ5xV3FzoCe5rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297515; c=relaxed/simple;
	bh=jR/Tcg7+EQw+SWmztdurSsXsg5sin9MQ7p2HAWdstsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuHDZMdSRLxnME6uOpA1pYrKkdD8Uq1F3dSLU1dvrs9q4MMc27mTRxbf+Oc3v/mAV8bKvZVjPdepNqAIPf4nN39SUVuM6C9h+w0/SV6VTBz8RvLsAjPdkXlIbLJeJDjUx3bArh1rgSpQnoVkJi/IZAvEjpmbVipLOOj5DTqNpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxp7q3uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A0BC2BCB0;
	Sat,  9 May 2026 03:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778297514;
	bh=jR/Tcg7+EQw+SWmztdurSsXsg5sin9MQ7p2HAWdstsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jxp7q3uuGf+d3J7Jk4FdSvCU7PMtBOxb4BkVQNspUp73Hx7sya8dZ0cAhUROvGJWI
	 WTP3fkIk6Q74zW4gOREI+jJZboIcU12Ib32pLmNd7HmEqVQZBJL7AYvT6qP+OeT9tn
	 Jd2XRHVPQBG7/cGrJTK/+YgHDiw26en7W0XQhHufb4L1sZ64XVdPj6px+7YLgGTte8
	 9YRJBO9RKy2lETtQZLWUeqmPNsbcObCCs7IVFZPcrwBTA/F0kmIyuP7CyI05oZ+KB6
	 LOejorZ8AmBJ5LJZmOcjTSh5pWC1aEX8BroknjuHeQcF2H5+GIRFbApbUFATiv7yLT
	 BhDUnygh9+PMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
Date: Fri,  8 May 2026 23:31:50 -0400
Message-ID: <20260509033150.3082044-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509033150.3082044-1-sashal@kernel.org>
References: <2026050440-dude-evade-6747@gregkh>
 <20260509033150.3082044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 192234FDE10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244900-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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


