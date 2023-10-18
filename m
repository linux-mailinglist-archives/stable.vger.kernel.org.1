Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB137CE2D9
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjJRQf0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRQfZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 12:35:25 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D33AB
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 09:35:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49d0f24a815so3118003e0c.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697646919; x=1698251719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl/7EOsE+qKolAEw1eaMnzYR9djxxzkrTyT+pdY5BHo=;
        b=Oz4HPCT10/tC07tw27CrpwCVRlpPMF4yKHJP/HLKRdxk2rGWu0LOcWs7tGnZCltt7J
         erDyowg8HXM+KMHewvW/5x22Wn+8URLW31uMY83/UsMiad97/smT7gbHoEf4MIs/h9dc
         eQiLv3PEFiqElQdTdeL6G6inEBLcuQ03UHLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646919; x=1698251719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl/7EOsE+qKolAEw1eaMnzYR9djxxzkrTyT+pdY5BHo=;
        b=kPndHtsl3Wy3D8dwvv6wc/P+d98VARr69IeuLtufTw0VZcbZQmEqB3/77Yj2Uw1lda
         YgomoTjRptqlufP6/2qHTNDEzGePG8Rz6oPTKf9MBOBeO5tarntRckUJnT4vXXcR35ps
         I1mKGyM7DQvxoi4xhcbhPSPdHltL3vvBFj4ARfXSRIE1j9+OscfMgVHX/L/8dCELzNXH
         ag5dNpSnUSGi+g+srbBCb3wdXcm0+p4p8ypyryQXL4koZAtDWsjlriYxL+uxUJpZPL3F
         HFfRvafFkXBRw6tSACro8wuOdDlqf55xPfuDYHRbUmsrCCDCmhpaDPyEaT7M742woSgY
         zRog==
X-Gm-Message-State: AOJu0YxDgqwU0EIq6Y69TySfMO1+rqdQZAOYhtrUJJL/n49MSU+LxiCK
        D1rw0p4n5j21jzfZlrKBytAv0A5AY+w6SHCc2NM=
X-Google-Smtp-Source: AGHT+IGkyevofenDlycQZJgY+CA4svDDDb4yinrAXQ3KDgCWccw53eVU0fk/0LblBzo+Vx81TwJXuw==
X-Received: by 2002:a1f:17c6:0:b0:49d:b653:da31 with SMTP id 189-20020a1f17c6000000b0049db653da31mr5257584vkx.7.1697646919003;
        Wed, 18 Oct 2023 09:35:19 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id m22-20020a056122215600b0048720f093dbsm424974vkd.44.2023.10.18.09.35.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 09:35:17 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7b65004396fso2076163241.3
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 09:35:16 -0700 (PDT)
X-Received: by 2002:a05:6102:34eb:b0:457:e822:60e8 with SMTP id
 bi11-20020a05610234eb00b00457e82260e8mr6142210vsb.29.1697646916101; Wed, 18
 Oct 2023 09:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.286315610@linuxfoundation.org> <20230911134651.582204417@linuxfoundation.org>
 <ZS6xYa_kjRGvdCG6@google.com> <bd5d2f882e47b904802023d5d4d54d8d4755440e.camel@linux.ibm.com>
 <CAHQZ30A8R+EDGbrngMOQrXabR=DTHL3Y-1Tv+3RF98VHQ5b68Q@mail.gmail.com> <c9b7de507e26cb4e5111cdc76998f1dcd3c0957a.camel@linux.ibm.com>
