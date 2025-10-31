Return-Path: <stable+bounces-191793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BBC2433B
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A055B3A9AFA
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB5329E42;
	Fri, 31 Oct 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd4V7jGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1634D3B2
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903226; cv=none; b=t2UEQhzr8pDa3i7wLLj8E+slgN9wy8YeF+6bbM8hl7qP0uVCelS/KRSOphd5IckrDdJ8F7VNyYptuUYKyK4uNVqj1UrHBBKQQtSX062w7oAy0tykvTnVc98zO6oX165cJaYCjAknkMqbulU6+0OAtBeqKieUqnb183YkL4c5r4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903226; c=relaxed/simple;
	bh=wjlFe99rIG8XwA0xoFCrdXi+EIHA45P/zBdta80zE0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3L/EEfStIV2bVwkJ+YAJVIMiBJTZcm9lfHAdK7hK3B+PNfWvTX6sXzhR7wwE1bRzNZ29tNN0TEhHO4uCdJdHdAMJy3BfgVIsJIJTHQ0pADbFa0I2VlDZFTQs+dAmvff4MhqnQrJMVrvUpWu5gYEnfacMC3ZDgwAm+Inteo+Ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd4V7jGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52B0C4CEE7;
	Fri, 31 Oct 2025 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761903225;
	bh=wjlFe99rIG8XwA0xoFCrdXi+EIHA45P/zBdta80zE0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hd4V7jGa1ZBw+w02ODC4w48CW/Hy6sXF12wzRRmQ/VEZtV1sJfd2iLXleaigE1lXK
	 noUohmo0No34O83XKk53xFSa0Mo1QJcTQ/uUqeS10ddbYiOOQ5QZmXUxJ2loCNyXW+
	 OAa0Td6zjF2vdVxqGDev2VpYgBlyqLi6IZkgwG0o5BORVDwJ9+nlKPZxhTFcVEmBDC
	 eu/jAvjK/fVrLubdLZbxMNvrf7A/Yu1W48EHNDhFXmuD5Kaba1xQnXmQqaHW0jULC+
	 jYwXvuLTmLTNXvxY+RH90Tp3oLzUuNazgPX8HfSMGZX6ZC3kd/aUdf9+soe5ukjumC
	 cCa+bGXop6GxA==
From: William Breathitt Gray <wbg@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.12.y 1/5] bits: add comments and newlines to #if, #else and #endif directives
Date: Fri, 31 Oct 2025 18:33:15 +0900
Message-ID: <20251031093326.517803-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102619-shortage-tabby-5157@gregkh>
References: <2025102619-shortage-tabby-5157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=wbg@kernel.org; h=from:subject; bh=MJd/pjYKMcR/Y5swWGHduvZLzO7jCOJrJ9z6tpD0850=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJksTazs8x4kvOxVn3Ql2IztdblYS7vdys2JoiE7BOeou fztfX27o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZhIXiAjw09Dh/VWHU8ZLdw+ aWRLnSta+VSxNlTX+FzK6X0xBkwnXjAy/J5t96LPYu70ddv/z8uU3v/kyeuYucZXpmu3npfdv+3 XdkYA
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
index 60044b608817..18143b536d9d 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -19,17 +19,21 @@
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
 
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-- 
2.51.0


