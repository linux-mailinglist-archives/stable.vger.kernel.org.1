Return-Path: <stable+bounces-134638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E4A93C21
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B64C188424E
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFD218AD4;
	Fri, 18 Apr 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e69irpG1"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDD2AE8C;
	Fri, 18 Apr 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997839; cv=none; b=czvCGOXrq/FNNJQB2igvTrnVjLbWiv8QQKdzFtUyODb8D3rh4n4qIkcpZznUQEoxhk6kBi2+85ZxlM3NazVdeupQ9/gW/W7htq8LSvGvzE2lMrl/4YEmKmGOfh+r4UsdZTDL8qmdj1iZ/b5pSWU9rxWrInJVqd7zNbcHQ4WzATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997839; c=relaxed/simple;
	bh=nBmCipnBYBtC93GcnvzRAKXGqP/Kr7xCEtJLO8u/CdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3EZL+Fz2PlJxtxkQmVKbT58Wx4OOtpAop0RmqFoAjKfR8a/zOccm98tEQgfHvtf8JwBN/MdYPydYuN/OApuscUsgHpkpLd4eu5IeOpVuSZq6oLTgx15hUbljWgZr4Kf6oI5TJ530nvLsIWVxyYSo5jVhgMSWAczMBvSFt+ED94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e69irpG1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0729140E0214;
	Fri, 18 Apr 2025 17:37:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SVSRx4Ac5zuv; Fri, 18 Apr 2025 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744997827; bh=/OsAeQQ1ATmyDMbNXu/5LHgwBNX2gfsJooSlRYXisVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e69irpG1iZQwHWn4p26oLIyI+h4WVBiQopLXmSMDU0NmfetwbytFs14ENX4/HMv66
	 SXgVwinYeciMPHXG79i05l5+sa3+z2n5iX1PqU3Jh2HmvjULG6Eiu90/avthPH4GjH
	 eivcWttYM+ziVTgBhyFucYApgX9GGorgtgWRDoJW9A6osEnBEjeY4jpjHW/3JK1KIF
	 4yjLAx76INEFWQW3RxsHG3A2tgkBs3fCL+3whYFtiWz3zeekwuboq0V19hdvEFXOPC
	 wDljKFBqOzehYm+W2SljsbTMhTh+SyoSMVuVoAJVx8VlMSoHO9+cZOJDj0NuAw3K1V
	 dI2scwi/kr4eNY0B0Rf9huopUmnfQSRt5TleoJVbPXWaeAvTKloGs2mtNaigei/FBb
	 jGz8tLFvacMnV30iqteKXCGIlSZbXTR+mDgxsNT/NA/GqWRYd79aM+F+640ZdSjub5
	 pEKdyz2tU6mwcET2wNXSFx6tKh9axCrhP/J1+i41pMyoNKkqj8XPuNuJ9mvewa9gUD
	 uRg0nyIJQW31PblpUA4PH2FRKcfUVRgRCMDKbjhSZmVrZYdp42w51knJg6M89cchgM
	 F2KlkJjXKPPsEspseKtbq2D9BKUMrucc/t3iqWFuLQ2xMZFD64jIFVcRx3ljVNQWq9
	 7yPtm/Z7q/Qcd9HRWkjtuICU=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E05E40E0200;
	Fri, 18 Apr 2025 17:36:50 +0000 (UTC)
Date: Fri, 18 Apr 2025 19:36:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	darwi@linutronix.de
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear
 X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual
 machine
Message-ID: <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-2-sashal@kernel.org>
 <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAKJkrQxp5on46nC@google.com>

On Fri, Apr 18, 2025 at 10:19:14AM -0700, Sean Christopherson wrote:
> Uh, and the hypervisor too?  Why is the hypervisor enumerating an old K8 CPU for
> what appears to be a modern workload?
> 
> > I'd say this is not good stable candidate.
> 
> Eh, practically speaking, there's no chance of this causing problems.  The setup
> is all kinds of weird, but AIUI, K8 CPUs don't support virtualization so there's
> no chance that the underlying CPU is actually affected by the K8 bug, because the
> underlying CPU can't be K8.  And no bare metal CPU will ever set the HYPERVISOR
> bit, so there won't be false positives on that front.
> 
> I personally object to the patch itself; it's not the kernel's responsibility to
> deal with a misconfigured VM.  But unless we revert the commit, I don't see any
> reason to withhold this from stable@.

I objected back then but it is some obscure VM migration madness (pasting the
whole reply here because it didn't land on any ML):

Date: Tue,  17 Dec 2024 21:32:21 +0100
From: Max Grobecker <max@grobecker.info>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Max Grobecker <max@grobecker.info>, x86@kernel.org
Subject: Re: [PATCH v2] Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8()
 on AMD when running in a virtual machine
Message-ID: <d77caeea-b922-4bf5-8349-4b5acab4d2eb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

Hi,

sorry for my late response, was hit by a flu last days.

On Tue, 10 Dec 2024 13:51:50 +0100, Borislav Petkov wrote:
> Lemme get this straight: you - I don't know who "we" is - are running K8
> models in guests? Why?

Oh, I see, I missed to explain that, indeed.

This error happens, when I start a virtual machine using libvirt/QEMU while 
not passing through the host CPU. I do this, because I want to be 
able to live-migrate the VM between hosts, that have slightly different CPUs.
Migration works, but only if I choose the generic "kvm64" CPU preset to be
used with QEMU using the "-cpu kvm64" parameter:
 
  qemu-system-x86_64 -cpu kvm64
 
I also explicitly enabled additional features like SSE4.1 or AXV2 to have as
most features as I can but still being able to do live-migration between hosts.
  
By using this config, the CPU is identified as "Common KVM processor"
inside the VM:

  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 15
  model           : 6
  model name      : Common KVM processor

Also, the model reads as 0x06, which is set by that kvm64 CPU preset,
but usually does not pose a problem.

The original vendor id of the host CPU is still visible to the guest, and in
case the host uses an AMD CPU the combination of "AuthenticAMD" and model 0x06
triggers the bug and the lahf_lm flag vanishes.
If the guest is running with the same settings on an Intel CPU and therefore 
reads "GenuineIntel" as the vendor string, the model is still 0x06, but also 
the lahf_lm flag is still listed in /proc/cpuinfo.

The CPU is mistakenly identified to be an AMD K8 model, while, in fact, nearly
all features a modern Epyc or Xeon CPU is offering, are available.


Greetings,
 Max

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

