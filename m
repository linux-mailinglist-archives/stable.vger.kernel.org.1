Return-Path: <stable+bounces-114366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD2A2D419
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18405188DB2A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFAC145FE8;
	Sat,  8 Feb 2025 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Go3ZJP85"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25517BA6
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992631; cv=none; b=WiM4e4Q/l0sMzk0lDyk7oT1kRNqLcLTMD36+scHXVV//erTrW/Lmhmxr7A0EPmZiE3oAoSBOxjKvP3h4+iT2r8KQ8BqIyxtXNUE1ELhin7tNuErJajyDj/62CdyHAC0i3isuKPbd3LIkaO8Q1TJntfqSujt5dHEPifXfBOAoGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992631; c=relaxed/simple;
	bh=jdhRj2OXxCgt72Ooxak4eX+F1hJ708P7r42kl5H8la8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoH2Rpdi5U/v5x4THPeubaMzS9j3faHZacYat4HNWKtH4yao+mXy0qYCWJnm+KAoKpLKFTDPJhUYFojf21CZHM7jPOUTc3s8qYj+NWbC12r7UPdpamVORe+bRMJB9TrdCiDZi4cjqb+cS07wAsv9knJixQPyzT9WaQ/oP/cv0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Go3ZJP85; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-148.bstnma.fios.verizon.net [173.48.111.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5185UBl6014483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738992614; bh=Hpl/F0jFE1zUvay4XS9oyJREGUyTQF/l3z+1Ic2cPgY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Go3ZJP85jb7o58wFt00KI6ppHx7xobHqb4UHzfDBtzfjABAi7vzkdBbzAna9Bp8uC
	 ENONPU0+vQtIN44VOqM14koe13DTebHV0Y9GsqwPkukHj3YDYdTc1uyMWzEBIhwegT
	 opljfyZ7b7npixBXTK1fH7bz/r+RYeXSwGefWzT39MlHtB1gyquC/EG+XiHyZpTGbG
	 /HWQ5IB0s1DxWINNY0NdLYCSgtv5zZLRbDpk32ugOyXNWyW0tXwTabUO7c/qX+nyEn
	 0KEi55lZ1e1lMe6oXjKjBALWNNsLaln3gWd+XWeJY/0AWUHLoA9EmKdKodNioNGQVr
	 93dEjpMm9ycfQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 886AC15C013F; Sat, 08 Feb 2025 00:30:11 -0500 (EST)
Date: Sat, 8 Feb 2025 00:30:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Daniel Rosenberg <drosen@google.com>
Cc: Todd Kjos <tkjos@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: f2fs: Introduce linear search for dentries
Message-ID: <20250208053011.GK1130956@mit.edu>
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh>
 <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
 <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>

On Mon, Feb 03, 2025 at 03:07:10PM -0800, Daniel Rosenberg wrote:
> 
> The revert of the unicode patch is in all of the stable branches
> already. That f2fs patch is technically a fix for the revert as well,
> since the existence of either of those is a problem for the same
> reason :/
> 
> On Sat, Feb 1, 2025 at 9:06 AM Todd Kjos <tkjos@google.com> wrote:
> >
> > Before we can bring back the reverted patch, we need the same fix for
> > ext4. Daniel, is there progress on that?

So I have a working fix for ext4, now but it's going to be a lot more
complicated if we want to bring back the reverted patch.  That's
because both e2fsprogs and f2fs-tools needs to be able to calculate
the hash used by the directories, and so fsck.ext4 and fsck.f2fs will
get confused if they run across file systems with file names which
were inserted while the reverted patch was in force.

I confirmed this was applicable for both ext4 and f2fs by modifying my
unicode-hijinks script to generate an f2fs image, and then running
fsck.f2fs on the image:

% /sbin/fsck.f2fs  /tmp/foo.img 
Info: MKFS version
  "Linux version 6.14.0-rc1-xfstests-00013-g30a8509ae0bb-dirty (tytso@cwcc) (gcc (Debian 14.2.0-8) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.50.20241210) #456 SMP PREEMPT_DYNAMIC Fri Feb  7 01:18:48 EST 2025"
Info: FSCK version
...
[FIX] (f2fs_check_hash_code:1471)  --> Mismatch hash_code for "❤️" [9a2ea068:19dd7132]
[FIX] (f2fs_check_hash_code:1471)  --> Mismatch hash_code for "❤️" [9a2ea068:19dd7132]

And of course, this happens with ext4 as well:

Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Problem in HTREE directory inode 4048: block #18 has bad max hash
Invalid HTREE directory inode 4048 (/I/no-E/H/red).  Clear HTree index? yes


Now, I'm not sure how much it's important to bring back the reverted
patch.  Yes, I know it's claimed that it fixes a "security issue", but
in my opinion, it's pretty bullshit worry.  First, almost no one uses
the case folded feature other than Android, and second, do you
*really* think someone will really be trying to run git under Termux
on their Pixel 9 Pro Fold?  I mean.... I guess; I do have Termux
installed on my P9PF, but even I'm not crazy enough to try install
git, emacs, gcc, etc., on an Android phone and expect to get aything
useful done.  Using ssh, or mosh, with Termux, sure.  But git?  Not
convinced....

Anyway, if we *do* want bring back the reverted patch, it would need
to be reworked so that there is a bit in the encoding flags which
indicates how we are treating Unicode "ignorable" characters, so that
e2fsprogs and f2fs-tools can do the right thing.  Once the kernel can
handle things with and without ignorable characters, on a switchable
basis based on a bit in the superblock, then we wouldn't need to use
the linear fallback hack, with the attendant performance penalty.

But honestly, I'm not sure it worth it.  But if someone sends me a
patch which handles the switchable unicode casefold, I'm willing to
spend time to get this integrated into e2fsprogs.

Cheers,

						- Ted

P.S.  This has only been tested using my a file system image created
using my unicode-hijinks script, but it hasn't gone through a full set
of regression tests yet.  But this it is doing the right thing at
least as far as the Unicode case folding is concerned.

From 78499980bfa243a129a2a72f037d35147d3cf363 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 7 Feb 2025 23:08:02 -0500
Subject: [PATCH] ext4: introduce linear search for dentries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch addresses an issue where some files in case-insensitive
directories become inaccessible due to changes in how the kernel
function, utf8_casefold(), generates case-folded strings from the
commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
points").

There are good reasons why this change should be made; it's actually
quite stupid that Unicode seems to think that the characters ❤ and ❤️
should be casefolded.  Unfortimately because of the backwards
compatibility issue, this commit was reverted in 231825b2e1ff.

This problem is addressed by instituting a brute-force linear fallback
if a lookup fails on case-folded directory, which does result in a
performance hit when looking up files affected by the changing how
thekernel treats ignorable Uniode characters, or when attempting to
look up non-existent file names.  So this fallback can be disabled by
setting an encoding flag if in the future, the system administrator or
the manufacturer of a mobile handset or tablet can be sure that there
was no opportunity for a kernel to insert file names with incompatible
encodings.

Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c    | 14 ++++++++++----
 include/linux/fs.h |  6 +++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 536d56d15072..820e7ab7f3a3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
 		 * sure cf_name was properly initialized before
 		 * considering the calculated hash.
 		 */
-		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
+		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
+		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
 		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
 			return false;
@@ -1595,10 +1596,15 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		 * return.  Otherwise, fall back to doing a search the
 		 * old fashioned way.
 		 */
-		if (!IS_ERR(ret) || PTR_ERR(ret) != ERR_BAD_DX_DIR)
+		if (IS_ERR(ret) && PTR_ERR(ret) == ERR_BAD_DX_DIR)
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
+				       "falling back\n"));
+		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
+			 *res_dir == NULL && IS_CASEFOLDED(dir))
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: casefold "
+				       "failed, falling back\n"));
+		else
 			goto cleanup_and_exit;
-		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
-			       "falling back\n"));
 		ret = NULL;
 	}
 	nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..b50ba230f1d4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1246,11 +1246,15 @@ extern int send_sigurg(struct file *file);
 #define SB_NOUSER       BIT(31)
 
 /* These flags relate to encoding and casefolding */
-#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+#define SB_ENC_STRICT_MODE_FL		(1 << 0)
+#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
 
 #define sb_has_strict_encoding(sb) \
 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
 
+#define sb_no_casefold_compat_fallback(sb) \
+	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
+
 /*
  *	Umount options
  */
-- 
2.45.2


