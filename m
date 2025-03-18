Return-Path: <stable+bounces-124817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB4A67779
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4962D1896DBB
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2120E702;
	Tue, 18 Mar 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCoYsoS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AFC13D
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310764; cv=none; b=QdoEOqUK/wYpG1OhsEFQ0bGrQalPZtG+tPfa7VvzTzzjtX3QjFyjBnl0r5UYFZmi3FgDTqqGaOKX1VFe0ZCPngqTU/7YF271fVqdoyL6Bj7307FfADweonmt2ZqkiYnV0jkD1FIbYHdDJsYetyRgwZG5mNefncUQmwj6YJM1p/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310764; c=relaxed/simple;
	bh=Ht2y6WN05hqu3yeIm+3ktGFUmpbHJGSB3HXeg8UTcL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLpp7rjcTjSJm6dO+VkI8rFcCtd2e8k2NMrK5Ph8CQroYfbd1rlhpQLbcPeYwVbaHsJHdBdILcNTcJ+WYGrWsvhZlxJaCkZpdgP1YXLcEl+AzK5xdXry0fWWjd81dPdc9lUPMJ3cZUPHZAsKStOEKVsTMyurCq5fmUQGDdiPhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCoYsoS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0346C4CEDD;
	Tue, 18 Mar 2025 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310764;
	bh=Ht2y6WN05hqu3yeIm+3ktGFUmpbHJGSB3HXeg8UTcL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCoYsoS06yxUf+EaRZWhCUs7WQ0/906JvTTcC+t8dArW8IJNwJVaPGuJjZjShLyDc
	 jiDYSRhJtOLolaMiUGvhHQMHzgL2xKkFme537BZVRAeDfnHFw+feVN/tJWw5e7kECG
	 E2oa96Y9iWlixNVY2JmKLadkZIuJs2/yvkQtvzf+pt4fvZuhd5YgqOxHRJ2iVdtkxY
	 JSW67HjpT3exbCQFzkKfsEocI1cqzaq5Jr8iclh4gqYcmdZhEOo5j91FbxOLw4QET2
	 o/Tmrc1FsuYuC2W+t35DhJaXIQzzx+LZQCbBieg/JdUCW2JGhIrQ45Wzb7d8nUIqpH
	 JiByCecEgwwcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 3/3] sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
Date: Tue, 18 Mar 2025 11:12:42 -0400
Message-Id: <20250318080430-936962da5d864135@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318105308.2160738-4-chenhuacai@loongson.cn>
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

Summary of potential issues:
ℹ️ This is part 3/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 558bdc45dfb2669e1741384a0c80be9c82fa052c

WARNING: Author mismatch between patch and found commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  558bdc45dfb26 ! 1:  ff211158f62fa sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
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

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

