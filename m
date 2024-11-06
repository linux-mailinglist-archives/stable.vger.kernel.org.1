Return-Path: <stable+bounces-90627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1BF9BE943
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB641F2255F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325641DED58;
	Wed,  6 Nov 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtPyxtm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE91DF251;
	Wed,  6 Nov 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896335; cv=none; b=HmpwK9+ZBdemiGLLObpHpA47cYlE9rPOmHE7AYVzDBRrFNf6uruw5gOkYiRVQHFqXeElFtPYVFdV8FnBxVhzA0zaQENaxJjDsUxdqqmb4DwBZXDfPbmo0Pk2HKzEkB+WYdZtQXMOWMBlw3YaEMXczgsdvNwDPK1BDgJCdBThawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896335; c=relaxed/simple;
	bh=RII3Np4iBzaaxAmEUexQSX0Ygi7Ujocy2ER8+83CCrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVt6oy+xMMqj2oDK3z7exyQhyQMDsfxU8dLyeMuDrjiqLyynLmpSVNQ3VbCONDAgTAUClFg2jCyq7RYUwRm0iWHaHbnanBHj/lCxPaad/nTvmOPjy3IbnoNVBclOzeOLbh9O3E0ublkADzfo05XDE3TEKzPZYI9ijDmVIsG1t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtPyxtm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B20BC4CECD;
	Wed,  6 Nov 2024 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896334;
	bh=RII3Np4iBzaaxAmEUexQSX0Ygi7Ujocy2ER8+83CCrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtPyxtm0Vvd64WFqeMAl06H4G1s+Gb2FQ/okHKUNB/sPRswO88UBuNP36Q7Yk4nFM
	 UDbNytfoBk4v9CKPPTYRfaFTyG9kNP+xz4+KpUd3WLXRtOShmwrxRnkm+3cjg6vZty
	 gJSferdg4bWRBWnmVg7fXT4+A+exggerZoaavUEg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 168/245] tpm: Rollback tpm2_load_null()
Date: Wed,  6 Nov 2024 13:03:41 +0100
Message-ID: <20241106120323.374753070@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit cc7d8594342a25693d40fe96f97e5c6c29ee609c ]

Do not continue on tpm2_create_primary() failure in tpm2_load_null().

Cc: stable@vger.kernel.org # v6.10+
Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 44 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 9551eeca6d691..a194535619929 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -915,33 +915,37 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
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
-		return rc;
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc)
+			*null_key = tmp_null_key;
+		goto err;
+	}
 
-	/* an integrity failure may mean the TPM has been reset */
-	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
-		return rc;
-	/*
-	 * Fatal TPM failure: the NULL seed has actually changed, so
-	 * the TPM must have been illegally reset.  All in-kernel TPM
-	 * operations will fail because the NULL primary can't be
-	 * loaded to salt the sessions, but disable the TPM anyway so
-	 * userspace programmes can't be compromised by it.
-	 */
-	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	/* Try to re-create null key, given the integrity failure: */
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
+		goto err;
+
+	/* Return null key if the name has not been changed: */
+	if (!memcmp(name, chip->null_key_name, sizeof(name))) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
+	/* Deduce from the name change TPM interference: */
+	dev_err(&chip->dev, "null key integrity check failed\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
-	return rc;
+err:
+	return rc ? -ENODEV : 0;
 }
 
 /**
-- 
2.43.0




