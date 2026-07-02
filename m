Return-Path: <stable+bounces-270637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdbyAwaURmrFYwsAu9opvQ
	(envelope-from <stable+bounces-270637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:38:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E76FA512
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:38:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xSZj7Rua;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270637-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270637-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ECFD3056A87
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A964968E4;
	Thu,  2 Jul 2026 16:24:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AF3A960A;
	Thu,  2 Jul 2026 16:24:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009460; cv=none; b=aSIr59tL7Vvs06gGqY58LPu0Hc+mGDW/m7dsuSIVOcLgdWMl8a/dJ5QY0UYec/BK0DmTSmxkH97AMLvR9wBxc5GpR+U32KQYneAsW8ZBaVCxxs4b638n1ZSl5fwgVxmYlvTVF4tHJ3IKO2uf7u5F0tl8kcMsnDyPv/54P07KO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009460; c=relaxed/simple;
	bh=+AkLVqHSNdVcENkwAvbbsus0lkzMeDVjwD7LKlreCcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdXxl/IYds8RUzTnjz54DImVfu3mchhxaWA8KMDQEZqndX4w4K9aShu/WE6vbD9aVxArZghMogN0PoO17dYP0DQCLQiO0X7U/dDduJDJXx0L/yvUJ+0g7ej+bbPSXjkm3YYYXV24l1V9PSrm5ykiN0GvBkpY9I06DH2vBpt0tOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xSZj7Rua; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A91F00A3D;
	Thu,  2 Jul 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009455;
	bh=z2ASbxDPPzRcXeWQAoKfLg6hON5WsOnM/1B4UMhmf9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xSZj7RuaDsZfEiXzpiXd/X1ud77mmSXEigwISY5AX1XGLx7sfnVcsTV7nqZLNYBtd
	 pGx7Z2BT9dqjuj3toePWQ/8nBsAg/gDadMTACA+firD6u8Lh0y+McIK/kvYSDF+PhO
	 PeUY9hd7kL9cH1soaJO6sMNmqQR8kYLgoDG7YiH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 59/96] crypto: af_alg - Set merge to zero early in af_alg_sendmsg
Date: Thu,  2 Jul 2026 18:19:51 +0200
Message-ID: <20260702155110.223108068@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270637-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ramdhan@starlabs.sg,m:billy@starlabs.sg,m:herbert@gondor.apana.org.au,m:mdmitrichenko@astralinux.ru,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,starlabs.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 299E76FA512

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 9574b2330dbd2b5459b74d3b5e9619d39299fc6f upstream.

If an error causes af_alg_sendmsg to abort, ctx->merge may contain
a garbage value from the previous loop.  This may then trigger a
crash on the next entry into af_alg_sendmsg when it attempts to do
a merge that can't be done.

Fix this by setting ctx->merge to zero near the start of the loop.

Fixes: 8ff590903d5 ("crypto: algif_skcipher - User-space interface for skcipher operations")
Reported-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 4983dd68578e24..6acee8e0041a42 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -892,6 +892,8 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			continue;
 		}
 
+		ctx->merge = 0;
+
 		if (!af_alg_writable(sk)) {
 			err = af_alg_wait_for_wmem(sk, msg->msg_flags);
 			if (err)
-- 
2.53.0




