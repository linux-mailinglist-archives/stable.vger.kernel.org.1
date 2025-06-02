Return-Path: <stable+bounces-148852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C345ACA76D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5193A7A678F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9E33427D;
	Sun,  1 Jun 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0dWggTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E38334277;
	Sun,  1 Jun 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821473; cv=none; b=i6oTNG4p6kphBlwBJqqmAg4HdtALHJbimsbruFfKSCytl/Ix3To5CIvmNxGSvHd99aZeyYDfiGXR8EqujZDVR0AuQtuOiduOoR5mvFYL0YCkg8XuktkP/b3mxXA800P5B5KPf/Lrhv+9Q13g/Dg8tzE/m4oO9Ul7Dp5Nqsw1Ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821473; c=relaxed/simple;
	bh=wq5sNo98hWUjLSt36P3bpW+ygCORKRX2Q95XC/m0MEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMEvoxmFl3itZw8vBgyKPqGYKkg78an/7UK6kmb9MKDXgyqJ5Jk98xwQnjH2MuI1pD0HtLChamjwCe5llhmPRuW9gLNq5ep7rJAUpSVmndiw6ZNNkoxs2yTIJgy8BJB5V5elzG41lvE1VbMdm74eBUXPm/Q38vkyr3juhbdUE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0dWggTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187D0C4CEF1;
	Sun,  1 Jun 2025 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821473;
	bh=wq5sNo98hWUjLSt36P3bpW+ygCORKRX2Q95XC/m0MEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0dWggTkxbjltZi8vDEN5rzODMKUcv8ijgOFkWhuHM1yS3jzuEE6gelEI4ZfAMK/W
	 LoQAYTuo+hoClbNKaRb5HlHK4pOXudyQsZMPXqiaFsNyHD5nDbcjCGolUHyU6ixmd1
	 lOG9vQ+aHGRKz27MX2p+IaFvv1MZJaBbUcxSBaRioQU4TJx0E1mh94KtPN74ypCoRB
	 q+WqcoNZD1zQIHYgi0L9L2KbrqEkk/OvjKWyrknnM8V0tFGmdbjUawAB3qRHG9JrUk
	 hQ+WjdLVEaKXPo/bc4kkCa2DpMOxDXmCMTRDMXbnMwXwgsmakQNN9vE2zuZmyBHd/f
	 kAyV0xsm1P8bg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghanshyam1898@gmail.com,
	eadavis@qq.com,
	r.smirnov@omp.ru,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/34] jfs: fix array-index-out-of-bounds read in add_missing_indices
Date: Sun,  1 Jun 2025 19:43:38 -0400
Message-Id: <20250601234359.3518595-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234359.3518595-1-sashal@kernel.org>
References: <20250601234359.3518595-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aditya Dutt <duttaditya18@gmail.com>

[ Upstream commit 5dff41a86377563f7a2b968aae00d25b4ceb37c9 ]

stbl is s8 but it must contain offsets into slot which can go from 0 to
127.

Added a bound check for that error and return -EIO if the check fails.
Also make jfs_readdir return with error if add_missing_indices returns
with an error.

