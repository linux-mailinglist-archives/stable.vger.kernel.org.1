Return-Path: <stable+bounces-98787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FC09E53FC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6E918827F9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05791DB94F;
	Thu,  5 Dec 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOkiD28f"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8B1D63F6
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398308; cv=none; b=gShNA4VobaKJaSftuJGmJUS5ZbWHW4Nh1crZZVzFwLAecPkYMXhVI3vNLWdWGp+elaGm/q5klo7KY4TvrAelEy7SjRvHS5xdkGL7l7Ck148FBZnTICvSS3kKDtGnHCZ2ap4sytJt6hHTYg1NkS3Ip1XAlTJFhCcEZZ61OVQnv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398308; c=relaxed/simple;
	bh=WD+D3zjDdpr2nzObyZNKUJOpZi+JvTk/rmjXWt+DS7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrFQ1cH8LFb+8UyXEB5zeEVzCmvmSgJ8zxzkrgzKn6t5h3xfsimoBOFWuBKRbIBrK77x/EAfbudvUKeToVcJVZNPVD4/B8MeZ/hi/wRg0tyCkT5JoSvMeBF+kMFzaPfBRf3hEJetM+0T45dCxgyG2xHaaR86vF80a3ARaasFRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOkiD28f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733398306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrHIoxf1wwvsV961nNc3s6ncxxeirMR14NyYYwxPNxY=;
	b=NOkiD28fPtcH5f/ArNZW8CMtlbAB+K8Pmj2HW/q27qOEJI9xiVSM6BmW/f1oeUSX22cH9Z
	5DMGG2qKZQjcJXwh8EvM5W50csOPYWc2f6+x+H3ks/0jOiG9I1jXnGLdaVnqR4UPUeV1RS
	ziNk4aQ78bZBOb5zDr7+HEtqLAHhTS4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-sLPCtNsxNT2r4gGKGS7qhQ-1; Thu, 05 Dec 2024 06:31:44 -0500
X-MC-Unique: sLPCtNsxNT2r4gGKGS7qhQ-1
X-Mimecast-MFC-AGG-ID: sLPCtNsxNT2r4gGKGS7qhQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa628fd2687so43913166b.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 03:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398304; x=1734003104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrHIoxf1wwvsV961nNc3s6ncxxeirMR14NyYYwxPNxY=;
        b=l60qsjP3+0wP6RKMWrp8qaa7rI3pMzSd992cQZxfZaUb6gm9lLpoF2FYQKbZJVxK0F
         8lDl4e/2vKy9PQ0akVkrtjjqcNexTFWye/GRPJMENHbPx+nPTZYsGkloxRjL8lBPegNu
         wo+8ScMy4ztIfwuJ0y6wD0QyQGShz21JfiY/r6YfBPT8sPvOQJaoF66QtmzAClDxE6y9
         NmrYccUWcsMr04Z2Eqhxv6loXycxijbVR9/27CZ/zZdIe9CFdX6g5iNYjGsInq6j42BQ
         p0BEsh7sNVengjTxKuSl2/v6o0ioPFwdzgxW4OFl3iC8M1Touk/wIleS05LT8uvkx6qH
         OAng==
X-Forwarded-Encrypted: i=1; AJvYcCWAsd8cTaFYKA4OAzYmc5bXw36SB6mujXMcfOOhk++k/g1eXoDAy7TK1ftYU777TDi9Of22+m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmPn57zu6Tb27vF4pMSKKhX9VOBI4FyW9KJWeiakXYCzn0ntk
	TXxsEm4ZxNhaeS7HhBHb21ma6cWonSWzgUGbhJvUHgBEKi9LAD7lsJioi4xwgT6yuf9lbXfWTOq
	I+OdoeP2OP/vKMfpjLCwbs3wJotfNehJq0gEks7NImpqunMo5lLwFyv50z/Qg/kj7gQO3K+4uoX
	pGxQxDItRKs7t8cdx9Hdk1WCEc4Pxg
X-Gm-Gg: ASbGncsdksyT5p1bLFFVpa9zb0spXINsYevkaeMxKsizZNfxjZLF92FI0Y7h7DOX3pj
	mZJlZvIBavlJcBt0fBNGt9GrRAlxfj1CfD//3/guyeKKk4JoxCw==
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id 4fb4d7f45d1cf-5d10cb5c7c7mr15008317a12.20.1733398303581;
        Thu, 05 Dec 2024 03:31:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/LNwZyYb5cNNb233xpazpDtAY3FmHy3Im/NdeY7v4mcL81NmkDVKHroBDsI4MKXESH4Ayo+yHw6mZbxUuGSY=
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id
 4fb4d7f45d1cf-5d10cb5c7c7mr15008280a12.20.1733398303265; Thu, 05 Dec 2024
 03:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com> <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
In-Reply-To: <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 13:31:32 +0200
Message-ID: <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a bad patch, I don't appreciate partial fixes that introduce
unnecessary complications to the code, and it conflicts with the
complete fix in the other thread.
Please coordinate with me in the future.

On Thu, Dec 5, 2024 at 1:25=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Thu, Dec 5, 2024 at 9:32=E2=80=AFAM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > On Fri, Nov 29, 2024 at 9:06=E2=80=AFAM Max Kellermann <max.kellermann@=
ionos.com> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat=
.com> wrote:
> > > > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > > > this way will end badly.
> > >
> > > Is there anybody else who can explain this to me?
> > > I believe Alex is wrong and my patch is correct, but maybe I'm missin=
g
> > > something.
> >
> > It's been a week. Is there really nobody who understands this piece of
> > code? I believe I do understand it, but my understanding conflicts
> > with Alex's, and he's the expert (and I'm not).
>
> Hi Max,
>
> Your understanding is correct.  Pages would be freed automatically
> together with the request only if the ownership is transferred by
> passing true for own_pages to osd_req_op_extent_osd_data_pages(), which
> __ceph_sync_read() doesn't do.
>
> These error path leaks were introduced in commits 03bc06c7b0bd ("ceph:
> add new mount option to enable sparse reads") and f0fe1e54cfcf ("ceph:
> plumb in decryption during reads") with support for fscrypt.  Looking
> at the former commit, it looks like a similar leak was introduced in
> ceph_direct_read_write() too -- on bvecs instead of pages.
>
> I have applied this patch and will take care of the leak on bvecs
> myself because I think I see other issues there.
>
> Thanks,
>
>                 Ilya
>


