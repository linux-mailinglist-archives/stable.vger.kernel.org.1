Return-Path: <stable+bounces-212334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLpHGFEwemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1015A48B0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62FAA3072BE8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B93019A6;
	Wed, 28 Jan 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpek9Z2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530930C34E;
	Wed, 28 Jan 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615170; cv=none; b=GAPCbtRpq4hjfIpA5G0jeuWy+oaS3xZfGcj4Wwu9wfz1Gc5wEC0msTmwrL8lVKRo83E2v+0DfYyZglURPC+gbm7HR8AZE3XCa0Jx4XbZp1sIgKCXwj6BY3WSAK7QHyhmVgPLjFAGCUaRjKozLOjNpyOtb9OYdryko2aXd+qINO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615170; c=relaxed/simple;
	bh=eKdih7893CUebL3wxqqRE3vaOEN37WnrveKxTjl90I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihG8vRMoahacRsuczQgvfrVKhFR4STqHBp+KRj8PfhU47L/hgDiHQUPJG8vPghmXlYZ8A5YrIW/wnfojWeUZA5ctHVWQ+M9P7hfha26DMF2RwOH48hw1ShgjdiCeFtspqG1sAbf9+zeN8+VDdwTNEgzNULOvvifQzDM8TimM/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpek9Z2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A03C4CEF1;
	Wed, 28 Jan 2026 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615170;
	bh=eKdih7893CUebL3wxqqRE3vaOEN37WnrveKxTjl90I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpek9Z2j0mwQ/N4HER+++07+Sr4wbtUvmB5+39lq7zoszV3fM2uGOWOC6xXNCJJBM
	 q8b/8e75GS3I36/Nk4gO4m+N6aJ1l85XuO8DDY2Fh2qBFrY1EgONECMNngcqpVKqqn
	 hcUhu+46LivLPp/xwB76joih82663kKTDRmnB/SY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 099/169] tpm: Compare HMAC values in constant time
Date: Wed, 28 Jan 2026 16:23:02 +0100
Message-ID: <20260128145337.570473622@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212334-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1015A48B0
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 2c2615c8423890b5ef8e0a186b65607ef5fdeda1 ]

In tpm_buf_check_hmac_response(), compare the HMAC values in constant
time using crypto_memneq() instead of in variable time using memcmp().

This is worthwhile to follow best practices and to be consistent with
MAC comparisons elsewhere in the kernel.  However, in this driver the
side channel seems to have been benign: the HMAC input data is
guaranteed to always be unique, which makes the usual MAC forgery via
timing side channel not possible.  Specifically, the HMAC input data in
tpm_buf_check_hmac_response() includes the "our_nonce" field, which was
generated by the kernel earlier, remains under the control of the
kernel, and is unique for each call to tpm_buf_check_hmac_response().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 6342969dafbc ("keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/Kconfig         | 1 +
 drivers/char/tpm/tpm2-sessions.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index db41301e63f28..f0473d2148786 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -33,6 +33,7 @@ config TCG_TPM2_HMAC
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_UTILS
 	help
 	  Setting this causes us to deploy a scheme which uses request
 	  and response HMACs in addition to encryption for
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 4d9acfb1787e9..cb944df7b3ca6 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -71,6 +71,7 @@
 #include <crypto/ecdh.h>
 #include <crypto/hash.h>
 #include <crypto/hmac.h>
+#include <crypto/utils.h>
 
 /* maximum number of names the TPM must remember for authorization */
 #define AUTH_MAX_NAMES	3
@@ -888,12 +889,11 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	/* we're done with the rphash, so put our idea of the hmac there */
 	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
 			+ auth->passphrase_len, rphash);
-	if (memcmp(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE) == 0) {
-		rc = 0;
-	} else {
+	if (crypto_memneq(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE)) {
 		dev_err(&chip->dev, "TPM: HMAC check failed\n");
 		goto out;
 	}
+	rc = 0;
 
 	/* now do response decryption */
 	if (auth->attrs & TPM2_SA_ENCRYPT) {
-- 
2.51.0




