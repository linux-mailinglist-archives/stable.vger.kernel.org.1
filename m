Return-Path: <stable+bounces-106197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C787D9FD4FF
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAC1883CCC
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47C1F37D4;
	Fri, 27 Dec 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oysBi4xp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072018870C;
	Fri, 27 Dec 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735306496; cv=none; b=kZBzbqVYm41GZv8feUtNdWf1zLPjtpDFO+Sey+8PwNuDhw9rL1JAP3M5uL0VpXXAGjsLkbnYUHnariPXm4VBAOyXdrEjBjJHihN5qTLBZnW1VloMs0BYyeM/1xRpEYCn0d6ct60YobUN19yLRz7cyxkPbCjHixwBO+ZLnRutT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735306496; c=relaxed/simple;
	bh=7xxYILjX/jFVpdJ0p3yM21IZYo7rwX5MoSQ+F4HbZ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d72iVy+mXCs7JZjGeHDMmgWZu3IEGvBlFvnIqWqpQvdJKiFnUkhLtPmY1dOk1lIBUCHm0CedeIdpQKYkSsxihkVu7SYKR5zxXOYBFvW8to423KK84WTCPpuyQ9K7L/DLXIuBBBMwaiuvxus0ApPGrbLJKlpVFGH3ox+4HgVO/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oysBi4xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421BC4CED0;
	Fri, 27 Dec 2024 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735306495;
	bh=7xxYILjX/jFVpdJ0p3yM21IZYo7rwX5MoSQ+F4HbZ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oysBi4xph2dXUrPKYHSNezAGEouiCfRdGRTBpKm+ce2aYNelsLLTkjk2NvG85QK63
	 DD0QH03ofRI4yJF3djKXHVkAjA8d0k360SIWAQYTFXdfyfaCbCQkv+JgOYRe1dKkQW
	 nhG5rD0rm7LYAZ7AdmXs0I19U8o2Sfj9qYSKzL90=
Date: Fri, 27 Dec 2024 14:34:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Message-ID: <2024122711-dab-submarine-a475@gregkh>
References: <20241223155408.598780301@linuxfoundation.org>
 <CA+G9fYt+k1m9oTuuZaGyTXqg+EKsSTnmfsc2HYijDWmEjx9xFg@mail.gmail.com>
 <87y102r27e.wl-maz@kernel.org>
 <2024122713-vacant-muppet-06eb@gregkh>
 <87ed1tp8df.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed1tp8df.wl-maz@kernel.org>

On Fri, Dec 27, 2024 at 01:23:40PM +0000, Marc Zyngier wrote:
> On Fri, 27 Dec 2024 13:04:11 +0000,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Dec 26, 2024 at 01:41:41PM +0000, Marc Zyngier wrote:
> > > On Tue, 24 Dec 2024 19:12:40 +0000,
> > > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > 
> > > > On Mon, 23 Dec 2024 at 21:31, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > This is the start of the stable review cycle for the 6.12.7 release.
> > > > > There are 160 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > 
> > > > The following test regressions found on arm64 selftests
> > > > kvm kvm_set_id_regs.
> > > > 
> > > > This was reported and fixed by a patch [1].
> > > > 
> > > > * graviton4-metal, kselftest-kvm
> > > >   - kvm_set_id_regs
> > > > 
> > > > * rk3399-rock-pi-4b-nvhe, kselftest-kvm
> > > >   - kvm_set_id_regs
> > > > 
> > > > * rk3399-rock-pi-4b-protected, kselftest-kvm
> > > >   - kvm_set_id_regs
> > > > 
> > > > * rk3399-rock-pi-4b-vhe, kselftest-kvm
> > > >   - kvm_set_id_regs
> > > > 
> > > >  Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > This is totally harmless, and if anything, indicates that the *fix*
> > > is doing its job, and that this patch *must* be backported.
> 
> I think I caused the confusion here, as "this patch" refers to the
> original fix which has been queued, rather than the patch to the
> selftest, which I don't consider a candidate for backports.
> 
> > Ok, but for some bizare reason someone stripped OFF the Fixes: tag,
> 
> "Someone" == we, the KVM/arm64 maintainers.
> 
> And that's on purpose. A selftest patch doesn't fix anything, and I
> really don't want to use the "Fixes:" tag as a type of dependency.
> Additionally, these tests are mostly pointless anyway, specially this
> one, which really should be deleted.

So should I drop something?  Revert it?  Add a new commit?  What is
going to help solve the issue that we now have selftests failing?

still confused,

greg k-h

