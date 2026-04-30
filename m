Return-Path: <stable+bounces-242029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBe2LOD+8mmIwQEAu9opvQ
	(envelope-from <stable+bounces-242029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925A49E57A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD573007F5D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBF396577;
	Thu, 30 Apr 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPAfy6AC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782B395259;
	Thu, 30 Apr 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532610; cv=none; b=ipT0XEXneKB+t3flMCkH8hj5G1XCXq0mF0FEWjFWn99OzGE9iMS/JB1KZUoDulEzruGQ1jbiIgvZsdF4FKVK/ld1t8BuR8wvV2G0Ui3GfCRxOoXt6mgeBHKAkfqyxs3CTD4KV74O4mL/9SVbHeQ9Q0KsvXU511pev3tJigA8uaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532610; c=relaxed/simple;
	bh=ldHduypkfg8LNl5PWslKxZaIFVNY3iE0K9zRSjzyDOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKj+OEaSs7F9DGL/O1lS0p5KTC820bl8vfsNtyvnEBXHg36YxcFyVcmdJCIvbYlrh6Qf3M4qvjG9fqpgf1NIZYlk79pYXy/K0szGgQgLPj47PToYiP9uQ9i6AlCsp7A4Yw1Ko2IHFKUttgX+VGD3Aj2J9uzOWrnntSBXesXDV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPAfy6AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A9C2BCB3;
	Thu, 30 Apr 2026 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777532610;
	bh=ldHduypkfg8LNl5PWslKxZaIFVNY3iE0K9zRSjzyDOE=;
	h=From:To:Cc:Subject:Date:From;
	b=sPAfy6ACvgYEcvNTWIYswdN1gRRtTpwosZwUL2RVXlrfryvXzyg3fwahI+7R4OX7W
	 fHcyNpeoGttOWYHo0iAYb7TwMbN1U7G1aZ/kxRVM989/f5mrrIqTWGVyCToy6gPIlT
	 ENF7b4vkPsC8oqwVxtpy/ScnZnpBJNBknXcVptBUFWSy1eqbbKUwWVwF3ZuN8vcq0i
	 nB+F2a3Z2nZUqwpnIIQgmPoJJwZ5B2CRMrN2H8AycOKTIo6Lw0q2y00dRebyYFOOXf
	 t8Mc3i1Hl/6m+vUkHFxua43FOo8mLW9qtDx+XEXIHxAoGbR3I0BaZhRxaPCWjAEGp3
	 ujZMyWaET+yPQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.10 00/10] AF_ALG fixes
Date: Thu, 30 Apr 2026 00:01:18 -0700
Message-ID: <20260430070128.219863-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0925A49E57A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242029-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series backports recent AF_ALG fixes to 5.10.  Compared to the 5.15
series
(https://lore.kernel.org/linux-crypto/20260430063604.173525-1-ebiggers@kernel.org)
I changed memcpy_sglist() to use atomic kmaps instead of local kmaps,
since local kmaps are not available in 5.10.  I also added "crypto: doc
- fix kernel-doc notation in chacha.c and af_alg.c" to make a later
commit cherry-pick cleanly.

Douya Le (1):
  crypto: algif_aead - snapshot IV for async AEAD requests

Eric Biggers (3):
  crypto: scatterwalk - Backport memcpy_sglist()
  crypto: algif_aead - use memcpy_sglist() instead of null skcipher
  crypto: authenc - use memcpy_sglist() instead of null skcipher

Herbert Xu (5):
  crypto: algif_aead - Revert to operating out-of-place
  crypto: authencesn - Do not place hiseq at end of dst for out-of-place
    decryption
  crypto: authencesn - Fix src offset when decrypting in-place
  crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
  crypto: algif_aead - Fix minimum RX size check for decryption

Randy Dunlap (1):
  crypto: doc - fix kernel-doc notation in chacha.c and af_alg.c

 crypto/Kconfig               |   2 -
 crypto/af_alg.c              | 137 +++++++++++------------
 crypto/algif_aead.c          | 203 ++++++++---------------------------
 crypto/algif_skcipher.c      |   6 +-
 crypto/authenc.c             |  32 +-----
 crypto/authencesn.c          |  84 ++++++---------
 crypto/scatterwalk.c         |  98 +++++++++++++++++
 include/crypto/if_alg.h      |   5 +-
 include/crypto/scatterwalk.h |  32 ++++++
 lib/crypto/chacha.c          |   4 +-
 10 files changed, 272 insertions(+), 331 deletions(-)


base-commit: 49e5d20074c20b20773c6dc0f8dce0635591093b
-- 
2.54.0


