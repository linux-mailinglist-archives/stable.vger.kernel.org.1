Return-Path: <stable+bounces-51545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E98907062
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4C8284B49
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4A13D512;
	Thu, 13 Jun 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1EnSic/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC266AFAE;
	Thu, 13 Jun 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281610; cv=none; b=X1lSSvsBaqlH2LnKEYZTJoF3AcetqJ31r+GOs6Hf3h2uN036dzgIGD8IDNzXxi6uHojwIkyHWrHkagrNt/MFWc9kSkKlMozQLUEMKG2gMulvUIyJiPfCzm1UHhzjgVNYAXSUgLLYs/EfA0BXZbp/7J1y3Vm2S1LqFhmwKZNpLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281610; c=relaxed/simple;
	bh=UUMkKFnwSsft/xP0Lud4OJGiitDjbcA8gXsUgt4Vz5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML9a5eAn+MP3QlO6EhCxQW+GCh4IBbXe5pfEDzcg/kN0fkqlH19c6scmIyGfuyx9WCoJTrvOUICBRtTazS7m73IlgtBuPptb0NSNtxWgM9gmluigKX8EVigmHr6+aEk2PBepYwgkrr1yYdOKV3RCWiLzZz/R1fvWcInJxgmhudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1EnSic/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67622C2BBFC;
	Thu, 13 Jun 2024 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281609;
	bh=UUMkKFnwSsft/xP0Lud4OJGiitDjbcA8gXsUgt4Vz5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1EnSic/cF4a20wjaGuWZ46Sa1DpOPETSfIiLfHC84w997jb99mmUoa70Yo1YHJGJT
	 RPP+FQPwrlU6aY/xA33qv3e4nO+k20sVaF5wehAvEZOz496Wyr1G7TCXzLFW7gMrAU
	 K2b6dxndVI89993JRFccJ7fJMTE5kgPmikZmF2Yk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Chikunov <vt@altlinux.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Paul Wolneykien <manowar@altlinux.org>
Subject: [PATCH 5.10 296/317] crypto: ecrdsa - Fix module auto-load on add_key
Date: Thu, 13 Jun 2024 13:35:14 +0200
Message-ID: <20240613113258.999942749@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Chikunov <vt@altlinux.org>

commit eb5739a1efbc9ff216271aeea0ebe1c92e5383e5 upstream.

Add module alias with the algorithm cra_name similar to what we have for
RSA-related and other algorithms.

The kernel attempts to modprobe asymmetric algorithms using the names
"crypto-$cra_name" and "crypto-$cra_name-all." However, since these
aliases are currently missing, the modules are not loaded. For instance,
when using the `add_key` function, the hash algorithm is typically
loaded automatically, but the asymmetric algorithm is not.

Steps to test:

1. Cert is generated usings ima-evm-utils test suite with
   `gen-keys.sh`, example cert is provided below:

  $ base64 -d >test-gost2012_512-A.cer <<EOF
  MIIB/DCCAWagAwIBAgIUK8+whWevr3FFkSdU9GLDAM7ure8wDAYIKoUDBwEBAwMFADARMQ8wDQYD
  VQQDDAZDQSBLZXkwIBcNMjIwMjAxMjIwOTQxWhgPMjA4MjEyMDUyMjA5NDFaMBExDzANBgNVBAMM
  BkNBIEtleTCBoDAXBggqhQMHAQEBAjALBgkqhQMHAQIBAgEDgYQABIGALXNrTJGgeErBUOov3Cfo
  IrHF9fcj8UjzwGeKCkbCcINzVUbdPmCopeJRHDJEvQBX1CQUPtlwDv6ANjTTRoq5nCk9L5PPFP1H
  z73JIXHT0eRBDVoWy0cWDRz1mmQlCnN2HThMtEloaQI81nTlKZOcEYDtDpi5WODmjEeRNQJMdqCj
  UDBOMAwGA1UdEwQFMAMBAf8wHQYDVR0OBBYEFCwfOITMbE9VisW1i2TYeu1tAo5QMB8GA1UdIwQY
  MBaAFCwfOITMbE9VisW1i2TYeu1tAo5QMAwGCCqFAwcBAQMDBQADgYEAmBfJCMTdC0/NSjz4BBiQ
  qDIEjomO7FEHYlkX5NGulcF8FaJW2jeyyXXtbpnub1IQ8af1KFIpwoS2e93LaaofxpWlpQLlju6m
  KYLOcO4xK3Whwa2hBAz9YbpUSFjvxnkS2/jpH2MsOSXuUEeCruG/RkHHB3ACef9umG6HCNQuAPY=
  EOF

2. Optionally, trace module requests with: trace-cmd stream -e module &

3. Trigger add_key call for the cert:

  # keyctl padd asymmetric "" @u <test-gost2012_512-A.cer
  939910969
  # lsmod | head -3
  Module                  Size  Used by
  ecrdsa_generic         16384  0
  streebog_generic       28672  0

Repored-by: Paul Wolneykien <manowar@altlinux.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/ecrdsa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -294,4 +294,5 @@ module_exit(ecrdsa_mod_fini);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vitaly Chikunov <vt@altlinux.org>");
 MODULE_DESCRIPTION("EC-RDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecrdsa");
 MODULE_ALIAS_CRYPTO("ecrdsa-generic");



