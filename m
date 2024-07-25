Return-Path: <stable+bounces-61343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4393BBD6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 06:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882E01C22724
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C418633;
	Thu, 25 Jul 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ustwsp2Y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9914A82
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883146; cv=none; b=VUtiR98vMgPGILqwzFt3feXrO3+X5idf4pLBVu0dBkEgqz2LCbOMy4RfgT43Hqkfvje7ggojTHKxxuov3CQxhbTnKl72V3bqfbko9GHEb4nHv+UjIAzBzH5mVXnwDTo6RhAG8cRvK6ScvLgKfuD/rXckr32WhNTiWHs2dT+v4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883146; c=relaxed/simple;
	bh=mL/nyKmujwn6YkWjBZNMcJIZOibTKy6k6+4CnXS3WAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HufAC38PnEfM9YETdcgZ4PpWSguMgJxxUoQDwhRZSbnGG2dcQiTDhm6XKSJS5zlsNqNCSvAXtOlSylDxWQbXOHWj2D+jgFtgDILjYMQuRq0gGHs2osUkq3zzmjEU6T+UOchGRM7IsCaV8mfIsNSx24UWJTvdUMwhFsTRrcmbUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ustwsp2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721883143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+b9QnXA6/oecn6EgMexQdtInvSuvypLufcCpqhW1tU=;
	b=Ustwsp2YKQyDddXAvTHBkiGEc5I9npI9t/lfL4sL/dlvuqcgEC1Ua/uwVBFUQgmfZXetr0
	vr4w/+cMZeGBWgACOzTOLibFyQOmvej5KR0/Et/O5I8SALHv/qnstdvJu5WvVpGJTtkHem
	hW9EczONOd1TkRdZ0cmndrb9SI9+2Eo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ibieCJPJN6ap4Zu9IHPaUQ-1; Thu, 25 Jul 2024 00:52:21 -0400
X-MC-Unique: ibieCJPJN6ap4Zu9IHPaUQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa26f342cso13122066b.1
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 21:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883140; x=1722487940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+b9QnXA6/oecn6EgMexQdtInvSuvypLufcCpqhW1tU=;
        b=fVY4CHArLiNYjFyY68juHrNnJoD5NBx3AIzbdeSZZ3RBUmy4f2ku4ekpb2bn+alHPU
         4F+niGLbdrbhcByoBaK1Pl/X7LdlsZiPOD/dxUZDLc7FFA79InHGEEr/TuMaQOYQPYKf
         VUKxfkcejqsw96bC0PxW6x6vALVxLRAhZgjql0xUvMbmNz7Y4KF1hjCfp2WWRaK+nR4Z
         m0SZDignXzt7fLIY/cN69JNdKLg7NNDEcG6syKT1/LF1eUDHgkI1DLkkXHuTp4dhr85E
         OvjcZrU09IMGHkI5IsmohIMk9cBFEvnNCPid1+TSeFPYvO+gMgaexkULWqSgcIc4zVlu
         BBYg==
X-Forwarded-Encrypted: i=1; AJvYcCW023z2prMT7rXyIVMJo5zOrdDA7eYMjNGhoUUOCGZv/QFD2jp9fDCKDGQdn0ZiycRMTl7ETDyAQvPrMHo7yqKeOc6RzI8Q
X-Gm-Message-State: AOJu0YwlL6uCzMbVoH9yj89bzdXON0TTfI8SJR9EGuIlHpOTU6gHNjLX
	DnDP9QIhbhJp1DJsSvo/77Pcby7oLcu6sMJ6Yvj7ccc2UW9d53Uz2X9tHgsKXgPSNPHGgYEqM7s
	KIQnFqzsL+NZtXfHUOeFFuuCjYskzhp99mM0EgIQvSOnuLgLT6fhUUiAqppzEOWhuD5j5X24f5Y
	A2bySSGD2qyz/Ok1sI8rmPkomMM7VA
X-Received: by 2002:a17:907:1c23:b0:a6f:4fc8:2666 with SMTP id a640c23a62f3a-a7ac52e0aedmr119402166b.44.1721883140447;
        Wed, 24 Jul 2024 21:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSfx3SLfS+WYvE6/Mk8MopVY/M652NJELZ9bSlD9ZLMvQoA6gNNxq2qDvK0DzS6IyAPi8OsYGBrQxqVOTB3VA=
X-Received: by 2002:a17:907:1c23:b0:a6f:4fc8:2666 with SMTP id
 a640c23a62f3a-a7ac52e0aedmr119400966b.44.1721883140009; Wed, 24 Jul 2024
 21:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716120724.134512-1-xiubli@redhat.com> <CACPzV1kqN49AW4ihgd0yDvmaujMWKr+4B7tonnUpn=dPPs6Nhw@mail.gmail.com>
 <dac1bb9f-c544-4c56-b1eb-b565a6405f76@redhat.com>
