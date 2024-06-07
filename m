Return-Path: <stable+bounces-49960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA09000C4
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5191F254E9
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759915CD6D;
	Fri,  7 Jun 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7GUDBaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F579F4
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755966; cv=none; b=MSd4kt0/6dHeNcKjzPyxfrtHWiGa5P5XkfbWYXw0ZKNk58qLM7hwJA2oa7xFZvwpxwGRPQN1E8dA5bBzkPMmBEW919X4VrBvNz11FV7cvi7qhY4Cipjpp6XOk319H9phKhVpw4bXISg6a7Aq/5T5PECoKBIA9tEBKMwg9EQL2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755966; c=relaxed/simple;
	bh=/P1wAzLOt8U3nxiThmIkw/dAExAewDodbIDUEsnt/AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c55Yrz3cIJxZjMfeG0iR0OuAsMvybcqj2sg8isuViG3DymnI74yKjmEeTcJUD3ajppZYwCOVfUo9abvG87bPxCpDbBV4ay/DkN4nEbLLHb0IDHaKDjiMuXcLwW/5SZjJO5L1go9rzuOd93c+D5N5BdnJxsYiEP4/1ysPWtdmpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7GUDBaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A74AC2BBFC
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755966;
	bh=/P1wAzLOt8U3nxiThmIkw/dAExAewDodbIDUEsnt/AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z7GUDBaSJ90OV7W15+2LWiMKb1edSqYYODJdf5lzPk8RJrvXiJr5RgJ5VaOtg1ml2
	 rtOQBAPedbhhHUt+3eBWJm8z/EZb/BVCnV6/h879/A2U4yB/6pmw2wTFohV5xunKA2
	 wiZkh9OLjkY1sm/8SM/KHx1tklXhOm+EglsGD+PxeI79oFu+TJAws2kcIDTl28GmXm
	 tjRq/uHTy4RywjAzLlXtgyDWyBX0sSPKF/71u3a/gHpSeGDUbtVW2anUSanBKZnoro
	 kCeEmkQ6/IdIhfaKH3MJAUo/seutS8+f8QU6Gd0nmnOIrVlsQkVet8NRQzDNxIsWpS
	 8+prT2BH7dSCw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eacd7e7b38so21187201fa.2
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 03:26:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEHcHa8dGRLHrYcHqvF/fm6HpzwGMhzfVqKXFMJ69ZdXrjHCv6
	LPc8Vq2s6kEfpADtEH+tzblmy2j+rj+WWcVOrqs3crFNISI8x2tqtz0hgbDQFGOMzsndKj2Nhid
	iTe/03bu1EZMxcsd1HgnuCbuX/Z0=
X-Google-Smtp-Source: AGHT+IG428KrAV7EahQWxPqFWyX2HLDqeOKLtMtfumfByzSZqjj6fuEr7lU1fmurWUFQ1AKVAt1pNIP/j/Qz0iWJN7o=
X-Received: by 2002:a2e:8044:0:b0:2e4:a21a:bf7d with SMTP id
 38308e7fff4ca-2eadce377f5mr17439341fa.21.1717755964766; Fri, 07 Jun 2024
 03:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh> <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
 <2024060733-publisher-tingly-e928@gregkh>
In-Reply-To: <2024060733-publisher-tingly-e928@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Jun 2024 12:25:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
Message-ID: <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
Subject: Re: backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 12:23, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 07, 2024 at 10:43:19AM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > > > Please consider commit
> > > >
> > > > 15aa8fb852f995dd
> > > > x86/efistub: Omit physical KASLR when memory reservations exist
> > > >
> > > > for backporting to v6.1 and later.
> > >
> > > Now queued up,t hanks.
> > >
> >
> > Thanks.
> >
> > I don't see it in v6.1 though - was there a problem applying it there?
>
> Nope, it's right here:
>         https://lore.kernel.org/all/20240606131701.442284898@linuxfoundation.org/

I don't see it here

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-6.1.y

