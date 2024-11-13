Return-Path: <stable+bounces-92882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC29C6726
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 03:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE18B23852
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323F7083F;
	Wed, 13 Nov 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSph2ksK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3A42A9E
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464207; cv=none; b=YeIoBVgLAlP4JG5ZzvbCemeuiiO5sjoATFMZDChu7sOaZRGqUfRyNFAi0J4EAmENsfQE2DNHG+8mLXDoBq4jh84BN9MglyUHvZwLGzQbY1FXdqfOHLHgkqgwMUxHLIO2WnyDJkj6vRjraexbZa/2qpCpIhA/HV/uCFC75Ls4fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464207; c=relaxed/simple;
	bh=PlYUhUcsPmwPDBIh9w61cOeqDhMpV0uV5BDrrbzYP2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5Pm0KrMWNASvi3w6rM2kmM+bGM98fPTceQw2V/wcfXDFpH9KkVjgU3ZKwHSY0j8zg1JYzHOWCNQ/ALT26p4b1tTqcTO+tg+2zaMGdrWD2x9s7Wchl2IoItWv81toUum1LgdwR5O//A6fs1JFnLM/BrjzEHwQH/e3Kn9/yYHHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSph2ksK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea339a41f1so54695707b3.2
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731464204; x=1732069004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaUhAfwWn67oPOmbocpvOSZXxg4dsQa9E4lX/jyrObM=;
        b=gSph2ksKTOFK4yqo8QEoaQAFckyjazhu2saKp/ARvESFJE9YzX7DJSGkIsYHr86mpD
         DDNJAGK2sE5NtWcCjWY9NLMLn0E2kZvk/XvX6zEhIN5C6mIbyeH0Luzn1NC2J8f7LmRu
         iyMRhjybwZzml8pFrhzK4rWEUcrLjuID7xH/8t2R6hLimEfdtzIkQhdwwjsjEmqycr2s
         6gYcv4bLdG7nAzkXdbeehY4S3oKZzu2lZroMn44cdTTkxaMqmCXCH71qaYxE0dAJ+iPN
         8AVov/us/RSpQzR6B7Afafgmc4/Fz7HoZ9efKeKSRovnZr3/uuwLEsyvEp2NZZjN3x23
         WSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464204; x=1732069004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaUhAfwWn67oPOmbocpvOSZXxg4dsQa9E4lX/jyrObM=;
        b=hBrB0IhE0dznvWcGdYqtCTZyIvuq2B3SGKtQP9TpNzQZZDjkHepVcGsRUsSElflwig
         CSDrIJQ2lCHg45FOR6WHPM15pUsD4VOwo12547orgeJcGVS7+hxTK5GKHEOUu4JctME3
         zXqQxbrYt3xegRCitjthSfExt9/xLDv8AaHtVDMEwSZIBEdPG/F0OLJvDBYjC1w2U/PC
         no/7VUCr+Oh/28tzus7C7x9hbsxemXfc1r6/5XpB6MGz4XowavuBDomf0C8TD8RgetWF
         +VkUM2WgBpBAWZ6dqK5ywkvF1ZGR7jVdoZlrTtR6lRT24CprGdupcE1jWEjL0Y9k26Qr
         nE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbmY+3odPKmlxjTAF2VZcYZ5tBTq7omCiF0rN8cjPkyVwaXOybaEPMo/VubRdRTk+rAe6QP8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMB8qfGZ0KZkfSRbdWHsrzt8RFowh7C3xnGaHkSeExtzzFMDk7
	JbnLfQCJgpwHb/ZfkNSkpeG2r/jXIpcEu7Q3KmqvXiLPShZv1Vjd37Qouuq8V69AP5UydVOwv2U
	etAt3sEUPIFT+7HdFMdhZLmUzdnk=
X-Google-Smtp-Source: AGHT+IGsRx8cx11tb/7TeovnH5vzxI3uRLJeSykRy70Vv4kV6hIHwn/aXyYqQfU3ZRmhCUpTSwhg9DQSrsXC70xT0X8=
X-Received: by 2002:a05:690c:4981:b0:6e2:ab93:8c68 with SMTP id
 00721157ae682-6ecb32f00e7mr16753477b3.25.1731464204351; Tue, 12 Nov 2024
 18:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com> <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com> <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
 <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
