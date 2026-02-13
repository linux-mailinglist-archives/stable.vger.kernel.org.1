Return-Path: <stable+bounces-216154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CoBLCItj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07220136B35
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9B83066BDF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D3563C3;
	Fri, 13 Feb 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9KbTCzY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA823645D;
	Fri, 13 Feb 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990816; cv=none; b=O9SncZOv0kugtl8alyTsMUb37dMPhVxHhVGQb1FirmDqkdG2/jRpcgANtodUjizklhfcd/ZYkvQPts0moqM8BHvCwJBDW8zm2EMpYk8H9iswlvvCDzCSv4wOQgdzyJ3bPWeK2wx3tt25XKvi9gM3SYtgn5dW+ryYDoY5z2j32DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990816; c=relaxed/simple;
	bh=QAeHQ/11yp+RC6xJfkDRd0NyLGORsWd5UHu1T5A0bW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNsk5dmC2g5RVHhHYEcyhmsXAap0UdLcksBvWQvP6ZGdmmcFEQ0dg60kFBKYf9zxYkMkGavHou8Bs4+1ZeAv6aYCQkPR6msgnWcAJk6OUMP1k7lGMuk5zjfkeHjczK5zHUdkU7NVnmdVc3NOlt7UQqysNqzt875u48m7f0tdwkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9KbTCzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C70C116C6;
	Fri, 13 Feb 2026 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990815;
	bh=QAeHQ/11yp+RC6xJfkDRd0NyLGORsWd5UHu1T5A0bW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9KbTCzYYEilg695a5aRlliJIlcil8qGBkDpKkfo/MpWxuo927HEF+kXO139hPjmJ
	 CkFFLLGwQpEYjykN2ScfM57ntl+BvJCDrQTHsjjhG51zGm2Y9js9wcDtq+keWMU3oz
	 ztsPfJyxpJ0hpc84ZRKokP+qVPCSld2BprAtB6uk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 31/49] crypto: octeontx - Fix length check to avoid truncation in ucode_load_store
Date: Fri, 13 Feb 2026 14:48:15 +0100
Message-ID: <20260213134710.021350489@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216154-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 07220136B35
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 5565a72b24fa7935a9f30af386e92c8c9dfb23b9 upstream.

OTX_CPT_UCODE_NAME_LENGTH limits the microcode name to 64 bytes. If a
user writes a string of exactly 64 characters, the original code used
'strlen(buf) > 64' to check the length, but then strscpy() copies only
63 characters before adding a NUL terminator, silently truncating the
copied string.

Fix this off-by-one error by using 'count' directly for the length check
to ensure long names are rejected early and copied without truncation.

Cc: stable@vger.kernel.org
Fixes: d9110b0b01ff ("crypto: marvell - add support for OCTEON TX CPT engine")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1326,7 +1326,7 @@ static ssize_t ucode_load_store(struct d
 	int del_grp_idx = -1;
 	int ucode_idx = 0;
 
-	if (strlen(buf) > OTX_CPT_UCODE_NAME_LENGTH)
+	if (count >= OTX_CPT_UCODE_NAME_LENGTH)
 		return -EINVAL;
 
 	eng_grps = container_of(attr, struct otx_cpt_eng_grps, ucode_load_attr);