In-Reply-To: <dac1bb9f-c544-4c56-b1eb-b565a6405f76@redhat.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Thu, 25 Jul 2024 10:21:42 +0530
Message-ID: <CACPzV1=jOYoqpRrZ+Si2bBMrQ23nWN_hJbxsRLxPpRr9NOL2fg@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: force sending a cap update msg back to MDS for
 revoke op
To: Xiubo Li <xiubli@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:31=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 7/24/24 22:08, Venky Shankar wrote:
> > Hi Xiubo,
> >
> > On Tue, Jul 16, 2024 at 5:37=E2=80=AFPM <xiubli@redhat.com> wrote:
> >> From: Xiubo Li <xiubli@redhat.com>
> >>
> >> If a client sends out a cap update dropping caps with the prior 'seq'
> >> just before an incoming cap revoke request, then the client may drop
> >> the revoke because it believes it's already released the requested
> >> capabilities.
> >>
> >> This causes the MDS to wait indefinitely for the client to respond
> >> to the revoke. It's therefore always a good idea to ack the cap
> >> revoke request with the bumped up 'seq'.
> >>
> >> Currently if the cap->issued equals to the newcaps the check_caps()
> >> will do nothing, we should force flush the caps.
> >>
> >> Cc: stable@vger.kernel.org
> >> Link: https://tracker.ceph.com/issues/61782
> >> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> >> ---
> >>
> >> V3:
> >> - Move the force check earlier
> >>
> >> V2:
> >> - Improved the patch to force send the cap update only when no caps
> >> being used.
> >>
> >>
> >>   fs/ceph/caps.c  | 35 ++++++++++++++++++++++++-----------
> >>   fs/ceph/super.h |  7 ++++---
> >>   2 files changed, 28 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> >> index 24c31f795938..672c6611d749 100644
> >> --- a/fs/ceph/caps.c
> >> +++ b/fs/ceph/caps.c
> >> @@ -2024,6 +2024,8 @@ bool __ceph_should_report_size(struct ceph_inode=
_info *ci)
> >>    *  CHECK_CAPS_AUTHONLY - we should only check the auth cap
> >>    *  CHECK_CAPS_FLUSH - we should flush any dirty caps immediately, w=
ithout
> >>    *    further delay.
> >> + *  CHECK_CAPS_FLUSH_FORCE - we should flush any caps immediately, wi=
thout
> >> + *    further delay.
> >>    */
> >>   void ceph_check_caps(struct ceph_inode_info *ci, int flags)
> >>   {
> >> @@ -2105,7 +2107,7 @@ void ceph_check_caps(struct ceph_inode_info *ci,=
 int flags)
> >>          }
> >>
> >>          doutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
> >> -             "flushing %s issued %s revoking %s retain %s %s%s%s\n",
> >> +             "flushing %s issued %s revoking %s retain %s %s%s%s%s\n"=
,
> >>               inode, ceph_vinop(inode), ceph_cap_string(file_wanted),
> >>               ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps)=
,
> >>               ceph_cap_string(ci->i_flushing_caps),
> >> @@ -2113,7 +2115,8 @@ void ceph_check_caps(struct ceph_inode_info *ci,=
 int flags)
