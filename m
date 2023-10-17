Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4347CD023
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQXBO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQXBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 19:01:13 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE642A4
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 16:01:09 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-457e5dec94dso1205533137.3
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697583669; x=1698188469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxvl1TlAYYqk8yQ5idpKi21TPpTBqDVkjCfJkiJoBRE=;
        b=ebD90BvBWYrck8ut2GJZ9UDovxHbMEZsr67Gi4ymVizvzlIZnz0dN+2RMz3DYUvtPO
         iImfnpByQQmDAYKGVQfHAtFReRhp865B5P9wXMVghiZ37l9uP3QiMODnoqPw0dzrk+ru
         xI4T1vtmwG1o8NKHY2+YPHcg/hQkkUULzqTA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583669; x=1698188469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxvl1TlAYYqk8yQ5idpKi21TPpTBqDVkjCfJkiJoBRE=;
        b=VLyxYFCgOlzO7htkkSc4/hsXKJEwaDdKK4B81k5J5bn3vfu9iVUJqLPIkpo0T64Yo3
         HxnDcjAUPSwxMAOsU/QDBb0/C90KripV33gDf8JzQ0yE5f+UNfc3oZaPPILxuTxZ0vbP
         UEjXj2aprHEaqw4AEJ/WBU2Sn5NCukZE1PmlAZeULSsHOOzcc5M47WDQfPsB12eOJNcr
         4s58hWsG10Jo4Z050WmsIrW6bsKqPftnokKi1MVb9iD1/cpMzn3mPyMg7QFt25pp8nzO
         /MqAN0V/TZxLOOIbh5S+xeZFInp9DtEWSmLs/iEAj+/6gt0jEp9VtUyvEqPawWiguocS
         MSjA==
X-Gm-Message-State: AOJu0YzdwpgXa5Ku81ILoZU7qxT9wfnq7lKOVqUfo9qHaFiOqGgm4F81
        c4ORo9Ms64R+/N5f27TaiIJex+uiLjSsQai1QrQ=
X-Google-Smtp-Source: AGHT+IFIz5Cz9W2WYVzEmfXIKk6P/1+ELpfAt+EsRa848fvQ2nAx9xhFcFGCn3HFvBkOfmYcEFFdUA==
X-Received: by 2002:a67:b804:0:b0:457:bac5:ea50 with SMTP id i4-20020a67b804000000b00457bac5ea50mr3338418vsf.25.1697583668681;
        Tue, 17 Oct 2023 16:01:08 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id l23-20020a67fe17000000b0045479f31625sm244827vsr.3.2023.10.17.16.01.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 16:01:05 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-457eebf8e01so1166224137.2
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 16:01:05 -0700 (PDT)
X-Received: by 2002:a67:c21e:0:b0:457:d6a2:7187 with SMTP id
 i30-20020a67c21e000000b00457d6a27187mr4120495vsj.7.1697583664474; Tue, 17 Oct
 2023 16:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.286315610@linuxfoundation.org> <20230911134651.582204417@linuxfoundation.org>
 <ZS6xYa_kjRGvdCG6@google.com> <bd5d2f882e47b904802023d5d4d54d8d4755440e.camel@linux.ibm.com>
In-Reply-To: <bd5d2f882e47b904802023d5d4d54d8d4755440e.camel@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 17 Oct 2023 17:00:53 -0600
X-Gmail-Original-Message-ID: <CAHQZ30A8R+EDGbrngMOQrXabR=DTHL3Y-1Tv+3RF98VHQ5b68Q@mail.gmail.com>
Message-ID: <CAHQZ30A8R+EDGbrngMOQrXabR=DTHL3Y-1Tv+3RF98VHQ5b68Q@mail.gmail.com>
Subject: Re: [PATCH 6.4 041/737] ovl: Always reevaluate the file signature for IMA
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, Tim Bain <tbain@google.com>,
        Shuhei Takahashi <nya@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 12:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Tue, 2023-10-17 at 10:08 -0600, Raul E Rangel wrote:
> > On Mon, Sep 11, 2023 at 03:38:20PM +0200, Greg Kroah-Hartman wrote:
> > > 6.4-stable review patch.  If anyone has any objections, please let me=
 know.
