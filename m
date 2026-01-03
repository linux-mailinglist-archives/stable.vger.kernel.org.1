Return-Path: <stable+bounces-204527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0380CEFA7F
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 04:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7363013EE5
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607282505AA;
	Sat,  3 Jan 2026 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5c+ahyB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFE20CCDC
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767412649; cv=none; b=P6HSDor+WOB7KgZxYsdT7mCE/qREP+KiT08STM68mtE3gLI02Jp+Dh9HI6gFmhdPbbtnUwdCV75DofdYSe8F7dOUOI948JjY1VxhX2vQseQVoflgXg3q7pxTEBQC1itj3osC5jzKc4MPUHa22tqDjNY4+hLdXSTo7XoYnzw6Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767412649; c=relaxed/simple;
	bh=AeFdZYiYPzl1pEEjZ9I42Uglf405zH8bRDJ+yUqKhSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCU+JC7baoDWDjISax49iySyUsxUTcNaR9yL3pdAa5DIKXZQVENp7ukqd+z1cZp9qCaQO9HwUeQcBsVf9gm11E9rlJncH++M/rx0aEimb6UWLibUfosAHI39FKVf/bKB35VLBCZF69BUYWSNQa3F6sVd/BMAkUT2k0jBEgjAyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5c+ahyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCAAC19423
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 03:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767412648;
	bh=AeFdZYiYPzl1pEEjZ9I42Uglf405zH8bRDJ+yUqKhSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m5c+ahyB3QvwhdC7yt8srqpYLt3UReMYYyKGnAUCLOt/F6OXTxaUqEGzRBxAH2xzf
	 +5p8+H9tAkRswL5P0pyUZfnzYyHiCKxCnTYIP3Ma5MqxFUsExtfD5U8jfeHK0FrGET
	 9GsHk2Yjy/9mi3uxYhgtGtnDePiyobm66IJcac8O6hfpzJTntfT0uPnAr00G4RBPwS
	 MFGRIlOA8VOT+w/yiNk0CzYuERn0OHoCycU3VaW6UdhVpYXl4hkcel31mB5qagG65P
	 3IZTymrZHcIto1F0rNwi8mybmb9L7jGXKSxv3aPARhQEPyhwu9agcM7ioN02hqEKGC
	 K9HqztvNzPxeQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so2630182966b.3
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 19:57:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWACidVrru2t42FjZV675AyUs5rqH2UrKmvE1wWwowW6CdFcYV9m3kUhI6l+Ph7e+fHNKH4RA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShvDqm41gfCoDID9zZNswBVuRq1lTXpl+BCCNkX+Sw2iuHRmw
	qa9c6xK8AG69wkrZmuzHgOdu8DxqxVM8w/cD8pQQLrrhfTKZP0gvrPH3g66RvPKcp290v+gjkUO
	o66RGUYtt1/QB1oUTDTHK7lgdW8d6QYY=
X-Google-Smtp-Source: AGHT+IEn3aufPmFFWMDcg6KEHSRJwtm9J1uFeX3len5u0fi6cvwdxIi0kuc6c6wIedMPRDBkYH+A0VAByXZcsiczbOc=
X-Received: by 2002:a17:906:f586:b0:b79:fe73:3b18 with SMTP id
 a640c23a62f3a-b8036f56584mr3958118466b.22.1767412647282; Fri, 02 Jan 2026
 19:57:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh> <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
 <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
 <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com> <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
In-Reply-To: <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Jan 2026 11:57:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H601B96D9rFrnARho4Lr9A+ah7Cx7eKiPr=epbG17ODHQ@mail.gmail.com>
X-Gm-Features: AQt7F2pAMrEJKbEHMWIRnkpzMBe0sTv7w_v74KyTevBsL5DkQBjSqu86tQVkJgo
Message-ID: <CAAhV-H601B96D9rFrnARho4Lr9A+ah7Cx7eKiPr=epbG17ODHQ@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 11:33=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Sat, Jan 03, 2026 at 11:16:59AM +0800, Huacai Chen wrote:
> > Thank you for your explanation, so it means there are two methods: The
> > old one is EHCI with a companion OHCI; the new one is EHCI with a
> > USB-2.0 hub. Right?
>
> Right.
>
> > > > So I guess OHCI/UHCI have an EHCI dependency in order to avoid "new
> > > > connection", not only in the PCI case.
> > >
> > > Do you know of any non-PCI systems that do this?
> > Unfortunately, in 2026 there are really "EHCI with a companion OHCI"
> > for non-PCI systems, please see
> > arch/loongarch/boot/dts/loongson-2k0500.dtsi.
>
> Since these systems don't use PCI, the question I raised earlier still
> needs to be answered: How do they route connections between the ports
> and the two controllers?
>
> There may be some exceptions, but for the most part, the code in
> ehci-hcd was written assuming that only PCI-based controllers will have
> companions.  If you want to make an exception for loongson-2k0500, you
> will need to figure out how to get it to work.
Loongson-2K0500 use EHCI/OHCI with platform bus, while
Loongson-2K1000/2000 use EHCI/OHCI with PCI bus. They use the same USB
IP cores, so the route connections are probably the same.

Huacai
>
> Have you tested any of those systems to see how they behave if a USB-1
> device is already plugged in and running when the ehci-hcd driver gets
> loaded?
>
> Alan Stern

