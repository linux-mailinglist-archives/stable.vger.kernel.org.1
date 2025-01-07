Return-Path: <stable+bounces-107869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0772A04530
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7B71887B4E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F131F0E2A;
	Tue,  7 Jan 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIFu+Qud"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF961EE7BB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265162; cv=none; b=kZn95TMa56o+utwfcQCzZbRmnZ7bhZBEENYJ/ZlvfeIvvEDI2dup8mLy1Umbyd3KOXb4TvwnkU3KUW6V3CDiOrPKHyHsHq5Gd2icpzqUfzw+Uc8z0DLYWcriohw8I+SRQdgTzzbVeHsTQt5UDupajHHDU2+D3AV0pT4dq2eCJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265162; c=relaxed/simple;
	bh=Y3K6VnkTj0agsEpHyH49R+8Yy718tcYTrz5OV5nifrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkOTO1lN3ErpMTkRQGPYNpHqK4rjewobYaseOWTQOlXp1Nl/4AAhrdZBhf+bUfsqFbfq0EeHJn2VUn6ckPyQ1chgzR5mP2K9+hsMqI6XuTYnqUu+h723EwzRouIReAKpyCnty1rCsgW4oYt0iFOU7Zc3ose9+WxnIz1uK9uKx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIFu+Qud; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso18769546a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736265158; x=1736869958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5akAFf1ZPesAMt6W0eaVJbcjKXPbLry7I/lEXkZAboA=;
        b=DIFu+Qud2IoKpTGnM53QzSLR8LAg+V6CThWAbhKVEm+OLL/3bOCGQa0NlGIYZH+r/1
         cJTYOjzK0sioUR2Uq2iYaI9hOrzmzTjsUJEmrQazh3pjeFoIZRYU1pYUlB61RK7mqzT1
         kC2dWOJdhh5QLsIbBns8IVRPulm3rOylsvpQjbZLKMX4+DMOzQWJPrVe43mTu5JQCE3A
         LoVghHZ8n6h0PKlKo2aDQSZD8WrUA0vNVopvodoAgeymKQyEadj96/PUEQ59g4K9l4wf
         8Y+FpZfshRXLny46mrwZR1PPBjzyBC1Qm20v1qx9nRjfiUV7yRMyO35sVUCOauQIEFtB
         Pe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736265158; x=1736869958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5akAFf1ZPesAMt6W0eaVJbcjKXPbLry7I/lEXkZAboA=;
        b=DmhVYpYDhgkrzTVi5X9ywfTkAEjvicgNxjF0FVKMPSGKufxDdb1rW03pmbHcZECNgx
         0katxYJJv9oVEKJkl1DTdtKU2bKTvMZj7J5/jYr8BkjMBf7A25qB7N587bi6bdSIjjvO
         eBfQjYD8/JZUF/gX5xTEDa1svNa/TaRxOiHEoFqcgaus5uuimqMtqYYPH1Cg1J4IAiQv
         qX1SPXsIF8inc/Qbru+puPqLuZSg52OQwZl9txNyYXXh/BBlTsA+PypNsx/OC/o3xMDW
         i28bL71chXVHL3HvpAPQSdoVXqGRPudNEvDEBovS7rxplQ7EQkAa2k2AcSCBfPqm0zuR
         jP8g==
X-Gm-Message-State: AOJu0Yy60z5PM6OTr/otrzCooR/gSyA3qtaPivm5wbn91yD9eLW7D9eb
	FKkXwrykb5TLq93uY3m5NDStdMIosZ2QrC4IHqsivISYnsNcNIu+fDLckVBHs/CYj89SS37T5dQ
	NI7n9nIyCp1925Ei16YPJyzMUP+LlpPEe
X-Gm-Gg: ASbGncvM3dk7zxIzo5ugpLREJUCYIyauSkRtWhVKMbfYdNmSVpM4KUmArVK4o/IeKnF
	PKxO5+rJVKfq3pqx5TpCu1XeMw9Y2WJwU1Q1x+A==
X-Google-Smtp-Source: AGHT+IH1MJiukfAycq+hK/y+HEGZQSzQHUwwsUw+2RmnbE5MF9cXH6e29VZImIdEQGJyw1Y4KMMtUvA/kp6Z7oPQwDk=
X-Received: by 2002:a17:90b:37c3:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f452e2fe28mr96830234a91.16.1736265158427; Tue, 07 Jan 2025
 07:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151155.069105214@linuxfoundation.org>
 <CAOi1vP9_s3oW8XP6bytvKm3JocPO0-odkv9LQFuuEU==JBgfaw@mail.gmail.com> <2025010737-fancy-blurb-f510@gregkh>
