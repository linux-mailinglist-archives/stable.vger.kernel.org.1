Return-Path: <stable+bounces-39214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490048A1E3E
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B6B2D0D4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8353E0E;
	Thu, 11 Apr 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8IWtQef"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D571758E
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856490; cv=none; b=GqaPp704HSSqyxKYbk8gZ931od0GCKZIY6QFctKOa6cUoEQ/5yisDpagZcxOlsRNFeGSye+Kt3u8ahpL96qlw1eYJwluN6vbFe8hoIaKPhiwlVudFUAwwN8AdCXb8754Wo8tsrmCu4SNGuxJBKcLSkA3d6OWTrJdwoLU4CDbyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856490; c=relaxed/simple;
	bh=QmdABsuvMGC7lZLNHPqtkqyYVMZuaZB9F1yMJHXzp0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roZYUM/nYMZx25NNqsfn6kAhzEzRB1IG8qYZP++MLUKPhlMvZT0LZw51Qj+7WRIU5b6XZa5P5AohifYNEht3VV3aLrx/ak1VDY9U1JX3fG96Eol1k8jDHojHoNtTRDeAn1vOvtu+fUTcBemln3mGHL3FTNaC2GcA+47lE+qQuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8IWtQef; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-417f5268b12so14295e9.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712856487; x=1713461287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmdABsuvMGC7lZLNHPqtkqyYVMZuaZB9F1yMJHXzp0E=;
        b=Z8IWtQefITmi329VGvqJInqU5dXGTTobagXnz5JMwlGABM01HpZNU2wB5AWsiUVLrY
         nRFFafQO+N05ZUZqxrNCynEGjdZ0uleax+95i/w9kadecZQmBzrQxn92pXSk8u+d/bpE
         7Tn/pmVx6vTASP5w/9/xGLm+t9yQ12GjRLmnqPSr3LNIQmXpNOQ7CkOSTKSUP/hJPjB7
         pP3E9TbsYL/3UPIv8hzr9yrZKgWg7fGdojhcdUbPWenhoSq0pyycztRZTiiBSeBW9Sbq
         ebWUjPklJJApopd15L6+CxTnhB5kJVbf5Pie3Jqcb7RmLxtu6K82uahDXyU6sDOZcOvv
         wlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856487; x=1713461287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmdABsuvMGC7lZLNHPqtkqyYVMZuaZB9F1yMJHXzp0E=;
        b=aT/vDQgOwOi+Ov2sa8PZ5p0fPbdSO/wfvq0XVt67IpRMfo1VcsP0sxac0oo6lkeZBy
         YDlVSgqB5VqgbC4G6LmtA7tyv6aSSueXe5jMhS/WZorrBLGontZ/8ZyGKbNT7hdj+A8Y
         Dx2u3PbkgQuF4aKk7ZgB08a4TvyKJlZ203nLjBk3TEp4Ryfpnzm33NHlAQB0cz8tL3ic
         Tx+TBtBz0PLsEKbLtlV0oefvzZ8Fq+iMsxHQr4JpzmFlF7IcJlDJdblGf0+4jC/0fV6j
         mgzqBeFy5nRzIru2SBAidH22hdDhOWVMrB8S/T8Gpike7kItW9Aj4U9z/yOIUUajXQi0
         72Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWmdO5PY7FLBtTnxE5DDPurTzaPgFMzVARxTLT7Xum/hHl+SWr+hasRCtS5fq8wBj/OKep2sEYryh6RuaK+WiwG8tG+OEXh
X-Gm-Message-State: AOJu0YwXkzDG9phyvJArH6uAZoFNGEDd52mjuvRAGdNMzIxGfjxAr5Pc
	U1Yq2A0fEeSgf0p1M4uPZPwTP+oKE8P97kXpdyTAKGp8bYi79gjBdzNvS5+1CZFWGcsgkDbNMbO
	QAYNU7CfIKvATQ113WFThoGy7uT8MXkLQAloL
X-Google-Smtp-Source: AGHT+IGrxx1fiCigAlFTvEwzfyfajwH2hwSawvvXRXkYppVRsG0j5Ao/N8KrqRJW5yqJHmYTg1Fgrg7ht+TWaMSeTQo=
X-Received: by 2002:adf:f40b:0:b0:343:5e64:a1dd with SMTP id
 g11-20020adff40b000000b003435e64a1ddmr161884wro.71.1712856487253; Thu, 11 Apr
 2024 10:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403125949.33676-1-mngyadam@amazon.com> <20240403181834.GA6414@frogsfrogsfrogs>
 <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
 <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
 <2024040512-selected-prognosis-88a0@gregkh> <CAOQ4uxg32LW0mmH=j9f6yoFOPOAVDaeJ2bLqz=yQ-LJOxWRiBg@mail.gmail.com>
 <2024041144-curly-unscrew-bbb0@gregkh>
In-Reply-To: <2024041144-curly-unscrew-bbb0@gregkh>
From: Leah Rumancik <lrumancik@google.com>
Date: Thu, 11 Apr 2024 12:27:30 -0500
Message-ID: <CAMxqPXULt+AHJ1Pqb5+KPQQBuyE5hh2AZZi-1iyYXgHE43_bSQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by xfs/179/270/557/606
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, will do!

- Leah


On Thu, Apr 11, 2024 at 2:22=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Apr 05, 2024 at 12:55:41PM +0300, Amir Goldstein wrote:
> > On Fri, Apr 5, 2024 at 12:27=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 11:15:25AM +0200, Mahmoud Adam wrote:
> > > > Amir Goldstein <amir73il@gmail.com> writes:
> > > >
> > > > > On Wed, Apr 3, 2024 at 9:18=E2=80=AFPM Darrick J. Wong <djwong@ke=
rnel.org> wrote:
> > > > >> To the group: Who's the appropriate person to handle these?
> > > > >>
> > > > >> Mahmoud: If the answer to the above is "???" or silence, would y=
ou be
> > > > >> willing to take on stable testing and maintenance?
> > > >
> > > > Probably there is an answer now :). But Yes, I'm okay with doing th=
at,
> > > > Xfstests is already part for our nightly 6.1 testing.
> >
> > Let's wait for Leah to chime in and then decide.
> > Leah's test coverage is larger than the tests that Mahmoud ran.
>
> Ok, I'll drop these from my review queue now, when they are "good
> enough" can someone resend them please?
>
> thanks,
>
> greg k-h

