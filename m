Return-Path: <stable+bounces-155252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF834AE300D
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C93A6C63
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365B148827;
	Sun, 22 Jun 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktbrle9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA841D90A5;
	Sun, 22 Jun 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597917; cv=none; b=lbAu+LEC/EmkiD4t7pgWlIqYVKEzc/yoAjaggOKAqSKtCx76mMAWh+Aq63Om9B6jVzEXvTuUZC96LEGBNPuoItD+xlSBMObVbRewFtJ3ykFrrCBcPmOyOh5gNXwo2BKmUpnXBvO/QJrqPTyyRFDUXUt3bwGOxXsXvoDQXCg7Wlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597917; c=relaxed/simple;
	bh=iFTfBogO7Ou6dRiZk4dXS5Xfb9kUSJe7BRtNpxUsngQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE6ARbwwSmYill8ncQ+xXmV1mNZ5bB+3gJ0sMMEZhw8+qWqFsf2yMhB+KcCnnW324e0j7BfNT4266rwkRSeJUNdAeqfNlFPPJfZ8f3YEBS6ok8UvzjUCki85HalUGxWUEIN2+KVtUqr0gNi+uFCCId/n8ozRrf1SeBgSqdzRmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktbrle9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E755C4AF09;
	Sun, 22 Jun 2025 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750597917;
	bh=iFTfBogO7Ou6dRiZk4dXS5Xfb9kUSJe7BRtNpxUsngQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ktbrle9tgQ0Yh/RcyjFd4TYWZaFmKdCVBAEFkwa7BfUSGEdBFDxZuz+VVCrVwucSG
	 mj+LXayg2pbut5kZ9Hl5KYktVrKosVVhiWUlLGY1sYKbsCS4nvpPAEuM354mFZyY8b
	 at4PlTfECuJi0BpJsyByBsmO3FJPAUp3YIV5x+zy3Cd9f/JBPeiyacksF5K8ieW8hW
	 5vOdu0TvXPTyBq93nKnOLq6HbgRGPxkme6AT9QF8zt38rYR5e5ga0qKezpcyc8Oq6e
	 Wd4D9d/1QXfHZq3anZawevsTPISu7E9e6oudLK3gtOyMNhKJVm5XheEqaXIGoP/bGE
	 Wb9ZOL2jjix/A==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso5252600a12.1;
        Sun, 22 Jun 2025 06:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2bZlsqo5MDQ34cHvS5uJUHFiHPy1gyemNaITEiHPP4hbmaujnWtxEI4um1b7Dwr1PD9z4EeeY@vger.kernel.org, AJvYcCVvJzxrNa10AAzaJauGpFKuImeXpEhGrYXA9dhSwLyTL9c7kgJxGzkXShL1U7wRBNJK0kyXPxoskAVs0AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmYO5SZGve4GbSMgYEj7CB2koOEiLKfb5IB86h89htz20qAm+
	QIXoDTHO3fV0qn2jZXzmNS9mqAjRPTcq66xfA0B/8SgcReqt59c262MtxijI5olAKpK5vYOEYza
	088y8OjXl2xSjz77MolXx4iFmwcrzJa4=
X-Google-Smtp-Source: AGHT+IGp9Zdaokzz3FwUEoyQYdRXVh7NwJHpk8jxjbFMKjmQdM6VeSLuT3NcA4XIzfjMQ4yJApFLtG9aPRAplFTZyCk=
X-Received: by 2002:a05:6402:35cb:b0:607:1984:5009 with SMTP id
 4fb4d7f45d1cf-60a1d167699mr8209874a12.20.1750597915758; Sun, 22 Jun 2025
 06:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622110148.3108758-1-chenhuacai@loongson.cn> <2025062206-roundish-thumb-a20e@gregkh>
In-Reply-To: <2025062206-roundish-thumb-a20e@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 22 Jun 2025 21:11:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
X-Gm-Features: AX0GCFs3ooE5xKM6IATv-GyKY4DmnLVVqYAEs6tbglCMyQwyFvGaUkVD3I9PD14
Message-ID: <CAAhV-H4S=z5O0+pq-x9X4-VjYsJQVxib+V-35g50WeaivryHLA@mail.gmail.com>
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error
 due to backport
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, ziyao@disroot.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 9:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 22, 2025 at 07:01:48PM +0800, Huacai Chen wrote:
> > In 6.1/6.6 there is no BACKLIGHT_POWER_ON definition so a build error
> > occurs due to recently backport:
> >
> >   CC      drivers/platform/loongarch/loongson-laptop.o
> > drivers/platform/loongarch/loongson-laptop.c: In function 'laptop_backl=
ight_register':
> > drivers/platform/loongarch/loongson-laptop.c:428:23: error: 'BACKLIGHT_=
POWER_ON' undeclared (first use in this function)
> >   428 |         props.power =3D BACKLIGHT_POWER_ON;
> >       |                       ^~~~~~~~~~~~~~~~~~
> >
> > Use FB_BLANK_UNBLANK instead which has the same meaning.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/platform/loongarch/loongson-laptop.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> What commit id is this fixing?

commit 53c762b47f726e4079a1f06f684bce2fc0d56fba upstream.

>
> thanks,
>
> greg k-h

