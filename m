Return-Path: <stable+bounces-125835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848CCA6D334
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 04:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE01816DBED
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F31EB3E;
	Mon, 24 Mar 2025 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrF805CX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2F79F5
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742785363; cv=none; b=sANg3gmb4ffuFEndtLcTURqM10fIU0jR1dTIvf1FKcveVysGu+68Ii1eZopFLe111arqV5PdqU8uHes5pigoY8+DGZXoFM+QW3T1KLoiVOSQO09ArLC2uk3kGsUsJjE+cPhq76LLie1Zht8YG8eVYMWh+ElWnDkfJdxOdz1zo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742785363; c=relaxed/simple;
	bh=IFV7KJD8VoJJK2IzBTq45zJuCQd8SK0HFOS2V7eokCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRv8gkAGLF2Jn7MSrxiBZNztbj1Mu84LgOdjVGcXi0aQKRIH+/fMigBnekGqbbFdxUlHU5WgjyuQY6xSWkpUKovxK+eF0/6CLAeB6Dyw7rKOMrSxY84c/FNdPlVN7GEAyyOfMAT8gq1CK3pxabYjf0/oGWwwWgKTGJr1jMshB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrF805CX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso74838975ad.1
        for <stable@vger.kernel.org>; Sun, 23 Mar 2025 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742785360; x=1743390160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+l7w6YVclRU1veLb1P6QKLsVP0T/fgc/by4ealGnWA=;
        b=MrF805CXMIeTHos/igL2IcnTCnYUQuo/tccfJOLUdwcE6kIQVR165lYS2nqxq0G7au
         C4b3sAMFgJYG2e1nvpgy0+KcKR1ScDdD8Hv3U1fd9BcQWvSCANH9IYrnJdtFpHQHlIau
         2lLhRwlfZJYmxJEL6lQKoyjlVhXw2+3rzYNjFKq7N6JbS4LAbPJxliGClQPEo5Xy8nnn
         jGWAfIJ9lPLORtj3nxrgDsPaXyK531jRfHQPXIVHeIb2Sg9eznXrG6LvJvBwFqthQPvM
         DrQR5pU7eRaROJQac2QVSHyKDq4j3ekS8eesDDvi2btFDlU5K+/iS5ax7a8nZbDvtyy7
         LJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742785360; x=1743390160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+l7w6YVclRU1veLb1P6QKLsVP0T/fgc/by4ealGnWA=;
        b=g5Py1OmXBkT1HgHEYIref2SQgZv/+FT8aH4NyJ5GEQP3qCP62t1ODaAk4tFqkcExng
         cAs7rEl+mWyFtIfSF3d8gbykmzDcxRcuVA+LaYsnKp0z3Vxao4KBm5fXpPelkj7FQtTB
         36c3UvGMn/m4WP5n7ZyW6rtCuEmEu0yTK2Kr1sjjJigiDeWr2F/Gqv1KR7AdA80o8Fm9
         PJpjotSM3d49yIT0UrBlLAIEBmHB61OeXdjVtGu5KxVmw1w0OB1rHFJFNtL8NLqY1Nj4
         mJ7eeQhxQBnvvlthXa9i82znU8bEm8gmXPlwbRkN/98/G8IKdtr4Y32R4DyZ6aHPuy9n
         k2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXi9k4PC/iJ+CKbrzhpfiYXrLfUBuscfEYTAVYYFFrCOZxNpoScq8efeVnWeCyuv33TTgUYpZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgGKHY+aZZ7XW6UD6nb9fqfXMiIaFehMq8JmD9HMCkI+JGlrA
	S6VdDVMqFY4a4CmZO1HDkqNtCcvXooKqLQ+tdpwa0PFzW5J9M1fy
X-Gm-Gg: ASbGnctYUhQk6i6+KuJxqlvIlg0CHzvGmhQT/s6z8iYJit1/dlkoQicbYBZZN7ZiylL
	Pj5N2irqRRGoDBzx1skNoJtxyG3IauiPucxeVjsJ1uyPOMf6pruwiWcYV5UUkmDC5nykJWGKEYh
	UyW3+HdXGpKAfbz1Y/5SUKsug1MLfsxLvVcU3GATHgRQc4SlRGXU1Hi2RJoJMe1zcYfkKdadYLo
	rOhh2PVNIP5ee9FGkaRiLGEQ9CZgMCWZPY9Wmbsox9yg3yPJqrOzer7P7C/+Zzy9yhWkb2n20ij
	oazjIjDodml8Uwg0XVUvTLIm/OVCJ86q6Ih5Z0J/UuSRRZsns0cYIjwj8I2G8ggxnPVflLkDwTN
	f0SnF
X-Google-Smtp-Source: AGHT+IGvlHUYNSmaORVI045cPDXtYriK0azQzUrN/p8vZbmhQ11excCaFQHsNthOaJHHDvztQbNBzQ==
X-Received: by 2002:a17:902:e74d:b0:223:5e6a:57ab with SMTP id d9443c01a7336-22780e10df0mr170951605ad.39.1742785360068;
        Sun, 23 Mar 2025 20:02:40 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301b9e19ceesm11026239a91.0.2025.03.23.20.02.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Mar 2025 20:02:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	clm@meta.com,
	ct@flyingcircus.io,
	david@fromorbit.com,
	dhowells@redhat.com,
	dqminh@cloudflare.com,
	gregkh@linuxfoundation.org,
	kasong@tencent.com,
	laoar.shao@gmail.com,
	ryncsn@gmail.com,
	sam@gentoo.org,
	stable@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 6.1.y] Revert "xfs: Support large folios"
Date: Mon, 24 Mar 2025 11:02:31 +0800
Message-Id: <20250324030231.14056-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
References: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6795801366da0cd3d99e27c37f020a8f16714886.

Even after resolving the page cache corruption issue [0], problems persist
with XFS large folios. Recently, we encountered random core dumps in one of
our Hadoop services. These core dumps occurred sporadically over several
weeks, and it took significant effort to pinpoint XFS large folios as the
root cause. After reverting the related commit, the issues disappeared
entirely. Given these issues, it seems premature to adopt large folios on
stable kernels. Therefore, we propose reverting this change.

Link: https://lore.kernel.org/all/20241001210625.95825-1-ryncsn@gmail.com/ [0]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_icache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dd5a664c294f..f59890430f40 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,6 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -323,7 +322,6 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
 
-- 
2.43.5


