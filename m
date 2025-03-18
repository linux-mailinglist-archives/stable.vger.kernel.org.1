Return-Path: <stable+bounces-124814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24815A67778
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E1A1889B2B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1420E6F0;
	Tue, 18 Mar 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjy0ipVS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676D186294
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310758; cv=none; b=VWPyXHeC/gGZhAdn/7C5fDJ5G7EEOa67nv5GSOo+84U/gDwyjyzv6TN2jsPQ86hvlwx61j/BtJupVqh3sawwojpA33pEMY6YECVh6uhQIJPUEXg2z8Uytw3QpyDhxusYRDR3ns6h7UYGno8UwLOwiY8BftvownIo3Ww+3Zwy0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310758; c=relaxed/simple;
	bh=ugxn2nucQrWDoJSzMpNwto+kTz6xN0QFdMkHohRv4vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GARE/mtJzu63hJf1pb3wKRDET3rjfjfEnYLK5CSdg44tJTP+L1IFl+TLo4YGWXlyC+JMT/eM7YEoJobadtgg2VzeI2AVr0eeWLGhgk/gye/FdYqJ37qPDjqRgSRR3I+g4v/zmvj5AWW53qiQGyi6kRQxk4U1otn4+HpQe/2m3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjy0ipVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F970C4CEDD;
	Tue, 18 Mar 2025 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310758;
	bh=ugxn2nucQrWDoJSzMpNwto+kTz6xN0QFdMkHohRv4vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjy0ipVStzK5LqiALMZVtyFpgHuxBixElz8rdf1D66xmp1egj95ZAO51112fi72v4
	 gu4P+Buum9O98cCQzUWY10YZbbmLc2r9Tker87Go+x1JZJYvuCOy1s0M6NUBIthiuk
	 m/DzYuHxn0yCypVOieabQGElOdELQdMLh9FV8p7ySAtEmEfv23GCCyHWO6MMxhAJ1h
	 n43WgX5vhyDl7Y2xlwr0QbI4JZW0Llv7AoLqVxzrqavvupORVES2X7J73MqHrZa2bE
	 k8cSL0MW7ugYL8O3s0y20/mdLcE+S+Rb9ZO1ys9RpjDOu2bKrBxjibkN2pwJA0T/4g
	 nkjIzGyqtZPmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V2 3/3] sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
