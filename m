Return-Path: <stable+bounces-76210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79014979FF8
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3EE2832C9
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E715667E;
	Mon, 16 Sep 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFDppsOs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C206156661;
	Mon, 16 Sep 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484855; cv=none; b=iz36XQg23isWknpaAF7Ffq2mG0+gPdSsqKX62GtayfeEKt3unKkWRXh0q9MucxC2j283GNtsfmWBEzIG7UtLpVwcwS4EAV4bxXOJuEppDtgEJbtXz6QXxyaQIKETdgsFD44+yFBkBark7UC/v1nbc1ZdpYPXcNxxlPj4U6xQi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484855; c=relaxed/simple;
	bh=Qw+w7KRfHJ0gIw4SApLuVV0TeYVyKK0mF4hCdPm1L68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qad1YVhzgWxzWKeCSjdDRFtwsua7JEVlgTd3cEm9jsSbNBB69W+IWmkKNKlopUON31OL3EYuFnt2Whpezlt7o7pBXb4UQBozXLxIq6BGQ4hyaNOXbJGTkofShK27wfzWqSEeqvhZyL24Rv20h+aPTfG0jKgLdwkvA5lnDxgJuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFDppsOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B07C4CEC4;
	Mon, 16 Sep 2024 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484854;
	bh=Qw+w7KRfHJ0gIw4SApLuVV0TeYVyKK0mF4hCdPm1L68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFDppsOsqgwfFpQ55MhwYdmVmh4f+d2Q70uvglLj6LBcwQo76j3glQGdPkpwhIvsd
	 DeZqjc26MMeRBVYOe04gdoPOGcWsJ/ZcQmiAgMR0J3LiHOkFffv/eTHA9hR3zHC7kU
	 PCn2974yWcij6vLGE7bvlBQpPHl5BSyVl0q6TaL/wc2kcyswq/rCHw3Oh42deWqj7X
	 U2vgj/G3kYWEEHW5HWzj1+qpdUwrOmA/OaOGmTEDpTBMGC79G0i5EOftDJ2q5R9SFl
	 MTstneelbG6BnHx7XOuzvkZ2TvHoQVxEQhgqUqAJWl0/CL07SuAz1v+5wFlPGTcwTT
	 NEq9XzuMnaDTA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 3/6] tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
Date: Mon, 16 Sep 2024 14:07:08 +0300
Message-ID: <20240916110714.1396407-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916110714.1396407-1-jarkko@kernel.org>
References: <20240916110714.1396407-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_null() ignores the return value of tpm2_create_primary().
Further, it does not heal from the situation when memcmp() returns zero.

Address this by returning on failure and saving the null key if there
was no detected interference in the bus.

Cc: stable@vger.kernel.org # v6.11+
Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Refined the commit message.
- Reverted tpm2_create_primary() changes. They are not required if
  tmp_null_key is used as the parameter.
---
 drivers/char/tpm/tpm2-sessions.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d63510ad44ab..9c0356d7ce5e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -850,22 +850,32 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
 static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 {
-	int rc;
 	unsigned int offset = 0; /* dummy offset for null seed context */
 	u8 name[SHA256_DIGEST_SIZE + 2];
+	u32 tmp_null_key;
+	int rc;
 
 	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       null_key);
-	if (rc != -EINVAL)
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc)
+			*null_key = tmp_null_key;
 		return rc;
+	}
 
 	/* an integrity failure may mean the TPM has been reset */
 	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
+
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
 		return rc;
+
+	/* Return the null key if the name has not been changed: */
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
 	/*
 	 * Fatal TPM failure: the NULL seed has actually changed, so
 	 * the TPM must have been illegally reset.  All in-kernel TPM
@@ -874,6 +884,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 	 * userspace programmes can't be compromised by it.
 	 */
 	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
 	return rc;
-- 
2.46.0


