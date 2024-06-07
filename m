Return-Path: <stable+bounces-49953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF688FFE33
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F42B21015
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC1D15B115;
	Fri,  7 Jun 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2e+6oAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C414EC7D
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749813; cv=none; b=YYBL9UvUY0iiMVPOm2dwGlP8XwV68syvebgaNjq2CuZ8wSucZQvo+/bHi88m43IFBnA1gCPKkWUvSrRaNNZbvaZMo6zI5ztLMwlRfwhfw9HB1kOOvYsC82VPBXeDZtc5dYtRetIytvFSMIkJwtHEM+IdxOin2Jo0Kff+rNWBCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749813; c=relaxed/simple;
	bh=kebM1ht6zZGAYTIpx75DECJ7ZoF2ZWFlbE5I28fmWyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi0hKgf46k7fIqA3TS6b7T/gV+lRzQc56fM20enJXqcghRHxH6VErpyP5TzsdfFKG4yuG03x0soPdP6z7en4pEvPlx+DPQtgLLtsugYrKcYa/GH0T4H2DXvQxm5ye2ZXaMsYnxtjHw8mgNJ0n78/plkXakqijnkx4nYk8EnLz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2e+6oAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756AFC2BBFC
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717749812;
	bh=kebM1ht6zZGAYTIpx75DECJ7ZoF2ZWFlbE5I28fmWyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J2e+6oAhWpsedqsrbIawznSsa/6fAw6xQIIeMZv4DrjVEgWyhWgUov96zdyZ71opO
	 G1xcgGlvtqSXGzaTbzUA1Nalb7VrQ9Q/qQlaFvqBnv49OM4t8AsFTsb8YqD2sstTne
	 1jLmj2yVazwqDgikPXsjU40B60ChBlOBsDiDPZQPjRVKKHeo2XYnEiv6Lcm8RVc5ws
	 Rb+x9Tsk8+P590P6oUZqoajA1iVWpTbt3+9rGDozgXvWcA2B21jV43fXMTbjDNSxbT
	 KXgvZ0VdA1tc70Otxvfefm1D2N8LCFIYIczrCZHX70EfvPPgzcfM/F2zYYNAyDD4kf
	 sAepQdUVI1iSg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eacd7e7b38so20233071fa.2
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 01:43:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywkag3uPAUXWwCYZEgxazaxbRMlhjfRcxg3f6WN3RWNKzk67bdH
	4MNd48YfyjZxxIALoIog/5pzJSM5XMKcFZ9G8NAToP6v2s6tBYGlFIdjQEVUuCH/PlcKj+dJViA
	nBJFUkTlu2irnrok6LnZ7lgadJA8=
X-Google-Smtp-Source: AGHT+IFCwBWH8Bq3QtqxgipkUvhwW40tcBR3B4hqvPBs1UrK85u0LHoFT3k/C+t/A2WC6jCb8tUfZJd/tWXkyoaUk6s=
X-Received: by 2002:a2e:9b17:0:b0:2ea:d2ec:444c with SMTP id
 38308e7fff4ca-2eadce37b71mr17112301fa.22.1717749810815; Fri, 07 Jun 2024
 01:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh>
In-Reply-To: <2024060602-reacquire-nineteen-57aa@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Jun 2024 10:43:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
Message-ID: <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
Subject: Re: backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > Please consider commit
> >
> > 15aa8fb852f995dd
> > x86/efistub: Omit physical KASLR when memory reservations exist
> >
> > for backporting to v6.1 and later.
>
> Now queued up,t hanks.
>

Thanks.

I don't see it in v6.1 though - was there a problem applying it there?

