Return-Path: <stable+bounces-225532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPy1FCr1t2mfXQEAu9opvQ
	(envelope-from <stable+bounces-225532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:18:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850C2995BB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 411ED3019FCD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223A3947B3;
	Mon, 16 Mar 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYdD6gKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F5394464
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663249; cv=none; b=E6OSCz6fJONiflgC+pfz4Eh5mIZ212NC5nt6rCBWz5IMM0Daul4dQbPaaUmVfDwfuswa2Vr6dAMqr/pm+kexhLpl5Exme3d/F4K78Hh7MFKHp21bbjihqYhYDH4KcruWTegGFumSVMvFxSIYUcvVPfhkS98xu1vmr+WofYnMIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663249; c=relaxed/simple;
	bh=kwQsfV7e3ynNaqwmAjynjPHLqXcCxDtNfOGXPNyHymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjAQOPXkgUbXsS+dk6d+d4InuYVrqpU2OE21gV3MnBkcqMeWwm2SkTXfm0bZYsUnoCYqpS3dT/LKIYbixuDxorYXvVdZPBzNR/C/FdJVTT/3NSxjGTvGqvX9DDtpYaBuH9QbrYVPt9E9ucnhM9IZ8n+NX26u9jl1iCjhdjp/upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYdD6gKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C45C4AF09;
	Mon, 16 Mar 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773663248;
	bh=kwQsfV7e3ynNaqwmAjynjPHLqXcCxDtNfOGXPNyHymE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYdD6gKboZR3GwPYZHzv9LWaxtFR3SiSG7/ntJ3o5pZs44r1brGO+YAaVMJdV6h3f
	 a4Rs80f7VWXXDau7jHrfPL7bPn84NQpvXNbUg3UpExwMO8ibJD3ZsUNT3I8Fy6wWwR
	 19gckBH1BL57zbcznhI41E61P/4XVe28ukMfhSkRGuXaquGM0mrMQrOSDpGTZCKyud
	 QFhbuUgjwTnsvyIqUtSJmnbToj1J3EFhHLacE92ZtKhxY5MpD3NxH1IGORQc6fZ4/b
	 CCHNoVVLukk2+bFegdGOsBxg4728AJHn+aXwEHUGogZRLkl4dsd1WadxUJD5bRp5CE
	 I5/YiEi01AHwQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6ACDBF40071;
	Mon, 16 Mar 2026 08:14:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 08:14:07 -0400
X-ME-Sender: <xms:D_S3aULN0h43O6sHfl1mNLpUnBCc2oKEO6nXYGmybdl56NRX9F6Y-g>
    <xme:D_S3aVUEJjayw7hGi_rYuxndgwnW9fgYWUuwrJ5D99LMYvHyhvvJDFev0le_jU5JZ
    lNALsdJClR-sdXjW4P02IAyGqqjiJDyTCgN1cqzFK-fw1lSQchH8R8>
X-ME-Received: <xmr:D_S3aVIgK8-Te6WKDYeN0IDmRntswR6SwVVjWiExB7LtKP7Cp5O1LZNaeHISGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeigfdvtdekveejhfehtdduueeuieekjeekvdfggfdtkeegieevjedvgeetvdeh
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvvg
    drhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphgsohhn
    iihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsvggrnhhjtgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsphesrghlihgvnhekrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:D_S3aazySViLmH0ELwDzINX5KVTUEJ5ja6x495NNyoBr2_r96xEiJw>
    <xmx:D_S3aRJDeBKIyv05tJmWe5LpEm99DnT-_L-31eYn8b2RPokTzjME9A>
    <xmx:D_S3adSaFsizCV08Sj5-zojDzDNKnIngCZpNLXW3rzsokhWIiU5ZwA>
    <xmx:D_S3aXjCAA9sSTxm1ucfQb-Cp4g8tD8Yq0sNjdYebykoqdSZ4gQLlQ>
    <xmx:D_S3aWrcn_zXaM4rx0yRApQ48ytP-GljOIBTvG1OyAYQNw-aaipRRxVw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 08:14:06 -0400 (EDT)
Date: Mon, 16 Mar 2026 12:14:04 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Kai Huang <kai.huang@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, seanjc@google.com, 
	rick.p.edgecombe@intel.com, tglx@kernel.org, bp@alien8.de, mingo@redhat.com, x86@kernel.org, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vishal Verma <vishal.l.verma@intel.com>, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Message-ID: <abfzX_OcpVYNrOnE@thinkstation>
References: <20260312100009.924136-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100009.924136-1-kai.huang@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225532-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5850C2995BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:00:09PM +1300, Kai Huang wrote:
> TDX can leave the cache in an incoherent state for the memory it uses.
> During kexec the kernel does a WBINVD for each CPU before memory gets
> reused in the second kernel.
> 
> There were two considerations for where this WBINVD should happen.  In
> order to handle cases where the cache might get into an incoherent state
> while the kexec is in the initial stages, it is needed to do this later
> in the kexec path, when the kexecing CPU stops all remote CPUs.  However,
> the later kexec process is sensitive to existing races.  So to avoid
> perturbing that operation, it is better to do it earlier.
> 
> The existing solution is to track the need for the kexec time WBINVD
> generically (i.e., not just for TDX) in a per-cpu var.  The late
> invocation only happens if the earlier TDX specific logic in
> tdx_cpu_flush_cache_for_kexec() didn’t take care of the work.  This
> earlier WBINVD logic was built into KVM’s existing syscore ops shutdown()
> handler, which is called earlier in the kexec path.
> 
> However, this accidentally added it to KVM’s unload path as well (also
> the "error path" when bringing up TDX during KVM module load), which
> uses the same internal functions.  This makes some sense too, though,
> because if KVM is getting unloaded, TDX cache affecting operations will
> likely cease.  So it is a good point to do the work before KVM is
> unloaded and won't have a chance to handle the shutdown operation in the
> future.
> 
> Unfortunately this KVM unload invocation triggers a lockdep warning in
> tdx_cpu_flush_cache_for_kexec():
> 
>   IS_ENABLED(CONFIG_PREEMPT_COUNT) && __lockdep_enabled && (preempt_count() == 0 && this_cpu_read(hardirqs_enabled))
>   WARNING: arch/x86/virt/vmx/tdx/tdx.c:1875 at tdx_cpu_flush_cache_for_kexec+0x36/0x60, CPU#0: cpuhp/0/22
>   ...
>   Call Trace:
>    <TASK>
>    vt_disable_virtualization_cpu+0x1c/0x30 [kvm_intel]
>    kvm_arch_disable_virtualization_cpu+0x12/0x80 [kvm]
>    kvm_offline_cpu+0x24/0x40 [kvm]
>    cpuhp_invoke_callback+0x1b0/0x740
>    ...
> 
> Since tdx_cpu_flush_cache_for_kexec() is doing WBINVD on a specific CPU,
> it has an assert for preemption being disabled.  This works fine for the
> kexec time invocation, but the KVM unload path calls this as part of a
> CPUHP callback for which, despite always executing on the target CPU,
> preemption is not disabled.
> 
> It might be better to add the earlier invocation logic to a dedicated
> arch/x86 TDX syscore shutdown() handler, but to make the fix more
> backport friendly just adjust the lockdep assert in the
> tdx_cpu_flush_cache_for_kexec().
> 
> The real requirement is tdx_cpu_flush_cache_for_kexec() must be done on
> the same CPU.  It's OK that it can be preempted in the middle as long as
> it won't be rescheduled to another CPU.
> 
> Remove the too strong lockdep_assert_preemption_disabled(), and change
> this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the
> more proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
> conditions that the context cannot be moved to another CPU to run in the
> middle.
> 
> Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
> Cc: stable@vger.kernel.org
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

