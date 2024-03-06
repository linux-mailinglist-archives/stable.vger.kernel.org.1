Return-Path: <stable+bounces-26948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B984F8736B4
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7030628298F
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3401272A4;
	Wed,  6 Mar 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F6xbbpd2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7B1E519
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728762; cv=none; b=VRx8mACPr5G7Bd6fUnHd+oY9Jyq2H4RWpmjFgJ7fAfSJcFGb+xRb/bm359Nt/aqw8U51+r7z2Qok9TYC5O8PXgNGOXPt7Uft4MfyQpL2fQwKaW2v1F3U4wviwIuoYkZDawRsMojnNeKiQnvCVTSOYfxvnvqrydTLXg7CSb6oFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728762; c=relaxed/simple;
	bh=sUHS/a2wS8mGD55WrFaxVz4wqrv82q8J8J4QDB97Wmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+UPvCEkdxkgt73IrruWhJJV+YRw+xdi9FS3saZHNwjjoMNRmCIyW4PXbFwzkCEmWxoaTySoFurl55PzfCTovO/WQduCWXPIhHjO8zP/1U1E2yGBIP0Y5WzmyYiW3tJ3e6LuZ+fm4DXZM8iRH5Rq7jjzjM+7XyE6GjHbgCb0iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F6xbbpd2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56715a6aa55so4108752a12.2
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 04:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709728758; x=1710333558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyS1+vKdFfO2wiU1gO6Q7YmFHviftdY/gMUVBF6T6Ys=;
        b=F6xbbpd299wI0P9lxIrv56G+UMgHByAeB/2oB+sB+bgkvtBuwqyGyX/aAdiY0jPaP5
         LsFYlCmuZcdGlGMwImcuSG8ByFSYmjfMxW3YtYa9XVb6j+0WbLj/Dp+whwebmRIlUv7r
         hQQPGl8Aj66UVMCPeuwxIVmZ/Pzcxe+THR1w1iqohEKZ6sRLwQDb0pjK8YpFcp9VxChg
         kJBqIw4EYbG+VxcLXhp/MUy2aAZIsyXuqThyRM/02FNwsSJWU3M1UmzVYM5RKdhPI0w5
         6Dj+V+o/QQOSDd8CDpMi9QLwTssnsROP09GhF94+gaHMzHMvhgcX0HZOA0xJJwrwz+ys
         M2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728758; x=1710333558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyS1+vKdFfO2wiU1gO6Q7YmFHviftdY/gMUVBF6T6Ys=;
        b=YZ8xGwydmtuHPTRclFe7gdOaart8MeK8ffsh9WVb0JesTlWTUi6fa+FfP3cQPUDIAy
         mQMwi+wqYb5Mz/uImD9U1ziMLk+NuJ1MX7fhsCjbLuhQXnvGnMdAIe5HppOat120EXGM
         41PbhbKEOXR/qcfQCW4sObP8T1U8S/axgBccnKqzx9SVTq8cdrXyPL4//hCSf5d6HE86
         1MwetpA4arF4qfK0ac1ASWJ8UNFAiyMJbkaNP06Zl2O3iAcjVSrKa7M8HmzilYrQeYy/
         soPvsrIFmulCmRimWIa+5gqfmqaJ4XKqM4KuDugwWrVkp7Ajc1+ekunupb+xPlHsTHM8
         UOOQ==
X-Gm-Message-State: AOJu0YxIbRrKgnKXt7eF9Eul4yNVr95qHCE/yOdA7qNq+/i48Xe7B0bB
	FOzo/kmlDKyNHNHkjVKiyCTLqKMHzSiEzSRT1bAA6jApWaUqnNhlo9+Y5RJMkM0yT+gmSNkqSRO
	xNfHLcJyUcYtF++uqRyZYDziYZNhmmOgMlUbt5Q==
X-Google-Smtp-Source: AGHT+IHYx521363c18fMRU9nNmrQqZGmVTPx1ek5vRUEa2UcMfUJV/7NQs1oA9MSDckKaaj8zkLfRBAHQPMVBkq2FBU=
X-Received: by 2002:a50:cc08:0:b0:566:8fa7:5d0b with SMTP id
 m8-20020a50cc08000000b005668fa75d0bmr10375185edi.3.1709728757701; Wed, 06 Mar
 2024 04:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304211551.880347593@linuxfoundation.org>
In-Reply-To: <20240304211551.880347593@linuxfoundation.org>
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 6 Mar 2024 12:39:06 +0000
Message-ID: <CAKisOQGCiJUUc62ptxp08LkR88T5t1swcBPYi84y2fLP6Tag7g@mail.gmail.com>
Subject: Re: [PATCH 6.7 001/162] btrfs: fix deadlock with fiemap and extent locking
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 9:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.7-stable review patch.  If anyone has any objections, please let me kno=
w.

It would be better to delay the backport of this patch (and the
followup fix) to any stable release, because it introduced another
regression for which there is a reviewed fix but it's not yet in
Linus' tree:

https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/

