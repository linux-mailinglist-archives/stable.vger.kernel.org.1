Return-Path: <stable+bounces-77789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC04987553
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4205A1F27656
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8FC149C42;
	Thu, 26 Sep 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EKbfTSc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E31384BF
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360400; cv=none; b=LpbFAgKaqYRyvVxDb7BhlE0oOUeadAEZej7AiM5Roy6801VWHsWfDKYTpVRio9InJCgCWRdqEUgyuilsoxPGi4oeD5/RcfL/aikYYwjZQyps4jN0IjYDOT7JA7qY9LN3kgboJo9VQJXwf0lZE8C4m+ko2gZKkQaUPN+kFQnob7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360400; c=relaxed/simple;
	bh=fsBejCLuikqVjJuRyFztdr0Xv2VonpPl0X1UtIzWwQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScGZZYtJT2ApdPwo+Twkz3kUmsUdvUExKBH8qlvW9YdGSk1doAvbaadjGQTd25Unl9VoxAedo56TcRg1FwJIAcQN7g4CoMR/nsRN9MOE0fAhJaDsnA/2uhB01gZOPMZBwMn8HZszSfMpq6rLczDbbM9xc/nb0NaGps3wYXBXFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EKbfTSc5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E3AB3F2E4
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727360392;
	bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=EKbfTSc561eeLfPVyZJaugK5285WEp3Szd3QXeCoC1L3PBwE60fJ4x8majmOJWR3J
	 TrfP2dHvxYUflB+rukHYYNdIW7Yl9pEPBMKmW0pw0crfsmRNH5vj7mZ/hmqlp0kkvm
	 hsN292uivqWrWFJ42+fq0VVMVzbaENOdLtgFYJXpIUROs/QUdr2hvWQ68NshS3rwRB
	 LFOJVX2TcdG+/48QIk0yaXBiVB7yloZd7QorL3b2Hpy0nqz2EqiDznuV4qBB0MPBxG
	 HfFoA9kuVxliaUyPUkQO9fE+w/IJ+hvxHnpfsiGAS/4OoBbueH7byFj+LYsWtJyU3O
	 cdR6pN9WzGuNw==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-501061b4a41so313886e0c.0
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 07:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360391; x=1727965191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL59POmvaFxcf8qmycNokQKGCX9wZGI3HSvbyTNhbxk=;
        b=PSGIgYWRDPYpWIOYY2vh5QbbN6ugmFZtAbsSXgIFlbA1/sRx32PAwl6FHBanM7RmoT
         K+t/T6LF8yAhDWMOgQ6OB7GBUVyAvXiyPHYNUbYp6I/Xcr7rpfOHv4xWDSHjWgE5e709
         YmvChKnjHPOF+tGwHmGP1vj4NC55KJ1iStnSl17zytS+GImumETLS87YV3xnGtPHVhNW
         WvmR/e5zwQR4A+pCFsxO/OExkUkI3xrxkNnc5wqrMYnxRl9oGZvSk3+DdtDY0fKT3IgV
         TKfQFbeI458//lKzvjPrG4U7qmlb/NVnffjIF308f5ik+BClQCHvHB7QjxdDpOogt0pA
         A9RA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ37JQkg40urOvNHFf4n2oOboGGsSFWLxUGM0fWU7qFuczMcebyqBRWrdkq3Xtjd1DUspApII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyLK60rm9FoX5voJUgWos3o8+OfALEGxEXBJB0T7TM9qc72NR
	a+8OST/47KGNCUL1c7GARUyfSxaagcIyGqq4RwPSv0Kd5CzleeDET4jtsG2OheVu/ZuI+5SmzdW
	UvqyHSDEjtcHJF6WGe9c6gy+QUmZqMiwR3IjZR4okwBvSCllpgxo9bU5D1cQIyiKT25jvOKZMYY
	IdGDYsYuXri7O5ph7jDCdk4masVNHahLn9ZpAp7ggdLuN5
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id 71dfb90a1353d-505c1d53c06mr5728825e0c.3.1727360390721;
        Thu, 26 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVXaX4QPQm+moOngoVdPlVhd3WRkw/NbU43aKvdUv71fZhsvtLbbDFgTOG2KujfW9HaeMmgltFHBuD5DMLxWY=
