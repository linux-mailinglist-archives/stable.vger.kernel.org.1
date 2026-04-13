Return-Path: <stable+bounces-237506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ASIBAQn3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E873F15B5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4357D30223A8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B434753F;
	Mon, 13 Apr 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qG9J2xSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3440346791;
	Mon, 13 Apr 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099630; cv=none; b=acxEWKt/o1gNGXwyNbqI0XkzQ43bV5/9/kqM0zgZjAELckhR3htknFGOlepIIxLcLDBSAFMQuWwAs9WzvvtMUEPpld+PDSWuHl1E8szkWXXPRfh91xSNVbkAJWoqq7EXYkyvR92Vx7Yvw1Us8D1mofmdW11rK8Ep6vz1DM8cAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099630; c=relaxed/simple;
	bh=BSyyrPyqvju6HGbMIMubw4O+Qg3WpCBK2oXO+u3wFsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOwKiAI9w/7pLY/dE8Y0tI2aS+jJNF9SRmd4V/+h+cV4vgyVH9gUYn0kQ+nX93qGCtwwr30q/L3Wp9gdhbxNdoBaBk2W7+4geVglrwUHwEuIJGMXewEakbW8d+o0oeZ+Qp/vA71gCggWq1+HUYtsIA23lwPxT9NKVpu63vgJ1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qG9J2xSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A2C2BCAF;
	Mon, 13 Apr 2026 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099630;
	bh=BSyyrPyqvju6HGbMIMubw4O+Qg3WpCBK2oXO+u3wFsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qG9J2xShi8XoVCfPb9OYgN3pCck+VyjP2eJLQgMxNHGUYlSZHP2eTsUhkhq5aeqYD
	 GcKnkaicpzb4Rwtl347jsz7onbmV2hj5mBeRvS7YHC0MKAuAZcJqWXtSK2EaKbzh4W
	 K6BVINC2GxlKb+k11ioMCtqrhglr8Kg8ODotXQe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.10 413/491] lib/crypto: chacha: Zeroize permuted_state before it leaves scope
Date: Mon, 13 Apr 2026 18:00:58 +0200
Message-ID: <20260413155834.490745085@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237506-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27E873F15B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit e5046823f8fa3677341b541a25af2fcb99a5b1e0 upstream.

Since the ChaCha permutation is invertible, the local variable
'permuted_state' is sufficient to compute the original 'state', and thus
the key, even after the permutation has been done.

While the kernel is quite inconsistent about zeroizing secrets on the
stack (and some prominent userspace crypto libraries don't bother at all
since it's not guaranteed to work anyway), the kernel does try to do it
as a best practice, especially in cases involving the RNG.

Thus, explicitly zeroize 'permuted_state' before it goes out of scope.

Fixes: c08d0e647305 ("crypto: chacha20 - Add a generic ChaCha20 stream cipher implementation")
Cc: stable@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260326032920.39408-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crypto/chacha.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -86,6 +86,8 @@ void chacha_block_generic(u32 *state, u8
 		put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);
 
 	state[12]++;
+
+	memzero_explicit(x, sizeof(x));
 }
 EXPORT_SYMBOL(chacha_block_generic);
 
@@ -110,5 +112,7 @@ void hchacha_block_generic(const u32 *st
 
 	memcpy(&stream[0], &x[0], 16);
 	memcpy(&stream[4], &x[12], 16);
+
+	memzero_explicit(x, sizeof(x));
 }
 EXPORT_SYMBOL(hchacha_block_generic);



