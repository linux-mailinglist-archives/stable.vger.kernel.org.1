Return-Path: <stable+bounces-152474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73AAD609B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602533A724F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964082BDC34;
	Wed, 11 Jun 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMnJYXkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C1288C1D
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675716; cv=none; b=aldi/Z7xS/eS7Xe7dx2BEldPXbvvlRrvve8uDegkowBBcFrjxVh6uwgBC9k/1yaNTslZSr+w5KnekvW/6EvyDBZJaY5v77Ph5xsUV8t8QI21zxjoyzVkd6/25T7OvHXVeeVuT2QgDvQkXcBEyvX8CTiAhuAZrXLeG9z2BW0gFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675716; c=relaxed/simple;
	bh=6RnJTPemhlz3nqtZS4tupAhRyGUEDlIEJSFc/103Ccc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2GaEn4QA6b+XErQNwnCMAIn2oRrf/FxsTuXxb7Yy0cqX0cHdxZPNFNlcJK2vWu0Cv3cVpHsPgkmBAp1Dic8ZyKtVsVw701lQsk9zojtFrEbqbEDkBoVRkgQLLGTrSdy6tLzF6MJdOU8KXP9cYUQWA9ZIUPzUAm42rFNrLU4keA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMnJYXkb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23602481460so3350565ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675714; x=1750280514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY60q7wpQkOwmio5q1kA3/eNfklZ3vobAwkSvxOsh/Q=;
        b=PMnJYXkbS6Fsw31a4ovhmBBUivQCneb6fg0LJnoNV/TNLTD6g8XTnetv65MWkH/Orz
         OiQWsrwxlNrvAGdMPKGvO6gsdX7ZCIs9txvkZNJz7ZPpIdgcwTOknSEwMwaGd5lfNPH6
         ZwLXn0sdMqBern/uZ5I1sWuaoYmdcI3loWjz9yGdf7rrcfvbZO3OyZLaThbLy+h6tQO3
         2JC425GGWXFmz0dPp5kQNVrnO28kS4dRVgE11R51mW4vOjpvX3Y3fecWicKVEbUDZZLk
         0IMMCNdU8/snA8Pmp/HB0n4YdWpG/L+SU0qHNIXb2GttF9ydYDCVYzkajUeUSvqzO0pF
         V+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675714; x=1750280514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY60q7wpQkOwmio5q1kA3/eNfklZ3vobAwkSvxOsh/Q=;
        b=mIf+B9qjvNV0Qr2d93ZN+0VWkt+JuNYEShuNBlxTAzh0NTQaF/YzCcMNt7WTrgoVsJ
         twtO3NIlO9bHNWAc1Frq+ejzHF2WizzBuH90E5VyPBbEpIcvoWCPU1j2+7p3T6kVxftU
         Wc3d3eeF74flyb0uPK4f0zOVwA9Im9aZv/kYi6hfG84vu254VGx+oJUgPOzFahlwAg2R
         O7qBHrZ9ntTulb1jmyXTXvM8JOkRTR86myMLt6dRQjTD0WU3ejwZgJn5Ky9HHdEJk2kL
         f0L1AmURMIHX8jbY2EemzO8CofoNkw9vwDQobtzqNI0Tl15pJBFCHOH24DGhV8d88f9I
         chFQ==
X-Gm-Message-State: AOJu0YyBQE/8Y+FECdCKl/QlYO+VD1AGHi2Y5xWcAMiXLhZMTWJ3+GMr
	1qux221iZkgxz022YDRjLQP6d/7O99k6SmT4r2PMv7CeDUE8slRqcAqwIZrn2+cs
X-Gm-Gg: ASbGnctcVKGUGLLzs54O7gT8DhfHrBWjJQMxDeCKWL2VegvTdypjongA3K8xCGVhwwc
	GtFJR+bcuweJAEZGtORYASnAJ8r5RK5iOnTS4bd/vOAlyoHvssHVE6NOZ3uh3btanPrCb3yK1oV
	1cN3sRgDIjalI5SseD+x1+PehSbfcuuyzSb3WW9D3cFau1q8i5035DBCsy2xz6rkNYYOnmuI6ZR
	Q7hBz6NHIUY0dYut5k5BwobG431S32UsQH4gem6Dlm1jdVEqmCiIwlbgwZn/S5ctjcKv691f++o
	xnkPHRQIGHS7g9FU6Fbqhu7AauLSDdlHx8JYjzbOrCzAyKcpV14CnNZLTk9KIrqJBt/UuDikSz2
	2CCnPsahTFGk=
