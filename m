Return-Path: <stable+bounces-94512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E09D4B0C
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178FA286A0A
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379281C2DCF;
	Thu, 21 Nov 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwOJFdpN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAC27447
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186104; cv=none; b=P0LFW4a5xrDgcUbLOBnpgYKpWNecl78ms8OhRTqslHGof3dqjFYY22dq2LRNf27GbhwnIzsM/yhHgdVfsVgsfL2EH6PAoh7qJaK2aeMgYG/HdHS9RskJycqFg2N7lnX3USXzdDoeaxt9IW4jrWAvvJ9nyRrajihXC+e9/4HaHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186104; c=relaxed/simple;
	bh=iZbIvkb47XP3o6P1YZINDCc219qubY3DBwYu/F3bLG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqhFvUDXK2lny/CXEJacnewgpZbAUIt6HqbsrUF0jft+BQYqN1KQcf51TIHvcF0MpWiNx615rHd/uljQ3/RjEH9JSO3ou3ab/TmJMTnxAqq8W/C3aLTYVtXkhNz6P+9Hi2Cp+A+4KHbDQoCzEWPC9bt1hJoSWXAQtfYQiuxfLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwOJFdpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732186101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZbIvkb47XP3o6P1YZINDCc219qubY3DBwYu/F3bLG8=;
	b=BwOJFdpNrgkE/8PkPPSLQk/5Q5UG01g3m9CYnLlL/M3RBRXkWOzcQpTeUyv8+JRD+ijsN0
	Ro6KHhlUjXKlWENP6JAbM3QewRI4xAhdhHWhA2n/w2huThHWU3fY9hRJs3Q11shNnL8xAM
	5jpLSxwnlP5Z57+rTroyiULEXTOqtTA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-OO4eP2Q1OIezv8q1ZIY5rA-1; Thu, 21 Nov 2024 05:48:20 -0500
X-MC-Unique: OO4eP2Q1OIezv8q1ZIY5rA-1
X-Mimecast-MFC-AGG-ID: OO4eP2Q1OIezv8q1ZIY5rA
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cfcd4862b1so555181a12.3
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 02:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186099; x=1732790899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZbIvkb47XP3o6P1YZINDCc219qubY3DBwYu/F3bLG8=;
        b=bs/p3q/Y99F/ngsw8/dYxTHnBk9aKbUtaGY3ZO4vPfYUKABT8+LdqjVcm7r4KIROkM
         GK57HzEoUjx9h+KddoQ5KCmHpssXUqIGKVaAakVHWOQ5PWeUhXp07t+lE+MZ/q4sePnW
         852PblRR3RmzFFTL0Ze4HQzc6PrChvlInE21I5orzBVqw2HtY+ls1ub5OpYR6u5KPQnk
         OvKg54J0Y3xK6NXy6cwnFN2DsbgvxDQALMkErGoj2bqblroCNwdL2nCWjoTijjg1ky2X
         552b0I528Akhw99y36422BsarEOBwRBiQhpWiWCZUeFWzOCEZNTDqd9kwnyOnPmXWfQe
         lfWA==
X-Forwarded-Encrypted: i=1; AJvYcCXWL1AWazYLRIH10NwCPvfHEJ3qiQ+fldq1oxfnxRuL3TRXbUbLJy2/OoW8V3sRO8cup3Ic2e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVDIWcb7N2xTIlsUMQUCs2G2KrypGaBxMEqsoroCQY/TgNbpJ
	27tXl1LEWHkkfeJ0FWP2mEk8I0o4z7g5fs8Yp8+nnLYMgGR98rHc0C0lMkkJTwcE35GBPkGVO8/
	m0e+zS1StMq5Thv2eGcbKyHBHa0aHS13dBLLxd3CcGiJIUw1ETw4QepAoG+b6g+pjdi5Q4b8Dqm
	MmdGlOdM0hz7peJUlJGpbNWod2b/pS
X-Received: by 2002:a05:6402:42c7:b0:5cf:de9c:9b4a with SMTP id 4fb4d7f45d1cf-5cff4ce4070mr5293717a12.28.1732186099102;
        Thu, 21 Nov 2024 02:48:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmXdB0HEkcU2syXmIrZsaNM5eevZc1PCVj6O2kU6gC46bTp8zQWRPl44RvEDWYjsCEUZpJa2ogiFJBnhxSGNE=
X-Received: by 2002:a05:6402:42c7:b0:5cf:de9c:9b4a with SMTP id
 4fb4d7f45d1cf-5cff4ce4070mr5293709a12.28.1732186098821; Thu, 21 Nov 2024
 02:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com> <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
In-Reply-To: <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 21 Nov 2024 12:48:07 +0200
Message-ID: <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IMHO, we should first have a solution for the immediate problem,
remove infinite retries and fail early, and cap it at 3 retries in
case there is a temporary issue here.
I would use ENAMETOOLONG as the primary error code, as it is the most
informative, and couple it with a rate-limited kernel log
(pr_warn_once) for debugging without flooding.
I would also open a bug/feature request for a dynamic buffer
allocation that bypasses PATH_MAX for protocol-specific paths.

On Tue, Nov 19, 2024 at 5:17=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
>
> On Tue, Nov 19, 2024 at 9:54=E2=80=AFAM Max Kellermann <max.kellermann@io=
nos.com> wrote:
> >
> > On Tue, Nov 19, 2024 at 2:58=E2=80=AFPM Patrick Donnelly <pdonnell@redh=
at.com> wrote:
> > > The protocol does **not** require building the full path for most
> > > operations unless it involves a snapshot.
> >
> > We don't use Ceph snapshots, but before today's emergency update, we
> > could shoot down an arbitrary server with a single (unprivileged)
> > system call using this vulnerability.
> >
> > I'm not sure what your point is, but this vulnerability exists, it
> > works without snapshots and we think it's serious.
>
> I'm not suggesting there isn't a bug. I'm correcting a misunderstanding.
>
> --
> Patrick Donnelly, Ph.D.
> He / Him / His
> Red Hat Partner Engineer
> IBM, Inc.
> GPG: 19F28A586F808C2402351B93C3301A3E258DD79D
>
>


