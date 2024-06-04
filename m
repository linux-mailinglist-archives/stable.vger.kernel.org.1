Return-Path: <stable+bounces-47946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475CE8FB924
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D70282D5F
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB32231C;
	Tue,  4 Jun 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNYw+Fks"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86EEEC0
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518933; cv=none; b=tr81yE7wPPCqd6qk72iY6YcqHKVueWUi55rADI3Zx7D69kgRAgN9dp5krkLlo25hz3KdIYqhd4fDezbXlDZHl/RTI5QN1kzDE9kR8p0h6YIMKEeeS6dApMrJy5mpW+E/JHWsc1olByS2MVpOYLlQ1KDkzxXpPRs+hn9iz5wqarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518933; c=relaxed/simple;
	bh=uGfqdx4dG/z+vG41amZkkdupdSn2UMbsmO9+ujsauOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RK/q4moyXyp7hU7Pg451KodKIjuL3SK2s6Kq0cPGDsuaX/jBbyAZD4u8chZGUZ1YCAAxLNmqkfGaEH+gnQyxyl1okGgizCHouG9XOfbn18lo8+I/TmfxVY9J2BKNcbuIvF9inUYVHFgLz/hQ51YxFKO9Uu+K59XRGwGcLhCc6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNYw+Fks; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso75a12.0
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717518929; x=1718123729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7HJdkvl9IBhCSO+oQufm2ToxeLflcMeHdqBVPkQMs4=;
        b=GNYw+FksQBWD9J/9UkrQYzvLl1hSziGJnY+6p5FhMWLf+vmBxyJ+JAdzIUVwffq6ip
         wpSXC02DMo7ZY9xucbkIZGBpqxbZ0IXdT/71DooKHNsPoueKamh0F+aGoKIyyZqD+LxW
         CkzpU2TTofHz3J3C8I3r9atP83ate2RGDFflHnfxuqM7kmSNGwh9pKy5F5kcFM2jVV0B
         m8rwVXthHtY4FcRI84FK89iU1PJARN9LcL1YLawkDcDxkDWun03l945PNROW3f3KREtg
         3SzX+2pXqC3pGEkx0OqFUcBbgT4shx1DP4wolMlJb+gBET5G8zVtN4c4qSCwJZ+gNX9D
         egug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518930; x=1718123730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7HJdkvl9IBhCSO+oQufm2ToxeLflcMeHdqBVPkQMs4=;
        b=VKI3NCZMWLLzQChQBlzM+sFbqohJKCnRlDszw5R+HeOL7xAm+4upk/cb3inFBepHOG
         2YQOjsekikVUm7XKMKUYEDg2WOlI+HbXlbxtP/Q6DThXZ0RJiiNe15cOLskKnRKJDuuE
         Vm6gC0J17TZJpPJlUZLUio+2Kr0TH4DtE2VdySjUuKN1oN7dXT2tUN7a4oMlmXxxSP/A
         K9FQBjDciI3JMaaInfhLM53LBFtZcVvb+aWvQC8kK1hYn70AXzP2kgtnk3K0SCcYeLGr
         9wo05U41EOqP+3IwThM5dsVP1uQRTnUm/UskJQVMb0x3fbY4IhXwaTtEWjEWs4zKvSXy
         F1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUSJAfIxzLcDI3tIcRP9FTLqRisrepRR0a7ehQKh23A7dVweHVfr4q3863NnRp7RmpBDZQ9Kh6wWgKtp1CbyTdDIAB6IVhF
X-Gm-Message-State: AOJu0Yw0La1eXBTHHAk9dXJYphZfA4SQGqmBlJFikFDDGlyzxVhT6hyf
	X9HRDiPmcdoiye86NVoOOfOPvPEFj897awNrO3L/N7bHqqCcrIm/wB8b/CKaiA8j7q9qkZKhOym
	EB2INlpnmKhNJLup2etiiMkvShsjuOofMbPZIe6YG3iBv3XDuyAlE
X-Google-Smtp-Source: AGHT+IH/esCFQSmlgRKst2gRbyTGVd7aGrimOXXWa7MskFXcTOeJnfn1GYJ0VMIMcvIT/C+UsIMYBz25kIZOZ7IaR5I=
X-Received: by 2002:a05:6402:5d93:b0:57a:2a8f:2d86 with SMTP id
 4fb4d7f45d1cf-57a7d6e828cmr150629a12.2.1717518925059; Tue, 04 Jun 2024
 09:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
 <2024060452-headrest-deny-2a5b@gregkh> <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
 <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
In-Reply-To: <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Jun 2024 18:35:13 +0200
Message-ID: <CANn89i+6X6o8bQjVUatuvBTq1hCBB6345a1=E=kA3dJUQggGNA@mail.gmail.com>
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jun 4, 2024 at 6:26=E2=80=AFPM Holger Hoffst=C3=A4tte
> <holger@applied-asynchrony.com> wrote:
> >
> > On 2024-06-04 17:44, Greg KH wrote:
> > > On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffst=C3=A4tte wrot=
e:
> > >>
> > >> Just ${Subject} since it's a fix for a potential security footgun/DO=
S, whereever
> > >> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv=
_wnd value")
> > >> has been queued up.
> > >
> > > Only applies to 6.9.y, have backports for older kernels?
> >
> > No, sorry - I'm just the messenger here and moved everything to 6.9 alr=
eady.
> > Cc'ing Jakub and Eric.
> >
> > My understanding is that the previous commit was a performance enhancem=
ent,
> > so if this turns out to be too difficult then maybe 378979e94e95 ("tcp:=
 remove
> > 64 KByte limit for initial tp->rcv_wnd value") should just not be merge=
d either.
> > I have both patches on 6.9 but really cannot say whether they should go=
 to
> > older releases.
> >
>
> Sorry I am missing the prior emails, 378979e94e95 does not seem
> security related to me,
> only one small TCP change.
>
> What is the problem ?

Ah, I guess you are referring to

commit f4dca95fc0f6350918f2e6727e35b41f7f86fcce
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu May 23 13:05:27 2024 +0000

    tcp: reduce accepted window in NEW_SYN_RECV state


Sure, If a stable kernel got 378979e94e95, it also needs
commit f4dca95fc0f6350918

