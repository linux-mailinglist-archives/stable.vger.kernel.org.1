Return-Path: <stable+bounces-203015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B393CCCD81
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B7830ACB6F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C3354AEE;
	Thu, 18 Dec 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y52xKweg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154B34AB1C
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074085; cv=none; b=DzSTJxt9Y4mnz4vt9mdz3aP9iiTZEcOz58aXGXLbPBKaorBwXh/FbKRu0AmvheZ+Go/PZqwu7ixeufMAnDSQoXSDBwlgSxbgIf1eeFn7DwoXp64AKhW1aPh/HaXobV8gbKV9Dm3+Vm+VoEM+daMU/Bp8FYEuUL8vD84MSHsN2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074085; c=relaxed/simple;
	bh=9fY3A5b4zET37FjxItWEHTv8ADHy/IGZ3gVaaXcN4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUhzknr76S/v3kTYSPNNFZr862p+EPQd7n0/T1SA8LRDnH62VNpnqfXFsmSCBufbOgV6vt7wdbGT9jmfw+vWOsixvbGZ9HybBU+bKSr4+WBH+trJ15FAxXGVrYot796bPYa4SOrV016JHdbud3RyYodMBi1M8POn3O70kwyvcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y52xKweg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f38c7d4eso46483f8f.3
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766074080; x=1766678880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll5fg56zYYiWFQstkxfa8620KqOD1ctc79MVD69plr0=;
        b=Y52xKwegM7mmUdCtOYl9QUFBm4JFmONTQJFs4ZgzhSC88i3iY57VH6vCNf5To3RxZd
         3pXBhM1RQx0IzOe5pJHq6mOIs3w+LMWd4wvtxw9jaVHCn8FVGTkynKWjO8mgF3pK7H2+
         BaDdTWwx3rRTG+Yp/9Ic2GqaR7YZChzNJZJhT63m15dlkmcPPsmUzGlPdsVTfM10gQaz
         VS07N2O9G1JeLT7mY6K1iwVYycCF45qXCoJ09/BV7N3HVNWfybQV2/zUAoJdMBtRELYS
         feDoiL5UL8SjkjT6gPRvbD5wrVlQsIoanlyS3p2hCe4jQyhNTATjVVSpKLBKPC7KhjVA
         5GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766074080; x=1766678880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll5fg56zYYiWFQstkxfa8620KqOD1ctc79MVD69plr0=;
        b=Uy7bO8A9VE29SHVTuoJ99VUYR4Tex9gMjwHpvfR0prHcW7L4Ka08fNOsRyYlUqHd9g
         81Q84VOy9lAHmCWRoiAVhizHfBjQ/iqcXAlMggxwNKJYNSmZ7mkyVs273AAiujRoT2jJ
         qxKXSI4XkX2miAasFU+VQ4TJaOA00Mkj0wDHf1hFjGpwZi6ySF2Go4eigNZrS2Xpp8Ny
         RLJX2zxtjpRXdsES4XnCpPaVuFEcd+MwK7iMCZRlFRLs62A9utq1BjeJ2TQw9CYtJxCi
         NEd3fb5kr6LO4WJcj85xTPU5+3Jzk7NqFntt4+JEuedaiU//FlYBIHvjnCOEWR35mUfQ
         iczA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vrNwI9vST/Bg5M5FGJvJV/th5Tsts0wbx479odBrHolQpety5bHw1rAk5PAuC2qa81AUeEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzT8atV6exMhZZTEc6E5VmRqcMN3DnByE/unbzCdKfn1//Gb0C
	57kPN/0n6FEXHEGDXUHlY+XIa9XAFl0fdwnGgDKOQTyEVkm2mCUmI4DQoT3hXBJSyKg=
X-Gm-Gg: AY/fxX4BZXBl1Jeev4PsRDTzP8SPZtXDselchSyv3WuD0a1sEj1pedfVAueaJnfZiQ+
	3B6ynbq0uSAfgTLKf9/Xq8bRzhc59aIJMnU+qRsUozFCIMvhM4NTvCPkbqaUofhj2lu7jXHZFYP
	g67ZUxiHWUYwrB5X303u4DstQxUS0+GmZicRVgjqFLzTlpBw9aMWYW7ZSUNB8IBOGlUpw67f5Y7
	mgPe1h/Y47A66S1Y9dWlysHpcF/HE8nZ/z9NzBMwU1ildgX2w7zQKX8/RT5KOR5cZQb7WgYnduf
	WzPDHojH2UCXhIvTh+E5LviR5T4cEZFMpgKr1ehNrqqWfDxC3lyPmDonOuUdLFDvXwrk8ss4LJR
	eKQfV/qMRuvtj4s8t7ZDo7ANeibLQjQaMuKMIcOPKvUMuKmv0wVRhl55EDfXRvxky7uFwkzSCV2
	sTimTU5pcGyg==
