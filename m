Return-Path: <stable+bounces-188198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D3BF2698
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF59189512E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3BF287505;
	Mon, 20 Oct 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haFXT3u+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6F26FA5E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977646; cv=none; b=DStI+299rV1zaUNvjPAci3JBA68z4untxJBPmakCvNZU7ZBDfnWS+dvyIAQaL3byvUp+XZQ0iDKtfDhT2C1vj1uvG0hf79GNmIq+4pD2IbfpQolICo6HOicFJ2EwieCpZoLG4fm217nOyyvh50rcYkB4QG6ePnWJv+lKsoOaN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977646; c=relaxed/simple;
	bh=+6bEQfqPcmHpYswJ1yDmWgE0Pu/wjYoN+9CiAlnCLYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh2Rav3ebTLb6ZPv7A5EMAckgCOC80PzMvVgetPJ61qiwzb6twpSH1R3RCrrvSEG2rHxc+LOl9ugpvmpYV8ucn8Yn2plMk7f2A4ftTG0am7jTn1Frw+dQnUXJPutV1qyk4uctgvLHYBm+fZl7gv0qHqCHh1Rjl3fg8kyxF3PllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haFXT3u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FD6C4CEF9;
	Mon, 20 Oct 2025 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977645;
	bh=+6bEQfqPcmHpYswJ1yDmWgE0Pu/wjYoN+9CiAlnCLYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haFXT3u+i6qBcrtePpH6KQo+6vKX/m1hlSlRbKjTRfInX7f9rxQByJfQ1ZmRP14Fm
	 9yRduRAsAEiLZk3pbq9fP4tJmEyBcwMGOHkXLe3piCHUIxvPlZFaPVfL60ijSTEsXp
	 nUdRhkQ2lpCAYngaiAh16tBvtpaylZr4Zm009anKgqUA+biu10zixIMNH1dtxAT9fZ
	 L3LmERadmvl5aJ530j5P1qtqxDAl7fshosC0hNG3Z7JnT3Jq596NjlYcFQIwTds/yQ
	 apjONiEqyXzlwBd9XOKoDlHcrJznMGqCQvSwTSewwz74di5xamrpDKhOWfb2UQmk+W
	 FJkTWUteEZmEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] KEYS: trusted_tpm1: Compare HMAC values in constant time
Date: Mon, 20 Oct 2025 12:27:23 -0400
Message-ID: <20251020162723.1838996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101624-attitude-destruct-3559@gregkh>
References: <2025101624-attitude-destruct-3559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit eed0e3d305530066b4fc5370107cff8ef1a0d229 ]

To prevent timing attacks, HMAC value comparison needs to be constant
time.  Replace the memcmp() with the correct function, crypto_memneq().

[For the Fixes commit I used the commit that introduced the memcmp().
It predates the introduction of crypto_memneq(), but it was still a bug
at the time even though a helper function didn't exist yet.]

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ changed include from crypto/utils.h to crypto/algapi.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/trusted.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 92a14ab82f72f..3ee9749c14fb6 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -9,6 +9,7 @@
  */
 
 #include <crypto/hash_info.h>
+#include <crypto/algapi.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -248,7 +249,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 	if (ret < 0)
 		goto out;
 
-	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kzfree(sdesc);
@@ -341,7 +342,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
+	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -350,7 +351,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
 	if (ret < 0)
 		goto out;
-	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
+	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
 		ret = -EINVAL;
 out:
 	kzfree(sdesc);
-- 
2.51.0


