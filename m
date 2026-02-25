Return-Path: <stable+bounces-218838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLlYCypXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1719049E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54E123085833
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984326F476;
	Wed, 25 Feb 2026 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBjHV50O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199E26056D;
	Wed, 25 Feb 2026 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983721; cv=none; b=NesqM9reVmCtidnypMk7qkB1fJiFsFVpIkhoze8UB0PSzqDQvf+i+UX74LjSUz6wFMHV3VkL95ky2/wM/s28x6TU11KZacoQylhdLT82iqlg0rWV6kWXNpYxNUj0pZ2ZxbnIGE/2DyOWAXjFo4foAeLdlbx6BaflEU0qeSwQukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983721; c=relaxed/simple;
	bh=RcwfHM6GCxalZjzYoDNec0tFZckhIl3oNN+fpH3FJiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlZ115Gs6rg3YxZvoYuvU0gUC9LOMyNajVoT2a8fimsHR4nyQ/3toPsEnh1lhwHK0cizjw+M5hV8HgjFWym1a3jCVDtyCOSWsOY7UCVTCTuMhi2d2lOBJ6YYqYGWjyv8wdX2Sj6sy2uEX0CfIQTAKwEm0hla8v+6bsLDMoZkzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBjHV50O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C1CC116D0;
	Wed, 25 Feb 2026 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983720;
	bh=RcwfHM6GCxalZjzYoDNec0tFZckhIl3oNN+fpH3FJiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBjHV50OZouC1R47smUluFAL73vYE2TbaOWDyB48U8snF6v+IO2sMMZxBd7nBWG7t
	 7nLNRQz6V53fCh5JozwqZHl1dKhIHn3zfmVdRiSPvP8qiRnutbS2j+OW6eD9N4Avfd
	 c51hAB3p0LoV/WSOm1QA31tWf96NfU5LFywy0nXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alper Ak <alperyasinak1@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 018/641] tpm: tpm_i2c_infineon: Fix locality leak on get_burstcount() failure
Date: Tue, 24 Feb 2026 17:15:44 -0800
Message-ID: <20260225012349.408880733@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218838-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 45E1719049E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alper Ak <alperyasinak1@gmail.com>

[ Upstream commit bbd6e97c836cbeb9606d7b7e5dcf8a1d89525713 ]

get_burstcount() can return -EBUSY on timeout. When this happens, the
function returns directly without releasing the locality that was
acquired at the beginning of tpm_tis_i2c_send().

Use goto out_err to ensure proper cleanup when get_burstcount() fails.

Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_i2c_infineon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index bdf1f329a6794..8b7d32de0b2ef 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -544,8 +544,10 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		burstcnt = get_burstcount(chip);
 
 		/* burstcnt < 0 = TPM is busy */
-		if (burstcnt < 0)
-			return burstcnt;
+		if (burstcnt < 0) {
+			rc = burstcnt;
+			goto out_err;
+		}
 
 		if (burstcnt > (len - 1 - count))
 			burstcnt = len - 1 - count;
-- 
2.51.0




