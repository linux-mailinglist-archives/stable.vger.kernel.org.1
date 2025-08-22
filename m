Return-Path: <stable+bounces-172362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC5B31616
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A7CA23246
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB38284669;
	Fri, 22 Aug 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIVA4RYo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FA253355
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860739; cv=none; b=K9SNND/Nljd05A3qAxY/TqGnEprjYcIls4jT83oUDhneNLSGeOsnQA8Csjujk8AISMkY5/4pD03bgWuazV/zsd2ndnyyS8osRBnXzlMfbOpfiQ2DjjiHetz8ATgTiL3eIjh9DLIOMXqIqDsArzGmtt+jG+E1pTv+KnVajTjHqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860739; c=relaxed/simple;
	bh=X+MeD59v/CULPYwjoTjdg2ZsivvIWpTawNC/PNXscRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phcbkZdPXujj6T+I6AXMQvSR4lIw6Zk2LX0JEda5X9LevG18few4UO5iGEwggf76irdFFV2N+QVjz/x19oacZK4qHafO2wznBQ/50yygf9M4K+fxUrrrpHC+RIvLk/sjebf1iX4hR8AP5d7ZIRWuxVxariF5VMdyXH/8Z/tOmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIVA4RYo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755860738; x=1787396738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X+MeD59v/CULPYwjoTjdg2ZsivvIWpTawNC/PNXscRI=;
  b=eIVA4RYowo3njX4Yf2Pxz3/YsEy5TcRBnr7UArnehs1JZjGmBYdmNgnr
   QLYkvmEfGb9mho9PSqaR1uHD2EKwgnB7GXng7/DQNxLggDjLCejEhXHVp
   cORrnhGzLaPo6baC5cq3FsxQGdS4lV1ZwX+GDlI+/oA5XHLM9rSFJ63zF
   lGePwU89NKIXKjkt4Aue2+7643gdHM4UBkxbKUnjM0v6nL672IUkmaL5l
   aBXDFmgxKOnbedwKXxHXZ/QFZAWhw7X0ikmrwXDvsrWrDXYCOLkMHSoBt
   l3UXKkQGeUKegJKkRiqQmJXtaMs5Lk+AX7TXdviBMcseNW/d1VqMD9sEU
   w==;
X-CSE-ConnectionGUID: YRoC8YX6SJK0Z8aFAQvPUg==
X-CSE-MsgGUID: 6nZmTD69QnmRqR8bJq5vOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45737164"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45737164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 04:05:37 -0700
X-CSE-ConnectionGUID: pXFD7C3zRByGrNeCfnZTRw==
X-CSE-MsgGUID: qCryKulcTvOm13wbw5sS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="205857450"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.223.204])
  by orviesa001.jf.intel.com with ESMTP; 22 Aug 2025 04:05:36 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	ebiggers@kernel.org,
	herbert@gondor.apana.org.au,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 6.16.y] crypto: acomp - Fix CFI failure due to type punning
Date: Fri, 22 Aug 2025 12:05:16 +0100
Message-ID: <20250822110532.5743-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 962ddc5a7a4b04c007bba0f3e7298cda13c62efd ]

To avoid a crash when control flow integrity is enabled, make the
workspace ("stream") free function use a consistent type, and call it
through a function pointer that has that same type.

Fixes: 42d9f6c77479 ("crypto: acomp - Move scomp stream allocation code into acomp")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[Giovanni: Backport to 6.16.y. Removed logic in crypto/zstd.c as commit
f5ad93ffb541 ("crypto: zstd - convert to acomp") is not going to be
backported to stable.]
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/deflate.c                    | 7 ++++++-
 include/crypto/internal/acompress.h | 5 +----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index fe8e4ad0fee1..21404515dc77 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -48,9 +48,14 @@ static void *deflate_alloc_stream(void)
 	return ctx;
 }
 
+static void deflate_free_stream(void *ctx)
+{
+	kvfree(ctx);
+}
+
 static struct crypto_acomp_streams deflate_streams = {
 	.alloc_ctx = deflate_alloc_stream,
-	.cfree_ctx = kvfree,
+	.free_ctx = deflate_free_stream,
 };
 
 static int deflate_compress_one(struct acomp_req *req,
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index ffffd88bbbad..2d97440028ff 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -63,10 +63,7 @@ struct crypto_acomp_stream {
 struct crypto_acomp_streams {
 	/* These must come first because of struct scomp_alg. */
 	void *(*alloc_ctx)(void);
-	union {
-		void (*free_ctx)(void *);
-		void (*cfree_ctx)(const void *);
-	};
+	void (*free_ctx)(void *);
 
 	struct crypto_acomp_stream __percpu *streams;
 	struct work_struct stream_work;
-- 
2.50.0


