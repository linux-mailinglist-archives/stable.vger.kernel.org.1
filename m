Return-Path: <stable+bounces-152460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496EAD608D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3353AAAFF
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F062BD5B0;
	Wed, 11 Jun 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxyGgj7C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776622BDC2C
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675702; cv=none; b=nLdlYQD9070Wr2o6l67Zv7VOyn1K1tXqG7Fk6YGIUtK/6bFY07OiixkTL8LRyBebHDUIxEwmJMhctPupA0rz+xVGuLeVVZDkp7XmSjS857cxjo6PnuARvjsyTL03xogxb+34k9ZJuf08oDgNTHeC9eocgEYFi/ViQTRB6g7v4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675702; c=relaxed/simple;
	bh=adgWZRszik8iB0P3tjWcTMeG13rS5Z3kyLJi5NZaIDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM0VMUEMrG9cvjTw6/qo8TdXtdtz3y0S07R9kRrz54DgAbj39+H30gX3gB5jM9iPfoqYtIQ2bIBNV1SwwrKGg7yStBckQMilEfWVrZdP5Bas8RKEGYYzwS34QvPTa9J4Xs7A/DdYuz5M/Ex/qX8JU2YCb5j3SSlawd3/OhgAqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxyGgj7C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so3634455ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675699; x=1750280499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRw3S/Zgssjc97Ua04jEevgFpNMhNf2M/EAnbZb0l+k=;
        b=bxyGgj7C4xdxfA4LD8CI22dXluaGMrS72yeQm1m8GVJLpGjRdf3tfTJ0tc5nOR5F7e
         VbBBMhA165rL7c+GZP+1/rT/5ODp6J+pfKhAyw2A4pKNmoAMn8N9XhxsFciVRP5sd0Q6
         ZHHJ4hNyYR4nZ2JGBl3mUS3/8VO1KE80oxIhK6o9eHefca09e7h0QzhA2qC5GgNdd1Q7
         TaoS79FS4HN0yG/kt9C3j/F50l8XmcPTJLhficc5QJ5CROTOAO+h9kc4XJ6gA2ezSuLI
         +Mj0CUjgBuvwT2pRtE1T/1zV1u4DXkYQq7v5zUjivQq/Q9gv6CT7uOBLhHsGa3IjJkMJ
         KnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675699; x=1750280499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRw3S/Zgssjc97Ua04jEevgFpNMhNf2M/EAnbZb0l+k=;
        b=PI/PEs3ox3mnNxhctexh5dDDiAZrVzfSQzRnZptZ1cr14J/dzuC2zF0ekqjf5T1acC
         YSHBqOvASLWvZrEoxhBhm3tGVwWGgHdlkhdU+fr1lIYjDgFDXOLui8A0RRX5hzaPwwHM
         jV/2HRnQrOaA62R7cnM/noSY39SYwuvdUWLNjP1Oh/ICTD7+jQMzdSboypuCNLW4feiP
         CjLhp0bMPWhD6+qzqdYDcmCNDZDVvfZ4Yz3Lpr1SdVPwwiw0Ma7+mSMc0BBiID/HKfe5
         LW1oGyD6VsppY/Jv4DtrMhS6hvTtfYL2G6rXy6g5f4LFXsSJzKRwjPxvmn6Ka5Y1C2vj
         WmZA==
X-Gm-Message-State: AOJu0YzsN8py7jcLnbjVKk//VmHpCghhs216gpr7PtgfxRn7V4ci9ZhF
	9MmeXRki3tTLdhExVv7jsShMDU4H/6heSkXsmcGhxpwboZS7uKBCB8JOtPwlAFSN
X-Gm-Gg: ASbGncsNDnGRclv1T5ZHvIdFz5KNpc09CfVgNBe96fd3zDpXnAZXKvqPEyxiva4MDFf
	caHjNRRcyDg34SoaPdOU8v1eWMARocv99TV7tq3ez9/x3FE5cU/ZSynVkbObh0KUWvnsLsMHOxG
	+8zYLn19iUYLkppfOPEKjyI7HORP7q0dpUdOXxdAL5Fhh+YOIsMQu1MtxwaNBUZBdCz1v46yiRg
	A85ouruCGoUN80zvVqnnP9L1ArofUn+eO8K6q0QFRpIfJWOzQ8ZZkunWG5BK+U+0QvQZPS7W/CN
	DPA+bII1FML0VnfJs1QQjDarQaQSl9BU09Wr/MBn8aSY3/2V4mu4SZnAvp6o58Hd2x6XQfcC7S3
	mi90z/XgFvXM=
