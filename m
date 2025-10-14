Return-Path: <stable+bounces-185601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A8BD83A7
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A85E434EC3A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F130FC28;
	Tue, 14 Oct 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJkksp4C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pKlrCZu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AED265CB2;
	Tue, 14 Oct 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431313; cv=none; b=By+6YcUHSwVkA69IGJlPzjcVZ5U97atVrFdGEPRAF8hpsXDv/aWFF7i1orDDkDvh1HXefgCY3RlN4Xyk6mXnXXrMlKRZQFJ97WzU6jM9qmn/S+Sr2bslSrQBZT1JqUeAEPIffKw3cMc857NEoztVTOYzkyjc65plApogJgNRV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431313; c=relaxed/simple;
	bh=ItRUKErWC0QhcWd0s6SC26fn3FTvNzSVCBpjY5Hdxww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uPnNm7WDVUZ0txzSE5CPwchmOcJ5qDozq15jt+CuJwR7TEegjlUu5RoVG9eC3I6c6Cc/6HYorP6Znbg79OnXbhY1dk/5pyATumosXo8BCEMPRPVLdx4QWu+yl+Pu+CY85e0bfyswbwUA4l14ijlt30DXit5Oa1ngVwnXgVhbc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJkksp4C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pKlrCZu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyXEC29O3ckp/+owfD4P7Jw16sRGibwoK39+dlwavbI=;
	b=GJkksp4CD7Ht0llinrQJWTtBZk29sXyqbiPWLfEJL0wUG028nnAJZqE1q9kPUxTbvLsqvP
	S+r67eiqeOYYslWFFaNkLs46J1Q5F3cBlABl6kw0z0SlA37yImZZwX6XKcYuV4Q2Imk7d3
	Orm3tAPC6QMAbd7Ntr9jzlZryTnN77ITZwS3fhaZ3y+3wg7B8sU9Ijx3gf9+qhjyiYUyLp
	1sk+1+7bqDoZNn/4Pzbyu7PIJBosOXnX6YfzEA7srlQ4fzRNW2aGkbBJLylIeCaJkTMnHs
	S3CwSqqlkvolAq2lYjExQN5DxMQggylRvb9zfNzB5rKJGTJIBKAqlBCa8AgFTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyXEC29O3ckp/+owfD4P7Jw16sRGibwoK39+dlwavbI=;
	b=1pKlrCZu94I6TLiPd2KnVlcFUUIerd1KEv6ShYxuaYJQC3bKfZpN8WudYzqfGLiShpofbp
	sl0mpaCyg5uOn3CA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix MMAP2 event device with backing files
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.8@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013072244.82591-4-adrian.hunter@intel.com>
References: <20251013072244.82591-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043130631.709179.12566321865328896091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     fa4f4bae893fbce8a3edfff1ab7ece0c01dc1328
Gitweb:        https://git.kernel.org/tip/fa4f4bae893fbce8a3edfff1ab7ece0c01d=
c1328
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 13 Oct 2025 10:22:44 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:10 +02:00

perf/core: Fix MMAP2 event device with backing files

Some file systems like FUSE-based ones or overlayfs may record the backing
file in struct vm_area_struct vm_file, instead of the user file that the
user mmapped.

That causes perf to misreport the device major/minor numbers of the file
system of the file, and the generation of the file, and potentially other
inode details.  There is an existing helper file_user_inode() for that
situation.

Use file_user_inode() instead of file_inode() to get the inode for MMAP2
events.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=3D=
work merged
    # perf record -e cycles:u -- /root/test/merged/cat /proc/self/maps
    ...
    55b2c91d0000-55b2c926b000 r-xp 00018000 00:1a 3419                       =
/root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.004 MB perf.data (5 samples) ]
    #
    # stat /root/test/merged/cat
      File: /root/test/merged/cat
      Size: 1127792         Blocks: 2208       IO Block: 4096   regular file
    Device: 0,26    Inode: 3419        Links: 1
    Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
    Access: 2025-09-08 12:23:59.453309624 +0000
    Modify: 2025-09-08 12:23:59.454309624 +0000
    Change: 2025-09-08 12:23:59.454309624 +0000
     Birth: 2025-09-08 12:23:59.453309624 +0000

  Before:

    Device reported 00:02 differs from stat output and /proc/self/maps

    # perf script --show-mmap-events | grep /root/test/merged/cat
             cat     377 [-01]   243.078558: PERF_RECORD_MMAP2 377/377: [0x55=
b2c91d0000(0x9b000) @ 0x18000 00:02 3419 2068525940]: r-xp /root/test/merged/=
cat

  After:

    Device reported 00:1a is the same as stat output and /proc/self/maps

    # perf script --show-mmap-events | grep /root/test/merged/cat
             cat     362 [-01]   127.755167: PERF_RECORD_MMAP2 362/362: [0x55=
ba6e781000(0x9b000) @ 0x18000 00:1a 3419 0]: r-xp /root/test/merged/cat

With respect to stable kernels, overlayfs mmap function ovl_mmap() was
added in v4.19 but file_user_inode() was not added until v6.8 and never
back-ported to stable kernels.  FMODE_BACKING that it depends on was added
in v6.5.  This issue has gone largely unnoticed, so back-porting before
v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisite
version, although in practice the next long term kernel is 6.12.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org # 6.8
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7b5c237..177e57c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9403,7 +9403,7 @@ static void perf_event_mmap_event(struct perf_mmap_even=
t *mmap_event)
 		flags |=3D MAP_HUGETLB;
=20
 	if (file) {
-		struct inode *inode;
+		const struct inode *inode;
 		dev_t dev;
=20
 		buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
@@ -9421,7 +9421,7 @@ static void perf_event_mmap_event(struct perf_mmap_even=
t *mmap_event)
 			name =3D "//toolong";
 			goto cpy_name;
 		}
-		inode =3D file_inode(vma->vm_file);
+		inode =3D file_user_inode(vma->vm_file);
 		dev =3D inode->i_sb->s_dev;
 		ino =3D inode->i_ino;
 		gen =3D inode->i_generation;

