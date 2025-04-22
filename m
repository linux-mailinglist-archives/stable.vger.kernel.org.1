Return-Path: <stable+bounces-135177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1376A97547
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E943B61EB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20228FFC7;
	Tue, 22 Apr 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXNGnj01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E58B666
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349465; cv=none; b=fFsDysw3ClDXogZagkM515PQC0Lr4ynIdXa5PrEY9O9B7YDjKPTjSG+sAgYfjbKMjh0ZKlNplwfu8DlN0yRl7NlRmhF4QzmUzDTTyTn/RXHE1sagsuJRuJfiSm3X7sK7sLh0qKsfHTCKRlraHokFEG9oT3t6VGR8xB5x9vdr1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349465; c=relaxed/simple;
	bh=BMXgnRLkYu1CwIxZ144QkZmWkW3L2QJ7ZzSOXE4JIyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiVCpJHSf3sTwq2+plz313B6aBfVW8/8MUCAfIiIoId4rNpvoOxDVtc/pC8dz/rA5REpsXynAcyhErZ5mNALpdQ1GyJ8Jgr5o1IvksdXjmBQXnyeazMFgdgednIzbgcKhp7bWjey3syyBkjqXTobJqcT+L9RrNb1w/njyJT+smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXNGnj01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAC6C4CEE9;
	Tue, 22 Apr 2025 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349465;
	bh=BMXgnRLkYu1CwIxZ144QkZmWkW3L2QJ7ZzSOXE4JIyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXNGnj01g37RtHBf3YP7NHJ9k9SIRBIvCbAVXXzFFtajY9cXeJn/XkhIqjD+yS/yR
	 QjLtiCUOiFtKbC/y15EVJlY0zNxiiIfqHuEyLBsWGRn8aLZgGglaB737REyc2LtJOr
	 dhwVIjjWiPHJuhuoxYOwPq0njVjfw2lVDzVm9c4/rzcyKe6leKAVg6OwTNNItQBfd7
	 aWOyJ6DKkb2mvM9tsOVzyeqMdAA1TlPpPOEdDz9MkiKt3XzIkAcysu+rkEDcuneh7d
	 umnrtSSRqSuzew2dZ1ToN8eH2rXzSIWrLtE1k7SWDh6pC2hAAh0jb1vJVDNCqvWg0D
	 ZlAigzkd2f8sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V4 3/3] sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
Date: Tue, 22 Apr 2025 15:17:43 -0400
Message-Id: <20250422133404-d8be794238d2c214@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422123135.1784083-4-chenhuacai@loongson.cn>
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
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  558bdc45dfb26 ! 1:  0870c1cd7c207 sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
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
| stable/linux-6.6.y        |  Success    |  Success   |

