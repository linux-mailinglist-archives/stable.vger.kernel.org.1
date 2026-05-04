Return-Path: <stable+bounces-243495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNeVJYes+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FA4BF64C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9B19304434B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7733DEAC8;
	Mon,  4 May 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aSL+uzFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7193DE45D;
	Mon,  4 May 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904031; cv=none; b=rBwNMxv3qFbluDnRYLPfGDPRpBFKNs0l0cjQWA6RtKOLmZyz4jSfid8Sre1bhGY/8Dbs/qjEACCzrtsk5P7xlUBvdLQzk+NQU0eU4I/3M7K4tq9jOWSEkSfagRuyi3s1JdiiVz7jTXpMiAYmzBu+jKJfbByagomP8OUc+40Lb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904031; c=relaxed/simple;
	bh=k3nj/+pWAgo+Ez5leC6z5w2NdogqenHNBUoCjn+cX5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7JUTaBNqHPmfq/7CTb/WsHFxZOkNIv7bkiVe2GE6fVHg2ODdmVrExhxdaxo/bp+EUhFqq9rhVC3cgfIgpMEX3uRhsWkIae/893mrzb5UhMtqXUybNN+c+I50KUKa9Uc5AcBfZgcTg6Zt/48hN/qHvSGmXFkw11WQwXgdfBSsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aSL+uzFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A23C2BCC4;
	Mon,  4 May 2026 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904031;
	bh=k3nj/+pWAgo+Ez5leC6z5w2NdogqenHNBUoCjn+cX5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSL+uzFnjOH/tXNqkY1DrAGOF8dV43RpOCCTfCjpraps2r4Jpc3/CZOzAOkZlaXhj
	 pRvlNey9FfhKKu2X2v+zThNhzv9RvcANMXWrLW1Ttq2iX0yNN1hBKkmxgdhN7RN00q
	 ellaAkQjIT3GGx0POX53/GWyM0unrE4ReCCxN2c4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.18 155/275] tpm2-sessions: Fix missing tpm_buf_destroy() in tpm2_read_public()
Date: Mon,  4 May 2026 15:51:35 +0200
Message-ID: <20260504135148.710193991@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 992FA4BF64C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243495-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gunnar Kudrjavets <gunnarku@amazon.com>

commit f0f75a3d98b7959a8677b6363e23190f3018636b upstream.

tpm2_read_public() calls tpm_buf_init() but fails to call
tpm_buf_destroy() on two exit paths, leaking a page allocation:

1. When name_size() returns an error (unrecognized hash algorithm),
   the function returns directly without destroying the buffer.

2. On the success path, the buffer is never destroyed before
   returning.

All other error paths in the function correctly call
tpm_buf_destroy() before returning.

Fix both by adding the missing tpm_buf_destroy() calls.

Cc: stable@vger.kernel.org # v6.19+
Fixes: bda1cbf73c6e ("tpm2-sessions: Fix tpm2_read_public range checks")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm2-sessions.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -203,8 +203,10 @@ static int tpm2_read_public(struct tpm_c
 	rc = tpm_buf_read_u16(&buf, &offset);
 	name_size_alg = name_size(&buf.data[offset]);
 
-	if (name_size_alg < 0)
+	if (name_size_alg < 0) {
+		tpm_buf_destroy(&buf);
 		return name_size_alg;
+	}
 
 	if (rc != name_size_alg) {
 		tpm_buf_destroy(&buf);
@@ -217,6 +219,7 @@ static int tpm2_read_public(struct tpm_c
 	}
 
 	memcpy(name, &buf.data[offset], rc);
+	tpm_buf_destroy(&buf);
 	return name_size_alg;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */



