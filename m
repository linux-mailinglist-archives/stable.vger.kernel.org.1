Return-Path: <stable+bounces-52008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CE9072AB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FC01F237B9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D1143C67;
	Thu, 13 Jun 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rEX5W6pe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24B143C60;
	Thu, 13 Jun 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282963; cv=none; b=Px6w422NiY1C9H9KCUh122C6w5W/XlJi3PmurNc4dakoX+FgL8HKjjJTRotLIZsOXoG2P/zBc7OkpNvGKSq3kHFLfVJ15GrBdc6sPgdWIilCflgzn7TmXvrr+jlKGcmg1g+0ybhD0UojJaLNc8aNYN00gxlAyo14NewmVAJlAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282963; c=relaxed/simple;
	bh=1aV0MCHgjgdCQcS/WwBUhSglVC6CQ89nctau+aPkDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2jJD2wCl38RxtvYbVQbrBj3nwqAoMDsbpaQpUNX42uJXMEpXxfe4i2vDBRNPb/GHm3XnbM0mtxEkpAlKyZwYxqyajdvaDoKt1uHIQ0KgiA5VG59QoFm7qy6XgBEw9/L6fToRYHrJpBFzodYIRRsUwdzX5i7uoqoL6sPZSy1r2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rEX5W6pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5234BC2BBFC;
	Thu, 13 Jun 2024 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282963;
	bh=1aV0MCHgjgdCQcS/WwBUhSglVC6CQ89nctau+aPkDXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEX5W6peNGVsdMpFWc9GR3PsZwmsYw/ESTqtrYICmEZLkjra9C6wZ5TSLUfKUCv7A
	 DNY7TRF3Zx16lwatIrcHb+ChNMSF/9TDJO+elvWJ5vmHIBBMdVUDryzEz1foB6xAit
	 noCLP5quOFr+2LJhR1rr6aj4puaqdqIhuluvcRA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Berger <stefanb@linux.ibm.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 51/85] crypto: ecdsa - Fix module auto-load on add-key
Date: Thu, 13 Jun 2024 13:35:49 +0200
Message-ID: <20240613113216.108958534@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Berger <stefanb@linux.ibm.com>

commit 48e4fd6d54f54d0ceab5a952d73e47a9454a6ccb upstream.

Add module alias with the algorithm cra_name similar to what we have for
RSA-related and other algorithms.

The kernel attempts to modprobe asymmetric algorithms using the names
"crypto-$cra_name" and "crypto-$cra_name-all." However, since these
aliases are currently missing, the modules are not loaded. For instance,
when using the `add_key` function, the hash algorithm is typically
loaded automatically, but the asymmetric algorithm is not.

Steps to test:

1. Create certificate

  openssl req -x509 -sha256 -newkey ec \
  -pkeyopt "ec_paramgen_curve:secp384r1" -keyout key.pem -days 365 \
  -subj '/CN=test' -nodes -outform der -out nist-p384.der

2. Optionally, trace module requests with: trace-cmd stream -e module &

3. Trigger add_key call for the cert:

   # keyctl padd asymmetric "" @u < nist-p384.der
   641069229
   # lsmod | head -2
   Module                  Size  Used by
   ecdsa_generic          16384  0

Fixes: c12d448ba939 ("crypto: ecdsa - Register NIST P384 and extend test suite")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/ecdsa.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -373,4 +373,7 @@ module_exit(ecdsa_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
 MODULE_DESCRIPTION("ECDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p192");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p256");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p384");
 MODULE_ALIAS_CRYPTO("ecdsa-generic");