X-Google-Smtp-Source: AGHT+IFfChPcdXBQmW4OnfiET0IribR1F0Ir/X6rOlOywgz8dsCin5NgK+sVVKYU+DaOhPJ/6fhXmg==
X-Received: by 2002:a05:600c:4ed2:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-47be3cffd6amr17869585e9.7.1766074080318;
        Thu, 18 Dec 2025 08:08:00 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fa20a22sm2673669a12.20.2025.12.18.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:07:59 -0800 (PST)
Date: Fri, 19 Dec 2025 00:07:56 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: handle OCFS2_SUPER_BLOCK_FL flag in system dinode
Message-ID: <njikmwfpnsdzalxump7dj7wnlvkwfmvuqwxhpwzly45v7ioj5l@yckvd3veaifi>
References: <20251216200544.4114-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216200544.4114-1-activprithvi@gmail.com>

On Wed, Dec 17, 2025 at 01:35:44AM +0530, Prithvi Tambewagh wrote:
> When ocfs2_populate_inode() is called during mount process, if the flag
> OCFS2_SUPER_BLOCK_FL is set in on-disk system dinode, then BUG() is
> triggered, causing kernel to panic. This is indicative of metadata
> corruption.
> 
> This is fixed by calling ocfs2_error() to print the error log and the
> corresponding inode is marked as 'bad', so that it is not used further
> during the mount process. It is ensured that the fact of that inode being
> bad is propagated to caller ocfs2_populate_inode() i.e.
> ocfs2_read_locked_inode() using is_bad_inode() and further behind along
> the call trace as well.
> 
> Reported-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=779d072a1067a8b1a917
> Tested-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
>  fs/ocfs2/inode.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 12e5d1f73325..f439dc801845 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -347,7 +347,12 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
>  	} else if (fe->i_flags & cpu_to_le32(OCFS2_SUPER_BLOCK_FL)) {
>  		/* we can't actually hit this as read_inode can't
>  		 * handle superblocks today ;-) */
> -		BUG();
> +		ocfs2_error(sb,
> +			    "System Inode %llu has "
> +			    "OCFS2_SUPER_BLOCK_FL set",
> +			    (unsigned long long)le64_to_cpu(fe->i_blkno));
> +		make_bad_inode(inode);
> +		return;
>  	}
>  
>  	switch (inode->i_mode & S_IFMT) {
> @@ -555,6 +560,11 @@ static int ocfs2_read_locked_inode(struct inode *inode,
>  
>  	ocfs2_populate_inode(inode, fe, 0);
>  
> +	if (is_bad_inode(inode)) {
> +		status = -EIO;
> +		goto bail;
> +	}
> +
>  	BUG_ON(args->fi_blkno != le64_to_cpu(fe->i_blkno));
>  
>  	if (buffer_dirty(bh) && !buffer_jbd(bh)) {
> @@ -576,7 +586,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
>  	if (can_lock)
>  		ocfs2_inode_unlock(inode, lock_level);
>  
> -	if (status < 0)
> +	if (status < 0 && !is_bad_inode(inode))
>  		make_bad_inode(inode);
>  
>  	brelse(bh);
> 
> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
> -- 
> 2.43.0
> 
> 

ocfs2_populate_inode has two callers: __ocfs2_mknod_locked() and
ocfs2_read_locked_inode()

Your code only works for the ocfs2_read_locked_inode() path, but not for the
__ocfs2_mknod_locked() path.
In __ocfs2_mknod_locked(), there are two tasks after ocfs2_populate_inode:
"creating locks" and "updating the transaction". If you use a 'goto' to bypass
these two tasks, ocfs2 will crash in the near future. Conversely, if you choose
to execute the two jobs, the logic is flawed because we perform on a bad inode.

In my view, the existing code (using BUG()) is acceptable. We don't need to
worry about this syzbot report.

Thanks,
Heming

