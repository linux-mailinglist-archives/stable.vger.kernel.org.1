Return-Path: <stable+bounces-235121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EpYKEWr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:23:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B993C2E43
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3147A3106474
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3521B67E;
	Wed,  8 Apr 2026 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KScmFFfe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6578348453;
	Wed,  8 Apr 2026 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674623; cv=none; b=uxzbMYj8RX6G5BHo8zyKE8oPDnf3exaXRFCXkQuigHQxztHR7LdCTIB9CnXWfupsHSKNBN2M7fimTIU6LKaeL09cl4SqcBHc9VefK6LTb7mFnKIyDX9cyWTrh8ol9AvKr0cY9E+eILszQr/s5/gIFHyx5lszvCLMzd9oaEJ2CFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674623; c=relaxed/simple;
	bh=Ky+Hl9RkNZVQv//mnY9f5LppVItdZRBnjewK71l3AQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmyzDmGCSED52KXiPIdPbZEsb2u7Xkqsu1PURRi9xX/9fwQiPOpMkFncAw6fs/yHgoyqXnMymxEwgOOCDlGzXJBNAIUZw3wJJ+Usg0Xzj2jcYUWkMrTYYd2niKSxp0wFeMbtQvBSKQnYZYeArK8xi/2pLnswBS1dTWfLnlksWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KScmFFfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5DEC19421;
	Wed,  8 Apr 2026 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674623;
	bh=Ky+Hl9RkNZVQv//mnY9f5LppVItdZRBnjewK71l3AQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KScmFFfey/i2HZ5uHv1s9s2eLUzi+xStH+l/Upi6EfiYFYeYvPMkPRQSIbVLALFNd
	 DYeTSGWT7CNdDFi4l73sfad/OvG0JxGEjAQ82ZgoG2C9iD4aTZmrSYrIb7RrRwiXya
	 3di9OR8dXrvlQqCMSWeTdjfC8+FSAbeodzVRBmwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.19 168/311] lib/crypto: chacha: Zeroize permuted_state before it leaves scope
Date: Wed,  8 Apr 2026 20:02:48 +0200
Message-ID: <20260408175945.678317708@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235121-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 19B993C2E43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
 lib/crypto/chacha-block-generic.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/lib/crypto/chacha-block-generic.c
+++ b/lib/crypto/chacha-block-generic.c
@@ -87,6 +87,8 @@ void chacha_block_generic(struct chacha_
 				   &out[i * sizeof(u32)]);
 
 	state->x[12]++;
+
+	chacha_zeroize_state(&permuted_state);
 }
 EXPORT_SYMBOL(chacha_block_generic);
 
@@ -110,5 +112,7 @@ void hchacha_block_generic(const struct
 
 	memcpy(&out[0], &permuted_state.x[0], 16);
 	memcpy(&out[4], &permuted_state.x[12], 16);
+
+	chacha_zeroize_state(&permuted_state);
 }
 EXPORT_SYMBOL(hchacha_block_generic);



