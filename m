Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B67A4513
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjIRIof (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbjIRInu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 04:43:50 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD6910E
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 01:43:21 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5739972accdso2856403eaf.1
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695026600; x=1695631400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZcC6454SXkCoFbPwkl3+gaRjC+6aJtJVnc/n+zS+3Y=;
        b=WOEe8VZYJfDttg8wMEq6jkof91WaDb4jJ46uO77vP1shPW7WvjRPm38riZODN4/8QV
         HszEMPhsCRU1xsMdyamvH2bxI0KRW/+1kVwNvffriQgPLEOsMW7pO3dXTUSe75DJx5L3
         dK8gMpHJ7CHzIoprflkCvl4uMtFUYdv6PRndGktDZwuJdMWEawPcaMBU+CVTkONx5Oai
         e3b/tQgPJQF76RjPIdH6yccu6ufnWrct/j1MMs3VjrCodUeuLoMsAUj14aK5/uurW6b0
         uqMFgm8qpQ/QKJbW0P0DjTo/w9kHUiOcT0iil9LdXL/WPpIqMehEwrPMOBQttf8swAYw
         /KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026600; x=1695631400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZcC6454SXkCoFbPwkl3+gaRjC+6aJtJVnc/n+zS+3Y=;
        b=dt0ER5ax+7Pf+gj9yDagPChLwMICfml24SZw4GaRp1sTnFTJkaBI8jt6xiTsiFUU9O
         076fhxQ7hMdXTnu/S/iQiSEQWBqbV9F2tapQ7EFEfkSLVN2LZBzZzDLTs43YUnEGGkis
         mFgPXHZH3Yzqn4g/tNwn1QetLs0PkuDLtMknzvnnN0G3WWXbVM3Ff8Xk8mTTZxAVm/De
         XZilBcynseq3iqM3HGE42Za2GyDYg2Z9PPs34w0ndJQPo13gIMG7DG+2mJszbYoTkow1
         ecO8M2McU9ji3n493sU0c+b9alLP+8cKUa/1Lztc41qMDlWCBtx9djiQnVt9Ry8zBfvg
         b/AQ==
X-Gm-Message-State: AOJu0YykgjOfIyvGTLHboGcUnoD4oPYkiJshS32gQKyhvghxOUBykxpn
        oiV0BHNdSmz7G1mwezxEE0br8+uiGyhbk15l6fhg3sNiqYU=
X-Google-Smtp-Source: AGHT+IEF2VoWcipTFMyJYQPN4Bn6tZtdzp2rsgL0ehDOFmvx58yi3mS5IXBaa3pjK080NAu73wGp8F9ktUi3fIbnRSA=
X-Received: by 2002:a05:6870:9f85:b0:1d6:63b4:ddfe with SMTP id
 xm5-20020a0568709f8500b001d663b4ddfemr4970867oab.27.1695026600464; Mon, 18
 Sep 2023 01:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191051.639202302@linuxfoundation.org> <20230917191055.579497834@linuxfoundation.org>
 <CAOi1vP9Mh02NB4-n5Wy3Zs1Y8M33qJsZzd12Y6k991jubQVzwQ@mail.gmail.com> <90c74084-d3dc-e1cf-0d9a-a244529f7779@redhat.com>
In-Reply-To: <90c74084-d3dc-e1cf-0d9a-a244529f7779@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 18 Sep 2023 10:43:08 +0200
Message-ID: <CAOi1vP9UU+GHn+rygfNgCdFMBCdgbB4h6FkzBOA56j9CesHBXA@mail.gmail.com>
Subject: Re: [PATCH 6.5 113/285] ceph: make members in struct
 ceph_mds_request_args_ext a union
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Milind Changire <mchangir@redhat.com>,
        Sasha Levin <sashal@kernel.org>
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

On Mon, Sep 18, 2023 at 10:20=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote=
:
>
>
> On 9/18/23 16:04, Ilya Dryomov wrote:
> > On Sun, Sep 17, 2023 at 9:49=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> 6.5-stable review patch.  If anyone has any objections, please let me =
know.
> >>
> >> ------------------
> >>
> >> From: Xiubo Li <xiubli@redhat.com>
> >>
> >> [ Upstream commit 3af5ae22030cb59fab4fba35f5a2b62f47e14df9 ]
> >>
> >> In ceph mainline it will allow to set the btime in the setattr request
> >> and just add a 'btime' member in the union 'ceph_mds_request_args' and
> >> then bump up the header version to 4. That means the total size of uni=
on
> >> 'ceph_mds_request_args' will increase sizeof(struct ceph_timespec) byt=
es,
> >> but in kclient it will increase the sizeof(setattr_ext) bytes for each
> >> request.
> >>
> >> Since the MDS will always depend on the header's vesion and front_len
> >> members to decode the 'ceph_mds_request_head' struct, at the same time
> >> kclient hasn't supported the 'btime' feature yet in setattr request,
> >> so it's safe to do this change here.
> >>
> >> This will save 48 bytes memories for each request.
> >>
> >> Fixes: 4f1ddb1ea874 ("ceph: implement updated ceph_mds_request_head st=
ructure")
> >> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> >> Reviewed-by: Milind Changire <mchangir@redhat.com>
> >> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >>   include/linux/ceph/ceph_fs.h | 24 +++++++++++++-----------
> >>   1 file changed, 13 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs=
.h
> >> index 49586ff261520..b4fa2a25b7d95 100644
> >> --- a/include/linux/ceph/ceph_fs.h
> >> +++ b/include/linux/ceph/ceph_fs.h
> >> @@ -462,17 +462,19 @@ union ceph_mds_request_args {
> >>   } __attribute__ ((packed));
> >>
> >>   union ceph_mds_request_args_ext {
> >> -       union ceph_mds_request_args old;
> >> -       struct {
> >> -               __le32 mode;
> >> -               __le32 uid;
> >> -               __le32 gid;
> >> -               struct ceph_timespec mtime;
> >> -               struct ceph_timespec atime;
> >> -               __le64 size, old_size;       /* old_size needed by tru=
ncate */
> >> -               __le32 mask;                 /* CEPH_SETATTR_* */
> >> -               struct ceph_timespec btime;
> >> -       } __attribute__ ((packed)) setattr_ext;
> >> +       union {
> >> +               union ceph_mds_request_args old;
> >> +               struct {
> >> +                       __le32 mode;
> >> +                       __le32 uid;
> >> +                       __le32 gid;
> >> +                       struct ceph_timespec mtime;
> >> +                       struct ceph_timespec atime;
> >> +                       __le64 size, old_size;       /* old_size neede=
d by truncate */
> >> +                       __le32 mask;                 /* CEPH_SETATTR_*=
 */
> >> +                       struct ceph_timespec btime;
> >> +               } __attribute__ ((packed)) setattr_ext;
> >> +       };
> > Hi Xiubo,
> >
> > I was going to ask whether it makes sense to backport this change, but,
> > after looking at it, the change seems bogus to me even in mainline.  Yo=
u
> > added a union inside siting memory use but ceph_mds_request_args_ext wa=
s
> > already a union before:
> >
> >      union ceph_mds_request_args_ext {
> >          union ceph_mds_request_args old;
> >          struct { ... } __attribute__ ((packed)) setattr_ext;
> >      }
> >
> > What is being achieved here?
>
> As I remembered there has other changes in this union in the beginning.
> And that patch seems being abandoned and missing this one.
>
> Let's skip backporting this one and in the upstream just revert it.

OK, I will send a revert to ceph-devel list.

Greg, please drop this one from all stable branches.

Thanks,

                Ilya
