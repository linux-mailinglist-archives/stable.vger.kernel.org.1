Return-Path: <stable+bounces-42846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7075E8B8469
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 04:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A343CB225D7
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 02:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37111C287;
	Wed,  1 May 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doiQKAE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA31BDCF;
	Wed,  1 May 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532071; cv=none; b=Tesgu3iAPjBvNKD8Uw+cLmOylcdHzAeS23UUMqiOU8q4cpJ27YS45ENj9eOeGQvviYaeo+VrqLlI8Gr9chTZ9Aa13q17re9qGk/8aCwmybcAW2gK2IYNM5W4exzY9aCdF+5Sd8Xs6J58VtB9mcxEVyGt67Bb7LO7EqF0bwYKtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532071; c=relaxed/simple;
	bh=aZB7vIbD/rzjyBEQhIjJP1qAh6CuOgetQmb4pP6HIhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3yihnR28bikRxe7ppGSFrgRTSC61q1G8iQAyE2cw6CN3nt3K/lLW7TB40XlVsEb4nj0xY1XNDHmC4wsN1sdUn2CE3cajzbjfHLutbyQ2ai+f85qk/ICFmjpA9Xs/g6F1ZbbWSCJsAJ86lsPiurFo/ch7qBDXPhnTC9dPpz9azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doiQKAE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB56DC2BBFC;
	Wed,  1 May 2024 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714532071;
	bh=aZB7vIbD/rzjyBEQhIjJP1qAh6CuOgetQmb4pP6HIhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doiQKAE82Z1BrDtH7nTKQDrj1rwqi6Rz+8calI8ctuJJHiVGBEzU4c3vB8v4DLxER
	 o+KCpBR6zP7xVzdV4xpxYiwtZnGf7H3czXq/G3/pBF9S3hnhHbiEwQ5QF6LqDLXes4
	 WhuZ3v1MIsARXOZSINxXCTZ+AWK2xPlRhHiA5JerNCWXDcBFWpyVvyGNs+lezIABo8
	 NhyugS9py4k0IPNz48dYvpGi5vACgt5i0s7I2h7mCvxLfuRN21coZK/KfkT8hAr11m
	 fxGWsHFM/fUsiMornC8OtnjpIf4NCH1AMzRQTJkJT87goSjDxPxLtCzN/iT6C8lHEj
	 u68+MddVDZ8sQ==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	stable@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] fsverity: use register_sysctl_init() to avoid kmemleak warning
Date: Tue, 30 Apr 2024 19:53:31 -0700
Message-ID: <20240501025331.594183-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <CAHj4cs8oYFcN6ptCdLjc3vLWRgNHiS8X06OVj_HLbX-wPoT_Mg@mail.gmail.com>
References: <CAHj4cs8oYFcN6ptCdLjc3vLWRgNHiS8X06OVj_HLbX-wPoT_Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since the fsverity sysctl registration runs as a builtin initcall, there
is no corresponding sysctl deregistration and the resulting struct
ctl_table_header is not used.  This can cause a kmemleak warning just
after the system boots up.  (A pointer to the ctl_table_header is stored
in the fsverity_sysctl_header static variable, which kmemleak should
detect; however, the compiler can optimize out that variable.)  Avoid
the kmemleak warning by using register_sysctl_init() which is intended
for use by builtin initcalls and uses kmemleak_not_leak().

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/r/CAHj4cs8DTSvR698UE040rs_pX1k-WVe7aR6N2OoXXuhXJPDC-w@mail.gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/verity/init.c b/fs/verity/init.c
index cb2c9aac61ed..f440f0e61e3e 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -8,12 +8,10 @@
 #include "fsverity_private.h"
 
 #include <linux/ratelimit.h>
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table_header *fsverity_sysctl_header;
-
 static struct ctl_table fsverity_sysctl_table[] = {
 #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
 	{
 		.procname       = "require_signatures",
 		.data           = &fsverity_require_signatures,
@@ -26,14 +24,11 @@ static struct ctl_table fsverity_sysctl_table[] = {
 #endif
 };
 
 static void __init fsverity_init_sysctl(void)
 {
-	fsverity_sysctl_header = register_sysctl("fs/verity",
-						 fsverity_sysctl_table);
-	if (!fsverity_sysctl_header)
-		panic("fsverity sysctl registration failed");
+	register_sysctl_init("fs/verity", fsverity_sysctl_table);
 }
 #else /* CONFIG_SYSCTL */
 static inline void fsverity_init_sysctl(void)
 {
 }

base-commit: 18daea77cca626f590fb140fc11e3a43c5d41354
-- 
2.45.0


