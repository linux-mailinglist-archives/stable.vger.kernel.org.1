Return-Path: <stable+bounces-23802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E77868792
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 04:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699131F25AB4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400921947E;
	Tue, 27 Feb 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgTzY+rc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D11B27D
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003500; cv=none; b=uCmxrgDkfapMFAhjJcukSV+dVx4mWpUtBdB/opinhvYodt6iEalMYKdQ73Fe0Q1h+Nv3siuf+/k+0uG1xwv35WyvQSSlFMWHeRxZDvA6YgWMaqSAHJVeDNHoS3S6cr9yu4bUV8pyq8YPhkTxRwFhLK2JcfrZPW/FDQB3Tv1LhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003500; c=relaxed/simple;
	bh=zNCrm2a+LIx1qolabXz3PdKc41aOAEn2UO7MJsLXxdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H69luP0owbtnKDQpQi+3am0Gzs9HiVUSGW5MfOICCoN2jbbtxypEdVzpUXplZ0OWKHz33A8wBAlLHGvUN27aWOiVBvlQAdOnrd7YqU+DyfYBBWrzyqd7xK3PATfNE7k/h0oIBIP0cgawkZpdBNhuYKlG2TBXFFEf3Eh7l2ppilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgTzY+rc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc49b00bdbso32857855ad.3
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709003497; x=1709608297; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYW+OiY7hrg9hJJVMV23BArQpEp+Mbu+faqphSzehlI=;
        b=CgTzY+rcUccwrZt3RpQQH9TozdM6vSdT7U1Wk7vtH5O9Zzj0ztr7Pa0KOEncYtrW0W
         WMMvdwCixp0sDAEBzyXRQfhjkFEHyKHt8wXQXAzbkHmURDXuzHdsJTHPurAI010JmHXl
         46MRcU2lzdk/5c7tueiyQLTlfsmp0jORgaUyfvwmFw31m/YsrDa0g/F+KFR50HuZb4uH
         etBFjyY1jX3M1eB9T9hhtYEt3koEuBVNzXhHpvAN2PDSf4xTUCVSyBYQo4LycbZQBRwn
         vRuqFUgVlw06A0nDlexzgfJ9C/RcNFN5jjSfe6vsHI2EZ/KdDHMBX/MGxSE12ovZTqOZ
         nNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003497; x=1709608297;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYW+OiY7hrg9hJJVMV23BArQpEp+Mbu+faqphSzehlI=;
        b=oUUUE4ctuSKnZPRS9UOv/MhA2g0ogRw1Jm8e4FCycwD1iMepZJ6pls8yLw3fsAGmoQ
         d6pqni/2Ulf4cnFdC5YkSlu4VwxMzsCCw3no7WDzGmLD5duBhyfs1z4Bhb7XH1mmQTx8
         ZLsru43SgUE/QsvMGcWHlBsHe+mXH+HSsmJG8EvkaIhYL0PcUrfpapz6gZ0DNAEyz1Gh
         s1PqYZtYQ3YfS325t9TgQTWcaXlicim3egvL801HUapTlQtQn0BbeTM8F6JjqTzFuldK
         kNHtPWqTtwzYEqEsv2bn67YX337SbJ8SFJvoohuwG+xPFsnE2jGWMCldRimyrdd/HfxW
         AQRw==
X-Gm-Message-State: AOJu0YwNYh/DVLlxvHHlZH3fAjhn1zBWHwh7XJbKionDTTSoadP/Pcgj
	PVweCLUpUxyS+u7lHcNY/UydhPZsmuitCj5fq6qLIH3QI8qPfyBRzzmCk+B3SO7z/vCV
X-Google-Smtp-Source: AGHT+IG5TwA92YjHC6YzSfesOetS4sm25SxEZk8Cc+fmnvspNDF82viDZx2QNhdLGC+3FYFEbJKJPA==
X-Received: by 2002:a17:903:246:b0:1dc:1e7c:cd3 with SMTP id j6-20020a170903024600b001dc1e7c0cd3mr9637251plh.47.1709003497035;
        Mon, 26 Feb 2024 19:11:37 -0800 (PST)
Received: from localhost.localdomain ([218.94.48.179])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001d7057c2fbasm402527plg.100.2024.02.26.19.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:11:36 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	zhangwen@coolpad.com,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH 6.1.y 2/2] erofs: fix inconsistent per-file compression format
Date: Tue, 27 Feb 2024 11:11:12 +0800
Message-Id: <c8c7503a90e89f6595205be21bfbda0cdfcb3a30.1709000322.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 118a8cf504d7dfa519562d000f423ee3ca75d2c4 ]

EROFS can select compression algorithms on a per-file basis, and each
per-file compression algorithm needs to be marked in the on-disk
superblock for initialization.

However, syzkaller can generate inconsistent crafted images that use
an unsupported algorithmtype for specific inodes, e.g. use MicroLZMA
algorithmtype even it's not set in `sbi->available_compr_algs`.  This
can lead to an unexpected "BUG: kernel NULL pointer dereference" if
the corresponding decompressor isn't built-in.

Fix this by checking against `sbi->available_compr_algs` for each
m_algorithmformat request.  Incorrect !erofs_sb_has_compr_cfgs preset
bitmap is now fixed together since it was harmless previously.

Reported-by: <bugreport@ubisectech.com>
Fixes: 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
Fixes: 622ceaddb764 ("erofs: lzma compression support")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Link: https://lore.kernel.org/r/20240113150602.1471050-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zmap.c         | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index ae3cfd018d99..1eefa4411e06 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -396,7 +396,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	int size, ret = 0;
 
 	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0337b70b2dac..abcded1acd19 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -610,7 +610,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		.map = map,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff;
+	unsigned int lclusterbits, endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
@@ -700,17 +700,20 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_INTERLACED;
-		else
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_SHIFTED;
-	} else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
-		map->m_algorithmformat = vi->z_algorithmtype[1];
+		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
+			Z_EROFS_COMPRESSION_INTERLACED :
+			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		map->m_algorithmformat = vi->z_algorithmtype[0];
+		afmt = m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2 ?
+			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
+		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
+			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+				  afmt, vi->nid);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	}
+	map->m_algorithmformat = afmt;
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
-- 
2.17.1


