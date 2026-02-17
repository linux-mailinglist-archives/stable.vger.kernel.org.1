Return-Path: <stable+bounces-216949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCZTEZvSlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:42:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06515016F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 434E73019C87
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52175378D9E;
	Tue, 17 Feb 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lM4aYlB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C54378D9B;
	Tue, 17 Feb 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360905; cv=none; b=QBgN+LJUG4agdNuwBh7k7RAtHDqk8JdyfaBbbeWQ2HZRiyvD9bcdGb9igVstGom63D6CfmRG9793Mryn/xS/fjZyGsn+qIsbUY0VcTrh030lic/9uIhX4j7cTODxmjdzdsYWSXE5tuik1Qu2lakDErVwbCgSMsyvYm6dVI38y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360905; c=relaxed/simple;
	bh=U210NVv1GXc5bOxQPhZPN0R4NecCwGGHfZQuooMaUTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1akPP/fBMQHkyppoS3FvfFyVDPSZaRPvm/SYIWNg9F82d6M3zf5TnnODfGsi8MRBCVeDJl6rXfD8+TxytwYzQwrOYEnAnwYP43yBDtnSSZZ4LPhXLVCj9eVpTY4HUfVpd8u4iu7K9cp/9aaXyu6FFGrHZiOtQzMPRjWkrUB/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lM4aYlB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6CEC19421;
	Tue, 17 Feb 2026 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771360905;
	bh=U210NVv1GXc5bOxQPhZPN0R4NecCwGGHfZQuooMaUTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM4aYlB25UfWWyWiP+bb/puzHXZiPgi0Wz6/d+ZptbP9Pw8AO+xhPgFG4NBbcEeDl
	 +lUa6pFbOAyIvY4M6Qw9jX1nCsX7SJNx/HDNXQyitU/+zE0BFOtRC3kyASi0wf+ezp
	 YKDLQfynpaEACa2zfWuvu4YXrju2suB2fY2jCGLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10 02/24] crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly
Date: Tue, 17 Feb 2026 21:31:15 +0100
Message-ID: <20260217200000.806811132@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200000.708219618@linuxfoundation.org>
References: <20260217200000.708219618@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216949-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email,apana.org.au:email]
X-Rspamd-Queue-Id: EE06515016F
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <kees@kernel.org>

commit 1562b1fb7e17c1b3addb15e125c718b2be7f5512 upstream.

The existing allocation of scatterlists in omap_crypto_copy_sg_lists()
was allocating an array of scatterlist pointers, not scatterlist objects,
resulting in a 4x too small allocation.

Use sizeof(*new_sg) to get the correct object size.

Fixes: 74ed87e7e7f7 ("crypto: omap - add base support library for common routines")
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/omap-crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/omap-crypto.c
+++ b/drivers/crypto/omap-crypto.c
@@ -21,7 +21,7 @@ static int omap_crypto_copy_sg_lists(int
 	struct scatterlist *tmp;
 
 	if (!(flags & OMAP_CRYPTO_FORCE_SINGLE_ENTRY)) {
-		new_sg = kmalloc_array(n, sizeof(*sg), GFP_KERNEL);
+		new_sg = kmalloc_array(n, sizeof(*new_sg), GFP_KERNEL);
 		if (!new_sg)
 			return -ENOMEM;
 



