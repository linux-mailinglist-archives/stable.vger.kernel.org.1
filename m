Return-Path: <stable+bounces-192234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798DC2D30A
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094F61895A8A
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59A3191C0;
	Mon,  3 Nov 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKLhAAW/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E53168F5
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187874; cv=none; b=sZ++mKvbkAooQPIaaxKLVerw9U9BpflSMWUH/rmAbAcxr5aUju6dm0g/vz5LVI/DjzpNQp30UEDFBhHvKjxuUUSBLzKfS2LjaiTkNVtjkXieZ720XiN2kT1Ayckd6HoXkEFRLr6BKTAbyLr/XQ5Ng6f7WcL7lybjTHY3AgCR7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187874; c=relaxed/simple;
	bh=/RxgV6GAH6nY0rXVs+txNdzsVeVssdpXirByBf12lhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHoXloL5dGTJZpIGuxzkzqgFZZt+FQD/+VyHuIE9zKQZGG/mCNeuacslql5GpHtrcGTUpGsUgKy/k/KcwxEyCsLktELdfklMkR5JMomiUO9EevpqNAXVTern9geKVAMIK4uqemLpX58OlYEdHOzY9jAj+Ws9SwDDXBTNUUf0TkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKLhAAW/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3401314d845so6072982a91.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187873; x=1762792673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dK/8sGZIswEav0IUiwDZwm9zq0rJ+LZHDAICuhXs0I=;
        b=mKLhAAW/yCu07piNY6FX8/jhybjhJ1R8eFmjNDiHryiLluC7Ur+3VCgji+gLIEkEm3
         4Clz44KVrBP199YoDaRREEdn3k6uhpo40mrA24MrzVsyUfooz4Abkjq17jsqsJ1SF4iG
         gcfpBvriE9yx2lQkBbk5wINE44+nyYylnD+/AafdTYpFF9WKNiR6kiYXhZTAzcu3zO2I
         R1fHxF+fkRJsEFVsyBQHaWK0r3CnPiCuaqV9QYpd4581PM/7LZOrCd+Z1hRnCfd/ylDX
         ks9juwkNLpj+lPt9u2I4QqeYpBOI8nZWUrIIvxJNSL0zTlhlQ2zK9ryy+Sjf5oIaLcTM
         dWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187873; x=1762792673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dK/8sGZIswEav0IUiwDZwm9zq0rJ+LZHDAICuhXs0I=;
        b=UclxMCuyDp8WyuTS6jQX3Q2pHQCktVrympBD8+naPE0S+43fgHedkFJO+k4HIr8hZQ
         ojH3u2COxs07qKO2EQFCjFR+q31UhqQwgfq+ohkIoKYszLdH4p/O1y1Oss+uiBP7xRXB
         Cl4n+RkYC+1ywCDJSxgldA7qpY6haZWntWBIGpOdAP8jhue4y1L/TlHBvWbcr8CsOxaV
         hdp2yD9+M++aVx1VjQy28L46EunKIIOf4nXZsVceJg3F69gfqqJ+5XWQ787JJnvXmoHS
         rzccipaUIsvLd+y+N8cYgSx6Dp0fvEbl753g1w/A6qKX7WCC0MxgNUHKS20kmzmIsNwk
         FHtw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Y3fl7ZYTr4PyFwLhXpTrNsj7JtQUsvx09hSkYGonoCzML+Lo1LuWGrPrvo985oFOcu6pIpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UwOHUrygj4+c2F9WuHTqbXJbBppemEy7C61M0T9SQ305Ueta
	33BxoqeaCaMLSpGGl5xMStQEJUGphhNhS7DjnsHR9Xd1FSzWLR+t3HIV
X-Gm-Gg: ASbGncvSn79GDrjehbLI8baePLoKvaJrPd0Aew2H62pzAMYZAcCv8Is7TJpgEXn9JoV
	4nK8oPjp6clKFnbY3NMS1qkeSqE4vniJqoBcl7i3JLgNxqxCphfVXqnUf39R+AzlSI6Vr3JGQ4w
	ehUnDS0JrvMRyqO4nz8NhLKlp6CKY7waZsGp2pFnSdIr1Y0Tjld1aGDxaTmdUuds4DBQdsEP39b
	vbv19j85nAlP3upHYiU1YLXoqvP1ae03ILHDTaFT6vXW07Tgi/HrgZLO2EFWvUFGMmXe+pOCAhC
	m3AH6axYJ4l1Xx/0l2n7KuVsGpldfKUEGyI+5KA+iaX9Rf/Qj4HVkRAxVUf2wa6dMbfEkMjyR9D
	6bFWLXDmCT1j6SXTAHktLtejs9WRRynOdcheceHofa4+f3tulwVZptBV3x18aFQdyJ8EQ0XFzZN
	VgF8yycRzsVdA/L3D6LRDoVgHjQHk=
X-Google-Smtp-Source: AGHT+IHOoUBY/CseGu1rYOaQtYc2Ta6dcd2TXqQsNF64ItkhFWSiHDGtUgBH1/myNfNr7IGUnHaDXg==
X-Received: by 2002:a17:90b:3952:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-340dd2ca68dmr9568119a91.3.1762187872654;
        Mon, 03 Nov 2025 08:37:52 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:52 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 00:36:18 +0800
Message-ID: <20251103163617.151045-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When sb_min_blocksize() returns 0 and the return value is not checked,
it may lead to a situation where sb->s_blocksize is 0 when
accessing the filesystem super block. After commit a64e5a596067bd
("bdev: add back PAGE_SIZE block size validation for
sb_set_blocksize()"), this becomes more likely to happen when the
block device’s logical_block_size is larger than PAGE_SIZE and the
filesystem is unformatted. Add the __must_check attribute to ensure
callers always check the return value.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 block/bdev.c       | 2 +-
 include/linux/fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..26d4ca0f859a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+extern int __must_check sb_min_blocksize(struct super_block *, int);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


