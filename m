Return-Path: <stable+bounces-118590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D46A3F633
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB86188A438
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86B20CCF4;
	Fri, 21 Feb 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu07H70V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F72066F4
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145141; cv=none; b=b4obbw45nYkeR69hgy4Ez1LPRiwVBRuYU3XwOp/1pE7UcfMjJ2kezyTacSi17vE4X8iGVUn5rWQYX9ccQSQcvoqwycTijwqv08+yLOw1MI3KX+nVwseNCd1zAXpBPOUh6bSMM47OSfhuHeN1N4m4+03pykFyF0DAxVqxs/SHYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145141; c=relaxed/simple;
	bh=LV4cBgT2Cn88BaJA7ygUH2v07T1Hb7kMaaAIC6sUmlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdR8HkVx7I7ZXIE/2+pu7WJlGbuadQOjjE7gbseUEWhI2R/HLun40B6Qrr4bdTVd7abBmJ3U19r4Yrgi45Lz6SevC7HvfTU2NJoFvXzXh0pFgbQOqfoAr6V+xH5tN96jCdnA+OJLBlCDh81jiDcH6QhHZEZoiyJi/USn2owGvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu07H70V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22104c4de96so35305835ad.3
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145139; x=1740749939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ8x/sAGliryp+27PVekH2FKqTwATm7XGGh6lvNg9iI=;
        b=Eu07H70V0THLQErg2OBaETKhou1lPjd/8vwbGXcC5TraRv6LVTlG6yoYKe152GEiZ9
         +uimF3XQTsPYD5axVDmTzsSziL/d0BKgBkdk01q6XswbLrOgsuc0P8QTWRtMO7upwSxH
         hjCl3HpbOXIu6xiaiwgj2mNClVhhWzq+tDtFhCQyafdwXVBhLwYPWg3l5XfD0gDCYtJn
         TYHVeK483p8WqcHyezd+Rdct4IhkPmB0PwHmd3w6hAlf04p2CPH36va/rpmtcyefvquN
         L6rwfyEp5UWnVLx0hyN8vRzQ8CxEWjv21q2f7vv21DlDN6b+n2MHs5wzvVmfMtScBT6o
         kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145139; x=1740749939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ8x/sAGliryp+27PVekH2FKqTwATm7XGGh6lvNg9iI=;
        b=RuV1KEA0S56PPFpjIBLPKLzictKaqzKLKZ5LkI7whCe8bgI4I/hC6eikokalroD2gN
         8l5Dqht69GFKdgKGjiFE2KXl8QmOaVByvg/UDKBPxtTgJm5C3nRwuzamdwrAt3tAEi2o
         0WMei966ZayX9RWTeyaQmYHla/eTPJcTTjKN8E73StJwFSyIqxjYMJZYnJri5tFIZcXq
         0b89RxnJ2e81AeS4ow3D9e5RiKbtlwnzucW+413C8SH4KOpnghv0xL8DB+2X1iAWjsQa
         cQRDJL5/F6DoYy0vtwQTIA0cp1Qb+MdyeLNfzVTOyBuMxrRdXwce4VXeifZHr6BZ+t43
         bzlA==
X-Gm-Message-State: AOJu0Yx/z+EoGhoY/Ao+PXgMdIfpK8nlEHwuvrL+ccirBgYjb3N28uOw
	23/pR73EZwR3GA1y2UO8zM8LlabYGH4bWAGOj/2WnHHeoSqNLj5z3ikQCA==
X-Gm-Gg: ASbGncv93Y27eajDF+4DplCL9OL39lJ0WneWVgp3MdH7Pxql2xcC40A9UtzO2gBnXBO
	k7wFbLNa/Hgj65ZJFSxZvqU/YZQhucw10Awd9FbzD3kt5tUlYxDu8K2ja4NG7BCQ7C/pxKyl+7u
	XCBMWULmRtPv/oCZalCwFmXNeiCbwuJtFwy32QB9DJx1clUYgn4QxoTuV7XF1X6x+n0eJym4bFX
	nbdqdOkMxvLRhY1XAtGM4T63+iq4Hhpe8t8pqc/cKs6aDepSUH3b3pzy/Mn7WyRBdINuP8HCWed
	V0e7CaxXhnDrFYXTBkHqWWDt4OYi4IEkZm85WAU0lYir2Dbk84ATyuzP84a6WIwyUUMkbIi66w=
	=
X-Google-Smtp-Source: AGHT+IEaqKd9X+4bVqM67G1WgmtSPQ5vqqW6MFX3RO3tWmsLNNyHtZYaw1yPSkEfe3LX+fdGvmavZQ==
X-Received: by 2002:a17:903:8c5:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-2219fffa9f3mr48421035ad.45.1740145139303;
        Fri, 21 Feb 2025 05:38:59 -0800 (PST)
Received: from carrot.. (i121-113-18-240.s41.a014.ap.plala.or.jp. [121.113.18.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm137818645ad.7.2025.02.21.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:38:58 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 2/3] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Fri, 21 Feb 2025 22:37:54 +0900
Message-ID: <20250221133848.4335-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
References: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.

In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
path.

When replacing the kernel memory mapping method from kmap to
kmap_local_{page,folio}, this violates the constraint on the calling order
of kunmap_local().

Swap the order of nilfs_put_page calls where the kmap sections of multiple
pages overlap so that they are nested, allowing direct replacement of
nilfs_put_page() -> unmap_and_put_page().

Without this reordering, that replacement will cause a kernel WARNING in
kunmap_local_indexed() on architectures with high memory mapping.

Link: https://lkml.kernel.org/r/20231127143036.2425-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
---
 fs/nilfs2/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 819ce16c793e..4d60ccdd85f3 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -431,13 +431,14 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	inode_set_ctime_current(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
-	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
 		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
+	nilfs_put_page(old_page);
+
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-- 
2.43.5


