Return-Path: <stable+bounces-241995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IxAGg/y8mnNvwEAu9opvQ
	(envelope-from <stable+bounces-241995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:09:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B450649DDCF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DED6300E279
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D86372EF9;
	Thu, 30 Apr 2026 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbgO+118"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0844369224;
	Thu, 30 Apr 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529352; cv=none; b=VHOx8LmtcIMdSR1aspTkCrxtPZmtPhAo8+uyQs7V7kzg+E7j5+gqx05X+v3dQimWgYShDTjtWeP6Ru/g6R421LeOHb9Yo3aSGPTjlTNEA4FlL/J06ngQhfWTglW85gStJtdHoQSkUSNc5DpcRS8LLwBHFlLWd5AhswW0goLmDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529352; c=relaxed/simple;
	bh=r4fe/GjSCsvrIK5FIRcRFbrwzSxYFCY+7seKgmmrRg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnOmC62rUcML5Ag8ghqaXZ7PDUI3bVKRO3DOLVWLHCcNIvEvJ0nLGdofK6i8LtcRRHOStC9JjUQvXB3+Dm1xPH415SSXsy1P3Tpap4P3UZtYA6HbVtXAYSxv1GhawwGHpau68EmqF35IZROiuNIbKIpcblqluZaJuB0eCQsb4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbgO+118; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6EEC2BCB8;
	Thu, 30 Apr 2026 06:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777529352;
	bh=r4fe/GjSCsvrIK5FIRcRFbrwzSxYFCY+7seKgmmrRg8=;
	h=From:To:Cc:Subject:Date:From;
	b=IbgO+118/VxSvcI7K6ts80OFoGqMlLZWFNLIqybr4TY7ZTd29w7EfQXHn0OeogLVM
	 QlVNo51sQ7UNG+3kUyiYx6XkJEiSRaJo8f5ojS3MOgqIVJVHa9qOddmEkVG7QgMzj5
	 OOVIbM62tzHTQkl0C40l1G6qhtHx8Vfsq7Al2Qd5JO1EAOv/Y9/irNNZwLdMrXoKoX
	 m0o8Wc1+s7oUuC2K9QMbug9ZWGG7JJVOg33kNqNiSR/DK/mbqMo6oe/h1rMCzhuEKo
	 UQ4oScRvsVAuANjC8cjx5fRwJMar0M5b5piMhrROSlwcPUbgIcdoS+tNcPIRq9lmQp
	 2+VQgLLL7oW7Q==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.12 0/8] AF_ALG fixes
Date: Wed, 29 Apr 2026 23:06:54 -0700
Message-ID: <20260430060702.110091-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B450649DDCF
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
	TAGGED_FROM(0.00)[bounces-241995-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series backports the recent AF_ALG fixes to 6.12.  These include
the fix for https://copy.fail/, fixes for that fix, and some other fixes
that went in at around the same time that seem related.

To enable the 5 actual fix commits to cherry-pick cleanly, commit 1
copies the latest implementation of memcpy_sglist() from upstream, and
commits 2 and 5 cleanly cherry-pick a couple cleanup commits.

I didn't check older kernels yet, but this should be usable as a
starting point for them.

Douya Le (1):
  crypto: algif_aead - snapshot IV for async AEAD request

Eric Biggers (3):
  crypto: scatterwalk - Backport memcpy_sglist()
  crypto: algif_aead - use memcpy_sglist() instead of null skcipher
  crypto: authenc - use memcpy_sglist() instead of null skcipher

Herbert Xu (4):
  crypto: algif_aead - Revert to operating out-of-place
  crypto: authencesn - Do not place hiseq at end of dst for out-of-place
    decryption
  crypto: authencesn - Fix src offset when decrypting in-place
  crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl

 crypto/Kconfig               |   2 -
 crypto/af_alg.c              |  51 ++-------
 crypto/algif_aead.c          | 203 +++++++----------------------------
 crypto/algif_skcipher.c      |   6 +-
 crypto/authenc.c             |  32 +-----
 crypto/authencesn.c          |  84 ++++++---------
 crypto/scatterwalk.c         |  94 ++++++++++++++++
 include/crypto/if_alg.h      |   5 +-
 include/crypto/scatterwalk.h |  31 ++++++
 9 files changed, 215 insertions(+), 293 deletions(-)


base-commit: c286ea5e62389897291fa742d2bb909ecc9ef2d0
-- 
2.54.0


