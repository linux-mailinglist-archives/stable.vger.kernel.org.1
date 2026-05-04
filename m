Return-Path: <stable+bounces-243560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDOXF56s+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F04BF6A0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62BA130B8BD5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920213DF007;
	Mon,  4 May 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HegIkIQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596A3DF000;
	Mon,  4 May 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904198; cv=none; b=qo4Tr/xx+KnQN5tZiyBoCBz3WbUGaA69Cym66DEFRa4BU2J6n7rbIXX8ELMziJPPIl8Xt9wL/1TtJdXzUZTHESnIhVKOIjXJZ4tcXO7b55d46o2LSy1gJSZD8U8tIHQha9SYsQbz9AnQtMx93WYsr/u1fpl6Y3vqBx0rk1eC8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904198; c=relaxed/simple;
	bh=Vs2dZYJ6111ZomRRNPWZ/MGi6ukYFEGeRIA+KDidue4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUe8SwOetGJNTVVfMtQTMJH/G5a8Yph+T9z6NOMlrKQop4uf+HW0DrUfOcluhHtp3vKehUCGQyom17pLYPbBMSc+nt0jfxFyVdHqY+dYPDerZOUDfbi5OPXUq3lp82UpK+geSlZ6wKVAG96JA29IfNZ1yskuLTm+iOe/CZW+trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HegIkIQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5447C2BCC4;
	Mon,  4 May 2026 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904198;
	bh=Vs2dZYJ6111ZomRRNPWZ/MGi6ukYFEGeRIA+KDidue4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HegIkIQUzQBndfCa/9Ku4hNY1y9JmtV2EFiIjIXVtwzDfnZsj+m+g/GGMJgOsU8q3
	 uV+I6mmZ9ovxSPF7Rovod8PDXHEj9+gR/Ef8stEd4DLn2riMtkJ597pIy9m2mwMuqZ
	 d2Kmi5U5MOV/kg8ZNPvV9UvZclYMez2QtJy/iPtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 221/275] crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit
Date: Mon,  4 May 2026 15:52:41 +0200
Message-ID: <20260504135151.280603302@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E93F04BF6A0
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
	TAGGED_FROM(0.00)[bounces-243560-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit f8f08d7cc43237e91e3aedf7b67d015d24c38fcc upstream.

Since the 'enc_after' argument to neon_aes_mac_update() and
ce_aes_mac_update() has type 'int', it needs to be accessed using the
corresponding 32-bit register, not the 64-bit register.  The upper half
of the corresponding 64-bit register may contain garbage.

Fixes: 4860620da7e5 ("crypto: arm64/aes - add NEON/Crypto Extensions CBCMAC/CMAC/XCBC driver")
Cc: stable@vger.kernel.org
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260218213501.136844-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/crypto/aes-modes.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -838,7 +838,7 @@ AES_FUNC_START(aes_mac_update)
 	encrypt_block	v0, w2, x1, x7, w8
 	eor		v0.16b, v0.16b, v4.16b
 	cmp		w3, wzr
-	csinv		x5, x6, xzr, eq
+	csinv		w5, w6, wzr, eq
 	cbz		w5, .Lmacout
 	encrypt_block	v0, w2, x1, x7, w8
 	st1		{v0.16b}, [x4]			/* return dg */
@@ -852,7 +852,7 @@ AES_FUNC_START(aes_mac_update)
 	eor		v0.16b, v0.16b, v1.16b		/* ..and xor with dg */
 
 	subs		w3, w3, #1
-	csinv		x5, x6, xzr, eq
+	csinv		w5, w6, wzr, eq
 	cbz		w5, .Lmacout
 
 .Lmacenc:



