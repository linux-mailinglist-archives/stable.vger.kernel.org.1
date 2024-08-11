Return-Path: <stable+bounces-66369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDB94E1D0
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E71C2060E
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D514A602;
	Sun, 11 Aug 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QtdK2esP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB35EAE9
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390169; cv=none; b=CsRnjpDgO+FdmeQABfkbqpoFSZaw0U1i9rrhQSAqnAtvsT5MJOYiCSY7quoeC7NhHs/uIEtAIgKawtm3IsJGV2TiyrXgT6GoOjGGtw9e5b4nueSrNfqFdgiEJas4hiwdDKidRnboSjOMnG5cNIyafYB8m1cUvz6vbWoQCc5r1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390169; c=relaxed/simple;
	bh=HqqQXg77Pid+Z+A5wg9eFm1XjbxufBpNMjy75MrLYRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vi3s42j28whNIQ+4/fYF49HGC08YdQp6TMsw/Gqze84U79W1e1Z2iepsZNLeKq50ZLkh9qBiliq0L+2TvWs3+4S6Mn+G0a/9KRNEyUCnuPa4RyucNIkHjL6hJJ/SftuZuRYruJ0gMUU5zUxyAKai7zbZQK3f7fvq1hAapgJst/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QtdK2esP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so36112141fa.0
        for <stable@vger.kernel.org>; Sun, 11 Aug 2024 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723390162; x=1723994962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIQMTPAJ7Dz1NC8zlLZPzf/m2LaelusvxrtmZRs87wc=;
        b=QtdK2esPc6+wZQdhZk4YjaZMvaadCsfjZZIjoeQqhuTY+OXduCu46rR4VfKXzAw+6m
         bcJTicn6cv2Z/khvcvXKSXY714R2M8IAz4xuKVLtlWiqgVKJTo56S0jkQvlA2jQ9p2lm
         jp+A+Qz5a6/tNBF9iwiSi19+FTGBcs1pSLZ888u13tMBZ1nBI/CKGYv0iLVmeb2VOiT8
         Ix1ivEjdX7K5zgeHDWLuRmPc2BNwmJf45Oca7Jg3+zFEEOtE+vbs8TSfymVmOflc6bAa
         5RWXZlzyZpQ2vl6YUbz8DZS4QIq8ALfz9PTrjDcHjqmEmuUNeRhKNTlPn/WB/kTc/qZE
         CvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723390162; x=1723994962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIQMTPAJ7Dz1NC8zlLZPzf/m2LaelusvxrtmZRs87wc=;
        b=BGzlC0czQgbQM+bj7Sgqt7r/a/joezi15yGluDHdYAwwdd7Oed8JPH1dpafd5Sm7vA
         q9Sheeoervc1Z5WGEYo0PK1AhkAoDMqSjLz0iWpbN3a/c6zXZC6zJQh6QTO6w87m2vJv
         Axn4jtcDOHgArX57hPjmewu4vroWHBEi4jopQJ+A4Z853rLn3B/a0e8qxtlXnBjyaNHU
         zpIYfCnR1i1hfBzxJW5uOwsK37AYQcTxtU5Sy+vyb7dwP+QpsFHqbB+Lu1knKeD31ikA
         yt40RLZGPBoZcutODxMEzZs2vybDJjwlKpQ73KrXRm7sdcSMKtOpb3PS2thGi2dLHkvD
         Xubg==
X-Gm-Message-State: AOJu0YwsL0qJxfw7Jo86i3qfQxDxDp54lM4HwRSrQCu2t1rfBlM5rCXa
	0P8zuSzXiK7WpILZ/U+utvt0JxfqKvrD1jJ9D3AYB6qwyPq8EF+xDTWAaZv6UBzmpgbtOBwM8WB
	cIJ0S+iMcA/wqxYRBY5B9jN0qX0ibgmLnGjBo4VxQqHLd90Ks
X-Google-Smtp-Source: AGHT+IEAF+0wIsTtBw8UEHf9OUMV3kHgfurcjOEPijZG/T8CxByR2nrhe+JvkUSqW4RlAVJd2BmkbH6yfc71jxAFYnw=
X-Received: by 2002:a05:651c:19a5:b0:2f0:29e4:dc52 with SMTP id
 38308e7fff4ca-2f1a6d26849mr49243981fa.27.1723390161768; Sun, 11 Aug 2024
 08:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811125913.1265607-1-sashal@kernel.org>
