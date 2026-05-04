Return-Path: <stable+bounces-242928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGkqLAFe+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 088934BA8E5
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF18E3000BBF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28528318B9B;
	Mon,  4 May 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="umvPoYF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A42E6CB3
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884535; cv=none; b=E60gMYZubuzish6S9e+G37eQ8ZrA0ARPxwP6KUAvMc4lvM8PWuNPuG93j1rtVLi6GyO3pc67JA9umPzQTGPgENGkp5m/3yvMF2uFmde7y18ilCt78yRuro6c6fv2kDIvbsoHFGrkzD665dAWpE11QXQpGxhv3lPhdyWi3j/ZiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884535; c=relaxed/simple;
	bh=y+Qf1UWkJlx7FWjWwETQXbjG7WAaped/g2RH73QJeFA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lwVGKAUrwM+/X04/8/hbDftimSxw3psmlc4aQnAGoI+Pg/MIb/9P4YWws7uqi7CBxO7ECO3nvQ2oFBtOrHx3uJesa0W+xgZxHdHtqspG4EmgglGDeDybU5+STMET6SUl2G6u6yaT/Lh30mH0ZcyI+oZaVp8Ms3iGKiomofEj8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=umvPoYF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26BC2BCB8;
	Mon,  4 May 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884535;
	bh=y+Qf1UWkJlx7FWjWwETQXbjG7WAaped/g2RH73QJeFA=;
	h=Subject:To:Cc:From:Date:From;
	b=umvPoYF5hSYARfsI13bTOHYpP2fCGqAfbK3HU/5uNEU2uflF3uuVDsgU0c66h4ic6
	 pdIe7Fr44ovqtY6Bgliyx2KCrv68tnmXcdRJK5fA3HRV3Ob9q8TJSqE0Me+OrWCLnG
	 oG6RKM5YZ91k1wEOusAN+OAWmj6CMaTCNOxmgWB8=
Subject: FAILED: patch "[PATCH] crypto: nx - fix bounce buffer leaks in" failed to apply to 6.6-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:48:40 +0200
Message-ID: <2026050440-dude-evade-6747@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 088934BA8E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242928-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linux.dev:email]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x adb3faf2db1a66d0f015b44ac909a32dfc7f2f9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050440-dude-evade-6747@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From adb3faf2db1a66d0f015b44ac909a32dfc7f2f9c Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Wed, 11 Mar 2026 16:56:47 +0100
Subject: [PATCH] crypto: nx - fix bounce buffer leaks in
 nx842_crypto_{alloc,free}_ctx

The bounce buffers are allocated with __get_free_pages() using
BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
path and nx842_crypto_free_ctx() release the buffers with free_page().
Use free_pages() with the matching order instead.

Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index b61f2545e165..661568ce47f0 100644
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
 


