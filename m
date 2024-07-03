Return-Path: <stable+bounces-57835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2C925E41
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28B61C20E6F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710EB17D34C;
	Wed,  3 Jul 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgGNSi1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DF6E5ED;
	Wed,  3 Jul 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006076; cv=none; b=LlTBWspXexvAJpOFYx3ByvP+8DpdmcYbDHWAThqHmghYRoP9Nh4mLsQmbiUGhd3vkMz4QDE6vNbAP7I27aLKMhLVXDbRBhD4/tC/9vi691f3z8qbR4P41BagyMrdgjjvJlriyVNlKiXE+i4vNAOq7748hbLp9V+LarI5Z9Apmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006076; c=relaxed/simple;
	bh=ZLzrNjHU1Lvy8V9o6kUjOETm54A469m3tOCk7AwN9g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9qhmaap8ChHVWHLnaFfizqYl7EtfRJ0pVtB6Zg/cfANkZIomcEwpk228teogUlxB5EZXBedCM5iAT+yVNS2iiMredTwdwZHqM9qh27gQYDsp9qKfzJB/WPYAQiTYpMNr3A+VMQYn2Ve0SOYOVBZ9Bk+OdY1q2ONyuKAj58+k1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgGNSi1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0EFC2BD10;
	Wed,  3 Jul 2024 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006076;
	bh=ZLzrNjHU1Lvy8V9o6kUjOETm54A469m3tOCk7AwN9g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgGNSi1qTG6cQX5Mfb/+5ZalHzAvneUJh3VoTab/xXqh2lxclfggshN8CaxWa3c1u
	 xqYx3nB0cT6MnkxurSXRLBZ7uiXHo1MVanEt3Bv8bcZWaB/NV9+bsytODgsbvYZjRz
	 tVA1QLqPBheLf0AL7ZtvelvSkMlYBQkpD63OS18Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joachim Vandersmissen <git@jvdsn.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 293/356] crypto: ecdh - explicitly zeroize private_key
Date: Wed,  3 Jul 2024 12:40:29 +0200
Message-ID: <20240703102924.202701801@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joachim Vandersmissen <git@jvdsn.com>

[ Upstream commit 73e5984e540a76a2ee1868b91590c922da8c24c9 ]

private_key is overwritten with the key parameter passed in by the
caller (if present), or alternatively a newly generated private key.
However, it is possible that the caller provides a key (or the newly
generated key) which is shorter than the previous key. In that
scenario, some key material from the previous key would not be
overwritten. The easiest solution is to explicitly zeroize the entire
private_key array first.

Note that this patch slightly changes the behavior of this function:
previously, if the ecc_gen_privkey failed, the old private_key would
remain. Now, the private_key is always zeroized. This behavior is
consistent with the case where params.key is set and ecc_is_key_valid
fails.

Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/ecdh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index c6f61c2211dc7..865e76e5a51c4 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -33,6 +33,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	    params.key_size > sizeof(u64) * ctx->ndigits)
 		return -EINVAL;
 
+	memset(ctx->private_key, 0, sizeof(ctx->private_key));
+
 	if (!params.key || !params.key_size)
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
-- 
2.43.0




