Return-Path: <stable+bounces-164533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290CB0FEF5
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F925467EF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE91A08A3;
	Thu, 24 Jul 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUqZYIUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039E22097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325667; cv=none; b=bFQ2HcoRJxIr2rY+TDlvtjqCil4KCn3UltTzcB9StV6WuO3LvGzP7Um4EtdPix0Y/mD3KUIvBwqy7zMfVTea9XGNvHdkJs5IAQEjGzjYcp0EPqTY4/92R+2zyA6TsSOYvE5QP5UbEdrAU4DpCG8yCOUExXbvldu0JelRSH296hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325667; c=relaxed/simple;
	bh=IKgz43LUimAxxfe4m04N4j3OzO1LUHklw6KDv1yri0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YovaItTet6WX7mNGCBOIAp6u0XxK+2FKHkXCXQtrXWki8KgvJZAnT2XXukSKLHjrB6HjxLapI69psA7Ie9X1l5SCq/EEs5zWj1/0dJ8IgzA1VL10xlAScVZAiMjbykruvIzekXU4vuVQ8xKORHJbvyBosZEWW+GD36z2LLwNnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUqZYIUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46C8C4CEE7;
	Thu, 24 Jul 2025 02:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325666;
	bh=IKgz43LUimAxxfe4m04N4j3OzO1LUHklw6KDv1yri0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUqZYIUS2a1h4dCDKw6z8X7NDD8OJM9HuhPl2WsiHrjucaghGDuvT8aCk9MSjN0ar
	 fx5mSABaH5vz2h0+ilMi6pPt0loc/KLHJDqYDlTlmOX2HQyoi6vPjttX6WQdD2Qbyr
	 wfCKhk1i4NynMlI278nHO0UZwds5OKoiIsa/GtWeRMpqYZj3efLfRTPQN8HzAMz0M9
	 mLmAjTwpHXI5d5JqV1OAy9I/j15U/zoJXeWmWSuY3/jR9zAvOTODdAaOJOVDh+b9C7
	 LRT2M6ArOSQpThafehHpkfu8U/TzSYZNV/BtgarlskUomlGcAEhGT4ps9qnow32Kre
	 FzgKOPTafSWZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: powerpc/poly1305 - add depends on BROKEN for now
Date: Wed, 23 Jul 2025 22:54:19 -0400
Message-Id: <20250724025419.1277524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062040-daylight-scrubber-8837@gregkh>
References: <2025062040-daylight-scrubber-8837@gregkh>
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
index fccf742c55c2c..5c1619f251885 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -129,6 +129,7 @@ config CRYPTO_CHACHA20_P10
 config CRYPTO_POLY1305_P10
 	tristate "Hash functions: Poly1305 (P10 or later)"
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	depends on BROKEN # Needs to be fixed to work in softirq context
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-- 
2.39.5