> > >
> > > ------------------
> > >
> > > From: Eric Snowberg <eric.snowberg@oracle.com>
> > >
> > > [ Upstream commit 18b44bc5a67275641fb26f2c54ba7eef80ac5950 ]
> > >
> > > Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version=
")
> > > partially closed an IMA integrity issue when directly modifying a fil=
e
> > > on the lower filesystem.  If the overlay file is first opened by a us=
er
> > > and later the lower backing file is modified by root, but the extende=
d
> > > attribute is NOT updated, the signature validation succeeds with the =
old
> > > original signature.
> > >
> > > Update the super_block s_iflags to SB_I_IMA_UNVERIFIABLE_SIGNATURE to
> > > force signature reevaluation on every file access until a fine graine=
d
> > > solution can be found.
> > >
> >
> > Sorry for replying to the 6.4-stable patch, I couldn't find the origina=
l
> > patch in the mailing list.
> >
> > We recently upgraded from 6.4.4 to 6.5.3. We have the integrity LSM
> > enabled, and are using overlayfs. When we try and execute a binary from
> > the overlayfs filesystem, the integrity LSM hashes the binary and all
> > its shared objects every single invocation. This causes a serious
> > performance regression when invoking clang thousands of times while
> > building a package. We bisected the culprit down to this patch.
> >
> > Here are some numbers:
> >
> > With this patch + overlayfs:
> >
> >       $ time /usr/bin/clang-17 --version > /dev/null
> >
> >       real    0m0.628s
> >       user    0m0.004s
> >       sys     0m0.624s
> >       $ time /usr/bin/clang-17 --version > /dev/null
> >
> >       real    0m0.597s
> >       user    0m0.004s
> >       sys     0m0.593s
> >
> > With this patch - overlayfs:
> >
> >       $ truncate -s 1G foo.bin
> >       $ mkfs.ext4 foo.bin
> >       $ mount foo.bin /foo
> >       $ cp /usr/bin/clang-17 /foo
> >       $ time /foo/clang-17 --version > /dev/null
> >
> >       real    0m0.040s
> >       user    0m0.009s
> >       sys     0m0.031s
> >       $ time /foo/clang-17 --version > /dev/null
> >
> >       real    0m0.036s
> >       user    0m0.000s
> >       sys     0m0.037s
> >
> > Without this path + overlayfs:
> >       $ time /usr/bin/clang-17 --version > /dev/null
> >
> >       real    0m0.017s
> >       user    0m0.007s
> >       sys     0m0.011s
> >       $ time /usr/bin/clang-17 --version > /dev/null
> >
> >       real    0m0.018s
> >       user    0m0.000s
> >       sys     0m0.018s
> >
> > i.e., we go from ~30ms / invocation to 600ms / invocation. Building
> > glibc used to take about 3 minutes, but now its taking about 20 minutes=
.
> >
> > Our clang binary is about 100 MiB in size.
> >
> > Using `perf` the following sticks out:
> >       $ perf record -g time /usr/bin/clang-17 --version
> >       --92.03%--elf_map
> >             vm_mmap_pgoff
> >             ima_file_mmap
> >             process_measurement
> >             ima_collect_measurement
> >             |
> >              --91.95%--ima_calc_file_hash
> >                     ima_calc_file_hash_tfm
> >                     |
> >                     |--82.85%--_sha256_update
> >                     |     |
> >                     |      --82.47%--lib_sha256_base_do_update.isra.0
> >                     |           |
> >                     |            --82.39%--sha256_transform_rorx
> >                     |
> >                      --9.10%--integrity_kernel_read
> >
> > The audit.log is also logging every clang invocation as well.
> >
> > Was such a large performance regression expected? Can the commit be
> > reverted until the more fine grained solution mentioned in the commit
> > message be implemented?
>

First off, thanks for the quick reply. And I apologize in advance for
any naive questions. I'm still learning how the IMA system works.

> IMA is always based on policy.  Having the "integrity LSM enabled and
> using overlayfs" will not cause any measurements or signature
> verifications, unless the files are in policy.

Good point. The policy we have loaded is very similar to the one we
get from setting `ima_tcb`on the kernel command line. We just remove
the uid=3D0 constraint. i.e.,
```
# SECURITYFS_MAGIC
dont_measure fsmagic=3D0x73636673
# SELINUXFS_MAGIC
dont_measure fsmagic=3D0xf97cff8c
...
# audit files executed.
audit func=3DBPRM_CHECK
# audit executable libraries mmap'd.
audit func=3DFILE_MMAP mask=3DMAY_EXEC
# audit loaded kernel modules
audit func=3DMODULE_CHECK
```

We don't have any appraisal rules loaded.

>
> The problem is that unless the lower layer file is in policy, file
> change will not be detected on the overlay filesystem.  Reverting this
> change will allow access to a modified file without re-verifying its
> integrity.

Given our simple policy, I think the lower layer file is included in the
policy. So if I understand correctly, you are saying that this patch
was meant to address the case where the lower layer wasn't
covered by the policy?

>
> Instead of reverting the patch, perhaps allow users to take this risk
> by defining a Kconfig, since they're aware of their policy rules.
>

That sounds good. Or would it make sense to add an option to the
policy file? i.e., `verifiable fsmagic=3D0x794c7630`

FWIW, I also added the following to my policy file:
```
# OVERLAYFS_SUPER_MAGIC
dont_appraise fsmagic=3D0x794c7630
dont_measure fsmagic=3D0x794c7630
dont_hash fsmagic=3D0x794c7630
```

I didn't get any entries in my audit.log, but the hashing was still
performed. I figured since tmpfs and ramfs were already marked
as dont_measure, adding overlayfs shouldn't really be any
different.

Thanks again,
Raul

> --
> thanks,
>
> Mimi
>
