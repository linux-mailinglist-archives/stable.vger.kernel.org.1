Return-Path: <stable+bounces-212555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4gNFI7emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:37:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E693A5E6B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28A4316E103
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB8146D53;
	Wed, 28 Jan 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="elDEHUeE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4002874FE;
	Wed, 28 Jan 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615911; cv=none; b=HcbOo6gB2Q5vxEPWm45Ybk6qtNVpjaKYJ2iyAE2yN6LijZRl2E7Z4RnPhcR9keJYzzR6QYezxbaiaWogTLtJnKC4ml5s7rttQsLPEdHAofd8Mrtt5xpoCpXgsUirtHk7PxlIMyd2EEXyaaxu7xcQY/0Q3fs+6ByQXeB4gZTPOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615911; c=relaxed/simple;
	bh=CyD1s/6VZT5hvLcIyrFZ+XuvitoUCXjc3eTeJ9EEDl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKni1FnhMndb69wH/d+xwU9lqf3ekno8IWHKE+asbmg6YeKkt9YOUzvRwTBXc+G9l6KftEy78/yhRWt+rtRPwVxGguo9RY1kdWtQcZoQLGx2eNrzxB6GuNZEKJ3N1ULfZ4oBTAhxsB93vu/Kof/4BrXMAIayShlw6g/pejykul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=elDEHUeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474CC4CEF1;
	Wed, 28 Jan 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615911;
	bh=CyD1s/6VZT5hvLcIyrFZ+XuvitoUCXjc3eTeJ9EEDl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elDEHUeEwOZsQtCEQhkDq92ZW6DGVBgige0k117WeYhuWb4F7gVt2q3r+88OmdBbQ
	 fWc35uFfhfg3Y9yBqhCLW1OyGrCuHsYW05Fc/JTkcji5CkiS7jLUOoNjebxXf6rHGT
	 ijXkVlnarDS7M82+Z5iGgs6fxibwl8XI2uKFUBwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 151/227] keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal
Date: Wed, 28 Jan 2026 16:23:16 +0100
Message-ID: <20260128145349.889116181@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212555-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_WP_URI(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 2E693A5E6B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srish Srinivasan <ssrish@linux.ibm.com>

[ Upstream commit 6342969dafbc63597cfc221aa13c3b123c2800c5 ]

TPM2_Unseal[1] expects the handle of a loaded data object, and not the
handle of the parent key. But the tpm2_unseal_cmd provides the parent
keyhandle instead of blob_handle for the session HMAC calculation. This
causes unseal to fail.

Fix this by passing blob_handle to tpm_buf_append_name().

References:

[1] trustedcomputinggroup.org/wp-content/uploads/
    Trusted-Platform-Module-2.0-Library-Part-3-Version-184_pub.pdf

Fixes: 6e9722e9a7bf ("tpm2-sessions: Fix out of range indexing in name_size")
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 7187768716b78..74cea80ed9be5 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -489,7 +489,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 }
 
 /**
- * tpm2_unseal_cmd() - execute a TPM2_Unload command
+ * tpm2_unseal_cmd() - execute a TPM2_Unseal command
  *
  * @chip: TPM chip to use
  * @payload: the key data in clear and encrypted form
@@ -520,7 +520,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, blob_handle, NULL);
 	if (rc)
 		goto out;
 
-- 
2.51.0