In-Reply-To: <20240811125913.1265607-1-sashal@kernel.org>
From: Filipe Manana <fdmanana@suse.com>
Date: Sun, 11 Aug 2024 16:29:10 +0100
Message-ID: <CAKisOQG31zm_UWa5TZCczq+zAV3PWKyrYbQX4DgZSebyariXDQ@mail.gmail.com>
Subject: Re: Patch "btrfs: reduce nesting for extent processing at
 btrfs_lookup_extent_info()" has been added to the 6.10-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 1:59=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     btrfs: reduce nesting for extent processing at btrfs_lookup_extent_in=
fo()
>
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      btrfs-reduce-nesting-for-extent-processing-at-btrfs_.patch
> and it can be found in the queue-6.10 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Why is this being added to stable releases?
It's just a cleanup, it doesn't fix any bug or compiler warning, etc.

>
>
>
> commit 5a0873e18421183cf695cc5f2c851aac4e1d832c
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Tue Jun 18 11:52:19 2024 +0100
>
>     btrfs: reduce nesting for extent processing at btrfs_lookup_extent_in=
fo()
>
>     [ Upstream commit 5c83b3beaee06aa88d4015408ac2d8bb35380b06 ]
>
>     Instead of using an if-else statement when processing the extent item=
 at
>     btrfs_lookup_extent_info(), use a single if statement for the error c=
ase
>     since it does a goto at the end and leave the success (expected) case
>     following the if statement, reducing indentation and making the logic=
 a
>     bit easier to follow. Also make the if statement's condition as unlik=
ely
>     since it's not expected to ever happen, as it signals some corruption=
,
>     making it clear and hint the compiler to generate more efficient code=
.
>
>     Reviewed-by: Qu Wenruo <wqu@suse.com>
>     Signed-off-by: Filipe Manana <fdmanana@suse.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 153297cb97a4a..844b677d054ec 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -104,10 +104,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>         struct btrfs_delayed_ref_head *head;
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_path *path;
> -       struct btrfs_extent_item *ei;
> -       struct extent_buffer *leaf;
>         struct btrfs_key key;
> -       u32 item_size;
>         u64 num_refs;
>         u64 extent_flags;
>         u64 owner =3D 0;
> @@ -157,16 +154,11 @@ int btrfs_lookup_extent_info(struct btrfs_trans_han=
dle *trans,
>         }
>
>         if (ret =3D=3D 0) {
> -               leaf =3D path->nodes[0];
> -               item_size =3D btrfs_item_size(leaf, path->slots[0]);
> -               if (item_size >=3D sizeof(*ei)) {
> -                       ei =3D btrfs_item_ptr(leaf, path->slots[0],
> -                                           struct btrfs_extent_item);
> -                       num_refs =3D btrfs_extent_refs(leaf, ei);
> -                       extent_flags =3D btrfs_extent_flags(leaf, ei);
> -                       owner =3D btrfs_get_extent_owner_root(fs_info, le=
af,
> -                                                           path->slots[0=
]);
> -               } else {
> +               struct extent_buffer *leaf =3D path->nodes[0];
> +               struct btrfs_extent_item *ei;
> +               const u32 item_size =3D btrfs_item_size(leaf, path->slots=
[0]);
> +
> +               if (unlikely(item_size < sizeof(*ei))) {
>                         ret =3D -EUCLEAN;
>                         btrfs_err(fs_info,
>                         "unexpected extent item size, has %u expect >=3D =
%zu",
> @@ -179,6 +171,10 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>                         goto out_free;
>                 }
>
> +               ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_=
extent_item);
> +               num_refs =3D btrfs_extent_refs(leaf, ei);
> +               extent_flags =3D btrfs_extent_flags(leaf, ei);
> +               owner =3D btrfs_get_extent_owner_root(fs_info, leaf, path=
->slots[0]);
>                 BUG_ON(num_refs =3D=3D 0);
>         } else {
>                 num_refs =3D 0;

