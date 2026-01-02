Return-Path: <stable+bounces-204425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6329CED9CC
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 03:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86123007FDB
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 02:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8030C35D;
	Fri,  2 Jan 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwEItP1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A130C603
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767321923; cv=none; b=Kny1EGZNlHkvXCRISb0qAb6D5JnWtxKplKgRZgk6W8IrcsQPk8zFlVVwpcK4QWWiw9EyNHM5zLybAxqaFsQ2qLbHNfFcIhUmaNZMIPKezAk1j7evPeGmXudoMJAB7YTNqxZqaGRx2QyyNdk4+K9mHKbuSmMDBFEcrxPtVMcqaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767321923; c=relaxed/simple;
	bh=MQsINCOU1hyGJCnl89I5bDH48JGnzEjL1Z1ei4uN1Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq39toCKgvblegRErEWqVL5P4YmLP/1n+InYLbhiaEa22/VGxmT/Xvaf3dv1HY/IekPmlrEg/jUFLxpZBPNtm6n5KUN2AtrHEA4HmQUqjdblp3ysAqaBsL/axVxX5V8wi/ti41u/d6WB0+W8Q5qYrCMMUEaIdxgcLsbPYbZT91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwEItP1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66037C4CEF7;
	Fri,  2 Jan 2026 02:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767321921;
	bh=MQsINCOU1hyGJCnl89I5bDH48JGnzEjL1Z1ei4uN1Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwEItP1dxz5oKQ7XMk9Taq3/D6PxPuKqjQnsdbYi62Zc7N5BZ7gcIQQaaKK8d9LjX
	 0YYnmmeYld+VC/7nCDx57k/v+IBoukj0p5/v70wRJDdb5fb6jVkiXud36yoAxXxuuj
	 vgpMVAkjj3daygXB7dNsFcpfRtNHyAmtkTLtvDCmgPMmXFDTEjlDd+tD/BNzVGh+t+
	 rz9Ddq1q3ElZXDsvxPaTmaLJyiCxyhG4MzKOlwBc6rhkEiHtvwAJMJsbsIvksFGugm
	 uo+MyiwF6XgUiUTyUja6P0CtNm+mVUo7CMVubMrX9ene5y204c7E5W93cRhSg++0Kx
	 y1A9d2mxPOSXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tpm2-sessions: Fix tpm2_read_public range checks
Date: Thu,  1 Jan 2026 21:45:19 -0500
Message-ID: <20260102024519.115144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122907-stream-lasso-ba6e@gregkh>
References: <2025122907-stream-lasso-ba6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit bda1cbf73c6e241267c286427f2ed52b5735d872 ]

tpm2_read_public() has some rudimentary range checks but the function does
not ensure that the response buffer has enough bytes for the full TPMT_HA
payload.

Re-implement the function with necessary checks and validation, and return
name and name size for all handle types back to the caller.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
[ different semantics around u8 name_size() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c      |  3 ++
 drivers/char/tpm/tpm2-sessions.c | 85 ++++++++++++++++++++------------
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index dfdcbd009720..5c525987ff65 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -11,8 +11,11 @@
  * used by the kernel internally.
  */
 
+#include "linux/dev_printk.h"
+#include "linux/tpm.h"
 #include "tpm.h"
 #include <crypto/hash_info.h>
+#include <linux/unaligned.h>
 
 static bool disable_pcr_integrity;
 module_param(disable_pcr_integrity, bool, 0444);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index cf0b83154044..a10db4a4aced 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -156,47 +156,60 @@ static u8 name_size(const u8 *name)
 	return size_map[alg] + 2;
 }
 
-static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
+static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 mso = tpm2_handle_mso(handle);
 	off_t offset = TPM_HEADER_SIZE;
-	u32 tot_len = be32_to_cpu(head->length);
-	u32 val;
-
-	/* we're starting after the header so adjust the length */
-	tot_len -= TPM_HEADER_SIZE;
-
-	/* skip public */
-	val = tpm_buf_read_u16(buf, &offset);
-	if (val > tot_len)
-		return -EINVAL;
-	offset += val;
-	/* name */
-	val = tpm_buf_read_u16(buf, &offset);
-	if (val != name_size(&buf->data[offset]))
-		return -EINVAL;
-	memcpy(name, &buf->data[offset], val);
-	/* forget the rest */
-	return 0;
-}
-
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
-{
-	struct tpm_buf buf;
 	int rc;
+	u8 name_size_alg;
+	struct tpm_buf buf;
+
+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
+	    mso != TPM2_MSO_NVRAM) {
+		memcpy(name, &handle, sizeof(u32));
+		return sizeof(u32);
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
 	if (rc)
 		return rc;
 
 	tpm_buf_append_u32(&buf, handle);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
-	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_read_public(name, &buf);
 
-	tpm_buf_destroy(&buf);
+	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return tpm_ret_to_err(rc);
+	}
 
-	return rc;
+	/* Skip TPMT_PUBLIC: */
+	offset += tpm_buf_read_u16(&buf, &offset);
+
+	/*
+	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
+	 * TPMT_HA (the extra four bytes).
+	 */
+	if (offset + 4 > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	rc = tpm_buf_read_u16(&buf, &offset);
+	name_size_alg = name_size(&buf.data[offset]);
+
+	if (rc != name_size_alg) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	if (offset + rc > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	memcpy(name, &buf.data[offset], rc);
+	tpm_buf_destroy(&buf);
+	return name_size_alg;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
@@ -229,6 +242,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
 	int slot;
+	int ret;
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
@@ -251,8 +265,11 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	if (mso == TPM2_MSO_PERSISTENT ||
 	    mso == TPM2_MSO_VOLATILE ||
 	    mso == TPM2_MSO_NVRAM) {
-		if (!name)
-			tpm2_read_public(chip, handle, auth->name[slot]);
+		if (!name) {
+			ret = tpm2_read_public(chip, handle, auth->name[slot]);
+			if (ret < 0)
+				goto err;
+		}
 	} else {
 		if (name)
 			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
@@ -261,6 +278,10 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	auth->name_h[slot] = handle;
 	if (name)
 		memcpy(auth->name[slot], name, name_size(name));
+	return;
+
+err:
+	tpm2_end_auth_session(chip);
 #endif
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
-- 
2.51.0


