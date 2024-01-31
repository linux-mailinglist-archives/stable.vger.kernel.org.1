Return-Path: <stable+bounces-17485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71758437DE
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 08:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169CD1C26CE5
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F251013;
	Wed, 31 Jan 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+PPRZDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945035DF0F
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685931; cv=none; b=tApgpRF+v8YnW2hdRI+nxqr2BkSWDhk9qavgXE4DMRRBQFjW6ysnaj6mNWiS9mCtMtUe1SWbhkB+pRzHIDhDFYujai3X2lnYbJi6utKos6RRah1fbgdU1DR5BXtSRtfjD/dVhjtwaTmWGJfWkJkrd/7ywqknlHj12BZnniE+iSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685931; c=relaxed/simple;
	bh=EDeaiVO2K2Ts63Y/UKcw0nogMvaq0i4jVu6msmflVt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkYFEPBeROyHSS117JbN5CggcQgR2hLllUZ9fSGeFgrHHabj6FSXpSgc+6rTOPYF7PSmgwDHCVovx4fxaHn3xsH611grcengKVsinzq3ZzTQqRINEHWX+XpfliYEim5j4BoLGZ/DYkEMw1hiirDIA5VCvTdQt+K0SaMSiVjsW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+PPRZDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFAC43390
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706685930;
	bh=EDeaiVO2K2Ts63Y/UKcw0nogMvaq0i4jVu6msmflVt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M+PPRZDFMtntYucTN/GPR9e/CVSC7S9VGN2Qq6s90NYY9FA8T53YmpDTAXvb4bZpT
	 3MsmQemzp/cF+6MhzcVwypd8so1v710p0ocLQ8y7jzs9zEVFB36vJkflpn8Py/TKix
	 TKQ5Mjnp2i71vFNxOu3Lu9gGwGkp8Sln0V9La1Kqt/iUiqYcJEIFtS63ZMcc8zOm0Z
	 v2hEVR6QeR6FC8tFLwvj5koAaesEZDFve5CocE+xjfMZvd4cTv3y+sVT0PuQI8qu+n
	 34lcK1ZXUMmXFInINgZVqV92J5rEPJkNK/vY2HsQFrVWoz6R2VX0boD00cs3/rqpfW
	 qWfFMN5w3aQ7Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f03ede12cso3680673a12.0
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 23:25:30 -0800 (PST)
X-Gm-Message-State: AOJu0YyZWTZ0p9HaV4hSEFe2qQGYWmjl/r3LvO1sXa8w9hM5ZIWyTC0n
	mWu5lH3OhFrj7HdvUqyISG+b4XAf8eOk3h0sFrC/6pt2A/uvqg/vC8Z/lUgW38d8C54X+e2THsB
	vKUhJfO/H2YdoSqb3MxJO1+L39TA=
X-Google-Smtp-Source: AGHT+IG2BMxTj8FeGJpc516OHDPB+t8Zvw2ufQ88Krn/HAivqr3u2M5pHxX0/wJyCYZ7GkINjTnavbpUuE5KRMsGdMw=
X-Received: by 2002:a05:6402:1751:b0:55f:3f35:32c0 with SMTP id
 v17-20020a056402175100b0055f3f3532c0mr447055edx.4.1706685928645; Tue, 30 Jan
 2024 23:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024012911-outright-violin-e677@gregkh> <CAAhV-H44QUho8cq4cG6rpovboBH_28vfiw-akMWoLMLR6Qgu1w@mail.gmail.com>
 <2024012932-share-rendering-96e1@gregkh>
In-Reply-To: <2024012932-share-rendering-96e1@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 31 Jan 2024 15:25:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4zODB93deM_vzoy+GGX7iYtDxXtgsDLUg0QXXQGqdQEw@mail.gmail.com>
Message-ID: <CAAhV-H4zODB93deM_vzoy+GGX7iYtDxXtgsDLUg0QXXQGqdQEw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] LoongArch/smp: Call rcutree_report_cpu_starting()
 at" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: chenhuacai@loongson.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Jan 30, 2024 at 10:25:18AM +0800, Huacai Chen wrote:
> > Hi, Greg,
> >
> > On Tue, Jan 30, 2024 at 12:53=E2=80=AFAM <gregkh@linuxfoundation.org> w=
rote:
> > >
> > >
> > > The patch below does not apply to the 6.1-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.1.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 5056c596c3d1848021a4eaa76ee42f4c05c50346
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012=
911-outright-violin-e677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > >
> > > Possible dependencies:
> > >
> > > 5056c596c3d1 ("LoongArch/smp: Call rcutree_report_cpu_starting() at t=
lb_init()")
> > Similar to the commit which it fixes, please change
> > rcutree_report_cpu_starting() to rcu_cpu_starting() in the code.
>
> I need a backported patch for that please :)
OK, wait a minute.
https://lore.kernel.org/loongarch/20240131072151.1023985-1-chenhuacai@loong=
son.cn/T/#u

Huacai

