Return-Path: <stable+bounces-242006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CmcA9728mmswAEAu9opvQ
	(envelope-from <stable+bounces-242006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:29:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CAA49E10D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C88B8300AD6A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8F377EC6;
	Thu, 30 Apr 2026 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAY0GBet"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001B37757A;
	Thu, 30 Apr 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530582; cv=none; b=bbAEBfsPg5IWE12FVHiSUn2msD3JkiQ52aa0iSRtpa2uh8BQlTs/mINWGt3XxqwB9TXGIOqsmyBt9D6Q40+s4HG93thruMcSxsjdlsmcEE/KiM7aEezH2h73kkpz4UWofsSfTHoMGw/ioxJXCy/N9QUCv4OTUDVxFiIUs/wJZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530582; c=relaxed/simple;
	bh=F+39f7/oLkprlIlCyai3ZYzfL09sOWhLTdLOzk0MTis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1wmsPAY0fHApJnGp6l28N3SOX62PvYNuf0Cu7164K5gEOOAweCR351jCeeqO2HFdoziR23iUw14iiohYPeFj/VUqG3CoO0SE2CS05EX7U7LPfA1t7ZjTYc5pt3SbnEpXNg16obgHR8Qgu5+eSBm/zM6scEii+krPsWCxCR76u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAY0GBet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184FBC2BCB8;
	Thu, 30 Apr 2026 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777530582;
	bh=F+39f7/oLkprlIlCyai3ZYzfL09sOWhLTdLOzk0MTis=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAY0GBetU1aCCFMXuHvMhXifaooWZUNl5YDcLW23CAa/glgMnjApWWZG77PNoi4xQ
	 GYbWNw368b4kecQPuaK+iE4+zTL4D22/GcZjw+vLFQowTvG3RbMK3lvXp03qIcNemn
	 uPaxQmqVLqDXYvDATr815qDh52jUF83XnjXuCAlwCiK6yebPfBwrm3EgGtiOyfvLKS
	 HexMo94R82zkFaG+FJul0M0Kct92MmaB0/8MwXiZIxb4uOzRuucO542vCaZT5pC2kB
	 DixefJK1by9TIKLuUllIar5eZPN7aaTaD+s63gxKGcxYg69HX0VECzCmrLNHhqSaom
	 a6gx2iehMyf0A==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.1 0/9] AF_ALG fixes
Date: Wed, 29 Apr 2026 23:27:22 -0700
Message-ID: <20260430062731.140497-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08CAA49E10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242006-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This series backports recent AF_ALG fixes to 6.1.  First 8 commits are
taken from the 6.12 / 6.6 backport
(https://lore.kernel.org/linux-crypto/20260430060702.110091-1-ebiggers@kernel.org)
rebased onto 6.1 with some conflicts resolved.  Commit 9 is another fix
missing on 6.1.

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

 crypto/Kconfig               |   2 -
 crypto/af_alg.c              |  51 ++-------
 crypto/algif_aead.c          | 203 ++++++++---------------------------
 crypto/algif_skcipher.c      |   6 +-
 crypto/authenc.c             |  32 +-----
 crypto/authencesn.c          |  84 ++++++---------
 crypto/scatterwalk.c         |  94 ++++++++++++++++
 include/crypto/if_alg.h      |   5 +-
 include/crypto/scatterwalk.h |  31 ++++++
 9 files changed, 216 insertions(+), 292 deletions(-)


base-commit: 7c87defbd336df289c8c0280f019647864ff70c6
-- 
2.54.0


