Return-Path: <stable+bounces-77328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471E985BDA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B2C1C24B1F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453F1C6F76;
	Wed, 25 Sep 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G26KClcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E81C6F6E;
	Wed, 25 Sep 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265190; cv=none; b=gin2t+mrKFEXWIPknNpdRjxkPYj2nZgXigVrIA0uFxXb3bEC//JHJE//otIVssQrer00fs2eU6UensVfaLd4z2iY9GyqLiv1y7sF0NX5AT+6mUUvdEx5kyRGY+Gb21LckiBrlmZsjxOdfRswHD0Y/toAGVD6NqmU22dqra2MjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265190; c=relaxed/simple;
	bh=DuoHC4eoRpAF2ydRHlp13T/qqkDeeG8pU8rlqzMEC88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnl4m5NNIu9BQ3gK45Ko1ztKWtiBoTJGBPWvboYgKjhj5rKtGgYNjS2HFyzEENUn8LrPIfqIA5RpCY76avEt574aoIFTe8zCUsioTfFqIWy6lW9TyV880jw6ih+IvfH2CarrdWcLJNw2Ss+L9lJoS0ww5cTDlWufYeaS0o+zSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G26KClcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17045C4CECE;
	Wed, 25 Sep 2024 11:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265190;
	bh=DuoHC4eoRpAF2ydRHlp13T/qqkDeeG8pU8rlqzMEC88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G26KClcvkwXXmj4hGcH09L8vry4XzWMgQk4NLIGRpTPVtwhfsfpoqr17LJ8Yrf0X5
	 QNI6a6NLRLRERF3FUhMfhoRTxn8z5Oypq3gtSmBvYVmbeaD4ypwuJlofkH+/pWcBsV
	 T77lNi2fj9LjCGu/F3tYMKNAhCLv8hZtkcp2ScZ1jlOdQOjBRuQ8udiZG5F70Al3R8
	 8DXvyK1UbdnTLW9jX9mnhBVwA1VYmzi2TkUHTY6z2UU/tzKWYGqSPFYiWRNxMerv1k
	 03D37bRs6qY2ku9eBswqY4bCHPLNghDARRYLQXyL3Oy/fXpdDBSd9qMChYsgitYQqA
	 KVDpe7siHrCDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Sasha Levin <sashal@kernel.org>,
	tytso@mit.edu,
	luto@kernel.org,
	tglx@linutronix.de,
	vincenzo.frascino@arm.com
Subject: [PATCH AUTOSEL 6.11 230/244] random: vDSO: avoid call to out of line memset()
Date: Wed, 25 Sep 2024 07:27:31 -0400
Message-ID: <20240925113641.1297102-230-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit b7bad082e113640fc81200ff869e5c2d7a9c29a2 ]

With the current implementation, __cvdso_getrandom_data() calls
memset() on certain architectures, which is unexpected in the VDSO.

Rather than providing a memset(), simply rewrite opaque data
initialization to avoid memset().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/vdso/getrandom.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index bacf19dbb6a11..1281fa3546c20 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
+#include <linux/array_size.h>
 #include <linux/cache.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
@@ -73,11 +74,12 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	u32 counter[2] = { 0 };
 
 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
-		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
-			.size_of_opaque_state = sizeof(*state),
-			.mmap_prot = PROT_READ | PROT_WRITE,
-			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
-		};
+		struct vgetrandom_opaque_params *params = opaque_state;
+		params->size_of_opaque_state = sizeof(*state);
+		params->mmap_prot = PROT_READ | PROT_WRITE;
+		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
+			params->reserved[i] = 0;
 		return 0;
 	}
 
-- 
2.43.0


