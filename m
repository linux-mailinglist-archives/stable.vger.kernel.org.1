Return-Path: <stable+bounces-86504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33E9A0C4C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B9283836
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E120B1EE;
	Wed, 16 Oct 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXyHDVTu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9BB1DAC9C;
	Wed, 16 Oct 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087977; cv=none; b=fmNi1mycRmx/ia5dzeMlrK05cqWUTzdebA5NP/fm4uarC5S2nPkiPwa1vomkhdDqOotKoAHfrk9jMjIq3IBmAgzEUnREA/d4ZDcvKU1xGwCEvMHo+qkt9EI4g0UG3gITvhqWGbwgCM6cfw6qXad62sLuJ/zfupquFM3535oCE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087977; c=relaxed/simple;
	bh=3RrCkYXmugcLMQqsuXjfHEhV6TfMPhr6H01CPzQR+Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy0MNDR5fdJIWDrzNyVX9UB4B5PefS3JruADm2OpECTcvhiGPsIhgTqb2J9g3TPi4+uoUWvpfTjXEgWf7CEKrJHyrJsJP/RD3eU8F5DkzRlbpS2URB81gSs72Uv0DScc2V3zqFev7gxjNd94V8R3jDegsr/DVCarCNuTepH8vWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXyHDVTu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so4061191a12.3;
        Wed, 16 Oct 2024 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729087975; x=1729692775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrtm50H5o6bNNp65/Lu5Hxh+mDOtWdf+1NtZcjfRoT4=;
        b=AXyHDVTu+DSl3F/FlHEoNn2NWve1szNCcHPbcq/0tMkuUuidpZbD5a9MmPhwVZnhc5
         bqVJwoFL7LwpToER4O/3UKk7wk3Y2UHIpz7F13O+cMCpq6rbRxfjX/IlpXYuesaEHdr7
         OVeYHvtVoftCzJ6zFxJLdh1H3dg9QOEdFVLaIvB+SfJ+beomDzMCQl0MutJ8GSfWwL0i
         9Wqazwe2AvUxNvp5eNz7H0w5Cs0Jdf3meAEl5PYKNmipMShQ7ycICSZ3iaUuK/CHhQkU
         H4utdlWmUOUvrF7xGZBpI3BUwXa/NAYnw/VxNHXifdfcAByEwbX/JKEzIr7jEzUDX3uH
         mdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729087975; x=1729692775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrtm50H5o6bNNp65/Lu5Hxh+mDOtWdf+1NtZcjfRoT4=;
        b=LT/sxaRiH2mur1vxpEU/2f+jwiqwqwKGSO4Z7xULiZdXJTf3D3OPTosYSi47oATOsQ
         HMiByU0Zc+gkjfBvIt05i7s0m92TlKz8hlDYvxk0ffHo9eKlJCovSpDs4e9wlnQqr+/X
         LHuHppzKee2Mjq5Q8IDayIU2YmqWzbehhkANZS8k7Bgj1AIwB6JteLbQLDuKoGJR+4EJ
         GkWx1cip4U+4fHjPZwC/NJShHlE6dZfRG1YnlZoQkIcLzUUfj8eMoDlLTZ5bkbu7X026
         htkgufa/hAntEt6d9q/+0pWglPGWcEadqs8g1J8aJPWzjzyLHqI6HqusCE8ey6MhneFd
         Sctw==
X-Forwarded-Encrypted: i=1; AJvYcCUszYmC7hnBz31TZaTgF07covAsFosb5YTVVwj27hgEgG0P5XVmVSWV9JN4oMeFk7OlGQdWPTZB+MU3y0E=@vger.kernel.org, AJvYcCWSCrp767zgRcOmeInN3u9aWRXOx2EacqoQskxwbOlJS0iUa7cWyafSkCU+cVnRGhATuw3FCcOy@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyofaKPIBDaPqxPgvIPBNh3XNcdCKSagR4StwWKRDh9jE/N0d
	cV64VXDw+vL99Z2a7f4hxvCi8amskFHDkAnNEm0A4ld5pRTj3R5twVwsG6FCma0w146xgZjQkr+
	u0vrXsguCjqXzYuE9068yUv3tvrU=
