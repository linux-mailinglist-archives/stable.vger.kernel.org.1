Return-Path: <stable+bounces-243539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDdQICSt+GkuxwIAu9opvQ
	(envelope-from <stable+bounces-243539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9B4BF877
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18A13063811
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913213DE428;
	Mon,  4 May 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0sHASivp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4E1C68F;
	Mon,  4 May 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904144; cv=none; b=OLPDPPhcSvLQhCfrfHk6i1Qfew3mbtq7Tua0gMyXQG2oOjIZ1zTTwLPwAMckHdsP9lsY2eC/1rEP2atqkOyiQVadYAjxxN0YXJoHyjamgLhP2CND/Uv8LY9dKRcZD2TlqSawKScGqPGzf+Zrp+IOJeoNv8eFuMXWlNKGiI7aHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904144; c=relaxed/simple;
	bh=noSHHGyXrkXtXE4XHkykRG9cO9hUw//Km4G2iokOXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/qMRFZ/FRzt58x+XCGc3Bf+8Qz5R97vR8c6utDHIDouOf524CWZSdNN6SOAoa9b/Gw5J4dfkpe/7Vd5MbL40VDvjUDh/51dcCnXZ01uyW75RUJ3WVUca7B9C7ot/5tW7PnZJmOT1fde3SBK/7nyiS7S3t71VgOmNnClOwg21l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0sHASivp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DB0C2BCB8;
	Mon,  4 May 2026 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904144;
	bh=noSHHGyXrkXtXE4XHkykRG9cO9hUw//Km4G2iokOXc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0sHASivpfaKqck5tYfg+T8uTNmQVFTllb8GMmDC957QdzBYoazycIV+SnNL4NErZG
	 z3+n6G0ZSjOwU1qYDiErtBfr/bhJNMi5S3WTbv9dhEj8FXsWkhLlWkC9hH/TmoYE/U
	 2I+D9V2/VjB600xnJf6SaqC7LdKwSS+XjmsmI65c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.18 157/275] tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()
Date: Mon,  4 May 2026 15:51:37 +0200
Message-ID: <20260504135148.816607095@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 20A9B4BF877
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243539-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gunnar Kudrjavets <gunnarku@amazon.com>

commit c424d2664f08c77f08b4580b5f0cbaabf7c229b2 upstream.

tpm_dev_release() uses plain kfree() to free chip->auth, which contains
sensitive cryptographic material including HMAC session keys, nonces,
and passphrase data (struct tpm2_auth).

Every other code path that frees this structure uses kfree_sensitive()
to zero the memory before releasing it: both tpm2_end_auth_session()
and tpm_buf_check_hmac_response() do so. The tpm_dev_release() path
is the only one that does not, leaving key material in freed slab
memory until it is eventually overwritten.

Use kfree_sensitive() for consistency with the rest of the driver and
to ensure session keys are scrubbed during device teardown.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -283,7 +283,7 @@ static void tpm_dev_release(struct devic
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 #ifdef CONFIG_TCG_TPM2_HMAC
-	kfree(chip->auth);
+	kfree_sensitive(chip->auth);
 #endif
 	kfree(chip);
 }