Date: Tue, 18 Mar 2025 11:12:36 -0400
Message-Id: <20250318083417-b270896a9262150e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318110124.2160941-4-chenhuacai@loongson.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 558bdc45dfb2669e1741384a0c80be9c82fa052c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  558bdc45dfb26 ! 1:  1da10ee635252 sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
     
    +    commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.
    +
         ENGINE API has been deprecated since OpenSSL version 3.0 [1].
         Distros have started dropping support from headers and in future
         it will likely disappear also from library.
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## certs/extract-cert.c ##
     @@
    @@ certs/extract-cert.c: static void write_cert(X509 *x509)
      		fprintf(stderr, "Extracted cert: %s\n", buf);
      }
      
    +-int main(int argc, char **argv)
     +static X509 *load_cert_pkcs11(const char *cert_src)
    -+{
    + {
    +-	char *cert_src;
    +-
    +-	OpenSSL_add_all_algorithms();
    +-	ERR_load_crypto_strings();
    +-	ERR_clear_error();
     +	X509 *cert = NULL;
     +#ifdef USE_PKCS11_PROVIDER
     +	OSSL_STORE_CTX *store;
    -+
    + 
    +-	kbuild_verbose = atoi(getenv("KBUILD_VERBOSE")?:"0");
     +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
     +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
     +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
     +		ERR(1, "OSSL_PROVIDER_try_load(default)");
    -+
    + 
    +-        key_pass = getenv("KBUILD_SIGN_PIN");
    +-
    +-	if (argc != 3)
    +-		format();
     +	store = OSSL_STORE_open(cert_src, NULL, NULL, NULL, NULL);
     +	ERR(!store, "OSSL_STORE_open");
    -+
    + 
    +-	cert_src = argv[1];
    +-	cert_dst = argv[2];
     +	while (!OSSL_STORE_eof(store)) {
     +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
    -+
    + 
    +-	if (!cert_src[0]) {
    +-		/* Invoked with no input; create empty file */
    +-		FILE *f = fopen(cert_dst, "wb");
    +-		ERR(!f, "%s", cert_dst);
    +-		fclose(f);
    +-		exit(0);
    +-	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
     +		if (!info) {
     +			drain_openssl_errors(__LINE__, 0);
     +			continue;
    @@ certs/extract-cert.c: static void write_cert(X509 *x509)
     +	}
     +	OSSL_STORE_close(store);
     +#elif defined(USE_PKCS11_ENGINE)
    -+		ENGINE *e;
    -+		struct {
    -+			const char *cert_id;
    -+			X509 *cert;
    -+		} parms;
    -+
    -+		parms.cert_id = cert_src;
    -+		parms.cert = NULL;
    -+
    -+		ENGINE_load_builtin_engines();
    -+		drain_openssl_errors(__LINE__, 1);
    -+		e = ENGINE_by_id("pkcs11");
    -+		ERR(!e, "Load PKCS#11 ENGINE");
    -+		if (ENGINE_init(e))
    -+			drain_openssl_errors(__LINE__, 1);
    -+		else
    -+			ERR(1, "ENGINE_init");
    -+		if (key_pass)
    -+			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
    -+		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
    -+		ERR(!parms.cert, "Get X.509 from PKCS#11");
    + 		ENGINE *e;
    + 		struct {
    + 			const char *cert_id;
    +@@ certs/extract-cert.c: int main(int argc, char **argv)
    + 			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
    + 		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
    + 		ERR(!parms.cert, "Get X.509 from PKCS#11");
    +-		write_cert(parms.cert);
     +		cert = parms.cert;
     +#else
     +		fprintf(stderr, "no pkcs11 engine/provider available\n");
    @@ certs/extract-cert.c: static void write_cert(X509 *x509)
     +	return cert;
     +}
     +
    - int main(int argc, char **argv)
    - {
    - 	char *cert_src;
    -@@ certs/extract-cert.c: int main(int argc, char **argv)
    - 		fclose(f);
    - 		exit(0);
    - 	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
    --		ENGINE *e;
    --		struct {
    --			const char *cert_id;
    --			X509 *cert;
    --		} parms;
    ++int main(int argc, char **argv)
    ++{
    ++	char *cert_src;
    ++
    ++	OpenSSL_add_all_algorithms();
    ++	ERR_load_crypto_strings();
    ++	ERR_clear_error();
    ++
    ++	kbuild_verbose = atoi(getenv("KBUILD_VERBOSE")?:"0");
    ++
    ++        key_pass = getenv("KBUILD_SIGN_PIN");
    ++
    ++	if (argc != 3)
    ++		format();
    ++
    ++	cert_src = argv[1];
    ++	cert_dst = argv[2];
    ++
    ++	if (!cert_src[0]) {
    ++		/* Invoked with no input; create empty file */
    ++		FILE *f = fopen(cert_dst, "wb");
    ++		ERR(!f, "%s", cert_dst);
    ++		fclose(f);
    ++		exit(0);
    ++	} else if (!strncmp(cert_src, "pkcs11:", 7)) {
     +		X509 *cert = load_cert_pkcs11(cert_src);
    - 
    --		parms.cert_id = cert_src;
    --		parms.cert = NULL;
    --
    --		ENGINE_load_builtin_engines();
    --		drain_openssl_errors(__LINE__, 1);
    --		e = ENGINE_by_id("pkcs11");
    --		ERR(!e, "Load PKCS#11 ENGINE");
    --		if (ENGINE_init(e))
    --			drain_openssl_errors(__LINE__, 1);
    --		else
    --			ERR(1, "ENGINE_init");
    --		if (key_pass)
    --			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
    --		ENGINE_ctrl_cmd(e, "LOAD_CERT_CTRL", 0, &parms, NULL, 1);
    --		ERR(!parms.cert, "Get X.509 from PKCS#11");
    --		write_cert(parms.cert);
    ++
     +		ERR(!cert, "load_cert_pkcs11 failed");
     +		write_cert(cert);
      	} else {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

