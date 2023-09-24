Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36027AC665
	for <lists+stable@lfdr.de>; Sun, 24 Sep 2023 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjIXC7Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXC7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 22:59:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D4127
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:59:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4179632293bso29546941cf.3
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695524357; x=1696129157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohClNdfhya5GTAkUp6yU5qky/QEkwLNTph1wCaa0gnQ=;
        b=bdhTyg7ism7Qkr2xc6ghncHeJTaBj9ZxYwOZ1i23G0pgIDSJCvMCxp4XOg2IYKnPXy
         WJNszSjDp8upBeWrday7HxmrJAHPx9cdhHbf0XDkHQTqHpvKXDToc/isQQwCAjaDA8By
         nIq2LQcKUx/PfIpefR75RzPZ02apHxpd177KLyV7G/5uFmSxp/ld6xjboRFusCKpxFFo
         fMkhKXwuTICjXrfuuralt4BWRvqKgIHxiQI3MBdTbXCiGf7wrcxVOGlFewBAtjYPlkNf
         KSsBsTZsv4yODmZaUCJXjY1v0csACoMgnWxa+RPMmLROykUVpwTRxL1L3ms4LP56SdQL
         CdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524357; x=1696129157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohClNdfhya5GTAkUp6yU5qky/QEkwLNTph1wCaa0gnQ=;
        b=INM7pff50DjTr4iXaZ1uWGWnwzlINLw8Q+NAUzNNj3DyIIYzszKS2qYCZhfs1whHEW
         /iNN4iJdNQ31wCFMj4hWpUqVdFfxU+za95n/EVe89SCdJMAG7SVKU8lmbqr5pUEWHzIj
         MrGduMfsDlFSu0hySRWvLFW1des0sKCjHM5Kf52rR57puuOOMWmotdp+bop7L59D53cb
         aDK/2Cd0aMlBMp3ZxOhjVyDIFFJO27udxVbsGfhp24mX8l4ahjFym5xWMs/MovprZOYK
         6Ur/o4pkvTAjdyHglH9BxTcERlDhtWca6fDDWT0lT+Qzlbp7NjsLhPwGROcLsLuHkf+V
         Y4og==
X-Gm-Message-State: AOJu0YwgYzEMhy+QmJfENeXldGL7Q2735u1iMrZ3fBBDG/DVr6JgBXAT
        s44KTt4LE84c2uRc0FN5Zcu8o3igj2kkj5Hiq1e6EHOIeyRLhg==
X-Google-Smtp-Source: AGHT+IF/JzcOn3zsE6Wrpbbz3dr8gUCP/CifT+NZS8xKvtxf+QfQd7+n12nkn0wZUNqxSjo9RK+0R6IUIhsfjdu7Go0=
X-Received: by 2002:a05:622a:118e:b0:411:ff22:b382 with SMTP id
 m14-20020a05622a118e00b00411ff22b382mr4160948qtk.66.1695524357544; Sat, 23
 Sep 2023 19:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <2023092055-disband-unveiling-f6cc@gregkh> <20230924022735.2256466-1-zhangshida@kylinos.cn>
In-Reply-To: <20230924022735.2256466-1-zhangshida@kylinos.cn>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Sun, 24 Sep 2023 10:58:41 +0800
Message-ID: <CANubcdW5fAHipLLMWtak=GBXWyrGoJpCTxt8MBJuj1ySm52_bw@mail.gmail.com>
Subject: Re: [PATCH 4.19.y] ext4: fix rec_len verify error
To:     stable@vger.kernel.org
Cc:     Shida Zhang <zhangshida@kylinos.cn>, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8824=E6=
=97=A5=E5=91=A8=E6=97=A5 10:27=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
>
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx:=
 dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxx=
xx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xx=
xxx: Directory index failed checksum
>
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
>
> But it is not the same condition when blocksize equals to 4k.
> when enough files are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
>
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k.
> To address this, helpers like ext4_rec_len_{from,to}_disk has already
> been introduced to complete the conversion between the encoded and the
> plain form of rec_len.
>
> So fix this one by using the helper, and all the other in this file too.
>
> Cc: stable@kernel.org
> Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree node=
s")
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/r/20230803060938.1929759-1-zhangshida@kylin=
os.cn
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> (cherry picked from commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6)

