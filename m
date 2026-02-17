Return-Path: <stable+bounces-216851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE/sJk+HlGmWFQIAu9opvQ
	(envelope-from <stable+bounces-216851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58C14D88E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE18B3036D4D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB7283FFB;
	Tue, 17 Feb 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9gVJf9O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4A280A29
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341636; cv=none; b=CNi2pJ3UBVwPBXA3Qaixni4mhr7G5qF1clAleJSkxhdqvGJAlyui7F8ZSlitNSrq6dYmPY2e/6v448zf8mXrlhGBPK5SazYKWHdDgNDuTdC7gRgrRPfbCr27Kcnjz9Hnt/NwvtoRJDWb1JsYN8lBks+tA5DL4nPYknOrvkWDd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341636; c=relaxed/simple;
	bh=DEg0TSX8yLRTvMvKucgXP1k7dBhbB9relrG0k/qhxZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5ruVtW0CC6WRniDjMTMgLCQuYJwhwYrWbEvnv47sr7eUY3P6zUKPz3MBl0KO8+y9N61tN4bVVE5ybNwCOza7oBT1XpR2glggNmvGSWjsW0zhq/lW7svfz8GkOUOe8tPO/t/bFjJ++wOqOi57PdXjD8LIz0MeU6Of+JYTZSz2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9gVJf9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6DC19424;
	Tue, 17 Feb 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341636;
	bh=DEg0TSX8yLRTvMvKucgXP1k7dBhbB9relrG0k/qhxZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9gVJf9OHC/Gu9RptAyYOKrgwdkMtpewMwyeABQD6a8+s3Sbhtk2g6WBAmmzbCT5M
	 TCctYCYN+9VKNS95eL9OrCazzn2GlsD8Orp+6tbogApoZddT7a+Lnqq1laODSnfVN3
	 ejzDQ6KJYpLJNntJZ7TUGbicV3NniWBDYtEA8kM3olVynsBxXXvPr5EtFjgFeey8/1
	 W8WvMuP9c8O2pLZNihdnHy3Ef4wR1vrahsXHlP++6zatmCbFMab4dIPmNT+d1RDS9Q
	 3eW7TuYohMj02tJcT+/QdDjkQV4Rxns5FWS9ABBYpsBIEdhWx8xVUU6zgMbY20aEMA
	 tDlqkd7AgU4lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Xiaolong Guo <guoxiaolong2008@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix to avoid mapping wrong physical block for swapfile
Date: Tue, 17 Feb 2026 10:20:32 -0500
Message-ID: <20260217152032.3680679-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217152032.3680679-1-sashal@kernel.org>
References: <2026021700-wrongness-undermine-54e0@gregkh>
 <20260217152032.3680679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216851-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D58C14D88E
X-Rspamd-Action: no action

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5c145c03188bc9ba1c29e0bc4d527a5978fc47f9 ]

Xiaolong Guo reported a f2fs bug in bugzilla [1]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220951

Quoted:

"When using stress-ng's swap stress test on F2FS filesystem with kernel 6.6+,
the system experiences data corruption leading to either:
1 dm-verity corruption errors and device reboot
2 F2FS node corruption errors and boot hangs

The issue occurs specifically when:
1 Using F2FS filesystem (ext4 is unaffected)
2 Swapfile size is less than F2FS section size (2MB)
3 Swapfile has fragmented physical layout (multiple non-contiguous extents)
4 Kernel version is 6.6+ (6.1 is unaffected)

The root cause is in check_swap_activate() function in fs/f2fs/data.c. When the
first extent of a small swapfile (< 2MB) is not aligned to section boundaries,
the function incorrectly treats it as the last extent, failing to map
subsequent extents. This results in incorrect swap_extent creation where only
the first extent is mapped, causing subsequent swap writes to overwrite wrong
physical locations (other files' data).

Steps to Reproduce
1 Setup a device with F2FS-formatted userdata partition
2 Compile stress-ng from https://github.com/ColinIanKing/stress-ng
3 Run swap stress test: (Android devices)
adb shell "cd /data/stressng; ./stress-ng-64 --metrics-brief --timeout 60
--swap 0"

Log:
1 Ftrace shows in kernel 6.6, only first extent is mapped during second
f2fs_map_blocks call in check_swap_activate():
stress-ng-swap-8990: f2fs_map_blocks: ino=11002, file offset=0, start
blkaddr=0x43143, len=0x1
(Only 4KB mapped, not the full swapfile)
2 in kernel 6.1, both extents are correctly mapped:
stress-ng-swap-5966: f2fs_map_blocks: ino=28011, file offset=0, start
blkaddr=0x13cd4, len=0x1
stress-ng-swap-5966: f2fs_map_blocks: ino=28011, file offset=1, start
blkaddr=0x60c84b, len=0xff

The problematic code is in check_swap_activate():
if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
    nr_pblocks % blks_per_sec ||
    !f2fs_valid_pinned_area(sbi, pblock)) {
    bool last_extent = false;

    not_aligned++;

    nr_pblocks = roundup(nr_pblocks, blks_per_sec);
    if (cur_lblock + nr_pblocks > sis->max)
        nr_pblocks -= blks_per_sec;

    /* this extent is last one */
    if (!nr_pblocks) {
        nr_pblocks = last_lblock - cur_lblock;
        last_extent = true;
    }

    ret = f2fs_migrate_blocks(inode, cur_lblock, nr_pblocks);
    if (ret) {
        if (ret == -ENOENT)
            ret = -EINVAL;
        goto out;
    }

    if (!last_extent)
        goto retry;
}

When the first extent is unaligned and roundup(nr_pblocks, blks_per_sec)
exceeds sis->max, we subtract blks_per_sec resulting in nr_pblocks = 0. The
code then incorrectly assumes this is the last extent, sets nr_pblocks =
last_lblock - cur_lblock (entire swapfile), and performs migration. After
migration, it doesn't retry mapping, so subsequent extents are never processed.
"

In order to fix this issue, we need to lookup block mapping info after
we migrate all blocks in the tail of swapfile.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Reported-and-tested-by: Xiaolong Guo <guoxiaolong2008@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220951
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ f2fs_is_sequential_zone_area() => !f2fs_valid_pinned_area() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c863e27fd846b..244f2b5a36222 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3934,6 +3934,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 
 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
+		bool last_extent = false;
 retry:
 		cond_resched();
 
@@ -3959,11 +3960,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
-				nr_pblocks % blks_per_sec ||
-				!f2fs_valid_pinned_area(sbi, pblock)) {
-			bool last_extent = false;
-
+		if (!last_extent &&
+			((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+			nr_pblocks % blks_per_sec ||
+			!f2fs_valid_pinned_area(sbi, pblock))) {
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
@@ -3984,8 +3984,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 				goto out;
 			}
 
-			if (!last_extent)
-				goto retry;
+			/* lookup block mapping info after block migration */
+			goto retry;
 		}
 
 		if (cur_lblock + nr_pblocks >= sis->max)
-- 
2.51.0