In-Reply-To: <c9b7de507e26cb4e5111cdc76998f1dcd3c0957a.camel@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 18 Oct 2023 10:35:03 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BPUtNbQhxvUGMQWP3Ka4UxtaS_NUeK12jtdaheMq4EWw@mail.gmail.com>
Message-ID: <CAHQZ30BPUtNbQhxvUGMQWP3Ka4UxtaS_NUeK12jtdaheMq4EWw@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 9:03=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Tue, 2023-10-17 at 17:00 -0600, Raul Rangel wrote:
> > On Tue, Oct 17, 2023 at 12:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >
> > > On Tue, 2023-10-17 at 10:08 -0600, Raul E Rangel wrote:
> > > > On Mon, Sep 11, 2023 at 03:38:20PM +0200, Greg Kroah-Hartman wrote:
> > > > > 6.4-stable review patch.  If anyone has any objections, please le=
t me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Eric Snowberg <eric.snowberg@oracle.com>
> > > > >
> > > > > [ Upstream commit 18b44bc5a67275641fb26f2c54ba7eef80ac5950 ]
> > > > >
> > > > > Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_ver=
sion")
> > > > > partially closed an IMA integrity issue when directly modifying a=
 file
> > > > > on the lower filesystem.  If the overlay file is first opened by =
a user
> > > > > and later the lower backing file is modified by root, but the ext=
ended
> > > > > attribute is NOT updated, the signature validation succeeds with =
the old
> > > > > original signature.
> > > > >
> > > > > Update the super_block s_iflags to SB_I_IMA_UNVERIFIABLE_SIGNATUR=
E to
> > > > > force signature reevaluation on every file access until a fine gr=
ained
> > > > > solution can be found.
> > > > >
> > > >
> > > > Sorry for replying to the 6.4-stable patch, I couldn't find the ori=
ginal
> > > > patch in the mailing list.
> > > >
> > > > We recently upgraded from 6.4.4 to 6.5.3. We have the integrity LSM
> > > > enabled, and are using overlayfs. When we try and execute a binary =
from
> > > > the overlayfs filesystem, the integrity LSM hashes the binary and a=
ll
> > > > its shared objects every single invocation. This causes a serious
> > > > performance regression when invoking clang thousands of times while
> > > > building a package. We bisected the culprit down to this patch.
> > > >
> > > > Here are some numbers:
> > > >
> > > > With this patch + overlayfs:
> > > >
> > > >       $ time /usr/bin/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.628s
> > > >       user    0m0.004s
> > > >       sys     0m0.624s
> > > >       $ time /usr/bin/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.597s
> > > >       user    0m0.004s
> > > >       sys     0m0.593s
> > > >
> > > > With this patch - overlayfs:
> > > >
> > > >       $ truncate -s 1G foo.bin
> > > >       $ mkfs.ext4 foo.bin
> > > >       $ mount foo.bin /foo
> > > >       $ cp /usr/bin/clang-17 /foo
> > > >       $ time /foo/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.040s
> > > >       user    0m0.009s
> > > >       sys     0m0.031s
> > > >       $ time /foo/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.036s
> > > >       user    0m0.000s
> > > >       sys     0m0.037s
> > > >
> > > > Without this path + overlayfs:
> > > >       $ time /usr/bin/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.017s
> > > >       user    0m0.007s
> > > >       sys     0m0.011s
> > > >       $ time /usr/bin/clang-17 --version > /dev/null
> > > >
> > > >       real    0m0.018s
> > > >       user    0m0.000s
> > > >       sys     0m0.018s
> > > >
> > > > i.e., we go from ~30ms / invocation to 600ms / invocation. Building
> > > > glibc used to take about 3 minutes, but now its taking about 20 min=
utes.
> > > >
> > > > Our clang binary is about 100 MiB in size.
> > > >
> > > > Using `perf` the following sticks out:
> > > >       $ perf record -g time /usr/bin/clang-17 --version
> > > >       --92.03%--elf_map
> > > >             vm_mmap_pgoff
> > > >             ima_file_mmap
> > > >             process_measurement
> > > >             ima_collect_measurement
> > > >             |
> > > >              --91.95%--ima_calc_file_hash
> > > >                     ima_calc_file_hash_tfm
> > > >                     |
> > > >                     |--82.85%--_sha256_update
> > > >                     |     |
> > > >                     |      --82.47%--lib_sha256_base_do_update.isra=
.0
> > > >                     |           |
> > > >                     |            --82.39%--sha256_transform_rorx
> > > >                     |
> > > >                      --9.10%--integrity_kernel_read
> > > >
> > > > The audit.log is also logging every clang invocation as well.
> > > >
> > > > Was such a large performance regression expected? Can the commit be
> > > > reverted until the more fine grained solution mentioned in the comm=
it
> > > > message be implemented?
> > >
> >
> > First off, thanks for the quick reply. And I apologize in advance for
> > any naive questions. I'm still learning how the IMA system works.
> >
> > > IMA is always based on policy.  Having the "integrity LSM enabled and
> > > using overlayfs" will not cause any measurements or signature
> > > verifications, unless the files are in policy.
> >
> > Good point. The policy we have loaded is very similar to the one we
> > get from setting `ima_tcb`on the kernel command line. We just remove
> > the uid=3D0 constraint. i.e.,
> > ```
> > # SECURITYFS_MAGIC
> > dont_measure fsmagic=3D0x73636673
> > # SELINUXFS_MAGIC
> > dont_measure fsmagic=3D0xf97cff8c
> > ...
>
> The following are new rules:
>
> > # audit files executed.
> > audit func=3DBPRM_CHECK
> > # audit executable libraries mmap'd.
> > audit func=3DFILE_MMAP mask=3DMAY_EXEC
> > # audit loaded kernel modules
> > audit func=3DMODULE_CHECK
> > ```
> >
> > We don't have any appraisal rules loaded.
>
> Okay.  The appraisal result of the overlay file is being cached and not
> cleared on file change of the lower file.
>
> > >
> > > The problem is that unless the lower layer file is in policy, file
> > > change will not be detected on the overlay filesystem.  Reverting thi=
s
> > > change will allow access to a modified file without re-verifying its
> > > integrity.
> >
> > Given our simple policy, I think the lower layer file is included in th=
e
> > policy. So if I understand correctly, you are saying that this patch
> > was meant to address the case where the lower layer wasn't
> > covered by the policy?
>
> Yes
>
> > >
> > > Instead of reverting the patch, perhaps allow users to take this risk
> > > by defining a Kconfig, since they're aware of their policy rules.
> > >
> >
> > That sounds good. Or would it make sense to add an option to the
> > policy file? i.e., `verifiable fsmagic=3D0x794c7630
>
> Perhaps instead of introducing a new "action" (measure/dont_measure,
> appraise/dont_appraise, audit), it should be more granular at the
> policy rule level.
> Something like ignore_cache/dont_ignore_cache, depending on the
> default.
>
> Eric, does that make sense?

I guess if one of the lower layers was a tmpfs that no longer holds.
Can overlayfs determine if the lower file is covered by a policy
before setting the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag? This way the
policy writer doesn't need to get involved with the specifics of how
the overlayfs layers are constructed.

In the original commit message it was mentioned that there was a more
fine grained approach. If that's in the pipeline, maybe it makes sense
to just wait for that instead of adding a new keyword? We just revered
this patch internally to avoid the performance penalty, but we don't
want to carry this patch indefinitely.

>
> > FWIW, I also added the following to my policy file:
> > ```
> > # OVERLAYFS_SUPER_MAGIC
> > dont_appraise fsmagic=3D0x794c7630
> > dont_measure fsmagic=3D0x794c7630
> > dont_hash fsmagic=3D0x794c7630
> > ```
> >
> > I didn't get any entries in my audit.log, but the hashing was still
> > performed. I figured since tmpfs and ramfs were already marked
> > as dont_measure, adding overlayfs shouldn't really be any
> > different.
>
> If you're using a modified "ima_tcb" there are "measure" action rules
> which would cause files to be re-measured.  Look at the IMA measurement
> list.

Oh, I assumed `audit` =3D=3D `MEASURE`, so I was thinking that
`dont_measure` would negate it. Thanks for that clarification.

>
> If you're only accessing files via the overlayfs and not the lower
> layer, then there wouldn't be any audit records.
>
> Mimi
>

Thanks,
Raul
