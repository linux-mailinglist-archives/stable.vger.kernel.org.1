Return-Path: <stable+bounces-230403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFr4ILyJxGn50AQAu9opvQ
	(envelope-from <stable+bounces-230403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:19:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413632DCB0
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4488F3023DC4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAE371D0E;
	Thu, 26 Mar 2026 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4ZPxP0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8D361659;
	Thu, 26 Mar 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774487963; cv=none; b=hSoF9B8kTk+5xHbmuqr3FFRU07hSJJaudQ1WcoOGSIdRBqZAuVtNQghxEc8FSzqSu/vRQ2kimFQlzpcA2c4BId2v/yvQI31ZSPlWBlPxOyRkyODBGxM6rO/09o3LWEUuiXTQD8A45NQ6Xqddv+1LoaS62XLqpOUr4AeN/iDkC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774487963; c=relaxed/simple;
	bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bl0Fqv5kvYzzq2K0Z6PL+HhO8F16M9r2l1Ukvv+cLg0wjA9ir0hKslOUj3oSF0U/b7T+GXqVyU7L4CV3A/z5T0s6/rqg+WR8Iefou3LO3kKcNez0+dyXf0iZNG0eW8zs/G9mMPVhNv8aUQLyiHavS5guFcXk7/4WYztyqhBEK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4ZPxP0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA83FC4CEF7;
	Thu, 26 Mar 2026 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774487962;
	bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
	h=From:Date:Subject:To:Cc:From;
	b=R4ZPxP0Kt1Y4XjHNcIkz/AnEPuldifIGo0Jv3O8R3cnZizBDhTHc6WRYmUYUY88tl
	 JbbvTjs3aduTrqDwh59MqAagbkPM0sJJkyb3TnfcRkyRqIsX7c0Ltae3H0FBCjxWIt
	 tnkScoMZdIDzEuT4l1aFAjX/alGWz7FNTwCjmoZ8AP5Z3j55XDLi085b0TTrKdjP7Z
	 43OQjD/d8me+SrrbB/Ael0qax391V73/uFvbRtD3zTFUNrZpeAptOfS3Uprraz+cLv
	 qk3+zdY5xlafVM1nsSC1phFwl34+ymRYdp8njsz21SEMHnEH5p8oZnhkQwO6Neg9Oy
	 a1gzVP8dv1gjw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 25 Mar 2026 18:19:15 -0700
Subject: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNWwrCMBBG4a2UeXYgpqjoVkQkl781WtKSSaRSu
 ndjffxezllIkAKELs1CCe8gYYwV+11D7mFiDw6+mrTSR9XqAzukLIw5J+PyJn7hc5+MCJdYBJ5
 tySzI3A+jNQPrVqkTXGd8d6banRK6MG/P6+1vKfYJl38jWtcv1/+4opUAAAA=
X-Change-ID: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0BRd4VuEPhlKgBSUNI+VmDK03+bIQLfCsmTHFn6xJwk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlHOmc0mUyYdHWZZzzXeodzCTs2ZX+JWSZoEHRX8cyfj
 U/DvqpO7yhlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATkbNl+J87L/Jx7MyC1x6C
 wgd3rNgjGRnouHO/xOJ5K2NiJ4jzH4xi+KcwYZ9SB6NDdoPw+af1Zy6znbnZ5an2f59f07ROvkz
 pD3wA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lists.linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-230403-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2413632DCB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
in clang under a new subwarning, -Wunused-but-set-global, points out an
unused static global variable in certs/extract-cert.c:

  certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
     46 | static const char *key_pass;
        |                    ^

After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
API, not the new provider API. Wrap key_pass's declaration and
assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
with its use to clear up the warning. While this is a little uglier than
just marking key_pass with the unused attribute, this will make it
easier to clean up all code associated with the use of the engine API if
it were ever removed in the future. While in the area, use a tab for
the key_pass assignment line to match the rest of the file.

Cc: stable@vger.kernel.org
Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am taking a fix for a similar warning in modpost through the kbuild
tree so I don't mind picking this up with an appropriate Ack or it can
just go through the keyring tree, does not matter to me.
---
 certs/extract-cert.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 7d6d468ed612..54ecd1024274 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -43,7 +43,9 @@ void format(void)
 	exit(2);
 }
 
+#ifdef USE_PKCS11_ENGINE
 static const char *key_pass;
+#endif
 static BIO *wb;
 static char *cert_dst;
 static bool verbose;
@@ -135,7 +137,9 @@ int main(int argc, char **argv)
 	if (verbose_env && strchr(verbose_env, '1'))
 		verbose = true;
 
-        key_pass = getenv("KBUILD_SIGN_PIN");
+#ifdef USE_PKCS11_ENGINE
+	key_pass = getenv("KBUILD_SIGN_PIN");
+#endif
 
 	if (argc != 3)
 		format();

---
base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
change-id: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


