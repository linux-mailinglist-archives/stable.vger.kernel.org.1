Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED07ABF72
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjIWJmo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjIWJmV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 05:42:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8976E5C
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 02:41:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4180f5c51f8so174651cf.1
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695462116; x=1696066916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHab9jL3Hzl/bCTFVpOj4EOvp1DJC3G3ya/77N60pm8=;
        b=WWPAQBjfIY/AtIXh1fRmYTCq+j+H6jfboFjFVZbkejcLj/UcxHvZUT+Ne4q+3afv88
         yjjvvVNE8060v2G6pE3PHfP9q0eLBrypx/HB0XISBcHk4wXgB5Wt6eLF9LTsn69oGZAm
         JnDBCgulW13IyPrrAJyGZum5+SuBr3nlmkqHEOY7cFan9FcJx6mBArxKJ11Tq6Fj13cU
         EpRvuCmT6qky6pdluHcMRIOvNPVYE7FUgbdisUPOuK6T2tHUAG+12eBmFfX9MuH4JbqQ
         8umUQA0XssZVZzdzmfBswr2vC5+RbGz0l7/JKaTrmiIVSKERG0mv7/vlnWI1q3WgzWvP
         iImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695462116; x=1696066916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHab9jL3Hzl/bCTFVpOj4EOvp1DJC3G3ya/77N60pm8=;
        b=uSeCumUWE51VwBO3zEANbjT95LjFIZQyxc55QaunxiqiCAOYEDPCyvpU4v0gBe3Mh1
         1NskD74cJdHbYYy0LDGBJOL+wOZpnafTetBMK+3Ne7P+cDcCdFxloa6c1RzzR/KUVrQO
         Mxozp/TDcUxAz/3WpHewbhAdYZc396S8idRyotGbNH0XKbnki8QcmnEjJN9WxN84bZns
         nzch+exy3em3chVFuQ+IjE7TisXBur6qnc49GD8M4CFOjyECfJgJgE/g2XG3HSis1vSK
         X/rjGp3JYHYwDR4hLyCxcLoPTkfGwVAox1jl7T1e9JQS0IlMG6u0MI3uT6QV7Se6ghv0
         vsXQ==
X-Gm-Message-State: AOJu0YydxEZCn3l25rGA/gNCTgZJADFReytSwZIaWmMy2NhLaMbqacqK
        d2DHS2GUypkEOir9n9O2rXGl1NB+io6EOyq8Y78=
X-Google-Smtp-Source: AGHT+IGM4nlAN8LOvwfEnjGWy3ZLXilBL1u8Z2QIMJ9aHdSLCIJ7AVh+756ugq0M4Bw9Y+wLcOoGSGusQqhkzAKUtWU=
X-Received: by 2002:a05:622a:1b8b:b0:415:15d2:b892 with SMTP id
 bp11-20020a05622a1b8b00b0041515d2b892mr5986735qtb.12.1695462115707; Sat, 23
 Sep 2023 02:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <2023092055-disband-unveiling-f6cc@gregkh> <20230922025458.2169511-1-zhangshida@kylinos.cn>
 <2023092205-ending-subzero-9778@gregkh>
In-Reply-To: <2023092205-ending-subzero-9778@gregkh>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Sat, 23 Sep 2023 17:41:19 +0800
Message-ID: <CANubcdVYCFS=UAKX6sfe=jpZCtipDBrxi_O4=RpsAr1LY4Z1BQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix rec_len verify error
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=94 17:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 22, 2023 at 10:54:58AM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > [ Upstream commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6 ]
> >
> > With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> > a problem occurred when more than 13 million files were directly create=
d
> > under a directory:
> >
> > EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxx=
x: dir seems corrupt?  Run e2fsck -D.
> > EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm x=
xxxx: dir seems corrupt?  Run e2fsck -D.
> > EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm =
xxxxx: Directory index failed checksum
> >
> > When enough files are created, the fake_dirent->reclen will be 0xffff.
> > it doesn't equal to the blocksize 65536, i.e. 0x10000.
> >
> > But it is not the same condition when blocksize equals to 4k.
> > when enough files are created, the fake_dirent->reclen will be 0x1000.
> > it equals to the blocksize 4k, i.e. 0x1000.
> >
> > The problem seems to be related to the limitation of the 16-bit field
> > when the blocksize is set to 64k.
> > To address this, helpers like ext4_rec_len_{from,to}_disk has already
> > been introduced to complete the conversion between the encoded and the
> > plain form of rec_len.
> >
> > So fix this one by using the helper, and all the other in this file too=
.
> >
> > Cc: stable@kernel.org
> > Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree no=
des")
> > Suggested-by: Andreas Dilger <adilger@dilger.ca>
> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Link: https://lore.kernel.org/r/20230803060938.1929759-1-zhangshida@kyl=
inos.cn
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  fs/ext4/namei.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
>
> What stable kernel tree(s) are you asking for this to be applied to?
>
> thanks,
>
> greg k-h

This one is intended for 4.14.y.
And the other one from zhangshida@kylinos.cn is for 4.19.y.

Apologies for this confusion. It appears that the '--subject-prefix' option
of the 'git send-email' command does not work with the local patch file.

BTW, I forgot to CC my Gmail address in another thread,
so I reply here only.

Best regards,
Shida
