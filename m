Return-Path: <stable+bounces-80619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E368498E801
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 03:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0221F25E04
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 01:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2B168DC;
	Thu,  3 Oct 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEVayczP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ECAE55B
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917700; cv=none; b=YBhR/yufNSVWGoa8nsKGYKQMJ5DzNoOzxOBcPgMVFa9dxExREr2yXIf2wzsVz3Sr0zCYnDR3M4X/L6FIoL7Z2oyMfDaTSrd/O8L1hxgbP4972Oeaj1QrDcU1FKiEluuOpHBfDyKNvjrrWjcyAtbto6rA16zN4VjUboLKRH8AofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917700; c=relaxed/simple;
	bh=+sPP1SjcipQTOOMvkAWvmegFg+ZNySyVNo6IDNNi0x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0WVDDoPah6nuJVyfETjwTz6b/Kld/ZwyRCTlbnDCNDdl65uEDtlNeMvx/aRZ8rYh9KLp5IzwoCrKMF30U/KsiEV0AAqmskUIwrjKsNqJkwI87/avzeSaaDUdGQbAnoy5+aqiihSHtWQANi1TOwkeGFSq/VWKcGTyjTfr8of468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEVayczP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727917696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TePBjAcl7OVgGhBRXtKyMh/Mzzfydzh6ym9fI03+LkM=;
	b=QEVayczP8rAWQQxQXGYlKGqJjFgENkIPExMWWGv5uQbc9pcvsSDs11a90ZLk7jcgR5wYBP
	TC56o2jrJhoryRHkiOmIk+A8Hffhadh1U6Og+GOsqVCFc142BDLj2rJIyVXXtJCRc2ljxu
	K4eWa3U5te/Ri9cA6LYiC6cNHT5dIRk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-e-WUTVJKMW6OwAwFTd4VaQ-1; Wed, 02 Oct 2024 21:08:15 -0400
X-MC-Unique: e-WUTVJKMW6OwAwFTd4VaQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9a71b17a3so65685185a.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 18:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917695; x=1728522495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TePBjAcl7OVgGhBRXtKyMh/Mzzfydzh6ym9fI03+LkM=;
        b=MK3GSeYjdSEHumrzAwKnz+rBgzyP8q8AYRSEGyfl1gwojkdj/Y9sInSlQZPzcdgqbS
         r98GN/72oEV5I098uNcOk1CeGYNSWyDuDsiRcHAb0RWNEHYtZT+VnfzXJ6IXgzI4qQiS
         12ljJDNjC3GVRTOK5xt/Mp/AM+KM6MLjW8Q40NzSrov2gI6wgEHVxBc2IOBfyqhCiNDF
         A66ad0BxbhT6+WLbfE++/l3qxcLvF5b0ZzF7FNzYEQmZIzN6RWl7v1mWFvm/91SAp9PS
         XGuRpOaXgQEpvcB2su2GboQ6DmF+E0yAu2BzP50nRxOjxPb+IiACMkWa+DiOf5O33Qyl
         1SDg==
X-Forwarded-Encrypted: i=1; AJvYcCX2qN9FDoRT9VIv5mjprZEvV4zsNS1zOS4AQBRh7D+FqGue2fWJBFyYM2BN7TR4P9jZ/AX5iRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTK7oKjhAW35CxwvzyWZ3+fD6iNblaXGgnGR9ugJ/RYy8DcKK
	U1j18arLoqa+u2DNO97qmHk+0dX917V2HZd/A0ZWmxsherWwaAW9LU7OjjjD72iBAtQnbFdGxXz
	JN3SqPnjXqJ+Kdf20X/fXILn2gmrxjNdgO7moSZlo4MAFFNeAQDbcZjT3t4iiWEpb1XdbKzeZyP
	0oUqjveu52A+4tCyinONkH/vZ/9b6SRfTFdKLwzJo=
