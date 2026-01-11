Return-Path: <stable+bounces-207992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC6D0E062
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D843301412E
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928941E7660;
	Sun, 11 Jan 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt16OhBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CD70830
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768096497; cv=none; b=CIqH3qfw/nEOvZe9G7E3/dPpWb4NYI0F1TLzPlrPIcwy1UYikExeu3M7N5HLFFgYg71eg1No4pX3lmFwVo0Houfhj6eqFyX42fXc6NgNjo1jFW5kSoljkE+PqVTHe4MtNvMSb81P28tewP2/9t22FYpg78sd/z15rAxoKcdInUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768096497; c=relaxed/simple;
	bh=3+boh/64J3UqZucLzwtl7B8Arc8PYtZWke74PMpbH5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsWg3SoIsdpZEAUNYakmlTdCLX7RkhPeo3+oUR9QebhbRStK2Im4l+qpWxM3DrNzo2KULudyIhB00kCky1Q4ji8ZjLHUN4MI2p0V41DbAH8neeos43LmLulbqlVWf8aDaf962WUQnrzu2iyvzEqbXLSd0GjKmgHj3/k4OIKhX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt16OhBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3040CC4AF09
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 01:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768096497;
	bh=3+boh/64J3UqZucLzwtl7B8Arc8PYtZWke74PMpbH5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tt16OhBZKlk0+Go8ZDGIooj4m9Cy/cX8hjpPtxK3d+3SwCyZJnxUjpSpcbhfLcziW
	 0TY0XrjCnJtIWjAlHgKqsp4T0nhE80SDzZPHjYV6hV+MzUUox6jlKJhumnSejXAEUH
	 XBgWSAS5hmWjDTASBlZl4Lks5XpdKfR4GvxuqMSe4+0O7l443+Ya64BBqfbJNIOGgf
	 iSYFU77G+SI+T5hJfcB6CVLCrh74XzkX8/qZNpyosUo78d3zq6btiQCzPXOFwipul7
	 K1oQigx9ceirpAquoRX7PvNJjekrXNhISflbuoLsRxdIhxgYQ/j4vq7V6KRU1Nxuq3
	 JOyVtEWPj6jcQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso4888001a12.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 17:54:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNLz6TsgD5DnsA/WlwOLrHV3AfXVKWS6gAsrnXjVCSMgeXcVjGWlk1ziLnjbgc29BIDSUvlWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vHfvsLof1T9vDSogacHFxvSJ+IXfamaJRIs2g+e8IyZ4Ox2T
	uax9qTtL0RL30ZGmoDhVzocflhBPIWYmvDQuOI8WZCyE8rrwcAmPUk8hls8R+rb0rlQJ0WMkUk9
	cUNpme+rv66jdmA+eMlsvhL9V3fMW9ps=
X-Google-Smtp-Source: AGHT+IFefzhNqietnG7jCSa+J+bZNTm2sxT6EMCIzG2hX7dQNgvopeRcl429RcoFUOJJ8DD+HXIMkLRyHc5oHcFBqoE=
X-Received: by 2002:a17:906:31c4:b0:b86:f558:ecbd with SMTP id
 a640c23a62f3a-b86f558ef40mr259752266b.13.1768096495753; Sat, 10 Jan 2026
 17:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
 <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
 <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
 <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
 <CAAhV-H601B96D9rFrnARho4Lr9A+ah7Cx7eKiPr=epbG17ODHQ@mail.gmail.com>
 <561129d8-67ff-406c-afe8-73430484bd96@rowland.harvard.edu>
 <CAAhV-H41kwndL+oz2Gcfpe3-MCagaQd2X21gK9kMO2vpw_thhA@mail.gmail.com> <e6a02bff-6371-4a03-910e-b47c5eec726c@rowland.harvard.edu>
In-Reply-To: <e6a02bff-6371-4a03-910e-b47c5eec726c@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 11 Jan 2026 09:54:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NGgHhrZ+oC2ZbzURj0--yVL8rpn4Z42xk9VzKD3E1Qw@mail.gmail.com>
X-Gm-Features: AZwV_QjrxAmrXgM418NqjlVUfhPSmRQwnTXsOX72D4q8A2YzFMOxw5809vLsa1c
Message-ID: <CAAhV-H7NGgHhrZ+oC2ZbzURj0--yVL8rpn4Z42xk9VzKD3E1Qw@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 11:00=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Sat, Jan 10, 2026 at 12:05:19PM +0800, Huacai Chen wrote:
> > So I think we need a softdep between ohci-platform/uhci-platform and
> > ehci-platform, which is similar to the PCI case.
>
> Yes, on your platform.  But not on other platforms.  (For example, not
> on a platform that doesn't have an EHCI controller.)
For the PCI case, OHCI without EHCI is also possible? So I think they
are similar.

>
> I think the best way to do this is to create a new CONFIG_EHCI_SOFTDEPS
> Kconfig symbol, and add the soft dependency only if the symbol is
> defined.  Normally it will be undefined by default, but on your platform
> (and any others that need it) you can select it.
>
> How does that sound?
From my point of view, keeping it simple may be better. I think an
unconditional softdep is harmless.

>
> > > There are other issues involving companion controllers, connected wit=
h
> > > hibernation.  You should take a look at commit 6d19c009cc78 ("USB:
> > > implement non-tree resume ordering constraints for PCI host
> > > controllers"), which was later modified by commit 05768918b9a1 ("USB:
> > > improve port transitions when EHCI starts up") and a few others.
> > >
> > > Also, read through the current code in hcd-pci.c (for_each_companion(=
),
> > > ehci_pre_add(), ehci_post_add(), non_ehci_add(), ehci_remove(), and
> > > ehci_wait_for_companions()).  Your non-PCI system will need to implem=
ent
> > > some sort of equivalent to all these things.
> > At least for the device probe, a softdep seems enough.
>
> Does this platform support hibernation at all?
LS2K500 is an embedded chip, it may or may not support hibernation,
but we haven't used hibernation.

Huacai

>
> Alan Stern