X-Google-Smtp-Source: AGHT+IFSiblOePGucUdWDqTwZHcArQBoRVvNCKw5GAOh+IZd/2OnfukjpWcg+QXWj9BoFVLO4Va8Vw==
X-Received: by 2002:a17:902:ea10:b0:234:c8f6:1b03 with SMTP id d9443c01a7336-23641b3f8dcmr68815245ad.47.1749675714049;
        Wed, 11 Jun 2025 14:01:54 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:53 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Zizhi Wo <wozizhi@huawei.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 20/23] xfs: Fix the owner setting issue for rmap query in xfs fsmap
Date: Wed, 11 Jun 2025 14:01:24 -0700
Message-ID: <20250611210128.67687-21-leah.rumancik@gmail.com>
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

From: Zizhi Wo <wozizhi@huawei.com>

[ Upstream commit 68415b349f3f16904f006275757f4fcb34b8ee43 ]

I notice a rmap query bug in xfs_io fsmap:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv' /mnt
 EXT: DEV    BLOCK-RANGE           OWNER              FILE-OFFSET      AG AG-OFFSET             TOTAL
   0: 253:16 [0..7]:               static fs metadata                  0  (0..7)                    8
   1: 253:16 [8..23]:              per-AG metadata                     0  (8..23)                  16
   2: 253:16 [24..39]:             inode btree                         0  (24..39)                 16
   3: 253:16 [40..47]:             per-AG metadata                     0  (40..47)                  8
   4: 253:16 [48..55]:             refcount btree                      0  (48..55)                  8
   5: 253:16 [56..103]:            per-AG metadata                     0  (56..103)                48
   6: 253:16 [104..127]:           free space                          0  (104..127)               24
   ......

Bug:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv -d 0 3' /mnt
[root@fedora ~]#
Normally, we should be able to get one record, but we got nothing.

The root cause of this problem lies in the incorrect setting of rm_owner in
the rmap query. In the case of the initial query where the owner is not
set, __xfs_getfsmap_datadev() first sets info->high.rm_owner to ULLONG_MAX.
This is done to prevent any omissions when comparing rmap items. However,
if the current ag is detected to be the last one, the function sets info's
high_irec based on the provided key. If high->rm_owner is not specified, it
should continue to be set to ULLONG_MAX; otherwise, there will be issues
with interval omissions. For example, consider "start" and "end" within the
same block. If high->rm_owner == 0, it will be smaller than the founded
record in rmapbt, resulting in a query with no records. The main call stack
is as follows:

xfs_ioc_getfsmap
  xfs_getfsmap
    xfs_getfsmap_datadev_rmapbt
      __xfs_getfsmap_datadev
        info->high.rm_owner = ULLONG_MAX
        if (pag->pag_agno == end_ag)
	  xfs_fsmap_owner_to_rmap
	    // set info->high.rm_owner = 0 because fmr_owner == -1ULL
	    dest->rm_owner = 0
	// get nothing
	xfs_getfsmap_datadev_rmapbt_query

The problem can be resolved by simply modify the xfs_fsmap_owner_to_rmap
function internal logic to achieve.

After applying this patch, the above problem have been solved:
[root@fedora ~]# xfs_io -c 'fsmap -vvvv -d 0 3' /mnt
 EXT: DEV    BLOCK-RANGE      OWNER              FILE-OFFSET      AG AG-OFFSET        TOTAL
   0: 253:16 [0..7]:          static fs metadata                  0  (0..7)               8

Fixes: e89c041338ed ("xfs: implement the GETFSMAP ioctl")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_fsmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 956a5670e56c..1efd18437ca4 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -69,11 +69,11 @@ xfs_fsmap_owner_to_rmap(
 	}
 
 	switch (src->fmr_owner) {
 	case 0:			/* "lowest owner id possible" */
 	case -1ULL:		/* "highest owner id possible" */
-		dest->rm_owner = 0;
+		dest->rm_owner = src->fmr_owner;
 		break;
 	case XFS_FMR_OWN_FREE:
 		dest->rm_owner = XFS_RMAP_OWN_NULL;
 		break;
 	case XFS_FMR_OWN_UNKNOWN:
-- 
2.50.0.rc1.591.g9c95f17f64-goog


