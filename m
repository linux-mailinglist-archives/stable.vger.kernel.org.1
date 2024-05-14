Return-Path: <stable+bounces-44545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C388C535C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EB11F232D7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE88594E;
	Tue, 14 May 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1YMKlvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3018026;
	Tue, 14 May 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686471; cv=none; b=lSe/jQqrmpkd5i+u8FMBR7D1p3ayKc55kHW8UkCNOw8z0fhe8paAWv1xqrJBgEriBOjeBhw3SmcBeuKxVa0A+9dagmH6D2UiVs75x7+ZZ4w8jNpmFJ64X9WGpum6BXLmRG1Ct+XHObKrKL4zYjRklQM/SySXtGtc5iNiEoyk9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686471; c=relaxed/simple;
	bh=fp9Dgj7caFJ9kPFSxkAQvpQXfskk3DM6hvRcoH2T9Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5Q5R4HY5XaR4tBL6n48Z9nHx4DsbGsbKd1jgVPJKH8Vxg7m4P8baAVvm0FLkvzWGWeE/jyoWdb1vmWhD7KCp036syjXde61PrfF0yeOQYrHFKX/FOLMdP6Czn2cz0tQDjPPL7Syc7YZJ4B+NH2XYBgvF/dpisuzrHJ6p0YS4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1YMKlvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F25C2BD10;
	Tue, 14 May 2024 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686470;
	bh=fp9Dgj7caFJ9kPFSxkAQvpQXfskk3DM6hvRcoH2T9Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1YMKlvUfXWzE4LG+jp3ghELoGsXHeflM0Eol2weGTddu6169btcVjxy6g5XTTLSX
	 pVjHg8YLhLMVsJxdY7g40cHCwaaYWoElTqE+2RQoJqaHItpcv/dNq09YBpsirVysvl
	 LBKFdFN8DjUfhGcQX0Ag5dpHg6yBGNZWgEgpeFEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/236] memblock tests: fix undefined reference to `panic
Date: Tue, 14 May 2024 12:18:00 +0200
Message-ID: <20240514101024.851479311@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit e0f5a8e74be88f2476e58b25d3b49a9521bdc4ec ]

commit e96c6b8f212a ("memblock: report failures when memblock_can_resize
is not set") introduced the usage of panic, which is not defined in
memblock test.

Let's define it directly in panic.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Song Shuai <songshuaishuai@tinylab.org>
CC: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20240402132701.29744-3-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/panic.h  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tools/include/linux/panic.h

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2e..07cfad817d539 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/math.h>
+#include <linux/panic.h>
 #include <endian.h>
 #include <byteswap.h>
 
diff --git a/tools/include/linux/panic.h b/tools/include/linux/panic.h
new file mode 100644
index 0000000000000..9c8f17a41ce8e
--- /dev/null
+++ b/tools/include/linux/panic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_PANIC_H
+#define _TOOLS_LINUX_PANIC_H
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static inline void panic(const char *fmt, ...)
+{
+	va_list argp;
+
+	va_start(argp, fmt);
+	vfprintf(stderr, fmt, argp);
+	va_end(argp);
+	exit(-1);
+}
+
+#endif
-- 
2.43.0




