Return-Path: <stable+bounces-218136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJdcCd9QnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1021918ED9E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85FFA303DA89
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B7242D9B;
	Wed, 25 Feb 2026 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sd5psS8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FD1EB5E1;
	Wed, 25 Feb 2026 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982918; cv=none; b=gcO5qleyok45C0xNFEZN6rc7Q6ohL3s7AjetRGkclybPTRXNPXKkr9qwPK/jkzjaiKn1RILReXxH4h4Ek9pZX9Up00gCEdan4GyRGijfQJMZDghNTRQRCO48NkvxqEdo0epfqGWsSHIztMTgmpJEYJbHJxDFO8n4RPr1f5nmpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982918; c=relaxed/simple;
	bh=V20TP94DhIPX/EYP9nz0T7tSdB2IDzqDU+fnXklvyyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwFK2leVsxejA2VaN/c7LLkw/lSeYGtKqnjnf5YknMfKBSbIAPugst+16w2LgUvFWrbvYm6f2l+EVWaj6dqRsNb2LXHRSeZnmgtHRr0cOFnESKFo/LbA9STIT3gXZ5Y1xZpv8o/mMxYoeWKh/H1SdTMxeeWgPAkR5fDZ4ojPr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sd5psS8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90174C116D0;
	Wed, 25 Feb 2026 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982917;
	bh=V20TP94DhIPX/EYP9nz0T7tSdB2IDzqDU+fnXklvyyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sd5psS8gpD5NC47I4tT2fDK8blzmsdTakH3vCK04nN01c6vHVfVrzpQ+CrveqixkD
	 4T56NpLZiTQu4x3rS3PPWVNaeSIGUeYXpmOK2bR3/0jiRI8hPwJNUn380NMmPBzXSW
	 nllohgdC9HFFVdEotTBALnFS4XnAQ4TvhSP3cDxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 097/781] crypto: inside-secure/eip93 - fix kernel panic in driver detach
Date: Tue, 24 Feb 2026 17:13:26 -0800
Message-ID: <20260225012402.068709825@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218136-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wp.pl,kernel.org,gondor.apana.org.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1021918ED9E
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit b6e32ba6d32503440a3e3e16c8d0521cbb7e0c5d ]

During driver detach, the same hash algorithm is unregistered multiple
times due to a wrong iterator.

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Antoine Tenart <atenart@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/inside-secure/eip93/eip93-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index 0b38a567da0e0..3cdc3308dcac8 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -90,7 +90,7 @@ static void eip93_unregister_algs(unsigned int i)
 			crypto_unregister_aead(&eip93_algs[j]->alg.aead);
 			break;
 		case EIP93_ALG_TYPE_HASH:
-			crypto_unregister_ahash(&eip93_algs[i]->alg.ahash);
+			crypto_unregister_ahash(&eip93_algs[j]->alg.ahash);
 			break;
 		}
 	}
-- 
2.51.0




