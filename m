Return-Path: <stable+bounces-171965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89560B2F480
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B093AC68C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1FE27FD78;
	Thu, 21 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IA7oUWF7"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A71E49F
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769686; cv=none; b=kTcPGCZWT64q3XJSLl0CBo+FhjwlPIaLqIswAqR1Zo6PhzsXn/rYCoPc2vtBivY9qMFcB1g+sss9DgYaKIMFA6BmSiTiqTaTca2QLHO/5aeI/FagKv7TzQ09qFEbb/6YjdAmn/R7SuVTi9HcamQ/lKWc08s8S8A9eN/ILv3NDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769686; c=relaxed/simple;
	bh=hcxNyJUaNtkfDSa1+Eo1DbSEaTohxNVNGEUpvasR4Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usDyG/O7LT6WoQ0Vuuj1bVdzWSziNaH1N+103S6Jgstg96qOoXEz0fzlf/raZ4N+kCy7ue6aNavLzJNsVtB54ipIUY/GSKegxqqwYTpCza2aGeeP5g4DOWACqr6dIilFcAc3lzkGmBCkLx5og1khrWiEY/p81XrNR6RMTGPyelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IA7oUWF7; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755769674; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WRpVITYQACcouR/Yb5lAqmjELogbdfbIz8t5ESfurWM=;
	b=IA7oUWF79jOc3g4trkvKspnnQ1kgPFk2wWASolZUUTtcq4t5J0PNZg1bZ51tVC/l9vkZTyY+qDNVEOJ49IgzJM/jIRu0Xm+S25qWMKTXbJXiXubJ7PF8D1TmQcX9PQAwJKPlipZOzyQjCamLk1EBCC9tEzN9bB252xs3d/i8yF8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmFdvuj_1755769670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 17:47:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-erofs@lists.ozlabs.org,
	"Bo Liu (OpenAnolis)" <liubo03@inspur.com>,
	kernel test robot <lkp@intel.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.16.y 1/2] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Thu, 21 Aug 2025 17:47:48 +0800
Message-ID: <20250821094749.3665395-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bo Liu (OpenAnolis)" <liubo03@inspur.com>

commit 5e0bf36fd156b8d9b09f8481ee6daa6cdba1b064 upstream.

fix build err:
 ld.lld: error: undefined symbol: crypto_req_done
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_acomp_decompress
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_alloc_acomp
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
Link: https://lore.kernel.org/r/20250718033039.3609-1-liubo03@inspur.com
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Also backport commit 74da24f0ac9b to address:
 https://lore.kernel.org/r/ca432b9e-e016-4d2d-b137-79def0aaca85@kernel.org

 fs/erofs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..7b26efc271ee 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -147,6 +147,8 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
+	select CRYPTO
+	select CRYPTO_DEFLATE
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
-- 
2.43.5


