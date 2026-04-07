Return-Path: <stable+bounces-233614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOUJOpob1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731103B07EA
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7E7308B5B4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0D33AD9C;
	Tue,  7 Apr 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a6QtnsRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC72BEFED
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573574; cv=none; b=bX0wsWff6DXBGwvsET6W+O8wwLDC7gy/BTbnUlS8f1k8MUcmuCYEpw74ePZ+ny4U28tPveoPfgZnFwNYF43AYRaXS9dh+cXb2bG1Qo2C80Nmla8LnFfTJXJdS2ASrsWXDawKmCRp3z9k1bp4RUY6xUtTEb8SN+RkxoKnptL2hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573574; c=relaxed/simple;
	bh=qfWKOybf3v6w+24l6zvoPNYj8zXq1UaQ0EVFguKFNP8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N1LJy1WepQKZxI0geKif7vHQwosvEFlQRLO7Ki0d5tzrrXrN8nTQAyUPIV2mf4VqwvbKZd9ie1pqHNfgJiROj3gRg+LR1qcuxGTtEmmq96v/5wSlmYl+ABlelClbS/hdGRy55bE9nMwnvASZAnmdLihghuOUixMdcvwkqMtF3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a6QtnsRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6FEC19424;
	Tue,  7 Apr 2026 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573574;
	bh=qfWKOybf3v6w+24l6zvoPNYj8zXq1UaQ0EVFguKFNP8=;
	h=Subject:To:Cc:From:Date:From;
	b=a6QtnsRvvlTov1z4DyN2q8DshO5ogarJVLsS9lNVQ2HW2alOvXWstdM8TeyECjiDH
	 6ixVYwjHLPYNj+UkYqaWDAF3KLXg3YXbxP6QrEwjKI7eRrEg/ntcO0U5c3EG6YAsAx
	 QVp4MRt6Pn1PiKhpwhPCl/SNePli9QrZMwUlS5mI=
Subject: FAILED: patch "[PATCH] lib/crypto: chacha: Zeroize permuted_state before it leaves" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,ardb@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:52:50 +0200
Message-ID: <2026040750-satirical-roman-c106@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233614-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 731103B07EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e5046823f8fa3677341b541a25af2fcb99a5b1e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040750-satirical-roman-c106@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5046823f8fa3677341b541a25af2fcb99a5b1e0 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 25 Mar 2026 20:29:20 -0700
Subject: [PATCH] lib/crypto: chacha: Zeroize permuted_state before it leaves
 scope

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

diff --git a/lib/crypto/chacha-block-generic.c b/lib/crypto/chacha-block-generic.c
index 77f68de71066..4a6d627580cb 100644
--- a/lib/crypto/chacha-block-generic.c
+++ b/lib/crypto/chacha-block-generic.c
@@ -87,6 +87,8 @@ void chacha_block_generic(struct chacha_state *state,
 				   &out[i * sizeof(u32)]);
 
 	state->x[12]++;
+
+	chacha_zeroize_state(&permuted_state);
 }
 EXPORT_SYMBOL(chacha_block_generic);
 
@@ -110,5 +112,7 @@ void hchacha_block_generic(const struct chacha_state *state,
 
 	memcpy(&out[0], &permuted_state.x[0], 16);
 	memcpy(&out[4], &permuted_state.x[12], 16);
+
+	chacha_zeroize_state(&permuted_state);
 }
 EXPORT_SYMBOL(hchacha_block_generic);


