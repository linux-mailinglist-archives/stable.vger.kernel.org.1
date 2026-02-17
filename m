Return-Path: <stable+bounces-216809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKmTG7RklGkFDgIAu9opvQ
	(envelope-from <stable+bounces-216809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:53:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430314C248
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70F8C300DF41
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFE355053;
	Tue, 17 Feb 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJiC7TFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B202355049
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332784; cv=none; b=mX23ZynJOTVLuMuS6Lqn9XcIFVrCFMr7gRcvQwj+3UZXvP44NiU4Ir9MvFMw1BgVjdauiUQUOq4IyqmWJgqbDMoq8Yu12agw5CuhCA7Z4M4VA1H87a9TByhpEIfek65P3K6YiXRdgyM1GW4UhHniEFtXNOdS5qqUNLGgxL6rcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332784; c=relaxed/simple;
	bh=M81JYG/Mu8vqN+HzNioklfXPd+S9WwW+cZ2KjHM3NLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mBB6ZqECz6alKDGPEervqD75zOuN+MJzRFMOLb83oPU9qwpmZaMWc47i+vlAIfYJFI67uGmljLCe33tskbdwHBSMsNYJznQUTQO4cY+aXgLAC14jDTOU1j5OL8Yj14Q2GW6w2YeleNEmAv6xXkzoUNgrEqv+8vscbmWjayT2G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJiC7TFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F4C4CEF7;
	Tue, 17 Feb 2026 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332784;
	bh=M81JYG/Mu8vqN+HzNioklfXPd+S9WwW+cZ2KjHM3NLg=;
	h=Subject:To:Cc:From:Date:From;
	b=zJiC7TFiPA6yvd1IkTQpHv5+0I+if9SwpIICbtEiQjLVe5gs0dTjp0B+t07NF9zHk
	 4MiwTdDcShvv50o8i7Ah7Z7IqIGtXSYYA3WIjx+6GMoxKiAz3kJ8fnYU/eSxtI3FEX
	 3i0m9cf7kZXgPnmfyVQW2v3hWq/7UHGjVXUOPpBQ=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid mapping wrong physical block for swapfile" failed to apply to 6.6-stable tree
To: chao@kernel.org,daehojeong@google.com,guoxiaolong2008@gmail.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:53:00 +0100
Message-ID: <2026021700-wrongness-undermine-54e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-216809-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 1430314C248
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5c145c03188bc9ba1c29e0bc4d527a5978fc47f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021700-wrongness-undermine-54e0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c145c03188bc9ba1c29e0bc4d527a5978fc47f9 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 13 Jan 2026 14:22:29 +0800
Subject: [PATCH] f2fs: fix to avoid mapping wrong physical block for swapfile

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

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3c2af0ef62bb..4e2f10bd2b07 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4206,6 +4206,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 
 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
+		bool last_extent = false;
 retry:
 		cond_resched();
 
@@ -4231,11 +4232,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
-				nr_pblocks % blks_per_sec ||
-				f2fs_is_sequential_zone_area(sbi, pblock)) {
-			bool last_extent = false;
-
+		if (!last_extent &&
+			((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+			nr_pblocks % blks_per_sec ||
+			f2fs_is_sequential_zone_area(sbi, pblock))) {
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
@@ -4256,8 +4256,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 				goto out;
 			}
 
-			if (!last_extent)
-				goto retry;
+			/* lookup block mapping info after block migration */
+			goto retry;
 		}
 
 		if (cur_lblock + nr_pblocks >= sis->max)