X-Google-Smtp-Source: AGHT+IELhMxL+ujD8gW+pINRJGhoNrUmuRh4sHphV1r5nzCqblWECK7CsBHn6G55e/mZh/MCaIGoXw==
X-Received: by 2002:a17:902:d58f:b0:235:a9b:21e0 with SMTP id d9443c01a7336-2364c67d44bmr16291885ad.0.1749675699223;
        Wed, 11 Jun 2025 14:01:39 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:38 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 06/23] xfs: validate fsmap offsets specified in the query keys
Date: Wed, 11 Jun 2025 14:01:10 -0700
Message-ID: <20250611210128.67687-7-leah.rumancik@gmail.com>
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

[ Upstream commit 3ee9351e74907fe3acb0721c315af25b05dc87da ]

Improve the validation of the fsmap offset fields in the query keys and
move the validation to the top of the function now that we have pushed
the low key adjustment code downwards.

Also fix some indenting issues that aren't worth a separate patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index cdd806d80b7c..d10f2c719220 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -800,10 +800,23 @@ xfs_getfsmap_is_valid_device(
 STATIC bool
 xfs_getfsmap_check_keys(
 	struct xfs_fsmap		*low_key,
 	struct xfs_fsmap		*high_key)
 {
+	if (low_key->fmr_flags & (FMR_OF_SPECIAL_OWNER | FMR_OF_EXTENT_MAP)) {
+		if (low_key->fmr_offset)
+			return false;
+	}
+	if (high_key->fmr_flags != -1U &&
+	    (high_key->fmr_flags & (FMR_OF_SPECIAL_OWNER |
+				    FMR_OF_EXTENT_MAP))) {
+		if (high_key->fmr_offset && high_key->fmr_offset != -1ULL)
+			return false;
+	}
+	if (high_key->fmr_length && high_key->fmr_length != -1ULL)
+		return false;
+
 	if (low_key->fmr_device > high_key->fmr_device)
 		return false;
 	if (low_key->fmr_device < high_key->fmr_device)
 		return true;
 
@@ -843,39 +856,41 @@ xfs_getfsmap_check_keys(
  *
  * Key to Confusion
  * ----------------
  * There are multiple levels of keys and counters at work here:
  * xfs_fsmap_head.fmh_keys	-- low and high fsmap keys passed in;
- * 				   these reflect fs-wide sector addrs.
+ *				   these reflect fs-wide sector addrs.
  * dkeys			-- fmh_keys used to query each device;
- * 				   these are fmh_keys but w/ the low key
- * 				   bumped up by fmr_length.
+ *				   these are fmh_keys but w/ the low key
+ *				   bumped up by fmr_length.
  * xfs_getfsmap_info.next_daddr	-- next disk addr we expect to see; this
  *				   is how we detect gaps in the fsmap
 				   records and report them.
  * xfs_getfsmap_info.low/high	-- per-AG low/high keys computed from
- * 				   dkeys; used to query the metadata.
+ *				   dkeys; used to query the metadata.
  */
 int
 xfs_getfsmap(
 	struct xfs_mount		*mp,
 	struct xfs_fsmap_head		*head,
 	struct fsmap			*fsmap_recs)
 {
 	struct xfs_trans		*tp = NULL;
 	struct xfs_fsmap		dkeys[2];	/* per-dev keys */
 	struct xfs_getfsmap_dev		handlers[XFS_GETFSMAP_DEVS];
 	struct xfs_getfsmap_info	info = { NULL };
 	bool				use_rmap;
 	int				i;
 	int				error = 0;
 
 	if (head->fmh_iflags & ~FMH_IF_VALID)
 		return -EINVAL;
 	if (!xfs_getfsmap_is_valid_device(mp, &head->fmh_keys[0]) ||
 	    !xfs_getfsmap_is_valid_device(mp, &head->fmh_keys[1]))
 		return -EINVAL;
+	if (!xfs_getfsmap_check_keys(&head->fmh_keys[0], &head->fmh_keys[1]))
+		return -EINVAL;
 
 	use_rmap = xfs_has_rmapbt(mp) &&
 		   has_capability_noaudit(current, CAP_SYS_ADMIN);
 	head->fmh_entries = 0;
 
@@ -917,19 +932,12 @@ xfs_getfsmap(
 	 * all other low key mapping types (attr blocks, metadata), each
 	 * fsmap backend bumps the physical offset as there can be no
 	 * other mapping for the same physical block range.
 	 */
 	dkeys[0] = head->fmh_keys[0];
-	if (dkeys[0].fmr_flags & (FMR_OF_SPECIAL_OWNER | FMR_OF_EXTENT_MAP)) {
-		if (dkeys[0].fmr_offset)
-			return -EINVAL;
-	}
 	memset(&dkeys[1], 0xFF, sizeof(struct xfs_fsmap));
 
-	if (!xfs_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
-		return -EINVAL;
-
 	info.next_daddr = head->fmh_keys[0].fmr_physical +
 			  head->fmh_keys[0].fmr_length;
 	info.fsmap_recs = fsmap_recs;
 	info.head = head;
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


