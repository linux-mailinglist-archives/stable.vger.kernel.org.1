Return-Path: <stable+bounces-72372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1F967A5E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70380282217
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC7181334;
	Sun,  1 Sep 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V35oWbau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27451DFD1;
	Sun,  1 Sep 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209709; cv=none; b=i1XDzSVziC6Zge9OOqB+4hz2nV+WPzwJvllqwwhbg1526BoT3SL7Wiw+62HpfrODemBvEcNuOhlHV4pg8rFx/sSmriuFu1lOpemfUrs3HSwZf836PcH/bkSmTzbFH45iMHVJBribkk9+c2F95/ZfR6+6bFl5umgHtGQKVjfjLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209709; c=relaxed/simple;
	bh=ZQdHKYaJaN+56/oXH3BcQnBseNAv8y19p83p5KNbomU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeeQIT6weo9ttz/QYVQVEK95tCmAUljTomUo1Q2QP7T3XG7w8Uf4UpZQDEWKXUBWhkLXiQx554swUl3B3tmkTcn6iKpyh3EsQ8ZvEZVDMrI5UuAKDkHUSQuVliiZ7KJnc/nlcZIrZkJw9mFicXFgLp99yZrYEgNzeGMwHdbi0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V35oWbau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25878C4CEC3;
	Sun,  1 Sep 2024 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209709;
	bh=ZQdHKYaJaN+56/oXH3BcQnBseNAv8y19p83p5KNbomU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V35oWbau09R3sdQklDfxhkUnFMtuenTwrYfHAgORh6qyvboKgTrHjKy/S7VN92oGG
	 xH1QdphJSbuGN4JSR3nfMWPhalrqJRnuXNaUC1H3JSS1LjqIY/2Ui8VDe4oRc5QB0E
	 tMthp138duOL+3gvn+yzaNRYVor4O55C0+59YyTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 120/151] tools: move alignment-related macros to new <linux/align.h>
Date: Sun,  1 Sep 2024 18:18:00 +0200
Message-ID: <20240901160818.623542840@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

From: Alexander Lobakin <aleksander.lobakin@intel.com>

commit 10a04ff09bcc39e0044190ffe9f00f998f13647c upstream.

Currently, tools have *ALIGN*() macros scattered across the unrelated
headers, as there are only 3 of them and they were added separately
each time on an as-needed basis.
Anyway, let's make it more consistent with the kernel headers and allow
using those macros outside of the mentioned headers. Create
<linux/align.h> inside the tools/ folder and include it where needed.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/align.h  |   12 ++++++++++++
 tools/include/linux/bitmap.h |    2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/align.h

--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <uapi/linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _PERF_BITOPS_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <stdlib.h>
 #include <linux/kernel.h>
@@ -166,7 +167,6 @@ static inline int bitmap_and(unsigned lo
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)



