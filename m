Return-Path: <stable+bounces-187462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E5BEA650
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81BB65A216F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D77330B20;
	Fri, 17 Oct 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHX1yVXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F6330B1F;
	Fri, 17 Oct 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716140; cv=none; b=cfyv3hj++HgV/fsHDt7rU+vZpWqnLb5xTCwHHdl3Qi6KoCj5lcV3481VdX8qNzNcQKiOZTx2ggQ3pPj5EbKVXKeLIg+S108/ExS9OCVCMWGJ6o630ArZRBT6ZMjKOScahF5XaflLKK0ZBXtQVUGGlKaAcWTBxKLbCMXU7veB9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716140; c=relaxed/simple;
	bh=G80rEcyY9JD3+ZtRGaSh3wrz3q7CdX1FriyBqCIKXrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mkez7LL3LFFPE1KLDLbWBB/TVftjfGFBVc7Cc4QMUglc9F1CrY5U1U/9/EMM6JPO7pNZu3AYpxRcctQe46rL7uOcnYY/hJ9FMNzlgRyyS04iYU1Pn2jTB00yuRx6LBVj36BWF0VKx+oi23jvk2nk7DJlAz6KTPZzSrHzgVHOGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHX1yVXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245DFC4CEE7;
	Fri, 17 Oct 2025 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716140;
	bh=G80rEcyY9JD3+ZtRGaSh3wrz3q7CdX1FriyBqCIKXrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHX1yVXm2zTR73rjrc4CUFXeGytfp5xs2OgfNcRtDJvGeVQyQG/ALtX+mgfjUOUCm
	 qwR4O8WH5OiXiFwwYrB1sDUemnM0k5lIvsfpO30G74Ti9oN/Cj+cYuCuFFRkxywAoI
	 PUBB6EHCihQhDZ/2mFJMnyRp03uOs9vWNFE2QhXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Magnus Lindholm <linmag7@gmail.com>,
	Ethan Hawke <ehawk@ember.systems>,
	Ken Link <iissmart@numberzero.org>
Subject: [PATCH 5.15 088/276] sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
Date: Fri, 17 Oct 2025 16:53:01 +0200
Message-ID: <20251017145145.698633347@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

[ Upstream commit 0b67c8fc10b13a9090340c5f8a37d308f4e1571c ]

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from
the respective function and calculate the remaining bytes left to copy
using the current register contents. This commit fixes a couple of bad
calculations and a broken epilogue in the exception handlers. This will
prevent crashes and ensure correct return values of copy_from_user and
copy_to_user in the faulting case. The behaviour of memcpy stays unchanged.

Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> # on SPARC T4 with modified kernel to use Niagara 1 code
Tested-by: Magnus Lindholm <linmag7@gmail.com> # on Sun Fire T2000
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Tested-by: Ethan Hawke <ehawk@ember.systems> # on Sun Fire T2000
Tested-by: Ken Link <iissmart@numberzero.org> # on Sun Fire T1000
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20250905-memcpy_series-v4-3-1ca72dda195b@mkarcher.dialup.fu-berlin.de
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index 8e4d22a6ba0b2..846a8c4ea394f 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -80,8 +80,8 @@
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
 __restore_asi:
-	ret
 	wr	%g0, ASI_AIUS, %asi
+	ret
 	 restore
 ENTRY(NG_ret_i2_plus_i4_plus_1)
 	ba,pt	%xcc, __restore_asi
@@ -126,15 +126,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_56)
-ENTRY(NG_ret_i2_plus_i4)
+ENTRY(NG_ret_i2_plus_i4_plus_16)
+        add     %i4, 16, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4)
-ENTRY(NG_ret_i2_plus_i4_minus_8)
-	sub	%i4, 8, %i4
+ENDPROC(NG_ret_i2_plus_i4_plus_16)
+ENTRY(NG_ret_i2_plus_i4_plus_8)
+	add	%i4, 8, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4_minus_8)
+ENDPROC(NG_ret_i2_plus_i4_plus_8)
 ENTRY(NG_ret_i2_plus_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, 8, %i0
@@ -161,6 +162,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
+ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
+	and	%i2, 7, %i2
+	add	%i4, 8, %i4
+	ba,pt	%xcc, __restore_asi
+	 add	%i2, %i4, %i0
+ENDPROC(NG_ret_i2_and_7_plus_i4)
 #endif
 
 	.align		64
@@ -406,13 +413,13 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	andn		%i2, 0xf, %i4
 	and		%i2, 0xf, %i2
 1:	subcc		%i4, 0x10, %i4
-	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x08, %i1
-	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
 	sub		%i1, 0x08, %i1
-	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
+	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x8, %i1
-	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
+	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
 	bgu,pt		%XCC, 1b
 	 add		%i1, 0x8, %i1
 73:	andcc		%i2, 0x8, %g0
@@ -469,7 +476,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	subcc		%i4, 0x8, %i4
 	srlx		%g3, %i3, %i5
 	or		%i5, %g2, %i5
-	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
+	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
 	add		%o0, 0x8, %o0
 	bgu,pt		%icc, 1b
 	 sllx		%g3, %g1, %g2
-- 
2.51.0




