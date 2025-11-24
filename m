Return-Path: <stable+bounces-196825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE9C82B38
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C734ACC3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8526560A;
	Mon, 24 Nov 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2KG0uby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C17251793;
	Mon, 24 Nov 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024051; cv=none; b=pZYLdObxINlV9WsRFGKdkYgi/sDZE9r5EpOGk1gELi23qjJsAj9dDKCE871kItdOtIwFu+v2N3FylY5m4mH1/BFxpnD2+0u2xSZOZIDZ0LwbbaZClVOo9nzXcmkNjutoYm9Y6G8fWMEUGr1GdkXZDXyu9QC5e8FALdcCLe9Dyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024051; c=relaxed/simple;
	bh=EEzp2ogUOzRXGQs0s5wKs0XxUYNtoSdF1XXYvxAS9L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OejjvKQ77brFFiKPjUimmgYQnGCOaJKlQig59NMgL/z4G/P0mBQVUpef4oOYJCaKDajfgOErf1D/B3wtfODM/ZTKkU9oIH5DtWCbf5j/dHi4eMLNzxSDQLa9NSOJCrGzEWqhrQoqXt3UbQaZ3wE28R4UWeoJI1Upp4GMB+R83U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2KG0uby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69977C4CEF1;
	Mon, 24 Nov 2025 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024050;
	bh=EEzp2ogUOzRXGQs0s5wKs0XxUYNtoSdF1XXYvxAS9L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2KG0ubyztpOJHoPgUvYMkophb1B6wonRo4SFMeSwsgTDnwTckv3OCCBDIPsW/Joj
	 /prMmXgUCbXDsqghAMvsmwGw4Kd4YA0+kEZjm7qZrNkyXbhwa+uZe5eoo4W7k+NZKb
	 mgFYhVTy3YRDfJ8OwHKGOHaaXqU7xe5aYLiWs3DvU3rXfkpIE/bbwdRHrxOUg7Yp+W
	 W4ma/2paTJbCa5/tBAMiAbvR6OcVRVl+xz3v0cwFk1uUY+GX874bxKi4O/kFZk2lNW
	 3JfaZKwYEL3F2U3m4sggRdPFAL7KzRK3g6FqD+b1s4rsJln/GGfGY+ZR5Y1UwR0cCK
	 vE3ayXBiCitlw==
Date: Mon, 24 Nov 2025 15:40:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: kernelci@lists.linux.dev, kernelci-results@groups.io, gus@collabora.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
Message-ID: <20251124224046.GA3142687@ax162>
References: <176398914850.89.13888454130518102455@f771fd7c9232>
 <20251124220404.GA2853001@ax162>
 <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>

On Mon, Nov 24, 2025 at 02:35:26PM -0800, Guenter Roeck wrote:
> On Mon, Nov 24, 2025 at 2:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Nov 24, 2025 at 12:59:08PM -0000, KernelCI bot wrote:
> > > Hello,
> > >
> > > New build issue found on stable-rc/linux-6.12.y:
> > >
> > > ---
> > >  variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer] in drivers/staging/rtl8712/rtl8712_cmd.o (drivers/staging/rtl8712/rtl8712_cmd.c) [logspec:kbuild,kbuild.compiler.error]
> > > ---
> > >
> > > - dashboard: https://d.kernelci.org/i/maestro:5b83acc62508c670164c5fceb3079a2d7d74e154
> > > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > - commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
> > > - tags: v6.12.59
> > >
> > >
> > > Log excerpt:
> > > =====================================================
> > > drivers/staging/rtl8712/rtl8712_cmd.c:148:28: error: variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
> > >   148 |                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> > >       |                                          ^~~
> > > 1 error generated.
> >
> > This comes from a new subwarning of -Wuninitialized introduced in
> > clang-21:
> >
> >   https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e
> >
> > This driver was removed upstream in commit 41e883c137eb ("staging:
> > rtl8712: Remove driver using deprecated API wext") in 6.13 so this only
> > impacts stable.
> >
> > This certainly does look broken...
> >
> >   static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
> >   {
> >       u32 val;
> >       void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> >       struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
> >
> >       if (pcmd->rsp && pcmd->rspsz > 0)
> >           memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> >
> > Presumably this is never actually hit? It is rather hard to follow the
> > indirection in this driver but it does not seem like _Read_RFREG is ever
> > set as a cmdcode? Unfortunately, the only maintainer I see listed for
> > this file is Florian Schilhabel but a glance at lore shows no recent
> > activity so that probably won't be too much help. At the very least, we
> > could just zero initialize val, it cannot be any worse than what it is
> > currently doing and copying stack garbage?
> >
> 
> Or backport the patch removing the driver ? It is in staging, after
> all, so I don't know if there is value in trying to keep it alive in
> 6.12.y.

That would likely not be the end of the world for 6.12.y but this
warning appears all the way back to at least 5.15 (the point I start
caring about warnings because of CONFIG_WERROR).

Cheers,
Nathan