X-Received: by 2002:a05:620a:2991:b0:7a7:deb7:6d9a with SMTP id af79cd13be357-7ae626ac2cdmr752779185a.11.1727917694891;
        Wed, 02 Oct 2024 18:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zAy2xiIv5VdrtML9L302HbfvRYyL/skRauQ08ks7vZMHpbCH+0rw4c3QWRwhdytILtpZUG3YHa4pftxRd8Q=
X-Received: by 2002:a05:620a:2991:b0:7a7:deb7:6d9a with SMTP id
 af79cd13be357-7ae626ac2cdmr752776985a.11.1727917694560; Wed, 02 Oct 2024
 18:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002200805.34376-1-batrick@batbytes.com> <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com>
In-Reply-To: <CAOi1vP_Y0BDxNR9_y_1aMtqKovf5zz8h65b1U+vserFgoc4heA@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 2 Oct 2024 21:07:48 -0400
Message-ID: <CA+2bHPYsoZCJJG_s3u6Q0TWoAxYPZsVsQm=zHh7LRjCq5RWcyw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix cap ref leak via netfs init_request
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Patrick Donnelly <batrick@batbytes.com>, Xiubo Li <xiubli@redhat.com>, 
	David Howells <dhowells@redhat.com>, stable@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:52=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Wed, Oct 2, 2024 at 10:08=E2=80=AFPM Patrick Donnelly <batrick@batbyte=
s.com> wrote:
> >
> > From: Patrick Donnelly <pdonnell@redhat.com>
> >
> > Log recovered from a user's cluster:
> >
> >     <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
> >     <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
>
> Hi Patrick,
>
> Noting that start_read() was removed in kernel 5.13 in commit
> 49870056005c ("ceph: convert ceph_readpages to ceph_readahead").
>
> >     ...
> >     <7>[ 5473.934609] ceph:   my wanted =3D Fr, used =3D Fr, dirty -
> >     <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking=
 Fr)
> >     <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 00=
000000f7784259 issued pAsLsXs
> >     <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe fi=
le_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsL=
sXsFsr  AUTHONLY NOINVAL FLUSH_FORCE
> >
> > The MDS subsequently complains that the kernel client is late releasing=
 caps.
> >
> > Closes: https://tracker.ceph.com/issues/67008
> > Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_=
request() check caps on readahead")
>
> I think it's worth going into a bit more detail here because
> superficially this commit just replaced
>
>     ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
>     if (ret < 0)
>             dout("start_read %p, error getting cap\n", inode);
>     else if (!(got & want))
>             dout("start_read %p, no cache cap\n", inode);
>
>     if (ret <=3D 0)
>             return;
>
> in ceph_readahead() with
>
>     ret =3D ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
>     if (ret < 0) {
>             dout("start_read %p, error getting cap\n", inode);
>             return ret;
>     }
>
>     if (!(got & want)) {
>             dout("start_read %p, no cache cap\n", inode);
>             return -EACCES;
>     }
>     if (ret =3D=3D 0)
>             return -EACCES;
>
> in ceph_init_request().  Neither called ceph_put_cap_refs() before
> bailing.  It was commit 49870056005c ("ceph: convert ceph_readpages to
> ceph_readahead") that turned a direct call to ceph_put_cap_refs() in
> start_read() to one in ceph_readahead_cleanup() (later renamed to
> ceph_netfs_free_request()).
>
> The actual problem is that netfs_alloc_request() just frees rreq if
> init_request() callout fails and ceph_netfs_free_request() is never
> called, right?  If so, I'd mention that explicitly and possibly also
> reference commit 2de160417315 ("netfs: Change ->init_request() to
> return an error code") which introduced that.

Yes, this looks right. To be clear, we were passing "got" as the
"priv" pointer but it was thrown out when 2de160417315 changed the
error handling. Furthermore, a5c9dc445 made it even worse by
discarding "got" completely on error.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


