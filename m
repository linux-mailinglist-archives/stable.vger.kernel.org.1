Return-Path: <stable+bounces-200948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953DCBA759
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C212E300F38B
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E22C178D;
	Sat, 13 Dec 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwlO+N53"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F923817F
	for <stable@vger.kernel.org>; Sat, 13 Dec 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765616146; cv=none; b=nNCxcDYyx2AOZ8BukeCFeAGrLLHEXbxPKP6AXbsZNY7MBkE4SfWewDMU+SspU5N+M4sFieD6OpakZ4DITNwR166/eyM5SlSnNzpofbgMCNXL8XJG2a2qGX+vxAZWpHuoWfcMp23LZqcI/ueeUela4f+WuNJR++1olCVd1RAkp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765616146; c=relaxed/simple;
	bh=Ap/xN+ohCrjvsa7OyB6aMNevZszmz22wTJ6d+jBLkl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIBzHXPDnhkvAjSv5AZdIMQ0lTU7mH69O6neR9LKwj2SjFzW0H8BHRmEw0YNN6WKXw5szB32cgzsWiWlnwoGltztpuozoZBvNRR6AepfAGpqzaVpHbKkAprMElcCKPpOEl2DvxsdM7yi/6QcF1e5xU6PsA9knvS0doYMVWvE9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwlO+N53; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2106819b3a.1
        for <stable@vger.kernel.org>; Sat, 13 Dec 2025 00:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765616144; x=1766220944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAPKwQxYFNxoXWaJA+G1Z4tfRb/olAqqNaUD+VOrvo8=;
        b=ZwlO+N53A2BRTGF11gRqT/YeqFAsJ6wXSrRH7o8D48CICEzc1enoZytcAzx68t4SZR
         3HRZCBApGejWlpeNZ07/3HT7CuCkqG0kJaemRdyuLghR3rca2a6URFk2nw+y3zJnmS+F
         /+OPzZeNkb64uZt+RksbhsHqladatb7Aa96+hRh2ICopW+pklTffHXcA/RtiPi+017LF
         CkoAmXvoGJP+k9tpWmSPCVj/JmyZ+dPAHpsnGeDAR3TG+o8OK7ZtN3HVkhfmZyWljeSt
         D8DcVbnwpG/J2f6RPR+JWmlfpgD0waf4kwXtHpL871JHE/+MIvUPVsNpFRdZgA1+JRIu
         OwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765616144; x=1766220944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAPKwQxYFNxoXWaJA+G1Z4tfRb/olAqqNaUD+VOrvo8=;
        b=KI4r32frxuemNjgrdWfsAcv49dCTKl+CzD+j6K78BSS3HsnRAB17ZjLDUOQ6D/KUBG
         cP4YsjgV9k3xFaYB2pny/z/t0Yl7HjGsNSjFxmadth2XY8wLRRjbAsBKN85xDcw09qPx
         bhDq3bO8na2tOmF5f4Ff9h4a4xuJfFguWIAa/vEYPnavTFa0SUEjylo57z/h2iwnCejX
         yiQTgj+7UiXRmn/eq1FF486In61xVDnwFhW+n38W++2chUSA1R6kLmoR/XHWwtM/68SE
         d1UJ7gFuZmmXHBr7XDHSIjjgLVdpKlgJNzddYdsTmQ4TocVSWuVDxzamaDSD3vjp+mDB
         rR9w==
X-Forwarded-Encrypted: i=1; AJvYcCXJyfpLBWT/IsoEugAF32r3xi8J7zeiMWrjG/g0oQnc4kDK4JVJu1JeljvZ3hll+P3bAohTeaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy401tlhmzm9z2bdd+I0nDpmFVHIE9Fp9M2zAiXFsQeCijQm4vd
	YOOnSBw9CRgUWtwsGOJUQo79Ke1ZUq+3O+GBOLUqdgD6SjVmHUL07B44
X-Gm-Gg: AY/fxX6yGOK0Euz210tY8dbRCTnMBWFPhWaV29Wa5/Z/ZExDj/q8QD1R1HjlWoob6kI
	pCMQ4R1ATim5N5YkE4tus/pgrPVFgqGO4vxUjTJcJELPE1O1tNp/72DD9EhHBIvfo9ZdbdOALOf
	fj5SDYkZSXEkLfJhmQ6M6vWfyAw4EeRcA6kTY1TDxsklcchFXOs/1w8KszY8ypPaRzmi8HVsGvr
	zfufSH3kSJ7efulPOhfIiVvjPMyhwdVbBpxQ/yODj+Ev1eWaVyTfUXye+p0ocy5OK8y4h7HF/W0
	MFraMzUBjHDGD80zBm3BukUnM/sFaJcBFUj26V0eWkRzf5S9jJl9cPtMt9wbB3N40/m6bE+t3II
	XOuZSDTt55Zrnu1FdlrqMYGSOlQgUfqENwwXHeMD1Umx/k9aGWb04MLcR3ARU/EUBf9aR8bbNfO
	Jc1Z+O0HDIYd2ZCyb8G1SPegM=