Thanks.

>
>
> ------------------
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> [ Upstream commit b0ad381fa7690244802aed119b478b4bdafc31dd ]
>
> While working on the patchset to remove extent locking I got a lockdep
> splat with fiemap and pagefaulting with my new extent lock replacement
> lock.
>
> This deadlock exists with our normal code, we just don't have lockdep
> annotations with the extent locking so we've never noticed it.
>
> Since we're copying the fiemap extent to user space on every iteration
> we have the chance of pagefaulting.  Because we hold the extent lock for
> the entire range we could mkwrite into a range in the file that we have
> mmap'ed.  This would deadlock with the following stack trace
>
> [<0>] lock_extent+0x28d/0x2f0
> [<0>] btrfs_page_mkwrite+0x273/0x8a0
> [<0>] do_page_mkwrite+0x50/0xb0
> [<0>] do_fault+0xc1/0x7b0
> [<0>] __handle_mm_fault+0x2fa/0x460
> [<0>] handle_mm_fault+0xa4/0x330
> [<0>] do_user_addr_fault+0x1f4/0x800
> [<0>] exc_page_fault+0x7c/0x1e0
> [<0>] asm_exc_page_fault+0x26/0x30
> [<0>] rep_movs_alternative+0x33/0x70
> [<0>] _copy_to_user+0x49/0x70
> [<0>] fiemap_fill_next_extent+0xc8/0x120
> [<0>] emit_fiemap_extent+0x4d/0xa0
> [<0>] extent_fiemap+0x7f8/0xad0
> [<0>] btrfs_fiemap+0x49/0x80
> [<0>] __x64_sys_ioctl+0x3e1/0xb50
> [<0>] do_syscall_64+0x94/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> I wrote an fstest to reproduce this deadlock without my replacement lock
> and verified that the deadlock exists with our existing locking.
>
> To fix this simply don't take the extent lock for the entire duration of
> the fiemap.  This is safe in general because we keep track of where we
> are when we're searching the tree, so if an ordered extent updates in
> the middle of our fiemap call we'll still emit the correct extents
> because we know what offset we were on before.
>
> The only place we maintain the lock is searching delalloc.  Since the
> delalloc stuff can change during writeback we want to lock the extent
> range so we have a consistent view of delalloc at the time we're
> checking to see if we need to set the delalloc flag.
>
> With this patch applied we no longer deadlock with my testcase.
>
> CC: stable@vger.kernel.org # 6.1+
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/extent_io.c | 62 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8f724c54fc8e9..197b41d02735b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2645,16 +2645,34 @@ static int fiemap_process_hole(struct btrfs_inode=
 *inode,
>          * it beyond i_size.
>          */
>         while (cur_offset < end && cur_offset < i_size) {
> +               struct extent_state *cached_state =3D NULL;
>                 u64 delalloc_start;
>                 u64 delalloc_end;
>                 u64 prealloc_start;
> +               u64 lockstart;
> +               u64 lockend;
>                 u64 prealloc_len =3D 0;
>                 bool delalloc;
>
> +               lockstart =3D round_down(cur_offset, inode->root->fs_info=
->sectorsize);
> +               lockend =3D round_up(end, inode->root->fs_info->sectorsiz=
e);
> +
> +               /*
> +                * We are only locking for the delalloc range because tha=
t's the
> +                * only thing that can change here.  With fiemap we have =
a lock
> +                * on the inode, so no buffered or direct writes can happ=
en.
> +                *
> +                * However mmaps and normal page writeback will cause thi=
s to
> +                * change arbitrarily.  We have to lock the extent lock h=
ere to
> +                * make sure that nobody messes with the tree while we're=
 doing
> +                * btrfs_find_delalloc_in_range.
> +                */
> +               lock_extent(&inode->io_tree, lockstart, lockend, &cached_=
state);
>                 delalloc =3D btrfs_find_delalloc_in_range(inode, cur_offs=
et, end,
>                                                         delalloc_cached_s=
tate,
>                                                         &delalloc_start,
>                                                         &delalloc_end);
> +               unlock_extent(&inode->io_tree, lockstart, lockend, &cache=
d_state);
>                 if (!delalloc)
>                         break;
>
> @@ -2822,15 +2840,15 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                   u64 start, u64 len)
>  {
>         const u64 ino =3D btrfs_ino(inode);
> -       struct extent_state *cached_state =3D NULL;
>         struct extent_state *delalloc_cached_state =3D NULL;
>         struct btrfs_path *path;
>         struct fiemap_cache cache =3D { 0 };
>         struct btrfs_backref_share_check_ctx *backref_ctx;
>         u64 last_extent_end;
>         u64 prev_extent_end;
> -       u64 lockstart;
> -       u64 lockend;
> +       u64 range_start;
> +       u64 range_end;
> +       const u64 sectorsize =3D inode->root->fs_info->sectorsize;
>         bool stopped =3D false;
>         int ret;
>
> @@ -2841,12 +2859,11 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                 goto out;
>         }
>
> -       lockstart =3D round_down(start, inode->root->fs_info->sectorsize)=
;
> -       lockend =3D round_up(start + len, inode->root->fs_info->sectorsiz=
e);
> -       prev_extent_end =3D lockstart;
> +       range_start =3D round_down(start, sectorsize);
> +       range_end =3D round_up(start + len, sectorsize);
> +       prev_extent_end =3D range_start;
>
>         btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> -       lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>
>         ret =3D fiemap_find_last_extent_offset(inode, path, &last_extent_=
end);
>         if (ret < 0)
> @@ -2854,7 +2871,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>         btrfs_release_path(path);
>
>         path->reada =3D READA_FORWARD;
> -       ret =3D fiemap_search_slot(inode, path, lockstart);
> +       ret =3D fiemap_search_slot(inode, path, range_start);
>         if (ret < 0) {
>                 goto out_unlock;
>         } else if (ret > 0) {
> @@ -2866,7 +2883,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>                 goto check_eof_delalloc;
>         }
>
> -       while (prev_extent_end < lockend) {
> +       while (prev_extent_end < range_end) {
>                 struct extent_buffer *leaf =3D path->nodes[0];
>                 struct btrfs_file_extent_item *ei;
>                 struct btrfs_key key;
> @@ -2889,19 +2906,19 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>                  * The first iteration can leave us at an extent item tha=
t ends
>                  * before our range's start. Move to the next item.
>                  */
> -               if (extent_end <=3D lockstart)
> +               if (extent_end <=3D range_start)
>                         goto next_item;
>
>                 backref_ctx->curr_leaf_bytenr =3D leaf->start;
>
>                 /* We have in implicit hole (NO_HOLES feature enabled). *=
/
>                 if (prev_extent_end < key.offset) {
> -                       const u64 range_end =3D min(key.offset, lockend) =
- 1;
> +                       const u64 hole_end =3D min(key.offset, range_end)=
 - 1;
>
>                         ret =3D fiemap_process_hole(inode, fieinfo, &cach=
e,
>                                                   &delalloc_cached_state,
>                                                   backref_ctx, 0, 0, 0,
> -                                                 prev_extent_end, range_=
end);
> +                                                 prev_extent_end, hole_e=
nd);
>                         if (ret < 0) {
>                                 goto out_unlock;
>                         } else if (ret > 0) {
> @@ -2911,7 +2928,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>                         }
>
>                         /* We've reached the end of the fiemap range, sto=
p. */
> -                       if (key.offset >=3D lockend) {
> +                       if (key.offset >=3D range_end) {
>                                 stopped =3D true;
>                                 break;
>                         }
> @@ -3005,29 +3022,41 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>         btrfs_free_path(path);
>         path =3D NULL;
>
> -       if (!stopped && prev_extent_end < lockend) {
> +       if (!stopped && prev_extent_end < range_end) {
>                 ret =3D fiemap_process_hole(inode, fieinfo, &cache,
>                                           &delalloc_cached_state, backref=
_ctx,
> -                                         0, 0, 0, prev_extent_end, locke=
nd - 1);
> +                                         0, 0, 0, prev_extent_end, range=
_end - 1);
>                 if (ret < 0)
>                         goto out_unlock;
> -               prev_extent_end =3D lockend;
> +               prev_extent_end =3D range_end;
>         }
>
>         if (cache.cached && cache.offset + cache.len >=3D last_extent_end=
) {
>                 const u64 i_size =3D i_size_read(&inode->vfs_inode);
>
>                 if (prev_extent_end < i_size) {
> +                       struct extent_state *cached_state =3D NULL;
>                         u64 delalloc_start;
>                         u64 delalloc_end;
> +                       u64 lockstart;
> +                       u64 lockend;
>                         bool delalloc;
>
> +                       lockstart =3D round_down(prev_extent_end, sectors=
ize);
> +                       lockend =3D round_up(i_size, sectorsize);
> +
> +                       /*
> +                        * See the comment in fiemap_process_hole as to w=
hy
> +                        * we're doing the locking here.
> +                        */
> +                       lock_extent(&inode->io_tree, lockstart, lockend, =
&cached_state);
>                         delalloc =3D btrfs_find_delalloc_in_range(inode,
>                                                                 prev_exte=
nt_end,
>                                                                 i_size - =
1,
>                                                                 &delalloc=
_cached_state,
>                                                                 &delalloc=
_start,
>                                                                 &delalloc=
_end);
> +                       unlock_extent(&inode->io_tree, lockstart, lockend=
, &cached_state);
>                         if (!delalloc)
>                                 cache.flags |=3D FIEMAP_EXTENT_LAST;
>                 } else {
> @@ -3038,7 +3067,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct=
 fiemap_extent_info *fieinfo,
>         ret =3D emit_last_fiemap_cache(fieinfo, &cache);
>
>  out_unlock:
> -       unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state)=
;
>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>  out:
>         free_extent_state(delalloc_cached_state);
> --
> 2.43.0
>
>
>