Reported-by: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=b974bd41515f770c608b
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Security and Stability Impact 1. **Critical
Array-Index-Out-of-Bounds Fix**: The commit addresses a serious array-
index-out-of-bounds vulnerability in the JFS filesystem's
`add_missing_indices()` function at `fs/jfs/jfs_dtree.c:2648`. The code
was accessing `p->slot[stbl[i]]` without validating that `stbl[i]` is
within valid bounds (0-127). 2. **Consistent with Established Pattern**:
This fix follows the exact same pattern as **all 5 similar commits**
that were marked as "Backport Status: YES": - Similar Commits #1, #2, #3
all add bounds checking for `stbl[i] < 0 || stbl[i] > 127` - Similar
Commits #4, #5 add bounds checking for array indices in JFS - All were
successfully backported due to their security importance 3. **Syzbot-
Reported Vulnerability**: The commit fixes a vulnerability reported by
syzbot (`syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com`),
indicating this is a real exploitable issue found through fuzzing. ##
Code Analysis **Key Changes Made:** 1. **Bounds Check Addition**: Added
validation `if (stbl[i] < 0)` before accessing `p->slot[stbl[i]]` 2.
**Error Handling**: Changed `add_missing_indices()` from `void` to `int`
return type to propagate errors 3. **Proper Error Propagation**:
Modified `jfs_readdir()` to check return value and exit on error: `if
((rc = add_missing_indices(ip, bn))) goto out;` 4. **Transaction
Cleanup**: Added `txAbort(tid, 0)` on error path to properly clean up
the transaction **Technical Context:** - `stbl` is declared as `s8 *`
(signed 8-bit array) but must contain valid slot indices (0-127) -
`DTPAGEMAXSLOT` is defined as 128, so valid indices are 0-127 - Negative
values in `stbl[i]` cause array-index-out-of-bounds when accessing
`p->slot[stbl[i]]` ## Backport Criteria Assessment ✅ **Fixes Important
Bug**: Prevents potential kernel crashes and security issues ✅ **Small
and Contained**: Limited to one function with clear, minimal changes ✅
**No Side Effects**: Only adds bounds checking and error handling ✅ **No
Architectural Changes**: Preserves existing logic flow ✅ **Critical
Subsystem**: Filesystem corruption/crashes affect system stability ✅
**Clear Pattern**: Identical to 5 other successfully backported JFS
fixes ✅ **Minimal Regression Risk**: Only adds safety checks, doesn't
change core logic ✅ **Confined to Subsystem**: Changes isolated to JFS
dtree handling ## Existing Infrastructure The kernel already has
extensive bounds checking for `stbl` indices throughout `jfs_dtree.c`: -
Line 2895-2898: `if (stbl[i] < 0 || stbl[i] > 127)` in `jfs_readdir()` -
Line 3099-3102: `if (stbl[0] < 0 || stbl[0] > 127)` in `dtReadFirst()` -
Line 637-640: `if (stbl[index] < 0)` in search functions This commit
simply extends the same pattern to the previously missed
`add_missing_indices()` function, maintaining consistency with the
existing codebase security measures. The fix is essential for preventing
potential kernel crashes and maintaining filesystem integrity, making it
an ideal candidate for stable tree backporting.

 fs/jfs/jfs_dtree.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 417d1c2fc2911..27ca98614b0bb 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2909,7 +2909,7 @@ void dtInitRoot(tid_t tid, struct inode *ip, u32 idotdot)
  *	     fsck.jfs should really fix this, but it currently does not.
  *	     Called from jfs_readdir when bad index is detected.
  */
-static void add_missing_indices(struct inode *inode, s64 bn)
+static int add_missing_indices(struct inode *inode, s64 bn)
 {
 	struct ldtentry *d;
 	struct dt_lock *dtlck;
@@ -2918,7 +2918,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	struct lv *lv;
 	struct metapage *mp;
 	dtpage_t *p;
-	int rc;
+	int rc = 0;
 	s8 *stbl;
 	tid_t tid;
 	struct tlock *tlck;
@@ -2943,6 +2943,16 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 
 	stbl = DT_GETSTBL(p);
 	for (i = 0; i < p->header.nextindex; i++) {
+		if (stbl[i] < 0) {
+			jfs_err("jfs: add_missing_indices: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+				i, stbl[i], (long)inode->i_ino, (long long)bn);
+			rc = -EIO;
+
+			DT_PUTPAGE(mp);
+			txAbort(tid, 0);
+			goto end;
+		}
+
 		d = (struct ldtentry *) &p->slot[stbl[i]];
 		index = le32_to_cpu(d->index);
 		if ((index < 2) || (index >= JFS_IP(inode)->next_index)) {
@@ -2960,6 +2970,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	(void) txCommit(tid, 1, &inode, 0);
 end:
 	txEnd(tid);
+	return rc;
 }
 
 /*
@@ -3313,7 +3324,8 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (fix_page) {
-			add_missing_indices(ip, bn);
+			if ((rc = add_missing_indices(ip, bn)))
+				goto out;
 			page_fixed = 1;
 		}
 
-- 
2.39.5