X-Google-Smtp-Source: AGHT+IFlig2DrZx8Feq9J9/VJRsbtE/6az80e8ZmIURSYb8lP80150rRSXNzgVWthWWXmu3XAcfTBA==
X-Received: by 2002:a05:6a00:4388:b0:7ab:6fdb:1d1f with SMTP id d2e1a72fcca58-7f667d1ff24mr4111609b3a.29.1765616144258;
        Sat, 13 Dec 2025 00:55:44 -0800 (PST)
Received: from prithvi-HP ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c237ef12sm7241612b3a.14.2025.12.13.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 00:55:43 -0800 (PST)
Date: Sat, 13 Dec 2025 14:25:29 +0530
From: Prithvi <activprithvi@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, 
	Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ocfs2: fix kernel BUG in ocfs2_write_block
Message-ID: <neqzjkw3ylaqghldgkl7jzlcl4o3vofbm6aa3a2kojfaakzjhm@ele2brknwzwm>
References: <20251210193257.25500-1-activprithvi@gmail.com>
 <9bad11da-0655-4fb4-b424-8c124b127290@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bad11da-0655-4fb4-b424-8c124b127290@linux.alibaba.com>

On Thu, Dec 11, 2025 at 10:17:21AM +0800, Joseph Qi wrote:
> 
> 
> On 2025/12/11 03:32, Prithvi Tambewagh wrote:
> > When the filesystem is being mounted, the kernel panics while the data
> > regarding slot map allocation to the local node, is being written to the
> > disk. This occurs because the value of slot map buffer head block
> > number, which should have been greater than or equal to
> > `OCFS2_SUPER_BLOCK_BLKNO` (evaluating to 2) is less than it, indicative
> > of disk metadata corruption. This triggers
> > BUG_ON(bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) in ocfs2_write_block(),
> > causing the kernel to panic.
> > 
> > This is fixed by introducing an if condition block in
> > ocfs2_update_disk_slot(), right before calling ocfs2_write_block(), which
> > checks if `bh->b_blocknr` is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if
> > yes, then ocfs2_error is called, which prints the error log, for
> > debugging purposes, and the return value of ocfs2_error() is returned
> > back to caller of ocfs2_update_disk_slot() i.e. ocfs2_find_slot(). If
> > the return value is zero. then error code EIO is returned.
> > 
> > Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
> > Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > ---
> > v1->v2:
> >  - Remove usage of le16_to_cpu() from ocfs2_error()
> >  - Cast bh->b_blocknr to unsigned long long
> >  - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
> >  - Fix Sparse warnings reported in v1 by kernel test robot
> >  - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
> >    'ocfs2: fix kernel BUG in ocfs2_write_block'
> > 
> > v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/
> > 
> >  fs/ocfs2/slot_map.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
> > index e544c704b583..e916a2e8f92d 100644
> > --- a/fs/ocfs2/slot_map.c
> > +++ b/fs/ocfs2/slot_map.c
> > @@ -193,6 +193,16 @@ static int ocfs2_update_disk_slot(struct ocfs2_super *osb,
> >  	else
> >  		ocfs2_update_disk_slot_old(si, slot_num, &bh);
> >  	spin_unlock(&osb->osb_lock);
> > +	if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
> > +		status = ocfs2_error(osb->sb,
> > +				     "Invalid Slot Map Buffer Head "
> > +				     "Block Number : %llu, Should be >= %d",
> > +				     (unsigned long long)bh->b_blocknr,
> > +				     OCFS2_SUPER_BLOCK_BLKNO);
> > +		if (!status)
> > +			return -EIO;
> > +		return status;
> > +	}
> >  
> >  	status = ocfs2_write_block(osb, bh, INODE_CACHE(si->si_inode));
> >  	if (status < 0)
> > 
> 
> Ummm... The 'bh' is from ocfs2_slot_info, which is load from crafted
> image during mount.
> So IIUC, the root cause is we read slot info without validating, see
> ocfs2_refresh_slot_info().
> So I'd prefer to implement a validate func and pass it into
> ocfs2_read_blocks() to do this job.
> 
> Thanks,
> Joseph

I checked using GDB and learnt that ocfs2_refresh_slot() is not called 
until the bug is triggered. Checking further, I obtained this backtrace 
just before the bug was triggered, with a breakpoint set at 
ocfs2_read_blocks():

#0  ocfs2_read_blocks (ci=0xffff88804b6e3cc0, block=0, nr=1, bhs=0xffffc9000f37efe0, 
    flags=1, validate=0x0) at fs/ocfs2/buffer_head_io.c:197
#1  0xffffffff83a1fb44 in ocfs2_map_slot_buffers (osb=0xffff888028d2c000, 
    si=0xffff888027329d00) at fs/ocfs2/slot_map.c:385
