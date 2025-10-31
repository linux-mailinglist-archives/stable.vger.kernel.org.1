Return-Path: <stable+bounces-191816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF9C25388
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D3414ED3D2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041B34B19F;
	Fri, 31 Oct 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI5W9+mc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748534AB04
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916333; cv=none; b=XmGSMY37QedIrfVHxuZiP/I9yqOn6nZ3VcgePQqz55ERgCddq6by60xwEzh8P73ZqTMWFLInGXbU/GQepqdxWdg+AV+b2V2cb377LL0NzDmExZ8+qky30f/pPYID91kiHoAGvXQ5c6YQNsdXC+86TTV2Hd/Yxhq17p+JY2fUROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916333; c=relaxed/simple;
	bh=d6gENf0gOi2unsfMB6yOOfdUG5k4an/ZqR0af0XPe8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNVO1Lb7v5tCyIndRVFIzjKLOpe7e7DRVH75F1ECH76sEgYIH7v+hDN7SCv0Q7QG5dwndxRlUvjuniVlEShgD3VbGVzcQK7PuyVsbR2re9DGY+hS2/+io4J8AIwFW9P4CGzIZ1onQpyxazNgeOWqTWh1NX8tHQsKT2+FkEuTz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI5W9+mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B83C4CEE7;
	Fri, 31 Oct 2025 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916333;
	bh=d6gENf0gOi2unsfMB6yOOfdUG5k4an/ZqR0af0XPe8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AI5W9+mcF8xkGJ18LnN+Vsw2orHDTKP57Tka6wFkTj+tX8BSGT4EWa7L3ueDKSyB8
	 2aIJ81KjoypTdYbmKk5VbBQ0n4r1DCGVhiJ9HLNEAQ5mkq2M0WlXZMJKLdiAy4l3fS
	 3MByHf8ETQ0ojeBG3Bg0ZzmRLDFPAmVCGlsC+KNNdZwqxgrPRq1BKwM8DeX9gj7ENI
	 iFMvU7cM7eFJ/WKDyvTWzMr1xOJwF1o8Tvlg2BGd5RIzqyst6kTIGj6AL6wkqDUcIz
	 KujXVu+d7mQM4BAE71enmq+/unI286SMDPqQTY29LlswqhzeErIzjMOCy6ZwVzWdFb
	 zwmrkuWqXNnjA==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.6.y 1/5] bits: add comments and newlines to #if, #else and #endif directives
Date: Fri, 31 Oct 2025 22:11:57 +0900
Message-ID: <20251031131203.973066-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-plaster-sitting-ed2e@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=wbg@kernel.org; h=from:subject; bh=qHDkh5qhgJbimUEkI8/7D2z+EQ25FuQSAo3hHH2whIs=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksm2fZ7XeK/5U071z3o/e+B/TzF+0VqAk4cEvwhE+Ol nvXwYMfOkpZGMS4GGTFFFl6zc/efXBJVePHi/nbYOawMoEMYeDiFICJfMhh+F8flDhN6qyJ9KR7 dRNkEywqepgvzIie0OLzQbuk0u37xCRGhpfJ/LsT3SsnBLOXzb/ReCbmcd9XRoUf1Zf+39nwZE7 0Vn4A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 31299a5e0211241171b2222c5633aad4763bf700 ]

This is a preparation for the upcoming GENMASK_U*() and BIT_U*()
changes. After introducing those new macros, there will be a lot of
scrolling between the #if, #else and #endif.

Add a comment to the #else and #endif preprocessor macros to help keep
track of which context we are in. Also, add new lines to better
visually separate the non-asm and asm sections.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Stable-dep-of: 2ba5772e530f ("gpio: idio-16: Define fixed direction of the GPIO lines")
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 include/linux/bits.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7c0cf5031abe..9cbd9d0b853c 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -18,17 +18,21 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #if !defined(__ASSEMBLY__)
+
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
 		__is_constexpr((l) > (h)), (l) > (h), 0)))
-#else
+
+#else /* defined(__ASSEMBLY__) */
+
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
 #define GENMASK_INPUT_CHECK(h, l) 0
-#endif
+
+#endif /* !defined(__ASSEMBLY__) */
 
 #define __GENMASK(h, l) \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-- 
2.51.0


