Return-Path: <stable+bounces-239478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEFVEd9k5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:39:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D922431B56
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0E635AF07E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9B3368AF;
	Mon, 20 Apr 2026 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhuZszYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324B2E093A;
	Mon, 20 Apr 2026 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700356; cv=none; b=b+EBa9vjXNyNjfa+2eDklxhbqTep8P1Df7rSa4r5FicRQ2A52W2rWO6kF3F6XuVkA9UW22cwoBe3nYnfU2VXeRPfO2XtV7u2DHP4P53ShcE70Dpz6UQwqPOC3ux9Jz6KiA7r30f/q+bakHgJhuYrH9YTQ3F1488oQDI1LTZBa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700356; c=relaxed/simple;
	bh=wYmkqLFVQx/SjVsrpEaQPKzw35b+jBVo6Z9AzGOeR3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVLgwMBqDe6XP8zkC9eNOk8RcGzQMOuT/oCElqBMPpCMTXqubkaRorEo5Ea1YpKoMiadVU2akJAiw1SEnaagi+a4XqI8f7qw9gIVKRU4vIDZyjqJmLdo6g+RNQTuzhZ9x7Bgy7VLkJX6PkRd77cVeijOUxvLSe/nXv/kmswGVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhuZszYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C015BC19425;
	Mon, 20 Apr 2026 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700356;
	bh=wYmkqLFVQx/SjVsrpEaQPKzw35b+jBVo6Z9AzGOeR3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhuZszYTHEgmjoVssktNysB+jFQMFEvK+BOVGl0HVrcp7SEZS2DmHNxNMA6BwE84a
	 bLUVn+0psi+TKnRWurdbO7ux/DTzVDzYD4Em3IZGODccvGH5GhKJfag+pIxGHhlL9p
	 EImkyjmvnt2yV51swVjhuwjPJRTQihtrJq5nVNDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com,
	Daniel Pouzzner <douzzer@mega.nu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 139/220] crypto: algif_aead - Fix minimum RX size check for decryption
Date: Mon, 20 Apr 2026 17:41:20 +0200
Message-ID: <20260420153939.029120163@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239478-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,aa11561819dc42ebbc7c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,appspotmail.com:email,mega.nu:email,apana.org.au:email]
X-Rspamd-Queue-Id: 3D922431B56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 3d14bd48e3a77091cbce637a12c2ae31b4a1687c ]

The check for the minimum receive buffer size did not take the
tag size into account during decryption.  Fix this by adding the
required extra length.

Reported-by: syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com
Reported-by: Daniel Pouzzner <douzzer@mega.nu>
Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_aead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index dda15bb05e892..f8bd45f7dc839 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (usedpages < outlen) {
 		size_t less = outlen - usedpages;
 
-		if (used < less) {
+		if (used < less + (ctx->enc ? 0 : as)) {
 			err = -EINVAL;
 			goto free;
 		}
-- 
2.53.0




