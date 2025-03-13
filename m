Return-Path: <stable+bounces-124378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF3A6029C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54EB17C17C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FC1F460B;
	Thu, 13 Mar 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvT5xkjS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682971F4624
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897586; cv=none; b=Tv3+r3IXNxX0LRkCfeCqNYLvWHfRS3FhzS2/Uet0vHPiGi/2010ON+lErhzcPO9MHAddQjFafez6zEQiYUAanYvgwUZHKWWjWglhcnpKP9K+dAthIPNu/qEr3AQThFSkn134PJwYzqgr27MUH0o/MELM9Aqhiv/xI0W7mBN6Yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897586; c=relaxed/simple;
	bh=Gef5jz/BgpYB8u8f9y9bBXrwhgSwYUF7FXHo8pRSnCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZNbrOxZ+uG4/tV2TLhPGVlBzfYOrX+aH5CjF2yTPXfSvrIAs2cpwxns11gZoqeCGZjzpiWjPunrt/a0aoOVus4IlLHAjdTxXCcZlfgbq5tXK1L6H8eNo7UvL0aml7Sq7jHqLo6B3/Y+u4Iig2md/IPqqWgknJqu7ZUReZake0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvT5xkjS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so38186285ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897584; x=1742502384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKZmGQiex7fl4HIARhGHtynh69FiUbt+YPH37OO9mho=;
        b=HvT5xkjS/7NJBOGUM241uZ9vkirOB8isHUbUylaTxBXoOArsleYqyemL8kc+wcNl1F
         pwQnXi6lYXMS4Lq86ZWT9o2HgJhsiq6jkiM96lAk14hnizvdRzuOR7MCSqFF4fj/zuBP
         YJysoz0s4hrQvK+p7ePHR5OCgs4+/RojLEFEvYWtr2BQ4kiP1ZDSrNBEZCsbjD6okNJu
         tGCIfCYOJHTJP+SQeo1SY98eBNJTtOuRTqld1/RIS0LS47bWuCoYUDasFSccFHPxtJKB
         vfHYDkDnY8yyth+wPwfq12H7wkaxWSlPCIG0sY7LWXTGxu+Tu8yRiD0npw6P3QNJ6WQJ
         9tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897584; x=1742502384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKZmGQiex7fl4HIARhGHtynh69FiUbt+YPH37OO9mho=;
        b=CR4jgRmeXlvI48TT2yIPF+vHRgtPLueZDVCNN8iTboZwCy5vSWcO9ZJjP1xHpMti1Y
         E+sZZ0Zfw8dUkGBFFuFA16dsglPyHthhA1WOyYXFYU8UeRp5d8+Rr9lpcGZgm9uT/BbY
         dGpCCrU93cB1CkxZxFxMy96P1Bru8P0osraLWmrc/ZElVbrOhEaPWZoEJhp9+KRMyGOy
         9vh4/HPumCcWzlVZV1gzzYuHz18IOXVtKmREKSnhPtvnpfMyGl0IhsQ0oA5gsecC9MmF
         5SYSJJNVG5hg9UCt+RO06LoMhJ4hXjEhu99lX7QERhWL51CNDqHOQeKvEYew/v68Pc5D
         y7rA==
X-Gm-Message-State: AOJu0Ywg3kUp/ZUSCx8gtjJHP6E3WFKherHSv8tdkpcCtgLJIy9fLTCT
	qjASwzgtVI2lQNb4dLG/JJUhkNrsXtvtttfYzXM2IN9t3T7YSdGMcs+FR6Tu
X-Gm-Gg: ASbGncskQ0gE8BxEdjfFHq5osk13hyyft4jUsnzB6TW5/QSygZP+1bVh8dBcl3oToOI
	pyces6z6ObLdgE32bOKQ817sIkilX6RRmQQpvorNu9ZxQz7nuB9aJA5pLYhw6D2ZvH/MT/7Qpm+
	5x7qhWWbooqwdYK7gFFwEg2UEHC2fLNonHLPZw/8lhQBCrOSG7dBKaH/zfT8e1I4BLujK8OxZH0
	51pwLP0VelvL37dI1mzGbJFhAwJuk/8V/Jrabdx/4mQeep/BxjR7jTXvAFBh0F/sHei41YALvMC
	Ieks4GUoUmWYgk+09vAzNxU/KREcPnTd+OZxjBV5mix03CkIvk/4N4kFHOqOW8+iCM9IG7M=
X-Google-Smtp-Source: AGHT+IHO+e9p7dcq4WXFR2ma1R3RACo5LTMwqsqT2y3t5TWMduV5Prl+ggmOClT9YY9itkd+TQ4ViQ==
X-Received: by 2002:a05:6a21:7a4e:b0:1f5:95a7:816e with SMTP id adf61e73a8af0-1f5c11c414fmr73073637.23.1741897584606;
        Thu, 13 Mar 2025 13:26:24 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:24 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 21/29] xfs: recompute growfsrtfree transaction reservation while growing rt volume
Date: Thu, 13 Mar 2025 13:25:41 -0700
Message-ID: <20250313202550.2257219-22-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 578bd4ce7100ae34f98c6b0147fe75cfa0dadbac ]

While playing with growfs to create a 20TB realtime section on a
filesystem that didn't previously have an rt section, I noticed that
growfs would occasionally shut down the log due to a transaction
reservation overflow.

xfs_calc_growrtfree_reservation uses the current size of the realtime
summary file (m_rsumsize) to compute the transaction reservation for a
growrtfree transaction.  The reservations are computed at mount time,
which means that m_rsumsize is zero when growfs starts "freeing" the new
realtime extents into the rt volume.  As a result, the transaction is
undersized and fails.

Fix this by recomputing the transaction reservations every time we
change m_rsumsize.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 2dcd5cca4ec2..7c5134899634 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1068,10 +1068,13 @@ xfs_growfs_rt(
 		nrsumsize =
 			(uint)sizeof(xfs_suminfo_t) * nrsumlevels *
 			nsbp->sb_rbmblocks;
 		nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
 		nmp->m_rsumsize = nrsumsize = XFS_FSB_TO_B(mp, nrsumblocks);
+		/* recompute growfsrt reservation from new rsumsize */
+		xfs_trans_resv_calc(nmp, &nmp->m_resv);
+
 		/*
 		 * Start a transaction, get the log reservation.
 		 */
 		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_growrtfree, 0, 0, 0,
 				&tp);
@@ -1151,10 +1154,12 @@ xfs_growfs_rt(
 		/*
 		 * Update mp values into the real mp structure.
 		 */
 		mp->m_rsumlevels = nrsumlevels;
 		mp->m_rsumsize = nrsumsize;
+		/* recompute growfsrt reservation from new rsumsize */
+		xfs_trans_resv_calc(mp, &mp->m_resv);
 
 		error = xfs_trans_commit(tp);
 		if (error)
 			break;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


