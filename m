Return-Path: <stable+bounces-171964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA974B2F488
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B00164C88
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5F258CCB;
	Thu, 21 Aug 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lbQVxlWJ"
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23F1E7C05
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769684; cv=none; b=Wk9+GM6P4YhsxLG5stZ+EULp7IC3eKxf6zFPLCtpdXw5z31wPSYCNLDUb7OYogFRtP87bnJlPDuTkDH8B96rN6QZoygIo7+9uBnOfoWlgXDdWsHwj7CFo2DhNyM5WNsz78M1hOJZNhAQkF8gpa0ANq3V4N3e+N61WpkahoKGOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769684; c=relaxed/simple;
	bh=kIZG+OAAx8tocENchx2qBgV4pogk0JQv0JVCEoINbqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL93qLG2BTi9wFZWVRKqHYaB9tj+ASdsxEdBQqHBB9h2zNB1kUn7IeCGCzZIj9lwU6jPpy0hgpOTR3aXzhqDZqx0+BxyUHMBsCExCHPb2hiE8j77dukbJm7d77hx+qbjy4eQfLeCH4+AIrjaGyurkaooiK4PWjhSqtcyqZp1nXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lbQVxlWJ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755769676; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CgJcbDKN+MTSvpgvbmZRd0uo1XfWR3RZXlsg6cyYMKM=;
	b=lbQVxlWJjI2lIUEsI2zYk3IJ74zaL9qzP6kmqg2FZR4rNB7ql5B4Q7JVe1PBabIkzczXWpFw6PoJy53O3llCpKquQuOZPhAZmL87xZYYknQjmJ797tdZAC+cq0n7TRVcAtPUS0dN5tfJIUmgNARFLbBpRMzvEP3P1vHjUMa/jTQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmFdvw2_1755769674 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 17:47:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.16.y 2/2] erofs: Do not select tristate symbols from bool symbols
Date: Thu, 21 Aug 2025 17:47:49 +0800
Message-ID: <20250821094749.3665395-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
References: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 74da24f0ac9b8aabfb8d7feeba6c32ddff3065e0 upstream.

The EROFS filesystem has many configurable options, controlled through
boolean Kconfig symbols.  When enabled, these options may need to enable
additional library functionality elsewhere.  Currently this is done by
selecting the symbol for the additional functionality.  However, if
EROFS_FS itself is modular, and the target symbol is a tristate symbol,
the additional functionality is always forced built-in.

Selecting tristate symbols from a tristate symbol does keep modular
transitivity.  Hence fix this by moving selects of tristate symbols to
the main EROFS_FS symbol.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/da1b899e511145dd43fd2d398f64b2e03c6a39e7.1753879351.git.geert+renesas@glider.be
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
to address:
 https://lore.kernel.org/r/ca432b9e-e016-4d2d-b137-79def0aaca85@kernel.org

 fs/erofs/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7b26efc271ee..d81f3318417d 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,8 +3,18 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select CACHEFILES if EROFS_FS_ONDEMAND
 	select CRC32
+	select CRYPTO if EROFS_FS_ZIP_ACCEL
+	select CRYPTO_DEFLATE if EROFS_FS_ZIP_ACCEL
 	select FS_IOMAP
+	select LZ4_DECOMPRESS if EROFS_FS_ZIP
+	select NETFS_SUPPORT if EROFS_FS_ONDEMAND
+	select XXHASH if EROFS_FS_XATTR
+	select XZ_DEC if EROFS_FS_ZIP_LZMA
+	select XZ_DEC_MICROLZMA if EROFS_FS_ZIP_LZMA
+	select ZLIB_INFLATE if EROFS_FS_ZIP_DEFLATE
+	select ZSTD_DECOMPRESS if EROFS_FS_ZIP_ZSTD
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
 	  file system with modern designs (e.g. no buffer heads, inline
@@ -38,7 +48,6 @@ config EROFS_FS_DEBUG
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
-	select XXHASH
 	default y
 	help
 	  Extended attributes are name:value pairs associated with inodes by
@@ -94,7 +103,6 @@ config EROFS_FS_BACKED_BY_FILE
 config EROFS_FS_ZIP
 	bool "EROFS Data Compression Support"
 	depends on EROFS_FS
-	select LZ4_DECOMPRESS
 	default y
 	help
 	  Enable transparent compression support for EROFS file systems.
@@ -104,8 +112,6 @@ config EROFS_FS_ZIP
 config EROFS_FS_ZIP_LZMA
 	bool "EROFS LZMA compressed data support"
 	depends on EROFS_FS_ZIP
-	select XZ_DEC
-	select XZ_DEC_MICROLZMA
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing LZMA compressed data, specifically called microLZMA. It
@@ -117,7 +123,6 @@ config EROFS_FS_ZIP_LZMA
 config EROFS_FS_ZIP_DEFLATE
 	bool "EROFS DEFLATE compressed data support"
 	depends on EROFS_FS_ZIP
-	select ZLIB_INFLATE
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing DEFLATE compressed data.  It gives better compression
@@ -132,7 +137,6 @@ config EROFS_FS_ZIP_DEFLATE
 config EROFS_FS_ZIP_ZSTD
 	bool "EROFS Zstandard compressed data support"
 	depends on EROFS_FS_ZIP
-	select ZSTD_DECOMPRESS
 	help
 	  Saying Y here includes support for reading EROFS file systems
 	  containing Zstandard compressed data.  It gives better compression
@@ -147,8 +151,6 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
-	select CRYPTO
-	select CRYPTO_DEFLATE
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
@@ -163,9 +165,7 @@ config EROFS_FS_ZIP_ACCEL
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
-	select NETFS_SUPPORT
 	select FSCACHE
-	select CACHEFILES
 	select CACHEFILES_ONDEMAND
 	help
 	  This permits EROFS to use fscache-backed data blobs with on-demand
-- 
2.43.5