In-Reply-To: <2025010737-fancy-blurb-f510@gregkh>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 7 Jan 2025 16:52:26 +0100
Message-ID: <CAOi1vP-aoU4mSvVm8OsLozka3=-S_LqroU9VAgZY-ptdrGZ+GA@mail.gmail.com>
Subject: Re: [PATCH 6.6 118/222] ceph: print cluster fsid and client global_id
 in all debug logs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Xiubo Li <xiubli@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Milind Changire <mchangir@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 07, 2025 at 01:21:12PM +0100, Ilya Dryomov wrote:
> > On Mon, Jan 6, 2025 at 4:28=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let me=
 know.
> > >
> > > ------------------
> > >
> > > From: Xiubo Li <xiubli@redhat.com>
> > >
> > > [ Upstream commit 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ]
> > >
> > > Multiple CephFS mounts on a host is increasingly common so
> > > disambiguating messages like this is necessary and will make it easie=
r
> > > to debug issues.
> > >
> > > At the same this will improve the debug logs to make them easier to
> > > troubleshooting issues, such as print the ino# instead only printing
> > > the memory addresses of the corresponding inodes and print the dentry
> > > names instead of the corresponding memory addresses for the dentry,et=
c.
> > >
> > > Link: https://tracker.ceph.com/issues/61590
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
> > > Reviewed-by: Milind Changire <mchangir@redhat.com>
> > > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > > Stable-dep-of: 550f7ca98ee0 ("ceph: give up on paths longer than PATH=
_MAX")
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  fs/ceph/acl.c        |   6 +-
> > >  fs/ceph/addr.c       | 279 +++++++++--------
> > >  fs/ceph/caps.c       | 710 +++++++++++++++++++++++++----------------=
--
> > >  fs/ceph/crypto.c     |  39 ++-
> > >  fs/ceph/debugfs.c    |   6 +-
> > >  fs/ceph/dir.c        | 218 +++++++------
> > >  fs/ceph/export.c     |  39 +--
> > >  fs/ceph/file.c       | 245 ++++++++-------
> > >  fs/ceph/inode.c      | 485 ++++++++++++++++-------------
> > >  fs/ceph/ioctl.c      |  13 +-
> > >  fs/ceph/locks.c      |  57 ++--
> > >  fs/ceph/mds_client.c | 558 +++++++++++++++++++---------------
> > >  fs/ceph/mdsmap.c     |  24 +-
> > >  fs/ceph/metric.c     |   5 +-
> > >  fs/ceph/quota.c      |  29 +-
> > >  fs/ceph/snap.c       | 174 ++++++-----
> > >  fs/ceph/super.c      |  70 +++--
> > >  fs/ceph/super.h      |   6 +
> > >  fs/ceph/xattr.c      |  96 +++---
> > >  19 files changed, 1747 insertions(+), 1312 deletions(-)
> >
> > Hi Greg,
> >
> > This is a huge patch, albeit mostly mechanical.  Commit 550f7ca98ee0
> > ("ceph: give up on paths longer than PATH_MAX") for which this patch is
> > a dependency just removes the affected log message, so it could be
> > backported with a trivial conflict resolution instead of taking in
> > 5c5f0d2b5f92 ("libceph: add doutc and *_client debug macros support")
> > and 38d46409c463 ("ceph: print cluster fsid and client global_id in all
> > debug logs") to arrange for a "clean" backport.
> >
>
> Great, can you send such a backport?

Sure, you should have one for 5.10-6.1 and a separate one for 6.6 in
your inbox now.

>
> > Were these cherry picks done in an automated fashion by a tool that
> > tries to identify and pull prerequisite patches based on "git blame"
> > output?
>
> Yes.
>
> > The result appears to go against the rules laid out in
> > Documentation/process/stable-kernel-rules.rst (particularly the limit
> > on the number of lines), so I wanted to clarify the expected workflow
> > of the stable team in this area.  Are "clean" backports considered to
> > justify additional prerequisite patches of this size even when the
> > conflict resolution is "take ours" or otherwise trivial?
>
> Yes.  Keeping the tree in sync is almost always preferred over "one-off"
> changes that have to be hand-provided, when the maintainer is not
> involved to ensure that we don't break anything.  But if you want to

In this case this lead to pulling in

  1 file changed, 38 insertions(+)

and

  19 files changed, 1747 insertions(+), 1312 deletions(-)

patches as dependencies to satisfy the backport of

  1 file changed, 4 insertions(+), 5 deletions(-)

patch.  Is this OK given that stable-kernel-rules.rst still has "It
cannot be bigger than 100 lines, with context." as one of the rules for
what kind of patches are accepted?

Thanks,

                Ilya

