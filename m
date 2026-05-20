Return-Path: <stable+bounces-251799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGHiFxMeDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:48:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67E59A210
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FBD2347724D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FD336405A;
	Wed, 20 May 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0fEhd1PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40973D7D7B;
	Wed, 20 May 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298920; cv=none; b=JAxqT9+vDvqbMwUSh39kFwkWONMuoQU8F8MXdco4yt8hF03eqoHA0YmBi/06dG7kiAVZtqy2vlTCd8VSAoqVAZhrq8X4iOWW8TTu9/20FbS4qFDLyEqF0PPJQqe16fUO4nelBOkwQBsLYGxcrUNGL/DoPvyBZXrCFaCoQ3pjdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298920; c=relaxed/simple;
	bh=u8vmvsomaQmRFZwJWFcy+Gc5uUiVTdZ4Sp/gk8uFd4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys0yLBW8yhx7xrqmM6E/DRZ6GMolDMXoHi80XWW7FUIBVM3Vm2ryoOE52qtbEB/5ZkWK285EH8itkooWHB8Sl0rKS+Vk1Cf6PJ7ws5yeC3MOcq0Qn6N20dgv4SQscKYsWhUmH+pBEGZk/vVegBM69UloC9zGlg5M1CtautBts6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0fEhd1PL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357861F000E9;
	Wed, 20 May 2026 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298919;
	bh=QraMoZePlVHNq4Y4gs64ptu6E2oYWrvECzFWOiaxu5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0fEhd1PL9x6Ufh+l3+m0s3rB2WwomBQo7Q2+b4fbSeFpsN+wRm5nk4Mox/zCOPSi2
	 r9bdVnamyZPzrMmmrqtYcV5Xy2t2obrt/zytF5salX/tM/JgfJ9cBZr2Zu+ns0uuu0
	 isg+FqWl/tS+uSVFd3rEJJOUpwKd8fj1Q7+ZXsRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	T Pratham <t-pratham@ti.com>,
	Manorit Chawdhry <m-chawdhry@ti.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 594/957] crypto: sa2ul - Fix AEAD fallback algorithm names
Date: Wed, 20 May 2026 18:17:57 +0200
Message-ID: <20260520162147.410671967@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251799-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,apana.org.au:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CC67E59A210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: T Pratham <t-pratham@ti.com>

[ Upstream commit 8451ab6ad686ffdcdf9ddadaa446a79ab48e5590 ]

For authenc AEAD algorithms, sa2ul is trying to register very specific
-ce version as a fallback. This causes registration failure on SoCs
which do not have ARMv8-CE enabled/available. Change the fallback
algorithm from the specific driver name to generic algorithm name so
that the kernel can allocate any available fallback.

Fixes: d2c8ac187fc92 ("crypto: sa2ul - Add AEAD algorithm support")
Signed-off-by: T Pratham <t-pratham@ti.com>
Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/sa2ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index fdc0b24860691..52fe4baeff934 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1744,13 +1744,13 @@ static int sa_cra_init_aead(struct crypto_aead *tfm, const char *hash,
 static int sa_cra_init_aead_sha1(struct crypto_aead *tfm)
 {
 	return sa_cra_init_aead(tfm, "sha1",
-				"authenc(hmac(sha1-ce),cbc(aes-ce))");
+				"authenc(hmac(sha1),cbc(aes))");
 }
 
 static int sa_cra_init_aead_sha256(struct crypto_aead *tfm)
 {
 	return sa_cra_init_aead(tfm, "sha256",
-				"authenc(hmac(sha256-ce),cbc(aes-ce))");
+				"authenc(hmac(sha256),cbc(aes))");
 }
 
 static void sa_exit_tfm_aead(struct crypto_aead *tfm)
-- 
2.53.0




