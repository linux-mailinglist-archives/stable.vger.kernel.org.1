Return-Path: <stable+bounces-164532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C39B0FEEC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5513A58D2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE215855E;
	Thu, 24 Jul 2025 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMHVJo8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96A22097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325366; cv=none; b=q8f8fRLZHCkuR0vjU18lgjvq3A5pnFjP8OlMjBHy5FXdC2wcEJNtvmkf7MmkdZ0EJ+HUpDJm/ZCojruT0dRTSM8yvKgDsqb+IuF2VNU8m8yg6vMjr4cQZeCcuFusrAaOkjIFckFsXfLdvoqyeKONFf2XonwHIpwHCA94D9PPDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325366; c=relaxed/simple;
	bh=PQzmD1EtO87cCbmjbLgK4Rpzjk6/3kBhCzwTi7SqmYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQrOwhgP4FsPLTo9iFkMTrxEYkIx3/ymPDKiQ7HkVCo7gYA6mCKrNeJyM0cVLRWh4zoJr+GmgXBz4ukMFwLyHa5uiKFyRUDANMfvHBZO6srRUSWC1ew691t+bThBsb8OF9Ggj2rY8cQ7ByUlXpffITstWm991KfffOs6OtGVW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMHVJo8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A17C4CEE7;
	Thu, 24 Jul 2025 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325366;
	bh=PQzmD1EtO87cCbmjbLgK4Rpzjk6/3kBhCzwTi7SqmYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMHVJo8F6rRmy49hr0OJW/fj67GvbbwLZbrbeT4NkfEzSQx7DajJQrlMVKGDmRP3X
	 sFbw4AS4PJK+1lXTNUYAek7TVAGe6+DeT/hVvUfMmDsOXM/E9sYS3bGlGk0SyITeBf
	 K4GCJV/0eFaxqhS209nELfhaVGszWt1li0Ltp0SBkKsxa1INxXgN4HQa/WuGBSkJjy
	 ThCxo2K3dz9AoP4bIzOUbZ0MYVZXwYjcrWUHQp7n3TFa6gAP/sB2j7c5TXbgYBOr/f
	 QHd3wNdMUFP+TpAbvLPs8vT88wyTJhD6jW0L7hiScNwf5ohH1eYPSA815IzIt7/WQm
	 nmFLxE1rkRSwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] crypto: powerpc/poly1305 - add depends on BROKEN for now
Date: Wed, 23 Jul 2025 22:49:21 -0400
Message-Id: <20250724024921.1276399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062040-renderer-tremor-6a52@gregkh>
References: <2025062040-renderer-tremor-6a52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit bc8169003b41e89fe7052e408cf9fdbecb4017fe ]

As discussed in the thread containing
https://lore.kernel.org/linux-crypto/20250510053308.GB505731@sol/, the
Power10-optimized Poly1305 code is currently not safe to call in softirq
context.  Disable it for now.  It can be re-enabled once it is fixed.

Fixes: ba8f8624fde2 ("crypto: poly1305-p10 - Glue code for optmized Poly1305 implementation for ppc64le")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ applied to arch/powerpc/crypto/Kconfig ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 7012fa55aceb9..15783f2307dfe 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -143,6 +143,7 @@ config CRYPTO_CHACHA20_P10
 config CRYPTO_POLY1305_P10
 	tristate "Hash functions: Poly1305 (P10 or later)"
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	depends on BROKEN # Needs to be fixed to work in softirq context
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-- 
2.39.5


