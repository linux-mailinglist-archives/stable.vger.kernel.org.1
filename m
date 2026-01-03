Return-Path: <stable+bounces-204526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15FCEFA67
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 04:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5367D3012DCE
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA221C16E;
	Sat,  3 Jan 2026 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EnO3RbgY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA693136349
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767411233; cv=none; b=d071vXJja+uOhJnalnXyQsiy2ZWa6PId29xjSwRLY5Uf3w8bgbcpvOfg2GAEf6YyAn3o++9XC9FSUV7HnODdTRV0MDefscK9dVxgJoTiPAzYCzK1VghRQf9q4VTfIU+Ks2aL+92CYBTgy2YH8ZGjfWw0Y6cSKpvYA/bdPpRJaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767411233; c=relaxed/simple;
	bh=DvHqOw/97h3KFCjLx4a3ZWvMiQuFjYBj7WlTh8Zjm9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpWEC0TPJdRkfD52X3+i3xiLHlTgcsKe6v0zyqMdeKfu2hRuGR27sB8ER6vQsDHe4aOiXyu2LNDBI11YGgHloEPVdOvQwy8H9Veq/EyrwQ28KBi32wpSi/m3Bgyy5iYFTOyB+QY1MgBHo5QL8CL+mLnYD/NQZkF50hN5zNRD7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EnO3RbgY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-888bd3bd639so6061236d6.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 19:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1767411229; x=1768016029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Rx4mxodgB1DZmHp5H8zfG7zdDZzjgVY/DGJF5Uvfuo=;
        b=EnO3RbgYgxu2m8turbvSBufg7zIHdVEHaA4e+P+h8UrOPJwNQP5x+SUG9t+kiVrlBb
         p/7O1ua2qlUQZKVS3tw7NG7SblvfGU2kFNF6bIveCS4qXpjr8FtEXXvZ2lJnaXcvTMZM
         vbgAMOQpKluGbdv68+LpPunroKLJ76pk3fYiJYXbT9zUsHsAUuK7vM1oOZ0Ba/bF+vVw
         o0yv339mCP5dniTJvI/k0g1vCt6iH+jgZMi8Pw9nxv0j9PPud8vCChkOzLWBrsw4rBU/
         vAxCw2nA25mvy+WXc3Ekcn6Ljnb1ujJ2cZlV2jVmsygbtNuJcjtGl58OHPHqYDGZU6Rb
         CZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767411229; x=1768016029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Rx4mxodgB1DZmHp5H8zfG7zdDZzjgVY/DGJF5Uvfuo=;
        b=LMg6NWpLrQMmIO/6piWmY32GyNzkTOG5H5ELWqYXTUhJdLfLLXXUFIys0ATo1i/tGw
         dTQK7eNZAsogGRiXZJ4JcXMkWhDbtMAJQsaCKuB3H6GhcXGF/omDLSDcsqKxPmgN2NkG
         D8IsYvixNWmNxCjRbewDHwluLI0G6R0qiSV1d/tEVxwegx3dZkT6AO9BXVRwtmMLYC93
         NribgLv9L19b8W3Po1FKRC1SXth1cFdXuE8NDo34yCtapt6r1xSS1+yQqg6eX6PN1Ukq
         L9HhGo51ozOQXbe1W3+XeYBOCOEeLvRDrBAH/zpVLQO2dPgIJUYOngCSIdo1Kg/D8GfU
         fR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPAlaJhOZQX7Us4CXkN+TTU6/bOB/c1LXQiUjOXw6d1Hv9WPPX5Z6zH5Jlz3ykbOsmSIRM7lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKNBRgU4J1FcrVyDRVfh3cWM6wF/NkfrcyQ2j1MHVVw+e6pJH
	uA7YaNj8uDCTsaEAi4e/GuMcOKprog6HbFivSRidt8nkIS0JWhk7Ukpp7yyp5Sh6OYeHwFIPhAd
	E+tw=
X-Gm-Gg: AY/fxX6Q2chHnPwYA+6NfNnGQYaKR/X5vrs0uanl0LLyjHF7lUNcKdNKg+bV6y++Jlc
	nh8xs0ZSF/RRCDnAcPLyBx6ARaHit3Ua+3qtYXvxPAOmzdsKuNayb1f2ucp9Zj7VCCWIwuby6FF
	O8AxKhse7elMUqNZfbJGwUZa/gL23NU8MHszeE19trkLvDw15FZ3eV6cUFNFfS8z4ngyPoyTkxg
	WkjyKu+idqGJS4jV1kerLjS0UIYFGGhuOH/sXimd019Gr6toyeSQOyU/kh91AfN++yloOwsFjNP
	5EZAm2UUYi+PxB2+1iEYyTZz4OWo/l0z3Rov5bndAVWSICaVvcM24yC+YMBlG+++fbg/j/MHUWH
	UwXXtDMWZB4EJlaF8d4FsLL1bYNCkkY4btSLQgg8rGlrtL6E3Mqxe/auspkY/FGJe9onIcsaUbB
	OXJsMEatFcZZcE
X-Google-Smtp-Source: AGHT+IHoyxqPLEaWnJ/LDGZOADLupMTl9wzEwLf9s+fKpC12/nZpuwilwnAGwaE+DlCKqsZXJWpJyQ==
X-Received: by 2002:a05:6214:1cc1:b0:88f:d4b0:10ff with SMTP id 6a1803df08f44-890594f14c6mr25041866d6.7.1767411229499;
        Fri, 02 Jan 2026 19:33:49 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::16e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac66841bsm299275101cf.30.2026.01.02.19.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 19:33:49 -0800 (PST)
Date: Fri, 2 Jan 2026 22:33:46 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Diederik de Haas <diederik@cknow-tech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
 <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
 <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
 <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>

On Sat, Jan 03, 2026 at 11:16:59AM +0800, Huacai Chen wrote:
> Thank you for your explanation, so it means there are two methods: The
> old one is EHCI with a companion OHCI; the new one is EHCI with a
> USB-2.0 hub. Right?

Right.

> > > So I guess OHCI/UHCI have an EHCI dependency in order to avoid "new
> > > connection", not only in the PCI case.
> >
> > Do you know of any non-PCI systems that do this?
> Unfortunately, in 2026 there are really "EHCI with a companion OHCI"
> for non-PCI systems, please see
> arch/loongarch/boot/dts/loongson-2k0500.dtsi.

Since these systems don't use PCI, the question I raised earlier still 
needs to be answered: How do they route connections between the ports 
and the two controllers?

There may be some exceptions, but for the most part, the code in 
ehci-hcd was written assuming that only PCI-based controllers will have 
companions.  If you want to make an exception for loongson-2k0500, you 
will need to figure out how to get it to work.

Have you tested any of those systems to see how they behave if a USB-1 
device is already plugged in and running when the ehci-hcd driver gets 
loaded?

Alan Stern

