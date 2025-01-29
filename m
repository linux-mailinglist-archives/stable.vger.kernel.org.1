Return-Path: <stable+bounces-111211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE4FA2242C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B6E18850F1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C841E0E11;
	Wed, 29 Jan 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU7n+rqy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513311DFE34
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176453; cv=none; b=kby/Vb4XTHVg2lZDHjfAp1tDTVgS26wUpWXDkrj3egIjt9dvDoq2S2h6xkE1W/j4SQzeVX6qqbgrBvzKwcjPWmoIk4knDM6mLb/ZOiVLcG3JjEFquGPZa9F7DrWfcJ9uLhUeMuvCL8C3f3y+SFVNYV2jUwkmtQX6kYL0YTBfE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176453; c=relaxed/simple;
	bh=m3mcm4P5C7YTtNMlQULAX3WYiRzuLkXNsFLLC0KyGig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+/K4aECYarv6ya8aBFpLajilpI8I78R5d9M/ceKRuO4jOThsoEMs11+0HoDQAwf92TIbWcGJFXwSUfhmn5eog23Rju8Yus9siASJ1eQrYRL2NrhyHx3AvoPvPnIsAOoncLg7B3j7N8CgGmKyElNzL2DRbmCa4if1C+16wHORV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU7n+rqy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163dc5155fso133125075ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176451; x=1738781251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw3J07jZMpjwNbG5CRDnfY+6XeeoUjFVhT3YWsmES+4=;
        b=VU7n+rqyROThaN+IHaac78JB5xN20YNotkQD1gE7u6zDfFa35cj3hmfaM+NCHZSYhy
         mw1qyyAo2u4zFzqHWpEAekdMykqU2zsJAFOHF5AmiLuzkQbSR5IfSmRofGMDUTR9p2nI
         m8fraklWcR9/Nplfr1xOnh0cWRNxBC7AtI6267MR6FXoLNexLRb0y7D4zsfkysWmrLoS
         tIksdajw8s4YhC+0lXyzzTIH36wt24lRARN4bhw88etNwNYsXI6uFKMFo57eq4DfaI/m
         DZphdCPOHnMw6yKlxQ/ycxo1WotRNjHU3PULaVf/h2PdmCxlcL6Nq4Zg3wGfpe8kkHHZ
         bXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176451; x=1738781251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw3J07jZMpjwNbG5CRDnfY+6XeeoUjFVhT3YWsmES+4=;
        b=Uk7ZPojfW68Z6ewPDdnjWiu0lyjGtKE1jIMgGalmkOq3dupP91u01s/BFn/6v9uPJe
         uhS2PeLWnGMUtPqvojosP4UCdUajS5SGznqbofC/pOmQM7S4pVp/WsU3WTLWqLH75diu
         3DR3pnqh4rqwAslSHJexbEEjfIpZVN1Dx8eC11ZElTMr5/lNn2+Ly/+Ba+2cLMecKkJn
         cmQROC/niYUnfqc52Y0QerlrU+4CGv1Pm5d2Rzmcokp+tsDpV9NnXyBvQO9G60fD56g2
         ZB8l0ZY+zhYjsFpXgSfEqOExjnmXZ3h8whjaTc9ZCoCcNGM/H5adAF4tUFI46rXSwPRc
         78/w==
X-Gm-Message-State: AOJu0YwDTTDISyjX7mYjIXVWDc2BZf8Sk0frr2kRVTJfix5jD3X95EGm
	2G829v4MA1BOVKVg9PEBSO6YBfTV4RcgJKb7fGYuJyoj9fLBoZyF3vzFbQ==
X-Gm-Gg: ASbGncvtWRvkic5PdTdAnPQRJt9L/L9OWWCDH3oDdXjzpFNXJRLNESqyCS+Lt6joifA
	9CMYGHmVETMBOd+1Zrxj3UBm8Q9jdPYC3lVvOer4z9+wgn5uamQZ+76xJmhKBvoAWbmO1F+M9Tb
	IlVAWPa1a3Y0HUK+lhu4JwRNqgBuelJueZJJM167vxIG7YOspm/kUAXnBF2jUUFxisNEM223JyL
	nKrDrJTN3fIyBksGHhYHLm0QnzFM/+AygUAL9yP47R9+Hn+WdJkRv2CEBGuIUl3B/P9r7qbUBT5
	aCq8NElSzwTpZX0FlFdi1lle2YEkKbCzts3snm60HjA=
X-Google-Smtp-Source: AGHT+IH7Y0xp2mT6vncLNCc8jj27aGbz72CYvQkt7OV4qkzerZvx91UgHodwDzrHmF3mllFgIjw/og==
X-Received: by 2002:a17:902:cec8:b0:216:2bd7:1c27 with SMTP id d9443c01a7336-21dd7dd8661mr60363385ad.33.1738176451299;
        Wed, 29 Jan 2025 10:47:31 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:30 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 01/19] xfs: bump max fsgeom struct version
Date: Wed, 29 Jan 2025 10:46:59 -0800
Message-ID: <20250129184717.80816-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 9488062805943c2d63350d3ef9e4dc093799789a ]

The latest version of the fs geometry structure is v5.  Bump this
constant so that xfs_db and mkfs calls to libxfs_fs_geometry will fill
out all the fields.

IOWs, this commit is a no-op for the kernel, but will be useful for
userspace reporting in later changes.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_sb.h b/fs/xfs/libxfs/xfs_sb.h
index a5e14740ec9a..19134b23c10b 100644
--- a/fs/xfs/libxfs/xfs_sb.h
+++ b/fs/xfs/libxfs/xfs_sb.h
@@ -23,11 +23,11 @@ extern void	xfs_sb_quota_from_disk(struct xfs_sb *sbp);
 extern bool	xfs_sb_good_version(struct xfs_sb *sbp);
 extern uint64_t	xfs_sb_version_to_features(struct xfs_sb *sbp);
 
 extern int	xfs_update_secondary_sbs(struct xfs_mount *mp);
 
-#define XFS_FS_GEOM_MAX_STRUCT_VER	(4)
+#define XFS_FS_GEOM_MAX_STRUCT_VER	(5)
 extern void	xfs_fs_geometry(struct xfs_mount *mp, struct xfs_fsop_geom *geo,
 				int struct_version);
 extern int	xfs_sb_read_secondary(struct xfs_mount *mp,
 				struct xfs_trans *tp, xfs_agnumber_t agno,
 				struct xfs_buf **bpp);
-- 
2.48.1.362.g079036d154-goog


