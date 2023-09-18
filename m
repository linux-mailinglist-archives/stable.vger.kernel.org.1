Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6A7A45D2
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjIRJYc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 05:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjIRJYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 05:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B97D3
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 02:24:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A280C433C8;
        Mon, 18 Sep 2023 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695029039;
        bh=llZZQL/PdWEgNFjxTV9qwEIAzivsRdBxp4Q040xeUrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duFVSpsv4dn4noctJQvV+jtXcpWNBq/lCSucxpLOUMZ/daHY/V6lKQowvjPLf/4pI
         QTypfxPKZNWRpvwCuj8/30p0qhieHbVF1fJM/YdqjQwU6hmPNE+Cvr4YYxS86U7G8N
         /DN/M4eTwMstYy96rxCPfsvi5DbVT4reUJ54hDfY=
Date:   Mon, 18 Sep 2023 11:23:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Xiubo Li <xiubli@redhat.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, Milind Changire <mchangir@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 113/285] ceph: make members in struct
 ceph_mds_request_args_ext a union
Message-ID: <2023091848-spiritual-foyer-7ce6@gregkh>
References: <20230917191051.639202302@linuxfoundation.org>
 <20230917191055.579497834@linuxfoundation.org>
 <CAOi1vP9Mh02NB4-n5Wy3Zs1Y8M33qJsZzd12Y6k991jubQVzwQ@mail.gmail.com>
 <90c74084-d3dc-e1cf-0d9a-a244529f7779@redhat.com>
 <CAOi1vP9UU+GHn+rygfNgCdFMBCdgbB4h6FkzBOA56j9CesHBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP9UU+GHn+rygfNgCdFMBCdgbB4h6FkzBOA56j9CesHBXA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 10:43:08AM +0200, Ilya Dryomov wrote:
> On Mon, Sep 18, 2023 at 10:20 AM Xiubo Li <xiubli@redhat.com> wrote:
> >
> >
> > On 9/18/23 16:04, Ilya Dryomov wrote:
> > > On Sun, Sep 17, 2023 at 9:49 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >> 6.5-stable review patch.  If anyone has any objections, please let me know.
> > >>
> > >> ------------------
> > >>
> > >> From: Xiubo Li <xiubli@redhat.com>
> > >>
> > >> [ Upstream commit 3af5ae22030cb59fab4fba35f5a2b62f47e14df9 ]
> > >>
> > >> In ceph mainline it will allow to set the btime in the setattr request
> > >> and just add a 'btime' member in the union 'ceph_mds_request_args' and
> > >> then bump up the header version to 4. That means the total size of union
> > >> 'ceph_mds_request_args' will increase sizeof(struct ceph_timespec) bytes,
> > >> but in kclient it will increase the sizeof(setattr_ext) bytes for each
> > >> request.
> > >>
> > >> Since the MDS will always depend on the header's vesion and front_len
> > >> members to decode the 'ceph_mds_request_head' struct, at the same time
> > >> kclient hasn't supported the 'btime' feature yet in setattr request,
> > >> so it's safe to do this change here.
> > >>
> > >> This will save 48 bytes memories for each request.
> > >>
> > >> Fixes: 4f1ddb1ea874 ("ceph: implement updated ceph_mds_request_head structure")
> > >> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > >> Reviewed-by: Milind Changire <mchangir@redhat.com>
> > >> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >> ---
> > >>   include/linux/ceph/ceph_fs.h | 24 +++++++++++++-----------
> > >>   1 file changed, 13 insertions(+), 11 deletions(-)
> > >>
> > >> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> > >> index 49586ff261520..b4fa2a25b7d95 100644
> > >> --- a/include/linux/ceph/ceph_fs.h
> > >> +++ b/include/linux/ceph/ceph_fs.h
> > >> @@ -462,17 +462,19 @@ union ceph_mds_request_args {
> > >>   } __attribute__ ((packed));
> > >>
> > >>   union ceph_mds_request_args_ext {
> > >> -       union ceph_mds_request_args old;
> > >> -       struct {
> > >> -               __le32 mode;
> > >> -               __le32 uid;
> > >> -               __le32 gid;
> > >> -               struct ceph_timespec mtime;
> > >> -               struct ceph_timespec atime;
> > >> -               __le64 size, old_size;       /* old_size needed by truncate */
> > >> -               __le32 mask;                 /* CEPH_SETATTR_* */
> > >> -               struct ceph_timespec btime;
> > >> -       } __attribute__ ((packed)) setattr_ext;
> > >> +       union {
> > >> +               union ceph_mds_request_args old;
> > >> +               struct {
> > >> +                       __le32 mode;
> > >> +                       __le32 uid;
> > >> +                       __le32 gid;
> > >> +                       struct ceph_timespec mtime;
> > >> +                       struct ceph_timespec atime;
> > >> +                       __le64 size, old_size;       /* old_size needed by truncate */
> > >> +                       __le32 mask;                 /* CEPH_SETATTR_* */
> > >> +                       struct ceph_timespec btime;
> > >> +               } __attribute__ ((packed)) setattr_ext;
> > >> +       };
> > > Hi Xiubo,
> > >
> > > I was going to ask whether it makes sense to backport this change, but,
> > > after looking at it, the change seems bogus to me even in mainline.  You
> > > added a union inside siting memory use but ceph_mds_request_args_ext was
> > > already a union before:
> > >
> > >      union ceph_mds_request_args_ext {
> > >          union ceph_mds_request_args old;
> > >          struct { ... } __attribute__ ((packed)) setattr_ext;
> > >      }
> > >
> > > What is being achieved here?
> >
> > As I remembered there has other changes in this union in the beginning.
> > And that patch seems being abandoned and missing this one.
> >
> > Let's skip backporting this one and in the upstream just revert it.
> 
> OK, I will send a revert to ceph-devel list.
> 
> Greg, please drop this one from all stable branches.

Now dropped, thanks.

greg k-h
