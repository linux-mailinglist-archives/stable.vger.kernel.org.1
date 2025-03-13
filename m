Return-Path: <stable+bounces-124377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EEBA6029B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759DD17D239
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F31F426F;
	Thu, 13 Mar 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntiK7JiK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D01F4604
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897585; cv=none; b=GBPRu9rN18k3IJGTI/D/5YYuOdA0hF5+Lf1Ebf4WUgrL7l1Krq1GjWaL6E3jt6RVps8ksV39tyXhIneUy7KBdJnBE+q2/WRwGHdp0jMaPs2yOqppeifAvnbMABWU+2FfO18a8R3q7UHNrUVtbp0B7kCXfwzuCI9ZaQK1KWlvKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897585; c=relaxed/simple;
	bh=Wj3ibwlt48iOxlBvoeIiMcEVEmYPQDd04GXqGz7gikQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baDqyJu10b1dCZ0EHX0AsH4kAQdf2zUjkw3cm1ARV6TShrblk/C0vsrBltaKZsd+gmZG5rIT3r622jEbKTW/Lbc8YaxXRMXMGhNZSTMN4EjiX0tJW6F7MKt7Zs0F1UjWf2rJhJJNZkWqdJxTlZ2/6lNgFDhbW7xa0IZ/uf4zW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntiK7JiK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301493f45aeso1214865a91.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897583; x=1742502383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXjdErJ5UDKKcBILdyWMHBHXCz7clBFQKh4//AMnmqI=;
        b=ntiK7JiKMNEw+ssU+UupfuKcqLCQEWh+5iHiwKV7pEs0ReS/HSxJjRo+L47jBtAwyt
         XjR7LMTHPAe0+Ko6T2Hi5a9SUABqKf0sVq4bw3iF/zkhGO13UDhmTVKR9I9N1veP+BCn
         NGz4yoe4YV6G3jdf3XoHIeO5dS7Ak/+3db90FEc+mHGzvdCDRw8xvcTIz6/LsKJuZe7G
         GRTBIxmdoKfuSrlESS29TqdhJ3iOYDIC0blvt/VmsyJCMGUl0ezsRe7yLM7JRBPslk0v
         FsGo9DaJ1wDKV/5mLD9z75vJLyPjg6K82xsA/6Gb4yGhApuTOWGmwYjphmrpobRiIhSh
         HCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897583; x=1742502383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXjdErJ5UDKKcBILdyWMHBHXCz7clBFQKh4//AMnmqI=;
        b=a2Y5MBjjyAK+qIhCC6S15qYcp1sQ6Ik1VkQ8qwFsGAxp0Dq3csGMHsIq946imIchwD
         Wcehh1rnybtTjfTGcM9hJswFZkz0Jdr9jfxS5VcjYSe2YahEGpZg6XMzDfwdhjUGE1SM
         nZfPHVQVi4wHkWvZ0ORMkRgr4bulG0RXquQuXqyyIqrl5VBJkhTtea6p8izWY/hmR565
         YXvE1YlidNFdVzZg7Y2tJb1GG1AI4WL1burFXgNJ3z9DhVYbu5IQehQ+33aPY/UP+6Bp
         1msv+B2i0AdqEGwV6I9YBuZcsW+36D8Yo8NCE8AUQmD0k+yFjwjVhwpROchKp4SVxH5v
         Vy7w==
X-Gm-Message-State: AOJu0Ywu1DnQ0jKaPJIaIjZCocVWXUipvpR/HzCuSJyhLRTVFkJLPjUS
	q8kcseC81z7KH/jxjtm3jHvfw6YU9THIa8gI37VKEXhEDA9EmBzaWfjDTNQz
X-Gm-Gg: ASbGncuGQR92jLJYfW7/ZNxr4FYN/EX7x2zJ2Teukv3MqmiBixVTe6eIZDXfBFbvr6u
	miMijvDXvxK+CuajmG69oqAXnSCcPAqW9CVd01IdmyHxtq6qtL8bOwbwwbqo7aNN00GhkoIkjnw
	L5eh/MwibZn0CAvUrXvfLFd4tXkvyrX40A56P5Wve2LFZi8s19vU0iy/X4U8N7NtnTPSqobThyr
	EZ9BreWLrt7YNyWKautgWTDGaQdidv1jFDwPaUtgfjbYQAzbL6Mrr7Rajb99bAFKZdy4eAbAYTZ
	kAudUROBWZ7gW0j4zONFysiX5Eq6qwrBzkh6wyge2g4DJhfHHQJu0gym6YM2q92dBXrtYuw=
X-Google-Smtp-Source: AGHT+IE/RczupRRdFR4sP40nkNEsDKwtiHr51v88nSxMfZ28H/P5brMX4OE4CvjqCmg5R40iDUtv1g==
X-Received: by 2002:a05:6a20:1d98:b0:1f5:58b9:6d9b with SMTP id adf61e73a8af0-1f5c1149a75mr107778637.12.1741897583652;
        Thu, 13 Mar 2025 13:26:23 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:23 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 20/29] xfs: remove unused fields from struct xbtree_ifakeroot
Date: Thu, 13 Mar 2025 13:25:40 -0700
Message-ID: <20250313202550.2257219-21-leah.rumancik@gmail.com>
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

[ Upstream commit 4c8ecd1cfdd01fb727121035014d9f654a30bdf2 ]

Remove these unused fields since nobody uses them.  They should have
been removed years ago in a different cleanup series from Christoph
Hellwig.

Fixes: daf83964a3681 ("xfs: move the per-fork nextents fields into struct xfs_ifork")
Fixes: f7e67b20ecbbc ("xfs: move the fork format fields into struct xfs_ifork")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_btree_staging.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree_staging.h b/fs/xfs/libxfs/xfs_btree_staging.h
index f0d2976050ae..5f638f711246 100644
--- a/fs/xfs/libxfs/xfs_btree_staging.h
+++ b/fs/xfs/libxfs/xfs_btree_staging.h
@@ -35,16 +35,10 @@ struct xbtree_ifakeroot {
 	/* Height of the new btree. */
 	unsigned int		if_levels;
 
 	/* Number of bytes available for this fork in the inode. */
 	unsigned int		if_fork_size;
-
-	/* Fork format. */
-	unsigned int		if_format;
-
-	/* Number of records. */
-	unsigned int		if_extents;
 };
 
 /* Cursor interactions with fake roots for inode-rooted btrees. */
 void xfs_btree_stage_ifakeroot(struct xfs_btree_cur *cur,
 		struct xbtree_ifakeroot *ifake,
-- 
2.49.0.rc1.451.g8f38331e32-goog


