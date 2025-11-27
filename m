Return-Path: <stable+bounces-197099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12465C8E722
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031AE3B1333
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87096274B23;
	Thu, 27 Nov 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hkjoh9+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A192144C7;
	Thu, 27 Nov 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249775; cv=none; b=odATcemZrdecZpmAMSTrDZeazPUXWXIZeUajGoVQMjUkxL5QXD0EJ6nTKmfa4HUOD2CxwcyGpviqyXZINrzPSMDKKKhz8y10TLOL5p+lWSXdBw3ADMiT9y0KlrppdiPa5t3bGBeQ1kMCwOsE/dL3qMwyw92YV0mSoNDHr+0rgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249775; c=relaxed/simple;
	bh=fKnNQFz4tv55GMgNw8e8PjfVCK5DPLfPqiUHl0YKqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCOe4ybyoGZ13iOaqhF6n0jha2kLmm9z49uZjKbKXloiad+DKDuShQADO9Mln+jHkRKLjKOXqVz5OP6U1NnT3uLADk26TM4J3Wyeey8v2sr/Bmi9+9KLkv+Mgsml2p1usR2SfrP3HFjyjlEA3Cfcx1vPFJka844T7VCTAi/TmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hkjoh9+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4350BC4CEF8;
	Thu, 27 Nov 2025 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764249774;
	bh=fKnNQFz4tv55GMgNw8e8PjfVCK5DPLfPqiUHl0YKqFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hkjoh9+aVPzj2eWkf42gDBRAGQL9KAsnSAuuXGTcfsofOOLRo1XgSIZRbjalHnAq3
	 MFvS5RAtyYZ+gaOeRkAWCv2FXOiOHJQxIS3BD5SWf/nt2UXb9jEdlrYZLgpl4BXIWj
	 9qzturn565vsCsi2r37iNtwix3Jc5QdTLQx7QLe0=
Date: Thu, 27 Nov 2025 14:22:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Guenter Roeck <groeck@google.com>, kernelci@lists.linux.dev,
	kernelci-results@groups.io, gus@collabora.com,
	stable@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
Message-ID: <2025112730-sterilize-roaming-5c71@gregkh>
References: <176398914850.89.13888454130518102455@f771fd7c9232>
 <20251124220404.GA2853001@ax162>
 <CABXOdTfbsoNdv6xMCppMq=JsfNBarp6YyFV4por3eA3cSWdT7g@mail.gmail.com>
 <20251124224046.GA3142687@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124224046.GA3142687@ax162>

On Mon, Nov 24, 2025 at 03:40:46PM -0700, Nathan Chancellor wrote:
> On Mon, Nov 24, 2025 at 02:35:26PM -0800, Guenter Roeck wrote:
> > On Mon, Nov 24, 2025 at 2:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Mon, Nov 24, 2025 at 12:59:08PM -0000, KernelCI bot wrote:
> > > > Hello,
> > > >
> > > > New build issue found on stable-rc/linux-6.12.y:
> > > >
> > > > ---
> > > >  variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer] in drivers/staging/rtl8712/rtl8712_cmd.o (drivers/staging/rtl8712/rtl8712_cmd.c) [logspec:kbuild,kbuild.compiler.error]
> > > > ---
> > > >
> > > > - dashboard: https://d.kernelci.org/i/maestro:5b83acc62508c670164c5fceb3079a2d7d74e154
> > > > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > > - commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
> > > > - tags: v6.12.59
> > > >
> > > >
> > > > Log excerpt:
> > > > =====================================================
> > > > drivers/staging/rtl8712/rtl8712_cmd.c:148:28: error: variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
> > > >   148 |                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> > > >       |                                          ^~~
> > > > 1 error generated.
> > >
> > > This comes from a new subwarning of -Wuninitialized introduced in
> > > clang-21:
> > >
> > >   https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e
> > >
> > > This driver was removed upstream in commit 41e883c137eb ("staging:
> > > rtl8712: Remove driver using deprecated API wext") in 6.13 so this only
> > > impacts stable.
> > >
> > > This certainly does look broken...
> > >
> > >   static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
> > >   {
> > >       u32 val;
> > >       void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> > >       struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
> > >
> > >       if (pcmd->rsp && pcmd->rspsz > 0)
> > >           memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> > >
> > > Presumably this is never actually hit? It is rather hard to follow the
> > > indirection in this driver but it does not seem like _Read_RFREG is ever
> > > set as a cmdcode? Unfortunately, the only maintainer I see listed for
> > > this file is Florian Schilhabel but a glance at lore shows no recent
> > > activity so that probably won't be too much help. At the very least, we
> > > could just zero initialize val, it cannot be any worse than what it is
> > > currently doing and copying stack garbage?
> > >
> > 
> > Or backport the patch removing the driver ? It is in staging, after
> > all, so I don't know if there is value in trying to keep it alive in
> > 6.12.y.
> 
> That would likely not be the end of the world for 6.12.y but this
> warning appears all the way back to at least 5.15 (the point I start
> caring about warnings because of CONFIG_WERROR).

No objection from me to delete the driver from all of the stable trees :)

thanks,

greg k-h

