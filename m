Return-Path: <stable+bounces-185527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDCBD6972
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B376940814B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D02F5320;
	Mon, 13 Oct 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGIzS1P+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333E2FB0BD
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393598; cv=none; b=HnAQivRp+fO9cOXZqceHfQkrPGjc6qQYW/0824lFMNql+/ASMMWvDE6iTLIvUDKvh+y8iJ6ZKY7mI3WJMAsSwhemdBKKHFMc20u2hiblvrJqwHUr89zCiN08/QUAD2WS2vC4vtox4mlhbdsDYdQ/hZLy0PDoac3u1p158yNLF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393598; c=relaxed/simple;
	bh=wjoYvXDZz0DfsX9uSWQcckKoP6w9GXLrRSh8PGU2nkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZPWsL/+MVa06WE+NMylS9TvEhnVpMcUt/IMZtnNRgM1Gr2Nv75GfnOLaTHfKaAlUVviUORHx0RGqXkargCJlmh0Fo1WRuccLzubYMsQI0FZ2v3zaiOSEIaCNU6yBgk4XRnIZA4J3EfVFQsICVe5rZMXVuYfsQYeHpog0WGyl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hGIzS1P+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-271d1305ad7so75400075ad.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760393596; x=1760998396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwDIVnwjatb9wZcHCyfzRACsLl5kuks0bwo7xSwJ8VY=;
        b=hGIzS1P+9aouRtCGIyPObV5aQOQTsIoji7nzyHJQ1Jj2Gr/mCXDEbbQG8I5ZfxeRzi
         o1KTI1s1MmHDMicgBi3YxeJGXzEQOXHpw30f2X+/dnhi+wOv+lG3vjBrocf+mXPMN4Wm
         rwM1d6RQjW2UQNK1ZP+4cXxvjDun1s4bdF3sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393596; x=1760998396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwDIVnwjatb9wZcHCyfzRACsLl5kuks0bwo7xSwJ8VY=;
        b=RoOMJmQWGFD6gxkl9xFrto8Zq8/nD1L10qiSiKIMAz2vtAYlq+344BepD/DCEH/GXh
         Jzhb4AormxFuiuaa4XNFxsG1ijSo6+fDOsGlxLjnplIqydrpe4i6unIES0NsorgIvrQT
         CbuEck0/I+MyHIK1WIHAAZh61qbdwewrl7duNqePwSqdFKs+N5eaMppLqGSq6AWupWqW
         Qz9g87qCj4ILt7YNM0X57XeF7uPWr3t2RBeZfF89FoM0x123zogHq+UvPs0G7uLV5YWu
         IEwFlXz8Nl50Ga8JDc6PqHl3MAJoLRdTo1k/Ag6aXCpwQoWkT4CLEhDsilNTsVz0ZTgR
         Mq0w==
X-Forwarded-Encrypted: i=1; AJvYcCW1zBjbJQ40BC7tXm4xlNEP0GRs5SO2U4Vu39XN3YCRtHtQXhTBC7rBbC8YAtsEsVUkxCxEwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlTYiSvYdqwsFUbzr8ylBc7ihV4YwB68WmCWhU4H6yCbmBZ3X
	9XjzQqcaKNZ6n3GZbk0CO42xYL7QxsMQ5RUGwk8FxJaDvshzQBkmNuWmbuo07zSLbg==
X-Gm-Gg: ASbGncsNobSRybhJ6QPdSrzp2rZ+GS3iQ8sH+mV6i56C/0ni6SZnBHbj4fnj1Xbz6rO
	2q3BnWu3i8pUjqOwkax1mnRf4L/J6oU5BjavyfPiQ/gDj/nIVfj10oN6oDzJKLfwSSWBBzUNzC0
	4poUMLADAH8mYWkpiOtZRIojKG4mvjX4lMQld9HpaVhXlchVVXBACzObPVZ7QjNhW+T3/Mo/3KH
	3jMLjo9I7XNjdqjHphbf+HPZjLbokytzOxIYFYRJhBW0ipsWTnEEqfDm9yIrS6pgZkGJdmWzHwJ
	BO68Q0UdQctl9rujVATR+Iopz72cO8UVEXOiK0xGzSqnR2q9gkEFj06aWK9Qeaax/6DkDJ2g920
	QUzon94+gdyULLffbPzm4y0Tx3yAHxKczlxbcIl/Yc62JnIgszDCkPo6yMAMXTMh9/WH8GwHHS+
	tw1XVgmeqprHcDeoT8mobgvDY=
X-Google-Smtp-Source: AGHT+IGFg5uCIhEU3lcn0qGmOLjSNLHjIAYyVFAFUM7gEwBM59gQGW1r0WNu8Fra1LpnKfzMHn+JxQ==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr293017275ad.6.1760393595967;
        Mon, 13 Oct 2025 15:13:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4cf5:d692:bb78:20c])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f36cb1sm142736965ad.100.2025.10.13.15.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:13:15 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:13:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <aO15eFW430nuXMa5@google.com>
References: <aOQLRhot8-MtXeE3@google.com>
 <20251006193333.GA537409@bhelgaas>
 <v7ynntv43urqjfdfzzbai2btsohaxpprni2pix2wnjfoazlfcl@xdbhvnpmoebt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v7ynntv43urqjfdfzzbai2btsohaxpprni2pix2wnjfoazlfcl@xdbhvnpmoebt>

On Mon, Oct 06, 2025 at 04:13:26PM -0700, Manivannan Sadhasivam wrote:
> On Mon, Oct 06, 2025 at 02:33:33PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 06, 2025 at 11:32:38AM -0700, Brian Norris wrote:
> > > Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
> > > when preparing for runtime or system suspend, so by the time they hit
> > > pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
> > > may still pick a lower state (D3cold).
> > 
> > We might need this change, but maybe this is also an opportunity to
> > remove some of those pci_set_power_state(..., PCI_D3hot) calls from
> > drivers.
> > 
> 
> Agree. The PCI client drivers should have no business in opting for D3Hot in the
> suspend path.

I dunno. There are various reasons a device might want to go to D3Hot
some time before fully suspending the system, and possibly even before
runtime suspend (or they may not support runtime PM at all). For
example, on the first step on my alphabetical trawl through

  git grep -l '\<pci_set_power_state\>' drivers/

I found a driver that supports some power-toggling via debugfs, in
drivers/accel/habanalabs/common/debugfs.c. It would take nontrivial
effort to evaluate every case like that for removal.

BTW, we even have documentation for this:

https://docs.kernel.org/power/pci.html#suspend

"However, in some rare case it is convenient to carry out these operations in
a PCI driver.  Then, pci_save_state(), pci_prepare_to_sleep(), and
pci_set_power_state() should be used to save the device's standard configuration
registers, to prepare it for system wakeup (if necessary), and to put it into a
low-power state, respectively."

So sure, it should be rare (like the docs say), and it's probably
redundant in many cases, but I'm not that interested in shaving various
drivers' yaks right now. I'm just fixing a (small) performance
regression in documented behavior.

> It should be the other way around, they should opt-out if they
> want by calling pci_save_state(), but that is also subject to discussion.

FWIW, that's also documented in the above link.

Brian

