Return-Path: <stable+bounces-244804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APF1DFgc/mnymwAAu9opvQ
	(envelope-from <stable+bounces-244804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:24:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19B4F9EAE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 652C3301A17D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFC035CB6D;
	Fri,  8 May 2026 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5iiUA0E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6E3E3C6D
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261073; cv=none; b=cfITtN8l3oH1TQZgCquiiM57BpqPrzq6H5/l8YTiksHfYYGe9vu6P/mkWQ7Rw84zKixyIXmlMWWB97gER5w8WRm5kHdwJBWj/1tIgVlPbopccPxp+nqSFx119NpFHWwa1nQzbhdGTe70ur/t0KNtJmdeLoplft1G31OWfZEr984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261073; c=relaxed/simple;
	bh=0xhshe2tDNR1m7BlykJNVpQHvnxYhnLl4bFd8BrmU84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThK14IkXHC1/uVBjbTwmQhVao8UCT6iNHelRgDKGViTTanNLuRlE0GzfWpmqUPwS3IO52MYM9mosaJwFwudNB5IlOg5kIr+s7CcsfTOinhAIXzMOmupoRi75uq6dVj1OzUEECwl0Jid+hnLNWKHlqEdIN0tTppX9/Ln4R/1VZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5iiUA0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1FDC2BCB0;
	Fri,  8 May 2026 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778261073;
	bh=0xhshe2tDNR1m7BlykJNVpQHvnxYhnLl4bFd8BrmU84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5iiUA0Ebu2MY13Ou8Q5Uhgqhh3aG/rTiSBr7fq1iIQO4w4KS5Pv2AKaDzAILZSki
	 rmUP9JTculS5GwTbnI1tJYiPp6mC8WT6IpwK1TYkVXWMFokjUqQ0rmKdSd0wUjvQm5
	 l3VYijmA45gATpkQTsbBxZ5uDKcr7M7CPi6Hsh6sybbrxE3hwLM1jSjvk1HVHjFhXK
	 eUYxGfyDo5YgW8Ny4ovI0/40UjtYVu6JckCY3oG9rRps312/eEybY9pF2FXa6sP50E
	 MMUb4qEc+M4qsqQYekTT6HZ+f7YDXen7JNeyBfhhoYNBAcMSYWhr1x204f4grh1cEl
	 uOCaQxnUTk9/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] tpm_tis: Move CRC check to generic send routine
Date: Fri,  8 May 2026 13:24:28 -0400
Message-ID: <20260508172429.1767444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050324-jump-diploma-db0f@gregkh>
References: <2026050324-jump-diploma-db0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C19B4F9EAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244804-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infineon.com:email]
X-Rspamd-Action: no action

From: Alexander Steffen <Alexander.Steffen@infineon.com>

[ Upstream commit 32a0c860ff48543299772f7a98f32dd3ee9281b7 ]

The CRC functionality is initialized before tpm_tis_core, so it can be used
on all code paths within the module. Therefore, move the CRC check to the
generic send routine, that also contains all other checks for successful
command transmission, so that all those checks are in one place.

Also, this ensures that tpm_tis_ready is called when a CRC failure is
detected, to clear the invalid data from the TPM, which did not happen
previously.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 949692da7211 ("tpm: tpm_tis: stop transmit if retries are exhausted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 968b891bcb030..88a85aff3cb82 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -464,6 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		goto out_err;
 	}
 
+	rc = tpm_tis_verify_crc(priv, len, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "CRC mismatch for command.\n");
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
@@ -517,12 +523,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
-	rc = tpm_tis_verify_crc(priv, len, buf);
-	if (rc < 0) {
-		dev_err(&chip->dev, "CRC mismatch for command.\n");
-		return rc;
-	}
-
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.53.0


