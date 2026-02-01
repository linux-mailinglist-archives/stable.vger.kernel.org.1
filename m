Return-Path: <stable+bounces-212986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKq0BJn9fml9hwIAu9opvQ
	(envelope-from <stable+bounces-212986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 08:15:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED98C51B0
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 08:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09EB83012248
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114C1DF74F;
	Sun,  1 Feb 2026 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PSEp83sx"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566419DFAB
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930131; cv=none; b=TjBL0lTzoX9aEQr0sVIIvRoIzmmMOhMkdb7IisopX/sA4lFbYVgxi/n6uFuGcPFL2arnRhkSBcouwN0InkDk6Jv3UDhacIPy6H4VNO8m84io0YjVKdydm/Ba3NYUuO7gfdh5osEQnfMwZNDNhd4I5Ez7ZAFSqLJDR/CQww+tJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930131; c=relaxed/simple;
	bh=dzi5Nois0ylIdWzJ/BlaYfPBmZyTRkUFWvJi8A93UuI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=FDnpEOo+Rruwn7xJm4O5LPbvOus8eUCdsr36WwhU9/oXZUwSCnXY7M2Fz1cuV7wfy0fAI4jSmjCA87WjJX9xkI6zafK+5xt2PEWIZcwy9rwFTH10RGREqdxWla74Da1bYkWV5I6J/vl70xn+bhzy5QL7tjbebk0We6h+Y3Btifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PSEp83sx; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769930119;
	bh=tyUMo0Z8Ys4hcdGmev/BC1d3Gpj7aqdHTr64uLIOLTE=;
	h=From:To:Cc:Subject:Date;
	b=PSEp83sxc4NhtGP7ibMGhxf3vqydYu1a5bYlRLiLJcD1trSARN5oxfBAhp3ync9y7
	 Aaj2zljz6MvXvApDrN+b6ySxk3Y4sVAdwYAthQc6ijtp6OcIdwlFGTy/BPUqP1NzLc
	 xRP6n0nu0FsJFe5iWJlMRm8qZvm4eslaAq/PU26g=
Received: from ubuntu24.corp.ad.wrs.com ([183.241.55.101])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 3689B6C0; Sun, 01 Feb 2026 15:13:40 +0800
X-QQ-mid: xmsmtpt1769930020tebn9bile
Message-ID: <tencent_A280B5140E218C468311AD76CDEBC78B2406@qq.com>
X-QQ-XMAILINFO: M3cUO7vMX4chyatjcjwHQ6wLwY5c2eQYRnzEkGV6bloDGwsV3CdhSKDN39TQY6
	 xgzRrEifit68IjJu3+RP74X+ACV/iDdSfuAjSH/NrSVtQ0CKZHwWJ11UYGFPU4pChRnQjKB/r4WU
	 4gQ/LFUy+dBi0UiaPNHBGHGo2o8y10MGkhJQbEoGxbQyONGVn2tpNzgTf3m8jEUkuUTyMIlyRbCY
	 4eN5jeYO7HU+VWNgEsGqJDMP1NWJkuJ8B0/t8RUARtLoajwOz9eKNkf6is05tmmZAKRjkKTTOxo8
	 ONuwkjnQuQ0v5fMJT6R/fXEbff80EYI3kh7h9C0aVPYv6tTSRxyBOJEZK2f4hAqXfeuu+Odh5Dpi
	 pJ0WQTtsGtjQ4D47RgeaifY2JFlJ1b9faepaUCjgQTilKG457cD2Wkr3q6RVkeCTWv2wedPzUwto
	 iCrwn7b77h8UTKPvzkxUjTCaIHJQF3hHRL3ww40szebaAC4W//bX6rgWeGBNWg111z7hiEgPuxo7
	 TmZKKvSdLDikFxTzigAUZbxiqn30BaFpEyoJPcH7GBGWtVNEgxSAi14fVLZBQrbgYafmFFjWByk+
	 9IGIGZbqxXGnCZgpGFg3MwLlEoW2GNlr6TwiFNgTgKzFwSiSe2bj4lVDdVPLPCFajL/PT2K7e1u+
	 0adkYYic1s2su8rAy9GfJ4tf7JUdSVxRryLaQio3nGdljDrw7pkYjExWl1pUShL03kGFHcMtwL+u
	 dFkB33FjWzP2uVlJV2O4CzE9k08o/lbb9njq2zP3DjzqgBvuoaa6Si5OTfA0Hq3a48pEur3800hk
	 auNjxSXjF//dpDWPFEOKraNyC5FL85VObMOrhiaHaB9MZ3H4cOrz4VeqeDk6JJA40axxa0aTY5Ix
	 cuHk00nKQQQM8FlaE5q318d7BTGGUIhnZC8v6dAIFFc3t/udCA0WpBShBgJVrO/MLsI/NHjtVDJg
	 xbMcJh4dad6KbZTpgRVkJDSTKhcX/JSd2QswlmEMNw8rX1oBxlBdukYA00wXrqPeJOum5PpdBqcG
	 f903tZtVJxZIXDPOfVOfp3ib7g9qjtLSJxPtrc9A8f/ecmoOFZOmOCJCPZxmDEV3mFPxyL6Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] ipv6: sr: Fix MAC comparison to be constant-time
Date: Sun,  1 Feb 2026 07:13:37 +0000
X-OQ-MSGID: <20260201071337.5032-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212986-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[kernel.org,uniroma2.it,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: AED98C51B0
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit a458b2902115b26a25d67393b12ddd57d1216aaa ]

To prevent timing attacks, MACs need to be compared in constant time.
Use the appropriate helper function for this.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Link: https://patch.msgid.link/20250818202724.15713-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Include crypto/algapi.h instead of crypto/utils.h in v5.10.y. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/ipv6/seg6_hmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 4a3f7bb027ed..d334458cbc9e 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -36,6 +36,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha.h>
+#include <crypto/algapi.h> // For crypto_memneq
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -270,7 +271,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;
-- 
2.43.0


