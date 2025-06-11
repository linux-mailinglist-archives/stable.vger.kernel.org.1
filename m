Return-Path: <stable+bounces-152457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E739DAD608A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CAA1BC21F4
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE61F4CB7;
	Wed, 11 Jun 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/zsfeUp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D51DFF7
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675699; cv=none; b=IaD4DJSF/pQoRJi04TYvjWqL4++1B5O2MVB1f6aCC/xWgG8yuhrhkKyrXSl/6faa18cI+U0w3rhh4tE5TLCIvkXpdtHx0FQ9juFpGialm21XW/8MuORDoFYInzpW1SZUP7jJfTc2W8niJ7pYBL0g++/7UMynDCuPrd6D70VwJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675699; c=relaxed/simple;
	bh=8m+vHGJfga0qNr2h4OF5dstlW0uRfVScY457vxY2iDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crMzjC1hd18i/wyI3g4SLi1QXqEz5Bd0KeQVzxonF/WtZya3LgpGbwy7pfbXTUCHKybHquX2vRgfS274iZ522Y9yKnFHsdmfWPRv/MTlLYS7+Qg/uO9nI0Iz1U6DI0NbFJVa/6STK9mtOQXzEbxvpPQHC/Azre24PTOpr13p+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/zsfeUp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so174477a12.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675696; x=1750280496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goDMck/8fNxYteDrebfQCLxZ7pD2hoCWa00IBC4U4no=;
        b=X/zsfeUp1i3a0Fcw2ax/Ej5U9iR6X1Mpd9dYmOO6bayv3y6DMxcFlsUbtfQEbnWnK/
         h8c2hgPcUqvramFHK2rPxGSmDI7kDE04bUsMFdBCg0B3MH8KaJOaZkBXycj8c7mUrlOB
         N+skevZpHsgjKzo3IlXhxMyEfvwNl6dElGgGo+iv4hzmBCrzRhQFIpaeiG9dODZG1lpe
         r4roBXWho0F2cnnStWaxnGuXuI5sFGlttD4lGSU7D9ZaO9/lc93byBbuFz1Du94xPCIl
         zwIl+ftRuTaXTBGv8YEfY4CNbEsCrhDNGhIxiqnLwCych/9ajFrz1bZ8uhRsbXWvpTjz
         1Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675696; x=1750280496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goDMck/8fNxYteDrebfQCLxZ7pD2hoCWa00IBC4U4no=;
        b=Ye4pQ9IsUjmbhmX+mKRqUvQW8xPmOk9afxZTRhLX0zw8e4DSKlNOCs241HDswcb3Jo
         AqPy98Lc17QmdIHcVPUQ65dsINn/qb2rPO6RpCdIZw7jRZ1qj18EtP8MiPvdKSW7ue1x
         h+h0P055Uw6D0TO2Z/7wP6SRMSnizBbexKzNBuIZB/jddaDNvraluzSOMJbXrEJGxFNp
         U/by4yCg2COhRA5ODrgGchKcwhPWQkdBOjc5qjJdzQ2BF7ejqTHc7BYpUJ7KoR9nQ1T2
         rRCNNFwtWWnzIE6EcbsBLS9/j73XMoLg2Tb2hd1uz0cg5+igJ+evUFp0A27f1T0dSG5c
         HUPQ==
X-Gm-Message-State: AOJu0Yx0/Qx0oniSgq2qkZ0SVWHlk4BJXD2RHgMf8YqUmPP2OAcM6YZI
	JqxW0OhmfW85PFNZ3KSrzngQil8OqIMJU0b8CYUa/T9/Bk/hwIlDDhEcrSnHmaxU
X-Gm-Gg: ASbGncu8JyHKHip7EmueS5EfLvDLwcZjT+EvkX2e4S4Ypx42WV0ClKVVYTt8SSj2dMX
	4R+XiswQD5eSs4hEDpUXBk0oZlGMMrgh77lRPn3BQZfG4wARH+haknamDgllRre/WvjygKmJE+Z
	/lKTz64xptIYy80o7rH3Qr6+SxkRMfcZDnbME5oSsHsH2BY/8UK0vz0XKRfBLq9d8dGfU5ycS6x
	sQAi96svRHKK+JWvZK070h32hb32py6dWhIhAO7zM4x/kFer9I63fJU0/1L+36QiJ5qYUIpuQtq
	xh3HUfI+mqV6+MI93IGLb+Rc5S2t6DjcCaBCOxxrEU3JAHAmhLuKblnDV7aNyt2ZmERj3dIUCpd
	b/TvfLGe4ths=
X-Google-Smtp-Source: AGHT+IHT2ZmxuimUm/b7FSqZTbwDuSExdtDZ++ABlJz3XeHWtSguMStae7ek8VJSEy2Oa2qrs8ZnVA==
X-Received: by 2002:a17:90b:2704:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-313af12a2bcmr7760567a91.11.1749675696141;
        Wed, 11 Jun 2025 14:01:36 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:35 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 03/23] xfs: fix getfsmap reporting past the last rt extent
Date: Wed, 11 Jun 2025 14:01:07 -0700
Message-ID: <20250611210128.67687-4-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit d898137d789cac9ebe5eed9957e4cf25122ca524 ]

The realtime section ends at the last rt extent.  If the user configures
the rt geometry with an extent size that is not an integer factor of the
number of rt blocks, it's possible for there to be rt blocks past the
end of the last rt extent.  These tail blocks cannot ever be allocated
and will cause corruption reports if the last extent coincides with the
end of an rt bitmap block, so do not report consider them for the
GETFSMAP output.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 5039d330ef98..7b72992c14d9 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -527,11 +527,11 @@ __xfs_getfsmap_rtdev(
 	xfs_rtblock_t			start_rtb;
 	xfs_rtblock_t			end_rtb;
 	uint64_t			eofs;
 	int				error = 0;
 
-	eofs = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rblocks);
+	eofs = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rextents * mp->m_sb.sb_rextsize);
 	if (keys[0].fmr_physical >= eofs)
 		return 0;
 	start_rtb = XFS_BB_TO_FSBT(mp,
 				keys[0].fmr_physical + keys[0].fmr_length);
 	end_rtb = XFS_BB_TO_FSB(mp, min(eofs - 1, keys[1].fmr_physical));
-- 
2.50.0.rc1.591.g9c95f17f64-goog


