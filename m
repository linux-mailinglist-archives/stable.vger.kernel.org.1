Return-Path: <stable+bounces-228227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBG1OqtKwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4082F4012
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E74130D7D7F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBA3B0AE9;
	Mon, 23 Mar 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+TV+rsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD413B0AE6;
	Mon, 23 Mar 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274511; cv=none; b=ubmk4GRhEli0mTQpCdmQkkg3cqS0kiZDewtWRKmToGZLtMUwweY4BdRq8liLqVt1+v63AIwcNuPYlfCNxY+u12ibWyC+srqcL6kuQj2yDaPYGn9axIzQ4r9hAKoSfCLj3x5LwRwKBT/YiMBlE50Kk0YJaPAt7E5UQtzqMb/DKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274511; c=relaxed/simple;
	bh=WfFru4MFbcls4RrdD1YhQIoWFrUS1SQi178psVk7TDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/tDdW5VXgFGcAANy/XRx1jnuSK+41JdoW4Z7MyV7x7AoMZiReQAiWQjpn+1WibgswW8hyT3lnef7rzM6nrRHR0Po37tJ0PuUczhfRkR2t1lRDCNxtLwWvCjMqRGbY8nKkHG097g2UcvWCzuHk23K+90oqEGgOcFsbiWREGb5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+TV+rsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A69C4CEF7;
	Mon, 23 Mar 2026 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274511;
	bh=WfFru4MFbcls4RrdD1YhQIoWFrUS1SQi178psVk7TDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+TV+rszuLeWXna3ELCiDpbKOhUr8y88nPnrgD3adS/bscoFZ21uNUr4B/2xKiq1U
	 SJyUM9LVD3Qt0yunWOQ4vhwC9XRm0TNlyW6LncYHzfR9r1ip3B1u2qxD3M98HrJ2Im
	 ejYp9yyxJb2AiJWKpXzJ05xILoAJmmDJhc9F1wBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AlanSong-oc <AlanSong-oc@zhaoxin.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 020/212] crypto: padlock-sha - Disable for Zhaoxin processor
Date: Mon, 23 Mar 2026 14:44:01 +0100
Message-ID: <20260323134504.396677137@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228227-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linux-hardware.org:url,zhaoxin.com:email]
X-Rspamd-Queue-Id: 7D4082F4012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AlanSong-oc <AlanSong-oc@zhaoxin.com>

commit ebba09f198078b7a2565004104ef762d1148e7f0 upstream.

For Zhaoxin processors, the XSHA1 instruction requires the total memory
allocated at %rdi register must be 32 bytes, while the XSHA1 and
XSHA256 instruction doesn't perform any operation when %ecx is zero.

Due to these requirements, the current padlock-sha driver does not work
correctly with Zhaoxin processors. It cannot pass the self-tests and
therefore does not activate the driver on Zhaoxin processors. This issue
has been reported in Debian [1]. The self-tests fail with the
following messages [2]:

alg: shash: sha1-padlock-nano test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
alg: self-tests for sha1 using sha1-padlock-nano failed (rc=-22)

alg: shash: sha256-padlock-nano test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
alg: self-tests for sha256 using sha256-padlock-nano failed (rc=-22)

Disable the padlock-sha driver on Zhaoxin processors with the CPU family
0x07 and newer. Following the suggestion in [3], support for PHE will be
added to lib/crypto/ instead.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1113996
[2] https://linux-hardware.org/?probe=271fabb7a4&log=dmesg
[3] https://lore.kernel.org/linux-crypto/aUI4CGp6kK7mxgEr@gondor.apana.org.au/

Fixes: 63dc06cd12f9 ("crypto: padlock-sha - Use API partial block handling")
Cc: stable@vger.kernel.org
Signed-off-by: AlanSong-oc <AlanSong-oc@zhaoxin.com>
Link: https://lore.kernel.org/r/20260313080150.9393-2-AlanSong-oc@zhaoxin.com
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/padlock-sha.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/padlock-sha.c b/drivers/crypto/padlock-sha.c
index 329f60ad422e..9214bbfc868f 100644
--- a/drivers/crypto/padlock-sha.c
+++ b/drivers/crypto/padlock-sha.c
@@ -332,6 +332,13 @@ static int __init padlock_init(void)
 	if (!x86_match_cpu(padlock_sha_ids) || !boot_cpu_has(X86_FEATURE_PHE_EN))
 		return -ENODEV;
 
+	/*
+	 * Skip family 0x07 and newer used by Zhaoxin processors,
+	 * as the driver's self-tests fail on these CPUs.
+	 */
+	if (c->x86 >= 0x07)
+		return -ENODEV;
+
 	/* Register the newly added algorithm module if on *
 	* VIA Nano processor, or else just do as before */
 	if (c->x86_model < 0x0f) {
-- 
2.53.0