In-Reply-To: <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Nov 2024 10:16:08 +0800
Message-ID: <CALOAHbAohzxsG7Fq2kNDc5twbtpzJRCPbJ1C=oYB8fy8PsQzaQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:19=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >> Sorry, but this code is getting quite confusing, especially with such
> >> misleading "large folio" comments.
> >>
> >> Even without MADV_HUGEPAGE we will be allocating large folios, as
> >> emphasized by Willy [1]. So the only thing MADV_HUGEPAGE controls is
> >> *which* large folios we allocate. .. as Willy says [2]: "We were only
> >> intending to breach the 'max' for the MADV_HUGE case, not for all case=
s."
> >>
> >> I have no idea how *anybody* should derive from the code here that we
> >> treat MADV_HUGEPAGE in a special way.
> >>
> >> Simply completely confusing.
> >>
> >> My interpretation of "I don't know if we should try to defend a stupid
> >> sysadmin against the consequences of their misconfiguration like this"
> >> means" would be "drop this patch and don't change anything".
> >
> > Without this change, large folios won=E2=80=99t function as expected.
> > Currently, to support MADV_HUGEPAGE, you=E2=80=99d need to set readahea=
d_kb to
> > 2MB, 4MB, or more. However, many applications run without
>  > MADV_HUGEPAGE, and a larger readahead_kb might not be optimal for> the=
m.
>
> Someone configured: "Don't readahead more than 128KiB"
>
> And then we complain why we "don't readahead more than 128KiB".

That is just bikeshielding.

So, what=E2=80=99s your suggestion? Simply setting readahead_kb to 2MB? Tha=
t
would almost certainly cause issues elsewhere.

>
> :)
>
> "mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even if
> we have no history of readahead being successful".
>
> So not about exceeding the configured limit, but exceeding the
> "readahead history".
>
> So I consider VM_HUGEPAGE the sign here to "ignore readahead history"
> and not to "violate the config".

MADV_HUGEPAGE is definitely a new addition to readahead, and its
behavior isn=E2=80=99t yet defined in the documentation. All we need to do =
is
clarify its behavior there. The documentation isn=E2=80=99t set in stone=E2=
=80=94we
can update it as long as it doesn=E2=80=99t disrupt existing applications.

>
> But that's just my opinion.
>
> >
> >>
> >> No changes to API, no confusing code.
> >
> > New features like large folios can often create confusion with
> > existing rules or APIs, correct?
>
> We should not try making it even more confusing, if possible.

A quick tip for you: the readahead size already exceeds readahead_kb
even without MADV_HUGEPAGE. You might want to spend some time tracing
that behavior.

In summary, it=E2=80=99s really the readahead code itself that=E2=80=99s ca=
using the
confusion=E2=80=94not MADV_HUGEPAGE.

>
> >
> >>
> >> Maybe pr_info_once() when someone uses MADV_HUGEPAGE with such backend=
s
> >> to tell the sysadmin that something stupid is happening ...
> >
> > It's not a flawed setup; it's just that this new feature doesn=E2=80=99=
t work
> > well with the existing settings, and updating those settings to
> > accommodate it isn't always feasible.
> I don't agree. But it really is Willy's take.
>
> The code, as it stands is confusing and nobody will be able to figure
> out how MADV_HUGEPAGE comes into play here and why we suddenly exceed
> "max/config" simply because "cur" is larger than max.
>
> For example, in the code
>
> ra->size =3D start - index;       /* old async_size */
> ra->size +=3D req_count;
> ra->size =3D get_next_ra_size(ra, max_pages);
>
> What happens if ra->size was at max, then we add "req_count" and
> suddenly we exceed "max" and say "well, sure that's fine now". Even if
> MADV_HUGEPAGE was never involved? Maybe it cannot happen, but it sure is
> confusing.
>
>
> Not to mention that "It's worth noting that if read_ahead_kb is set to a
> larger value that isn't aligned with huge page sizes (e.g., 4MB +
> 128KB), it may still fail to map to hugepages." sounds very odd :(

This will be beneficial if you're open to using MADV_HUGEPAGE in a
production environment.

--=20
Regards
Yafang

