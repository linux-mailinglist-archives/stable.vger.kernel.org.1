Return-Path: <stable+bounces-204424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E3CED9BA
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 03:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D2A3007FF4
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC230BF64;
	Fri,  2 Jan 2026 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GovNAfec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E2C8CE
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767321378; cv=none; b=k3Njdyrlr6cnBDIqdB13jaItZQU5YlJriCTPoNTkESHSgC42BsPHMLzU3O44WA9hPqY5N93fXgjXfydAWHR+7ntqp8xzC8iutjludbYgD9CW5guqSXrtCJKahPAw7QCuajH4YAgoAsIkKvU8hfoiqGz9z6yjTxHzVBeh7rBzXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767321378; c=relaxed/simple;
	bh=DfTjVyPkPlF8+h71Wfnen1ji8bK+saUfxXxq5W1MIko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECebx+fIiT2Y77wPSBT+FWjJv4Eupczn9J+Tj2BL9v2Ee2HypV4J16CjmLTMonao/pFj/khuhkoOjepQsfRLg05TFKdCIUHO/zutKLOdvux9aapoFODTx9beQaXma+k+YDs+N92t58UCulcGP4PVNw85aEhM7OgKTP0bGRF0ILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GovNAfec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7FFC19421
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 02:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767321377;
	bh=DfTjVyPkPlF8+h71Wfnen1ji8bK+saUfxXxq5W1MIko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GovNAfecOxI43sV18xi+N015VWAmkYS4XkX9qcDsgDKXL1DIKVAYAidMXQo8/jlLt
	 V8jOjXCVgaahM6OYFgUylIhx8iFw6vXaCLnvocLkPF07BEfhnyCy1n7C1R2V9qLbVR
	 UorviAGpXtA3usXsb+QzjIezu/sDKqbDo888si2l/nDieGJIjqgJudf8OUxNz5wKug
	 fRturtOU96hX7lCc1yojrq5kgWqmsi0sKa0BRu5oLLWnDGWIbtIcb/NlYCm/xV9WMd
	 vZ6VLj39UKd9UenSIhFfQWdJmRyHCck7Gi8ujhkDH4ZOjakZEKtacXyytWZN1vmnnR
	 P/QQDNJZySuTA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cee045187so2103961966b.0
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 18:36:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwrYflljtxqcLVFXqvcZ6av7VSK3KY22CmDVkCx/yzo+ANElgo09E9+qWdRriIfop2JNsj57Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuj0GrKl78HEFijnIbhDmk6tEqkygGEfsGLmZmjIycAFKs3KR7
	11w+8hlQ1AvfOdHyljGBVJ3XUw9wa2RSZ1d16FlwnPa7osz3wOcq5/J/OwCNYRTh9POUpSLu7Ae
	XOPBUQoKNl2PVRxRLaL211bsMK4F2mBg=
X-Google-Smtp-Source: AGHT+IFvKRFGjALVjIE2PdpGqIP4K3Bkyd218s2vwyTLJhdPENKNqcsiJiYAt6huCBwIaiwZWWGOlSPSep8xsABXsuA=
X-Received: by 2002:a17:907:1b26:b0:b72:84bd:88f3 with SMTP id
 a640c23a62f3a-b803563ee36mr4353637166b.11.1767321376278; Thu, 01 Jan 2026
 18:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh> <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com> <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
In-Reply-To: <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 2 Jan 2026 10:36:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
X-Gm-Features: AQt7F2pBMy6uQYiqfN3YBOwxky2OlMF5LBaK2LjXdA8kqKgx4D1i2BPaBPZfYkU
Message-ID: <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 11:21=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, Dec 31, 2025 at 05:38:05PM +0800, Huacai Chen wrote:
> > From your long explanation I think the order is still important. "New
> > connection" may be harmless for USB keyboard/mouse, but really
> > unacceptable for USB storage.
> >
> > If we revert 05c92da0c524 and 9beeee6584b9, the real problem doesn't
> > disappear. Then we go back to pre-2008 to rely on distributions
> > providing a correct modprobe.conf?
>
> The warning message in 9beeee6584b9 was written a long time ago; back
> then I didn't realize that the real dependency was between the -pci
> drivers rather than the -hcd ones (and I wasn't aware of softdeps).  The
> soft dependency in 05c92da0c524 is between the -pci drivers, so it is
> correct.
>
> To put it another way, on PCI-based systems it is not a problem if the
> modules are loaded in this order: uhci-hcd, ohci-hcd, ehci-hcd,
> ehci-pci, ohci-pci, uhci-pci.  Even though the warning message would be
> logged, the message would be wrong.
Correct me if I'm wrong.

I found XHCI is compatible with USB1.0/2.0 devices, but EHCI isn't
compatible with USB1.0. Instead, EHCI usually has an OHCI together,
this is not only in the PCI case.

So I guess OHCI/UHCI have an EHCI dependency in order to avoid "new
connection", not only in the PCI case.


Huacai

>
> On the whole, I think the best approach is to revert 9beeee6584b9's
> warning message while keeping 05c92da0c524's softdeps.  Greg might not
> approve of soft dependencies between modules in general, but in this
> case I believe it is appropriate.
>
> And so your patch really is not needed, as far as I can tell.  While it
> might in theory help some peculiar platform-dependent scenario, I'm
> not aware of any platforms like that.
>
> Alan Stern

