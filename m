Return-Path: <stable+bounces-75971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD369764F2
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716C1F249A4
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A5192B9F;
	Thu, 12 Sep 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dkR+Ke+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A1957E4
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131108; cv=none; b=YxEKQPkOYzHkdIOH0h+IKY8bMJBVzDNN//Ozd3rAAq7TVlVxFVcOLAYkKkYcxf3qBCsyH9nz6Z4tIVyD7sQrWWs7L5ijFqTRbd/1LHbdUv0ta2a2E3EupjaxQ5ju4sPVI7adg80HVCXA1gMwLL1SFg95309tqdGNiNXxZjl1Np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131108; c=relaxed/simple;
	bh=jrzdkvA2k4V7QhoZu0ZT4M7IkYxu0cJc/66f2zTK70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCR7oVOLQOuX3i/y3uYdJCCxk/9U1Actjdz0YHBq12Onr3TGUs9keESRDFD92Dag5SEiRRd1WY+n/ipbGXw+Hh0vbjmn2dp1i7xveSG/OlDF2bqDEkVu1AqkH+7HQe3ul5KseWIfeBLvf7fDS9X7nZFIEpI+eQPIdmcLsKYMobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dkR+Ke+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD87C4CEC5;
	Thu, 12 Sep 2024 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726131107;
	bh=jrzdkvA2k4V7QhoZu0ZT4M7IkYxu0cJc/66f2zTK70Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1dkR+Ke+mmMe9jtLyh+fEzu+w5pNPMTCbdN3ke94ntZVfjcpNuKFeKkEDarx4Fd+q
	 c1d1F0e1VR4Oc1Z2p5Bw8+oURplxbBvr6+NcX5f8gjJ1Lx5WPE8jZ+bbfpw3Rgb7DM
	 iyroyZn6ksKzBuLENM/PCxGoIJpGLMb3gEJi+ABs=
Date: Thu, 12 Sep 2024 10:51:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Niels Dettenbach <nd@syndicat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Message-ID: <2024091235-degree-drinkable-5363@gregkh>
References: <5998315.MhkbZ0Pkbq@gongov>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5998315.MhkbZ0Pkbq@gongov>

On Thu, Sep 12, 2024 at 10:48:14AM +0200, Niels Dettenbach wrote:
> Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a 
> special, nonstandard synthetized CPU topology which "just works" under 
> kernels 6.9.x while newer kernels wrongly assuming a "crash kernel" and 
> disable SMP (reducing to one CPU core) because the newer topology 
> implementation produces a wrong error "[Firmware Bug]: APIC enumeration 
> order not specification compliant" after new topology checks which are 
> improper for Xen PV platform. As a result, the kernel disables SMT and 
> activates just one CPU core within the VM (DomU).
> 
> The patch disables the regarding checks if it is running in Xen PV 
> mode (only) and bring back SMP / all CPUs as in the past to such DomU 
> VMs.
> 
> Signed-off-by: Niels Dettenbach <nd@syndicat.com>
> 
> ---
> 
> 
> The current behaviour leads all of our production Xen Host platforms 
> (amd64 - HPE proliant) unusable after updating to newer linux kernels 
> (with just one CPU available/activated per VM) while older kernels and
> other OS (current NetBSD PV DomU) still work fully (and stable since many 
> years on the platform). 
> 
> Xen PV mode is still provided by current Xen and widely used - even 
> if less wide as the newer Xen PVH mode today. So a solution probably 
> will be required.
> 
> So we assume that bug affects stable@vger.kernel.org as well.
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