X-Received: by 2002:a05:6122:3d0b:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-505c1d53c06mr5728792e0c.3.1727360390399; Thu, 26 Sep 2024
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3> <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
 <dcda93dd-f2ef-4419-ae73-7d3c55b5df8f@huawei.com> <CAEivzxdnAt3WbVmMLpb+HCBSrwkX6vesMvK3onc+Zc9wzv1EtA@mail.gmail.com>
 <4ce5c69c-fda7-4d5b-a09e-ea8bbca46a89@huawei.com> <CAEivzxekNfuGw_aK2yq91OpzJfhg_RDDWO2Onm6kZ-ioh3GaUg@mail.gmail.com>
 <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
In-Reply-To: <941f8157-6515-40d3-98bd-ca1c659ef9e0@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 26 Sep 2024 16:19:39 +0200
Message-ID: <CAEivzxcR+yy1HcZSXmRKOuAuGDnwr=EK_G5mRgk4oNxEPMH_=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:58=E2=80=AFPM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> On 2024/9/26 19:32, Aleksandr Mikhalitsyn wrote:
> >>> Question to you and Jan. Do you guys think that it makes sense to try
> >>> to create a minimal reproducer for this problem without Incus/LXD inv=
olved?
> >>> (only e2fsprogs, lvm tools, etc)
> >>>
> >>> I guess this test can be put in the xfstests test suite, right?
> >>>
> >>> Kind regards,
> >>> Alex
> >> I think it makes sense, and it's good to have more use cases to look
> >> around some corners. If you have an idea, let it go.
> > Minimal reproducer:
> >
> > mkdir -p /tmp/ext4_crash/mnt
> > EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
> > rm -f $EXT4_CRASH_IMG
> > truncate $EXT4_CRASH_IMG --size 25MiB
> > EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
> > $EXT4_CRASH_IMG)
> > mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4=
_CRASH_DEV
> > mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
> > truncate $EXT4_CRASH_IMG --size 3GiB
> > losetup -c $EXT4_CRASH_DEV
> > resize2fs $EXT4_CRASH_DEV
> >
> Hi Alex,
>
> This replicator didn't replicate the issue in my VM, so I took a deeper
> look. The reproduction of the problem requires the following:

That's weird. Have just tried once again and it reproduces the issue:

root@ubuntu:/home/ubuntu# mkdir -p /tmp/ext4_crash/mnt
EXT4_CRASH_IMG=3D"/tmp/ext4_crash/disk.img"
rm -f $EXT4_CRASH_IMG
truncate $EXT4_CRASH_IMG --size 25MiB
EXT4_CRASH_DEV=3D$(losetup --find --nooverlap --direct-io=3Don --show
$EXT4_CRASH_IMG)
mkfs.ext4 -E nodiscard,lazy_itable_init=3D0,lazy_journal_init=3D0 $EXT4_CRA=
SH_DEV
mount $EXT4_CRASH_DEV /tmp/ext4_crash/mnt
truncate $EXT4_CRASH_IMG --size 3GiB
losetup -c $EXT4_CRASH_DEV
resize2fs $EXT4_CRASH_DEV
mke2fs 1.47.0 (5-Feb-2023)
Creating filesystem with 6400 4k blocks and 6400 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/loop4 is mounted on /tmp/ext4_crash/mnt; on-line
resizing required
old_desc_blocks =3D 1, new_desc_blocks =3D 1
Segmentation fault

My kernel's commit hash is 684a64bf32b6e488004e0ad7f0d7e922798f65b6

Maybe it somehow depends on the resize2fs version?

Kind regards,
Alex

>
> o_group =3D flexbg_size * 2 * n;
> o_size =3D (o_group + 1) * group_size;
> n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>
> Take n=3D1,flexbg_size=3D16 as an example:
>                                                   last:47
> |----------------|----------------|o---------------|--------------n-|
>                                    old:32 >>>           new:62
>
> Thus the replicator can be simplified as:
>
> img=3Dtest.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 264M
> dev=3D`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 504M
>
>
> --
> Cheers,
> Baokun
>

