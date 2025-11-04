Return-Path: <stable+bounces-192377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE336C310E3
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 13:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F9D420F73
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442482EB841;
	Tue,  4 Nov 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IonmIC4L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9951F1513
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260655; cv=none; b=RT2ux/lhc0nvoBgdUgCotNnLGsugtf2IhKy8aKTOyA6KJ06NaOIAMcBr3zr3e/+Q50vkOsexMNI3IX76G9vX/CfJ57cRQNOMwEgpI3NQlUxb/j9GY8OpXG9t/R8XXmZ6QvZR9UTwpbIO6lgGCavTpS0xX82+W9+b/vg59Vbp40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260655; c=relaxed/simple;
	bh=WmtRZhDWkgJIzqTmohBXn31bc3c2KAlmHgsg5WATPKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld1p1Z/vahUZWlRlrK7ewz3DMiFD1lFGWoJESMavT7dkiFDoIBcAcY2vMOGdJRg8EXtQ/HiVpQ8PJP5MnTW28j2dgseNKUeS+qabbJ+dvT0QI4BgaqDfx4BqE1q0aW52lCfu3DNAwzmncsMoHuYhRaqyZ2IfRU3eoV8SRKdHaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IonmIC4L; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5548444b3a.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260653; x=1762865453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=IonmIC4LhN1XzPTkIv8HigOViYXPokTfsztF7j9wSpyOwjWz3r9up6tbmwkDz+ddq/
         MyUVPriJjEjAkPOBz/7nwAPHo4QTJcburF0aBIGHXEv0cjF+769y4DplVvCyBbjC8SSJ
         SSvvhbPEtpGWiuP5uFNSHsBha/nS/Sio/DF3b49qf50jhaih6OJRZZBF5DiHzeQrV+VW
         Vg9hqiJuYJfnKoXyWuudeFXrXq6utP50pFtXlfYM286upkugh6X1OM26ITR6jKZfsEQK
         daj+CBBaP0u3gJO3oGGyqlJTTF5xSd3m1jUQ0usAB8kKDRYhrqx9rTeOmvzOPr+HtVgc
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260653; x=1762865453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=SonwQAJHTkLswM/cgQgxKSVYN0Y/lkIL8K8MZ55JA8Oimi5YfVfjVTcuQAvoa2cvOk
         xoxtlyEJcd278RBm1OGZxvSnsFefU6JgcQWVr8F3ISVBpFpZU7QGwCl4P67y2hkEOYnH
         JXzi1usM1iyEAXyO38NU0aVSVvq4lcw2sqCoEwOMpwP8OGM7cnTeO9voSTkwekd/qs9I
         zyosZ2+lP9RAn/KCkJS+J26Gf5uTsBoCbqouIDyJa0PwKbHZWBWe4p6QeF+trIVz2V8n
         S77qKq35ch5+rVatytpz6guJGcwaGK0CIcN4+jzrG3eImlrQOjiU8R4jSOn+81ZBhtj4
         Pxeg==
X-Forwarded-Encrypted: i=1; AJvYcCWQrnGsyN6np4P2WJ/3SNhFCKF6knL0agZ7cXhSPmZ/3zk18Ti+x8o/ICQ84cCDxNqQ5GVaMWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcW/6rUB5jqiT9N0e1sqCUCu2nBSkuKhE+YwdkohKROCFUZcY1
	fDEa561P29JAW9Flzc8GNkA/nTjx1dkadqJEkvrTgB1Rw+EKfzRBI6hJ
X-Gm-Gg: ASbGncuDiNgOi/CKcOerpRzsd09zj9DFUFiOcg2/98/PSW3QzF2U3OjXXI2IHLaMbTE
	Oq+kolWu9m/SMA6sqiNSY75QW7ZhPeqNKlE8qLNxAWMnnYWLAyp8kVUVZtehbKP3CxevMmMRylF
	kj+vqCed4CAi0JGexLyYvdrfE2B80aLkDildfhXUsYEgQeyoPJ9nYmQ84k7nDi5jpLdeHtLcdT1
	l0u4KwkRQoumLNbpx2anEK0kd5QRRdB8axUIlKeHs9LE/+rBvRDTm8MPxFs5phMn33RJp2MMg5Q
	60IglJl1j3nflNUZ290LTcfOhyuJNRu3euDdynykTmCeSHXBph9rIwbe58kbi6fxaIptbTvITu2
	pfxT7IBDy79yKGilbLuLULYhpT2OEDw1aoYtC5gkhY7VFysM6Ced88yKXFtVVSSi0WeCFbOe+Gp
	/z1O/mCdf6O87YrbMkVsSEFq9BT6v4f4HhNcv5iRqxrUHIrVQ=
X-Google-Smtp-Source: AGHT+IF9GGj6LSoxr/C7fblJY9vEfziJTCbSQQeza2nw0zDMlzuQfM4TKJWECjNFJLSbFRIBSCyjKA==
X-Received: by 2002:a05:6a00:4188:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7ad82997336mr1106651b3a.2.1762260652783;
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 20:50:07 +0800
Message-ID: <20251104125009.2111925-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
accessing the filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 719c1e1829166d ("exfat: add super block operations")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/exfat/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
-- 
2.43.0