Oh no, I forgot to change that line to [Upstream commit ...] T_T
Will resend.

Best regards,
Shida.

> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/ext4/namei.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index db9bba3473b5..93d392576c12 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -322,17 +322,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(=
struct inode *inode,
>                                                    struct ext4_dir_entry =
*de)
>  {
>         struct ext4_dir_entry_tail *t;
> +       int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
>
>  #ifdef PARANOID
>         struct ext4_dir_entry *d, *top;
>
>         d =3D de;
>         top =3D (struct ext4_dir_entry *)(((void *)de) +
> -               (EXT4_BLOCK_SIZE(inode->i_sb) -
> -               sizeof(struct ext4_dir_entry_tail)));
> -       while (d < top && d->rec_len)
> +               (blocksize - sizeof(struct ext4_dir_entry_tail)));
> +       while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
>                 d =3D (struct ext4_dir_entry *)(((void *)d) +
> -                   le16_to_cpu(d->rec_len));
> +                   ext4_rec_len_from_disk(d->rec_len, blocksize));
>
>         if (d !=3D top)
>                 return NULL;
> @@ -343,7 +343,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(st=
ruct inode *inode,
>  #endif
>
>         if (t->det_reserved_zero1 ||
> -           le16_to_cpu(t->det_rec_len) !=3D sizeof(struct ext4_dir_entry=
_tail) ||
> +           (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=3D
> +            sizeof(struct ext4_dir_entry_tail)) ||
>             t->det_reserved_zero2 ||
>             t->det_reserved_ft !=3D EXT4_FT_DIR_CSUM)
>                 return NULL;
> @@ -425,13 +426,14 @@ static struct dx_countlimit *get_dx_countlimit(stru=
ct inode *inode,
>         struct ext4_dir_entry *dp;
>         struct dx_root_info *root;
>         int count_offset;
> +       int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);
> +       unsigned int rlen =3D ext4_rec_len_from_disk(dirent->rec_len, blo=
cksize);
>
> -       if (le16_to_cpu(dirent->rec_len) =3D=3D EXT4_BLOCK_SIZE(inode->i_=
sb))
> +       if (rlen =3D=3D blocksize)
>                 count_offset =3D 8;
> -       else if (le16_to_cpu(dirent->rec_len) =3D=3D 12) {
> +       else if (rlen =3D=3D 12) {
>                 dp =3D (struct ext4_dir_entry *)(((void *)dirent) + 12);
> -               if (le16_to_cpu(dp->rec_len) !=3D
> -                   EXT4_BLOCK_SIZE(inode->i_sb) - 12)
> +               if (ext4_rec_len_from_disk(dp->rec_len, blocksize) !=3D b=
locksize - 12)
>                         return NULL;
>                 root =3D (struct dx_root_info *)(((void *)dp + 12));
>                 if (root->reserved_zero ||
> @@ -1244,6 +1246,7 @@ static int dx_make_map(struct inode *dir, struct bu=
ffer_head *bh,
>         unsigned int buflen =3D bh->b_size;
>         char *base =3D bh->b_data;
>         struct dx_hash_info h =3D *hinfo;
> +       int blocksize =3D EXT4_BLOCK_SIZE(dir->i_sb);
>
>         if (ext4_has_metadata_csum(dir->i_sb))
>                 buflen -=3D sizeof(struct ext4_dir_entry_tail);
> @@ -1257,11 +1260,12 @@ static int dx_make_map(struct inode *dir, struct =
buffer_head *bh,
>                         map_tail--;
>                         map_tail->hash =3D h.hash;
>                         map_tail->offs =3D ((char *) de - base)>>2;
> -                       map_tail->size =3D le16_to_cpu(de->rec_len);
> +                       map_tail->size =3D ext4_rec_len_from_disk(de->rec=
_len,
> +                                                               blocksize=
);
>                         count++;
>                         cond_resched();
>                 }
> -               de =3D ext4_next_entry(de, dir->i_sb->s_blocksize);
> +               de =3D ext4_next_entry(de, blocksize);
>         }
>         return count;
>  }
> --
> 2.27.0
>
