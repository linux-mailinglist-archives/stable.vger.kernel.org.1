Return-Path: <stable+bounces-155314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E543AE37FF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5855E3AC834
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181221A433;
	Mon, 23 Jun 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPyizjS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2820E005;
	Mon, 23 Jun 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666213; cv=none; b=QvxNO+vyfvJ+i5gax1TLAldYlDEKfj0f8Orma/wfggHzOM4ybc9gSnTjqMVvyCymOFAFWBnvRI+pEumwhpLt41KGM/Zcrunh6d1PCJFOBO9IlEUWjIxqR6chosadT9OFaLyD5JsTgjf24KfBHbJ0dMbcQ0VZHwCLftaO85x8gIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666213; c=relaxed/simple;
	bh=9UFfyxd2/b0B8guWxRhS4jzpop1VBAtfJC/n8ZrMlz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrtcQIWvqgCxvEwzMscU1w33uGBG/9LwMIRMMOf8nkaCu0lKFECuLaZrmDV8TE0f/7aOGS7/B25SMcs8O7CFHKbzcjbTfztkqsUZ94HB7myqGVBca4WCC9GPnsI1fnTV3DSEL7Vc7D0HSY1Dx+BeLyxRsHROqTSto129n7P01e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPyizjS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3567C4CEF6;
	Mon, 23 Jun 2025 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750666212;
	bh=9UFfyxd2/b0B8guWxRhS4jzpop1VBAtfJC/n8ZrMlz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FPyizjS+kcmIUJdWgcX2yl5zU254/yT6y9fjJUzpsifXgAnOShDwKyuJa4Js7vi6W
	 zazBcrc0dYF8VXhdBegmcqBrmW1sl2Nf5iN3Bt7q3b09z5Hc4I/fsUApQDMUEtyvgR
	 qYZh/NvbVWnUkXlGpie58LgqMjIp5PK/aylLBDdOXl+GRF9Io3SHZUlg4exAjSJE1y
	 WGQ2Lcmy5+iEuBtlqRQP2yX5Jxwkx84cyHIo/ueCHQzIzaAqdw6KZjo2WwKsY3JnOa
	 RAMl+h2/8oJbez+mhgDxWQaHL8xNwejWoG/c5NKrt0bkO2HoxXIiGwJizb4iWRPcy6
	 oEfBdbY9XjECQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so7437069a12.3;
        Mon, 23 Jun 2025 01:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBAIp/pkrxelHGqrawKzqEdG6xX1r2ehxVsvBiRvyX5znf+AoRre5Povtps7JT/Rn/D55OFBfG@vger.kernel.org, AJvYcCVsFl+ZS/Xsx5kGEEXiNAUveWPcHvlnOuS7WS5AE+drJhQd4VIzeTSM2tJK1l01hXfer+fdPnyCaCo8i5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XiUBfK+Mv+nRjP1DVWlhS1vnmqrqw9ksY9CJnYXQYKq+GPOR
	sgz4J//5lSLw6JDS8Sf4MLvtgkyJJjx1VzuOdBhW/w5NQ1PJnJ5aY3ugkGJsqq/Y7chQxMDE4Jv
	FSZ9Cqx6BHJn0YWodsxUvCUUIpg+ZKRs=
X-Google-Smtp-Source: AGHT+IHVdXyQlxhUp2FRWU2idWY08CpHAI24CMuWlAmuGlq5qpodHyK+J3UrpjCva/pQR3fAFOc/BUmGTDLPAKsXno4=
X-Received: by 2002:a05:6402:84c:b0:609:d20b:1af5 with SMTP id
 4fb4d7f45d1cf-60a1cd1a81amr10778001a12.2.1750666209246; Mon, 23 Jun 2025
 01:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622110148.3108758-1-chenhuacai@loongson.cn>
 <2025062206-roundish-thumb-a20e@gregkh> <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
 <2025062349-proximity-trapeze-24c6@gregkh> <CAAhV-H7r-X-t0_i-x=oy2Gin4-ZMhSVwXtcaygZdJ1_J-zD3dg@mail.gmail.com>
 <2025062339-till-sloping-58b2@gregkh>
In-Reply-To: <2025062339-till-sloping-58b2@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 23 Jun 2025 16:09:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ntk0mdXGrvLPvwKmW2ROgyH7gnaSjYFgpDzg-d-hSfQ@mail.gmail.com>
X-Gm-Features: Ac12FXzYxecj6L72SAnsBRFC2YxdneMCN2Ajasq-9wTeF6WqfrpvimZYH9Axjt0
Message-ID: <CAAhV-H4Ntk0mdXGrvLPvwKmW2ROgyH7gnaSjYFgpDzg-d-hSfQ@mail.gmail.com>
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, ziyao@disroot.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 23, 2025 at 02:36:18PM +0800, Huacai Chen wrote:
> > On Mon, Jun 23, 2025 at 2:28=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jun 22, 2025 at 09:11:44PM +0800, Huacai Chen wrote:
> > > > On Sun, Jun 22, 2025 at 9:10=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> > > > > > In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build=
 error
> > > > > > occurs due to recently backport:
> > > > > >
> > > > > >   CC      drivers/platform/loongarch/loongson-laptop.o
> > > > > > drivers/platform/loongarch/loongson-laptop.c: In function 'lapt=
op_backlight_register':
> > > > > > drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BA=
CKLIGHT_POWER_ON' undeclared (first use in this function)
> > > > > >   428 |         props.power =3D BACKLIGHT_POWER_ON;
> > > > > >       |                       ^~~~~~~~~~~~~~~~~~
> > > > > >
> > > > > > Use FB_BLANK_UNBLANK instead which has the same meaning.
> > > > > >
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > What commit id is this fixing?
> > > >
> > > > commit 53c762b47f726e4079a1f06f684bce2fc0d56fba upstream.
> > >
> > > Great, can you resend this with a proper Fixes: tag so I don't have t=
o
> > > manually add it myself?
> > Upstream kernel doesn't need to be fixed, and for 6.1/6.6, the commits
> > need to be fixed are in linux-stable-rc.git[1][2] rather than
> > linux-stable.git now.
> >
> > I don't know your policy about stable branch maintenance, one of the
> > alternatives is modify [1][2] directly. And if you prefer me to resend
> > this patch, I think the commit id is not the upstream id, but the ids
> > in [1][2]?
> >
> > [1]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git/commit/?h=3Dqueue/6.1&id=3Df78d337c63e738ebd556bf67472b2b5c5d8e9a1c
> > [2]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git/commit/?h=3Dqueue/6.6&id=3D797cbc5bc7e7a9cd349b5c54c6128a4077b9a8c6
>
> What we should do is just drop those patches from the 6.1.y and 6.6.y
> queues, I'll go do that now, and wait for you to submit a working
> version of this patch for those branches, so that we do not have any
> build breakages anywhere.
>
> Can you submit the updated patches for that now?
OK, will do.

>
> thanks,
>
> greg k-h

