Return-Path: <stable+bounces-235781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAxpGrj62mlK7wgAu9opvQ
	(envelope-from <stable+bounces-235781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:51:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEC3E26B1
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D22301A93B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D92C027C;
	Sun, 12 Apr 2026 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edcOz6Rt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E23156F45;
	Sun, 12 Apr 2026 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775958705; cv=none; b=YIHuv9hxGsrBuf87eIJJTQZezgKxPEscpFOJ9vyNVCG3+/6hF+KkkvfpON2Oa/UzfLFqIpSXFzlEhXbkKvmMCmcmSmE35y0MHlscowLrEc5/sQFMPyNmDri0wY+d0yqsKyVapMvc968x+J65LVpyQgKCLcs838LACzrmhq7Ms2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775958705; c=relaxed/simple;
	bh=p43LWCrBdIDOSCiiR2D43lPcA0u6mbkljzridIfhFts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOsCpKqeD0qoJYS0SMnSFVJyZpnBj4FD4OMAMFti3EQc9FmTqZxmftmL8UqSDH50HmM5s3aDE86lbkacnRY00+aj/QtbRy43GderE0u5F7yKOeVEB5JB63ku4DCYa8StlndUM27lh9Fe1IUmYh5a5CiCdxbQ1lwQN3fgSIocP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edcOz6Rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FE9C116C6;
	Sun, 12 Apr 2026 01:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775958705;
	bh=p43LWCrBdIDOSCiiR2D43lPcA0u6mbkljzridIfhFts=;
	h=From:To:Cc:Subject:Date:From;
	b=edcOz6RtsiwEmN10z9PpwUDBfUSmiJ6r48Hwhi3GxD/2VyERzyaTZrLkDyHdgSEPs
	 Wq4II7S1d/SV4+MAdnWxWfj0VzkUiCmVB8GNkeqjLHOX7lLSl9qPmq2aPcoPPXMbf7
	 iFkXV37wK5JpevaUzdvZGhOC3uddqYYzKlIHo/H3kWIbAjEKDmanchq+ftb9lKDnoU
	 7oj8Kwz2kP45zCg6M36p4RAA6zjdQf603r8KIGo/11C5e4QAM0rAWphi5MEOJyvmhK
	 m0dkEwrGIr2PcprebT5yICdrRKkyc2tyJZBD3R6HP/Oano0BJ30NirMkKqKMd3CjSS
	 yBhn4EXQZyCJw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12, 6.6, 6.1, 5.15, 5.10] lib/crypto: chacha: Zeroize permuted_state before it leaves scope
Date: Sat, 11 Apr 2026 18:50:11 -0700
Message-ID: <20260412015011.18887-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235781-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BECEC3E26B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20260326032920.39408-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/chacha.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/crypto/chacha.c b/lib/crypto/chacha.c
index 3cdda3b5ee060..1271a7de1ba79 100644
--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -84,10 +84,12 @@ void chacha_block_generic(u32 *state, u8 *stream, int nrounds)
 
 	for (i = 0; i < ARRAY_SIZE(x); i++)
 		put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);
 
 	state[12]++;
+
+	memzero_explicit(x, sizeof(x));
 }
 EXPORT_SYMBOL(chacha_block_generic);
 
 /**
  * hchacha_block_generic - abbreviated ChaCha core, for XChaCha
@@ -108,7 +110,9 @@ void hchacha_block_generic(const u32 *state, u32 *stream, int nrounds)
 
 	chacha_permute(x, nrounds);
 
 	memcpy(&stream[0], &x[0], 16);
 	memcpy(&stream[4], &x[12], 16);
+
+	memzero_explicit(x, sizeof(x));
 }
 EXPORT_SYMBOL(hchacha_block_generic);

base-commit: e7a3953084a7050ca349010deb22546834c2e196
-- 
2.53.0


