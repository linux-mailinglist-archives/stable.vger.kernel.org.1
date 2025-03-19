Return-Path: <stable+bounces-125609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A777A69CE1
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4277B8A4AF8
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 23:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961A22423C;
	Wed, 19 Mar 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bI7viNFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F361DE3A9
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428297; cv=none; b=OiuNYa5m1dTLfwb9m53Xk0AGnlYcbw0LL0ByvtHCyx738kNpQqEDYzSBflH9bEYfaQK5amyudzCgzb4wSUpWwgT+BGNhnrGX/HdlJMyDQdUg9xUtXIQqkujHg4PduMn8rWnZUBBx3tVyWitzjEoGKKe1UiU2/zWw9KlbEocfHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428297; c=relaxed/simple;
	bh=Zd6lPK24wICTCeAGm9ShBQ7c4Bz82eP2PlBh96sLX4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpobTgbchNfFBzuv82nng88ml1Gu7rlfuNwkgZJgf4eYfgNBzhDeFavIGvlZ9BJXjauPsLJH0LVwS6yhE/8THzdDnL3qiAbgyDAhFp+X04e6J7yWdNwazNHMDOTt1KLWJLKXZIdx1zccFI3cWIqrFR1kNuugTRk4IcKlyg0t67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bI7viNFc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47681dba807so58461cf.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742428295; x=1743033095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXB37kE8g9zrW5XJLWVxY6X8l7gXuU/+PvbrOsHuw48=;
        b=bI7viNFccr80lvINnFA57b/1fLBpZNi6fBxlP0iYB6yL6r6VOg4n5D3rZXs3KiP2hH
         RkJ2FSkpiZc+t+Ha1JmoazZYPKbB7J1JaucsWPPC0yuaGeNMJI2bFK3yL6LYxBGKjt7I
         iA+IMDGbYd2X9yfkh5sO5BIp56cl9vpv0ERE+evHoncc2Rgn//GbY9M/DsYXEpYvRaE4
         s+tmteXDXa7SrnhMbmB8OEfRXqJNAxjueVQiNnjMiH0hcrLxcS0OE8CQHdVwMIz+KpJW
         AWrDjap3FS/E/+5HPlF34lwb+SVUWPpFqiC5e40GWeTU2yrkKqfleZOB4HOORZ0xL1ex
         6Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742428295; x=1743033095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXB37kE8g9zrW5XJLWVxY6X8l7gXuU/+PvbrOsHuw48=;
        b=FDkeKT4zXmBIrGF5lnUKOrHROb+gQiY+uDGGMbFfEr80yz7yzYgJ8BYWCeVUlEdq4g
         qbuIopu1GrVM246XOopA+S+Q5BvmN55XV1OYyf6rdS8/gSepmFhMvaIHXcsViBes82W8
         7OWUQktbtN9yUG2/VDV807D8wkCfoiXNeMz8UC8ktPt+8TnavPOt5y6y+61HT1ZgaB7H
         vK5PJOFZSn5XZqXKz1lFLJk/NnOBFrr3c8XkAoH+OPBy7RQIfOzSzPlIVtC4srm6lomL
         6QzUM5f5pG7yweL3Sc7K8KyCoIJBgq7pJUTgjqRE4z3SSiw0l2IXknAD1qoGwLv5ttus
         1XOA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8VXRYEggt5wIb1E9SiJgbbTpTT4gTiHKWSuWD/UkJ9Ia58rXLIwIpabEyRide70IEXiUGPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWaXj6n5CIWES8HR+KnNnmBWo5HqgJimioY+5HbG3zWDYq/Xr
	eH0hZ0QXNFjMtTno2LX9Fr+S6OVy1wLFqI0MmsB6eFUc5TO7jusQ9zWzTeg43uxKr3VoEJQRG/T
	PtW6phOKxSOcDU2FQi6e8JytcL/EtNe+kToYp
X-Gm-Gg: ASbGncsLX+XHMJ0UZ4q7lgs5qM88SRIcH4PCLsAgxv2eTTdXS0IvAJnsgstUXlx7HFE
	DlH1QFnksRdrMPZNLIQmvd5KZRK6FvRRUUtOrBl5ImeSXKrkINF6gDaZ+blG3A6RLRWhkj0p5iK
	0qNufpfUiaxXw6xcR8O+Dp7sX22nryxK76CropyS70q66xvgjYmO9ilyM=
X-Google-Smtp-Source: AGHT+IEPb3uycvbOzcrIXbuE2SeXFLKRLR9STk2vGI4AoY5lvO/hG0DbL3JlrOkTypHb1Rzp+bExnT/t4sAo5oc+yD0=
X-Received: by 2002:a05:622a:1b10:b0:475:1754:e044 with SMTP id
 d75a77b69052e-47712aff3a1mr703701cf.3.1742428294486; Wed, 19 Mar 2025
 16:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de> <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>
In-Reply-To: <1742423150-5185-1-git-send-email-hargar@linux.microsoft.com>
From: Leah Rumancik <lrumancik@google.com>
Date: Wed, 19 Mar 2025 16:50:58 -0700
X-Gm-Features: AQ5f1JpZCyj-YkaVlD8zo6zTR3YKxhHUYbw5UzdQJbh3ulRs6jc22xADpXMq0M4
Message-ID: <CAMxqPXXrfMs4zHuOOmTtDp2T5uTbJYnnXQ0E04gFRr62W3SJjw@mail.gmail.com>
Subject: Re: 6.1.132-rc1 build regression on Azure x86 and arm64 VM
To: Hardik Garg <hargar@linux.microsoft.com>
Cc: frank.scheiner@web.de, dchinner@redhat.com, djwong@kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey this is my bad, I cherry picked the fix to my local 6.1.y, running
tests now, should be out for review tomo or friday.

Thanks Frank for finding the missing commit!
(https://lore.kernel.org/stable/8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de=
/)

- leah

On Wed, Mar 19, 2025 at 3:25=E2=80=AFPM Hardik Garg <hargar@linux.microsoft=
.com> wrote:
>
> v6.1.132-rc1 build fails on Azure x86 and arm64 VM:
>
> fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
> fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use in t=
his function); did you mean 'tp'?
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |                                                   ^~
> ./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CO=
RRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
> fs/xfs/libxfs/xfs_alloc.c:2551:51: note: each undeclared identifier is re=
ported only once for each function it appears in
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |                                                   ^~
> ./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CO=
RRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
> In file included from ./fs/xfs/xfs.h:22,
>                  from fs/xfs/libxfs/xfs_alloc.c:6:
> ./fs/xfs/xfs_linux.h:225:63: warning: left-hand operand of comma expressi=
on has no effect [-Wunused-value]
>   225 |                                                __this_address), \
>       |                                                               ^
> fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CO=
RRUPT'
>  2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
>       |             ^~~~~~~~~~~~~~
>   CC [M]  net/ipv4/netfilter/arpt_mangle.o
>   CC      net/unix/scm.o
> make[3]: *** [scripts/Makefile.build:250: fs/xfs/libxfs/xfs_alloc.o] Erro=
r 1
> make[2]: *** [scripts/Makefile.build:503: fs/xfs] Error 2
>
>
>
> Tested-by: Hardik Garg <hargar@linux.microsoft.com>
>
>
>
> Thanks,
> Hardik
>
>