#2  ocfs2_init_slot_info (osb=0xffff888028d2c000) at fs/ocfs2/slot_map.c:424
#3  0xffffffff83a91b93 in ocfs2_initialize_super (sb=0xffff88802912a000, bh=<optimized out>, 
    sector_size=<optimized out>, stats=<optimized out>) at fs/ocfs2/super.c:2220
#4  ocfs2_fill_super (sb=0xffff88802912a000, fc=<optimized out>) at fs/ocfs2/super.c:993
#5  0xffffffff822db16e in get_tree_bdev_flags (fc=0xffff888029dac800, 
    fill_super=0xffffffff83a8d5c0 <ocfs2_fill_super>, flags=<optimized out>)
    at fs/super.c:1691
#6  0xffffffff822db3b2 in vfs_get_tree (fc=0xffff888029dac800) at fs/super.c:1751
#7  0xffffffff82366f32 in fc_mount (fc=0xffff888029dac800) at fs/namespace.c:1208
#8  do_new_mount_fc (fc=0xffff888029dac800, mountpoint=0xffffc9000f37fe60, mnt_flags=48)
    at fs/namespace.c:3651
#9  do_new_mount (path=0xffffc9000f37fe60, fstype=<optimized out>, sb_flags=<optimized out>, 
    mnt_flags=48, name=0xffff888024bf93a0 "/dev/loop0", data=0xffff888028b54000)
    at fs/namespace.c:3727
#10 0xffffffff823659c7 in path_mount (
    dev_name=0x1 <error: Cannot access memory at address 0x1>, path=0xffff888024bf93a0, 
    type_page=0xffff888028b54000 "user_xattr", flags=<optimized out>, 
    data_page=0x7fffc7d5cb00) at fs/namespace.c:4037
#11 0xffffffff82369253 in do_mount (dev_name=0xffff888024bf93a0 "/dev/loop0", 
    dir_name=0x200000000040 "./file1", type_page=<optimized out>, flags=2240, 
--Type <RET> for more, q to quit, c to continue without paging--
    data_page=0xffff888028b54000) at fs/namespace.c:4050
#12 __do_sys_mount (type=<optimized out>, dev_name=<optimized out>, dir_name=<optimized out>, flags=<optimized out>, 
    data=<optimized out>) at fs/namespace.c:4238
#13 __se_sys_mount (dev_name=<optimized out>, dir_name=35184372088896, type=<optimized out>, flags=2240, 
    data=140736546065152) at fs/namespace.c:4215
#14 0xffffffff82368f2c in __x64_sys_mount (regs=<optimized out>) at fs/namespace.c:4215
#15 0xffffffff81328ced in x64_sys_call (regs=0xffff88804b6e3cc0, nr=0) at arch/x86/entry/syscall_64.c:37
#16 0xffffffff8ac0015a in do_syscall_x64 (regs=0xffffc9000f37ff48, nr=165) at arch/x86/entry/syscall_64.c:63
#17 do_syscall_64 (regs=0xffffc9000f37ff48, nr=165) at arch/x86/entry/syscall_64.c:94
#18 0xffffffff81000130 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:121
#19 0x0000000000000000 in ?? ()

Hence, I think the function to fix would be ocfs2_map_slot_buffers() i.e.
the call to ocfs2_read_blocks() in it. I came up with following changes:

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index e544c704b583..299751617919 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -332,6 +332,26 @@ int ocfs2_clear_slot(struct ocfs2_super *osb, int slot_num)
        return ocfs2_update_disk_slot(osb, osb->slot_info, slot_num);
 }
 
+static int ocfs2_validate_slot_map_block(struct super_block *sb,
+                                     struct buffer_head *bh)
+{
+       int rc;
+
+       BUG_ON(!buffer_uptodate(bh));
+
+       if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
+               rc = ocfs2_error(osb->sb,
+                               "Invalid Slot Map Buffer Head "
+                               "Block Number : %llu, Should be >= %d",
+                               (unsigned long long)bh->b_blocknr,
+                               OCFS2_SUPER_BLOCK_BLKNO);
+               if (!rc)
+                       return -EIO;
+               return status;
+       }
+       return 0;
+}
+
 static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
                                  struct ocfs2_slot_info *si)
 {
@@ -383,7 +403,8 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 
                bh = NULL;  /* Acquire a fresh bh */
                status = ocfs2_read_blocks(INODE_CACHE(si->si_inode), blkno,
-                                          1, &bh, OCFS2_BH_IGNORE_CACHE, NULL);
+                                          1, &bh, OCFS2_BH_IGNORE_CACHE,
+                                          ocfs2_validate_slot_map_block);
                if (status < 0) {
                        mlog_errno(status);
                        goto bail;
  
What do you think? Is this the correct approach?

Thank You,
Prithvi

