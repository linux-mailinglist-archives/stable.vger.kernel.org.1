Return-Path: <stable+bounces-98796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC919E5548
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9016B056
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F42185A1;
	Thu,  5 Dec 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UZfDnC88"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B456217723
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401344; cv=none; b=HjUndtQKC7LQMJEsvXOjzKQAd6+79Oj/xt9/E2duM530P74BWsDpQ/L2ZBJJtu8cbdjb3lQZugbjyzHkc4hqVviBG1cFxD2PZeb+6dfjZpHBENArB9Rq8B1zAXegdWiG0W/XKd2sX1M/bY1x0JVLGlinx2wE1H6jxum4HGRObjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401344; c=relaxed/simple;
	bh=bmT3twxBWaTLEJxPl3rYSnM2xe3Wbx9wE5fovhcil+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRjLqS+fxswiXYPkkp0plgoh6FbJTdQKpOEh+BPpCqdHY2eb5qjNzg2jugNwcmC4CjN13l0C+pE5ABsa5GTNZ+/uW7QXbbQQR634HLGcQUIjk5pNiP/iC+2hgPLoC7MvmzZlyXT5Uej2nYgg/f3ixXc4FDQ3uHGKyCEXymZqVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UZfDnC88; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa578d10d50so129848466b.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733401339; x=1734006139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmT3twxBWaTLEJxPl3rYSnM2xe3Wbx9wE5fovhcil+c=;
        b=UZfDnC887eX6zE+gWGL2CfSPad588iXUsGqmVcEKC82AtIxxIUppKU5me2ttPUPbfI
         U9Ikuci2Ny7pdhcj4MD6jas7o2bw4uAAajahsFWQ3UySRhJTth9Dz+dVqx++iM4rY+vw
         IpB7BjYwKA/zWRWGSy1gCoYGqadTEe01xskbLZ8qNCZ2ABqSUR+o/6GL4LdP6JXi+GvK
         PjtWpafwZ7b+5g5C2asCHd5wU2jlDFVLwRy0cfEGHk4QOJP8gEM55tkLc8FT8uPuT963
         98GBTMP7QcnhsXn2W3v0fEVFADsejGzam5Rh1ve7C9lRDUmRyFzH/EdYC4EFf8S473VE
         gkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401339; x=1734006139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmT3twxBWaTLEJxPl3rYSnM2xe3Wbx9wE5fovhcil+c=;
        b=FiF+yRRPSaWekWpxIVnhdb3Cqt1fZa+LMn5ih6Y1pgUETihn0PFu8lx/0tPRncR5zh
         zuaPYmRDW7/m85B2Wv269YdyHVNLsi5bAq8+SRa27gCkv10MCn5LwEOIBvAqjUztdvfw
         zgQ5e62Y5CWt6bD4PRHcUvcIcZSfQBvSXDvpz0BQnMH3ArrBKtY3PXLV58j0dLci0lcQ
         tEynAvPfN/cNAWCJlOm3b9rUJb/TR2NT8e3X92+iqyTxmYuz6CgPNhFuFEdmypKASUoF
         fCHaX95QfIX+tdV2WDb0s9OdeBSmVQHdLjMJsRByVMCKVztp+ncKvs5f9DKLhQ1XubSs
         96RA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Zien+fy8TSsiTFUyBpaD+U3ky7QFdFeYaFhM2S5RXvnojSmicQNOWgf0bipFC8ijka3+qaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNhUxkveQR2oo8UICW4kKGsYG727zmih+eDXMLuq0aKRDA5o2
	H/P7LZL1H/xtXezvTQhIYhlLlquRxSDO4leUPGxiL8KIq5MJ2Cu8XXuwuw+KGf4g0tuSIf7rQsU
	dKqOXgX72rzxA9CODL18YIBoHUGBChmmN4kcueA==
X-Gm-Gg: ASbGncsX+yzUSA4nafn2WIi7Wsmia8X4J2dKBBEevSrfHi/zvA0MI5pR7IacNfs5h1s
	n36lFF0/PenxVl9obUGJSazFwIy7oHb9YGMeHcIJ8QCry47ifv/hP8gIjM7F0
X-Google-Smtp-Source: AGHT+IErxUl17Wl6jcYDVeSXOWMqLDuZkpuko8Wd7gO2UnqQ4Lyz1KIGiEY3SOGJuM05lO0GfwEsq893vtzezCFadTU=
X-Received: by 2002:a17:907:770b:b0:aa6:2567:efe8 with SMTP id
 a640c23a62f3a-aa62567f520mr200314766b.19.1733401338858; Thu, 05 Dec 2024
 04:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com> <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
In-Reply-To: <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 13:22:08 +0100
Message-ID: <CAKPOu+9K314xvSn0TbY-L0oJ3CviVo=K2-=yxGPTUNEcBh3mbQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:02=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> - What "other thread"? I can't find anything on LKML and ceph-devel.

Just in case you mean this patch authored by you:
https://github.com/ceph/ceph-client/commit/2a802a906f9c89f8ae492dbfcd82ff41=
272abab1

I don't think that's a good patch, and if I had the power, I would
certainly reject it, because:

- it's big and confusing; hard to review
- it's badly documented; the commit message is just "fixing a race
condition when a file shrinks" but other than that, doesn't explain
anything; a proper explanation is necessary for such a complicated
diff
- the patch changes many distinct things in one patch, but it should
really be split
- this patch is about the buffer overflow for which my patch is much
simpler: https://lore.kernel.org/lkml/20241127212130.2704804-1-max.kellerma=
nn@ionos.com/
which I suggested merging instead of all the other candicate patches
https://lore.kernel.org/lkml/CAKPOu+9kdcjMf36bF3HAW4K8v0mHxXQX3_oQfGSshmXBK=
tS43A@mail.gmail.com/
but you did not reply (as usual, sigh!)
- deeply hidden in this patch is also a fix for the memory leak, but
instead of making one large patch which fixes everything, you should
first merge my trivial leak bug fix and then the fix for the buffer
overflow on top