> >>               ceph_cap_string(retain),
> >>               (flags & CHECK_CAPS_AUTHONLY) ? " AUTHONLY" : "",
> >>               (flags & CHECK_CAPS_FLUSH) ? " FLUSH" : "",
> >> -            (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "");
> >> +            (flags & CHECK_CAPS_NOINVAL) ? " NOINVAL" : "",
> >> +            (flags & CHECK_CAPS_FLUSH_FORCE) ? " FLUSH_FORCE" : "");
> >>
> >>          /*
> >>           * If we no longer need to hold onto old our caps, and we may
> >> @@ -2188,6 +2191,11 @@ void ceph_check_caps(struct ceph_inode_info *ci=
, int flags)
> >>                                  queue_writeback =3D true;
> >>                  }
> >>
> >> +               if (flags & CHECK_CAPS_FLUSH_FORCE) {
> >> +                       doutc(cl, "force to flush caps\n");
> >> +                       goto ack;
> >> +               }
> >> +
> >>                  if (cap =3D=3D ci->i_auth_cap &&
> >>                      (cap->issued & CEPH_CAP_FILE_WR)) {
> >>                          /* request larger max_size from MDS? */
> >> @@ -3518,6 +3526,8 @@ static void handle_cap_grant(struct inode *inode=
,
> >>          bool queue_invalidate =3D false;
> >>          bool deleted_inode =3D false;
> >>          bool fill_inline =3D false;
> >> +       bool revoke_wait =3D false;
> >> +       int flags =3D 0;
> >>
> >>          /*
> >>           * If there is at least one crypto block then we'll trust
> >> @@ -3713,16 +3723,18 @@ static void handle_cap_grant(struct inode *ino=
de,
> >>                        ceph_cap_string(cap->issued), ceph_cap_string(n=
ewcaps),
> >>                        ceph_cap_string(revoking));
> >>                  if (S_ISREG(inode->i_mode) &&
> >> -                   (revoking & used & CEPH_CAP_FILE_BUFFER))
> >> +                   (revoking & used & CEPH_CAP_FILE_BUFFER)) {
> >>                          writeback =3D true;  /* initiate writeback; w=
ill delay ack */
> >> -               else if (queue_invalidate &&
> >> +                       revoke_wait =3D true;
> >> +               } else if (queue_invalidate &&
> >>                           revoking =3D=3D CEPH_CAP_FILE_CACHE &&
> >> -                        (newcaps & CEPH_CAP_FILE_LAZYIO) =3D=3D 0)
> >> -                       ; /* do nothing yet, invalidation will be queu=
ed */
> >> -               else if (cap =3D=3D ci->i_auth_cap)
> >> +                        (newcaps & CEPH_CAP_FILE_LAZYIO) =3D=3D 0) {
> >> +                       revoke_wait =3D true; /* do nothing yet, inval=
idation will be queued */
> >> +               } else if (cap =3D=3D ci->i_auth_cap) {
> >>                          check_caps =3D 1; /* check auth cap only */
> >> -               else
> >> +               } else {
> >>                          check_caps =3D 2; /* check all caps */
> >> +               }
> >>                  /* If there is new caps, try to wake up the waiters *=
/
> >>                  if (~cap->issued & newcaps)
> >>                          wake =3D true;
> >> @@ -3749,8 +3761,9 @@ static void handle_cap_grant(struct inode *inode=
,
> >>          BUG_ON(cap->issued & ~cap->implemented);
> >>
> >>          /* don't let check_caps skip sending a response to MDS for re=
voke msgs */
> >> -       if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REVOKE) {
> >> +       if (!revoke_wait && le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_=
REVOKE) {
> >>                  cap->mds_wanted =3D 0;
> >> +               flags |=3D CHECK_CAPS_FLUSH_FORCE;
> >>                  if (cap =3D=3D ci->i_auth_cap)
> >>                          check_caps =3D 1; /* check auth cap only */
> >>                  else
> >> @@ -3806,9 +3819,9 @@ static void handle_cap_grant(struct inode *inode=
,
> >>
> >>          mutex_unlock(&session->s_mutex);
> >>          if (check_caps =3D=3D 1)
> >> -               ceph_check_caps(ci, CHECK_CAPS_AUTHONLY | CHECK_CAPS_N=
OINVAL);
> >> +               ceph_check_caps(ci, flags | CHECK_CAPS_AUTHONLY | CHEC=
K_CAPS_NOINVAL);
> >>          else if (check_caps =3D=3D 2)
> >> -               ceph_check_caps(ci, CHECK_CAPS_NOINVAL);
> >> +               ceph_check_caps(ci, flags | CHECK_CAPS_NOINVAL);
> >>   }
> >>
> >>   /*
> >> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> >> index b0b368ed3018..831e8ec4d5da 100644
> >> --- a/fs/ceph/super.h
> >> +++ b/fs/ceph/super.h
> >> @@ -200,9 +200,10 @@ struct ceph_cap {
> >>          struct list_head caps_item;
> >>   };
> >>
> >> -#define CHECK_CAPS_AUTHONLY   1  /* only check auth cap */
> >> -#define CHECK_CAPS_FLUSH      2  /* flush any dirty caps */
> >> -#define CHECK_CAPS_NOINVAL    4  /* don't invalidate pagecache */
> >> +#define CHECK_CAPS_AUTHONLY     1  /* only check auth cap */
> >> +#define CHECK_CAPS_FLUSH        2  /* flush any dirty caps */
> >> +#define CHECK_CAPS_NOINVAL      4  /* don't invalidate pagecache */
> >> +#define CHECK_CAPS_FLUSH_FORCE  8  /* force flush any caps */
> >>
> >>   struct ceph_cap_flush {
> >>          u64 tid;
> >> --
> >> 2.45.1
> >>
> > Unfortunately, the test run using this change has unrelated issues,
> > therefore, the tests have to be rerun. I'll schedule a fs suite run on
> > priority so that we get the results by tomorrow.
> >
> > Will update once done. Apologies!
>
> No worry. Just take your time.

Here are the test results

        https://pulpito.ceph.com/vshankar-2024-07-24_14:14:53-fs-main-testi=
ng-default-smithi/

Mostly look good. I'll review those in depth to see if something stands out=
.

Thanks, Xiubo!

--=20
Cheers,
Venky


