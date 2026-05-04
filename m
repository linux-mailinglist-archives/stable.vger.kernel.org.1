Return-Path: <stable+bounces-243188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UImLIgun+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A264BE686
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9424D301739A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67873A3822;
	Mon,  4 May 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fi7fkI2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891793CEB89;
	Mon,  4 May 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903242; cv=none; b=BRZuCQXZg38sRfUe8W/EHYHV7HyNnEbhrwCF37nW7P+mJyrTo6F2THbMbrrN5fOd/O6nzu/mFMiIUXwuX02KahWCd7Df+ywbCUW8So8phJIB0q5DQl+vNNZy1+mels2mNvWIcXMPIt8avy3D29FC4vwDYviFZ6HqXscd9eV/yTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903242; c=relaxed/simple;
	bh=Kqo/6MG96/TmGyiOQadIfQbzvy7poXv/64YK4JfoZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOHmLKnjmGECotuLi2JSyuPFfJFfRNx7b/6EXAMt55pkF61iJV6Z6DfsJU9vMnyeCVaHJ6KYo4x9ID5rV2WMNl2giptk2bYnSbvnbNhJ03oAIQg0/RkjCS3Qaonc39xglw71gDE72Vz+snQh6VdyL7FQrFZEpY2Isqk85wcO27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fi7fkI2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B70C2BCB8;
	Mon,  4 May 2026 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903242;
	bh=Kqo/6MG96/TmGyiOQadIfQbzvy7poXv/64YK4JfoZVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fi7fkI2WEyaIhHal7hZVzxsanGWy63gY7sG6ChLc4hIGVZ5elh08wswVn2zR3m4Ji
	 M1DbllXZslYTSGktIj5F0byFSUO6UcQOOGw5Cgu4/YbibsoO1WZWlhv1Xpx9q8c6ld
	 013pawVCIggySSj2dL/ohQm+u8I5OgN/0Hj3GZxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 7.0 158/307] extract-cert: Wrap key_pass with #ifdef USE_PKCS11_ENGINE
Date: Mon,  4 May 2026 15:50:43 +0200
Message-ID: <20260504135148.783882705@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 33A264BE686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243188-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 4f96b7c68a9904e01049ef610d701b382dca9574 upstream.

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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://patch.msgid.link/20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 certs/extract-cert.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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



