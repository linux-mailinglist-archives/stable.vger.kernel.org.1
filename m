Return-Path: <stable+bounces-224645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCVDB0EQsWlwqQIAu9opvQ
	(envelope-from <stable+bounces-224645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:48:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723825D02C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3340B317C159
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC142BCF45;
	Wed, 11 Mar 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEjwP2ro"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55C22A4E9
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211710; cv=pass; b=QToA8pMGRBNlkj7m1IiYB4QOj+yMBE02UE5wwDCTrB/wCLAW1yC8jFfBOkPMvntLQt/+yi8q3fwvZK5yu3f7vUd4o/xw4Atgz4RKIUbVV5GdKHY/Pl+Ygrbx8feM8qUSRa8j9a9LuQe0RjG+9+tpVBx8PvpRMHTfqJqWvP8vurI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211710; c=relaxed/simple;
	bh=qM0GoM2uO4gAlwg1rfkadzsdOYE/jOQcDxxia8dWlP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKmSdfEWf6VkUPCl4M8YEN08A3bYbb0NCfWk5TwT2wCx9qb6EkaI5aHKs2LEG+66zD7UWYHzvBy4M+wcP0O2iiHixEN4vEc2dRWxZJz7EFFnA5ReCsUH3DhenmGjESjGUZ1dkG2KQJmJS7BM8ffc5DRdxbZnaJAgxsP+Bj0+cpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEjwP2ro; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439ad481518so1317834f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 23:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211707; cv=none;
        d=google.com; s=arc-20240605;
        b=NbASa9B0qoNXlsmTTh739EwXwJlvYogQhH1AQbU4M6hs+o0CVjAncUXYTQdOWovP5R
         eHJ7/cxKjwixFzvd76lArNzhJG08Wrz6BjA1AFLar5qiPQzKHHhqufIfjh+Xzar6fN2F
         tJVxJrhBpwaJAIVEIu3hd4Upo2KITJx2lxTovu26LrKVbJHJC+yjIsHyPquL4B/xDRnj
         XRni13rYxiiH734USgLMvmUkNeXqMA2UDtjqhWN10kHRNybsR7KdGQFoC0rxPFsMVNRM
         rKmytZho2mQpWvXOFA/AnRBK6QqPWBpKi27FRl2fqwwcYW/HrtUV1lJdJltsH8Sv+3c7
         W91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        fh=n2wbXVwS9QjjVnePJxrQykI3aQvKxeXyuTLYHSxeWeQ=;
        b=dh33Zkr7df9GEzoPQMs/9FTL+i6ePD9D0oNAdFRgMQAkpzK7BBZfb8v7kaA5KVXUKR
         z8pUD0TzfF36NTIK145c+lkiyhuWZ7Bnl3r3MLgrqNtm/toLqXWmsvWNmAqW7izJDm1c
         vxNt1iZMqP+dwj0mH98S23tcbChLlh/YQrhe9htTW+MrCafHSvNWXIDSvte/YaCMS0XF
         qLA/bjoQf6ZybaDcrtRpv9RrCe6g891gWY9tEy1PSFGbOsvBXciRbGEy/3qOQuFCvEl3
         4H2RyKGzmDDxxxV/LiXaV6K61H41uA/hV21dCGfXpGU2QyxLp1S+XuNbVUCaj8LQ8eex
         0DoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773211707; x=1773816507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        b=GEjwP2ro9m7Mki0EIgEaeMywxHrlyir6rnlfwSSMD7cePXBQA7jAYUG7YlFfvro3ye
         agEXzA3lwGwmNeVxZbd2CPZdsSJ1apeuAzsBx9m4V6WleJ6EYQYpV1CtZaikmW4LUxXJ
         Ou45T0RsHLCLK9xdKP73wjzWnl8k8bCz+yJSr5biE2yeowJ4jeQ/4eG3G8fWnMmM7vp4
         F7I2blrzTD3NXftsoxOLLpeb0Aj+RS443zvbfNrFKeymgiGdnEvjgyIYfJ6PAox1zGoB
         ywpSgM5gkCOYe4qEUPCHjtqYDlkFGeqd8uOYEb++/IuZ07pGGRHRV5NI0Tdo7xQsgGPV
         kapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211707; x=1773816507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qttt23klfgCrdbllbQ/OYtWEWyUncR5zfpWn/CMBhcE=;
        b=tegLZkSPLcDGYXjmr9XVPfI2syGOge8HWzjTBVi8iNaPmS0dwDBOocg2CffnfhBYdv
         Cb8el3xsp68ReMbbHEtsJrQkYI0Om74g7MRx9SJf2NeM+ru1/8X1QQvApukO4C/xI7lB
         QAHYFV+rjGCyZpa2IXubCLI3Xh8+UF9dyXJSsKFl2wrXDDF9AX8nZDIlGKAxqDKs/6NO
         7af5q2mFQhj5bbVMXBzEUU047dkfvngnr3anv74i23PkjlpkYY1oiKEyGAmf4W6WNPNl
         J3V+YYi+X95mYAPzC00S0VuLmXWZQ8SCHNzPKWi/W2LrG1VML+g9g9hiXd3Qks8xCXml
         GYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzzYGsTn6M0d8vTBEUBLDnuLavDoZKNG5JMOeMkuTkz+4qqFg/w40Oz6v4TIkGcyDL5ZI2WOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC/6LT+9FxvYEcgJqyfp8xE2Om1fYirWMwC3ddJ8ysq4zEWFp
	DX9oNeXk/t6R/QYT5w2nqXfKgIQr+Uq66DCUadG4gcMYI9dJiyW9KzzDl/W7FX132N2I77qldre
	4we5u2/esjbp65dPEGm67efcwkCHphFQ=
X-Gm-Gg: ATEYQzxkcMvo4p5GH+3g/h1YE4+ib2krWQzjBpPfPEywfLIAEl2H94d/6qilA67+hiF
	17eKRhBsplFOscnAI/51lByCQhiNpZDri9z1M6G1looWGIm/mir0iVAPdpMXS/xoW4R+ttF7WrR
	Gf2W6ZiMAMs0HGRQ4HM7gKp+JZDIbHCcGfpr5PFWw15KcmQA2FuI2/tow2/BRN2wUQIEGzEd7St
	zk3gawCOm0hC0TmDqP6PTQ+3nJVbhn27jg5dlsbRdFC0w3vP0ISo9Wih3PaBABeXxSYsKX5nYEQ
	FNsuhytl
X-Received: by 2002:a05:6000:2207:b0:437:72ce:8954 with SMTP id
 ffacd0b85a97d-439f82087c9mr1459231f8f.6.1773211707161; Tue, 10 Mar 2026
 23:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1773209614-1961-1-git-send-email-zhiguo.niu@unisoc.com> <c70a77a2-bc29-4767-b4c2-c5ba12dae04e@linux.alibaba.com>
In-Reply-To: <c70a77a2-bc29-4767-b4c2-c5ba12dae04e@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 11 Mar 2026 14:48:16 +0800
X-Gm-Features: AaiRm51dm_GPIPIMS59a0CAhUSzZaJ8nuweZCAN0n-xYvHBbxaJyLH_Fi9wW1Dw
Message-ID: <CAHJ8P3LH3Z9HjdVhhGXB9f8xAdbLgiwSay3e04GDfvGQwwwm=A@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] erofs: fix inline data read failure for
 ztailpacking pclusters
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org, ke.wang@unisoc.com, 
	Hao_hao.Wang@unisoc.com, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7723825D02C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224645-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[niuzhiguo84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=89 14:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zhiguo,
>
> On 2026/3/11 14:13, Zhiguo Niu wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > [ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]
> >
> > Compressed folios for ztailpacking pclusters must be valid before addin=
g
> > these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
> > may assume they are already valid and then trigger a NULL pointer
> > dereference.
> >
> > It is somewhat hard to reproduce because the inline data is in the same
> > block as the tail of the compressed indexes, which are usually read jus=
t
> > before. However, it may still happen if a fatal signal arrives while
> > read_mapping_folio() is running, as shown below:
> >
> >   erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline da=
ta -4
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000008
> >
> >   ...
> >
> >   pc : z_erofs_decompress_queue+0x4c8/0xa14
> >   lr : z_erofs_decompress_queue+0x160/0xa14
> >   sp : ffffffc08b3eb3a0
> >   x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
> >   x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
> >   x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
> >   x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
> >   x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
> >   x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
> >   x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
> >   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> >   x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
> >   x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
> >   Call trace:
> >    z_erofs_decompress_queue+0x4c8/0xa14
> >    z_erofs_runqueue+0x908/0x97c
> >    z_erofs_read_folio+0x128/0x228
> >    filemap_read_folio+0x68/0x128
> >    filemap_get_pages+0x44c/0x8b4
> >    filemap_read+0x12c/0x5b8
> >    generic_file_read_iter+0x4c/0x15c
> >    do_iter_readv_writev+0x188/0x1e0
> >    vfs_iter_read+0xac/0x1a4
> >    backing_file_read_iter+0x170/0x34c
> >    ovl_read_iter+0xf0/0x140
> >    vfs_read+0x28c/0x344
> >    ksys_read+0x80/0xf0
> >    __arm64_sys_read+0x24/0x34
> >    invoke_syscall+0x60/0x114
> >    el0_svc_common+0x88/0xe4
> >    do_el0_svc+0x24/0x30
> >    el0_svc+0x40/0xa8
> >    el0t_64_sync_handler+0x70/0xbc
> >    el0t_64_sync+0x1bc/0x1c0
> >
> > Fix this by reading the inline data before allocating and adding
> > the pclusters to the I/O chains.
> >
> > Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> > Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/erofs/zdata.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 7116f20..0b3ca62 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -788,6 +788,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_fr=
ontend *fe)
> >       erofs_blk_t blknr =3D erofs_blknr(sb, map->m_pa);
> >       struct z_erofs_pcluster *pcl =3D NULL;
> >       int ret;
> > +     void *mptr =3D NULL;
>
Hi Xiang,
> let's align with the upstream naming and ordering?
>
>         void *ptr =3D NULL;
>         int ret;
OK
>
> >
> >       DBG_BUGON(fe->pcl);
> >       /* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster =
*/
> > @@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct z_erofs_f=
rontend *fe)
> >       } else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> >               DBG_BUGON(1);
> >               return -EFSCORRUPTED;
> > +     } else {
> > +             mptr =3D erofs_read_metabuf(&map->buf, sb, map->m_pa, ERO=
FS_NO_KMAP);
> > +             if (IS_ERR(mptr)) {
> > +                     ret =3D PTR_ERR(mptr);
> > +                     erofs_err(sb, "failed to get inline data %d", ret=
);
>
> Could you retain the upstream error report? like:
>                         erofs_err(sb, "failed to read inline data %pe @ p=
a %llu of nid %llu",
>                                   mptr, map->m_pa, EROFS_I(fe->inode)->ni=
d);
>
> Otherwise it looks good to me.
>
> When you send the next version, please send the patch
> to Greg as well.
got it.
Thanks!
>
> Thanks,
> Gao Xiang
>
> > +                     return ret;
> > +             }
> > +             mptr =3D map->buf.page;
> >       }
> >
> >       if (pcl) {
> > @@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct z_erofs_f=
rontend *fe)
> >               /* bind cache first when cached decompression is preferre=
d */
> >               z_erofs_bind_cache(fe);
> >       } else {
> > -             void *mptr;
> > -
> > -             mptr =3D erofs_read_metabuf(&map->buf, sb, map->m_pa, ERO=
FS_NO_KMAP);
> > -             if (IS_ERR(mptr)) {
> > -                     ret =3D PTR_ERR(mptr);
> > -                     erofs_err(sb, "failed to get inline data %d", ret=
);
> > -                     return ret;
> > -             }
> > -             get_page(map->buf.page);
> > -             WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.pa=
ge);
> > +             get_page((struct page *)mptr);
> > +             WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, mptr);
> >               fe->pcl->pageofs_in =3D map->m_pa & ~PAGE_MASK;
> >               fe->mode =3D Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
> >       }
>