X-Google-Smtp-Source: AGHT+IHcowRCQGRU51SltbeOi71ITgKHmERwlcLd1LhTd/AzhJ0n0NGHJyu0awpNkKy7GQZG+REGmsRcePHn2ONZ4Ww=
X-Received: by 2002:a05:6a20:9f8c:b0:1d8:ef56:50ac with SMTP id
 adf61e73a8af0-1d905ea1b7emr5904880637.6.1729087975315; Wed, 16 Oct 2024
 07:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922080838.15184-1-aha310510@gmail.com>
In-Reply-To: <20240922080838.15184-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 16 Oct 2024 23:12:43 +0900
Message-ID: <CAO9qdTG9wxBSct-rrgG_DevaLZgy4AFirKu+3uu=HOPD1-PRBg@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm: shmem: fix data-race in shmem_getattr()
To: akpm@linux-foundation.org, hughd@google.com
Cc: yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> I got the following KCSAN report during syzbot testing:
>
> ==================================================================
> BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current
>
> write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
>  inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
>  inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
>  shmem_mknod+0x117/0x180 mm/shmem.c:3443
>  shmem_create+0x34/0x40 mm/shmem.c:3497
>  lookup_open fs/namei.c:3578 [inline]
>  open_last_lookups fs/namei.c:3647 [inline]
>  path_openat+0xdbc/0x1f00 fs/namei.c:3883
>  do_filp_open+0xf7/0x200 fs/namei.c:3913
>  do_sys_openat2+0xab/0x120 fs/open.c:1416
>  do_sys_open fs/open.c:1431 [inline]
>  __do_sys_openat fs/open.c:1447 [inline]
>  __se_sys_openat fs/open.c:1442 [inline]
>  __x64_sys_openat+0xf3/0x120 fs/open.c:1442
>  x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
>  inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
>  inode_get_ctime include/linux/fs.h:1629 [inline]
>  generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
>  shmem_getattr+0x17b/0x200 mm/shmem.c:1157
>  vfs_getattr_nosec fs/stat.c:166 [inline]
>  vfs_getattr+0x19b/0x1e0 fs/stat.c:207
>  vfs_statx_path fs/stat.c:251 [inline]
>  vfs_statx+0x134/0x2f0 fs/stat.c:315
>  vfs_fstatat+0xec/0x110 fs/stat.c:341
>  __do_sys_newfstatat fs/stat.c:505 [inline]
>  __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
>  __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
>  x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> value changed: 0x2755ae53 -> 0x27ee44d3
>
> Since there is no special protection when shmem_getattr() calls
> generic_fillattr(), data-race occurs by functions such as shmem_unlink()
> or shmem_mknod(). This can cause unexpected results, so commenting it out
> is not enough.
>
> Therefore, when calling generic_fillattr() from shmem_getattr(), it is
> appropriate to protect the inode using inode_lock_shared() and
> inode_unlock_shared() to prevent data-race.
>

Cc: stable@vger.kernel.org

I think this patch should be applied from next rc version and also stable
version. When calling generic_fillattr(), if you don't hold read lock,
data-race will occur in inode member variables, which can cause unexpected
behavior. This problem is also present in several stable versions, so I think
it should be fixed as soon as possible.

Regards,

Jeongjun Park

> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  mm/shmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5a77acf6ac6a..9beeb47c3743 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1154,7 +1154,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>         stat->attributes_mask |= (STATX_ATTR_APPEND |
>                         STATX_ATTR_IMMUTABLE |
>                         STATX_ATTR_NODUMP);
> +       inode_lock_shared(inode);
>         generic_fillattr(idmap, request_mask, inode, stat);
> +       inode_unlock_shared(inode);
>
>         if (shmem_is_huge(inode, 0, false, NULL, 0))
>                 stat->blksize = HPAGE_PMD_SIZE;
> --

