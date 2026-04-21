Return-Path: <stable+bounces-240049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ge0Caoe52mY4AEAu9opvQ
	(envelope-from <stable+bounces-240049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:52:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08CD4372B8
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD4B300CE53
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A332C94B;
	Tue, 21 Apr 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="St0oLX3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAE276041
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754338; cv=pass; b=WS1GBuukcRo8xWBrgaUaD+3jYMdOxa37IM8Nx+vpYnihFw41EgGnXeTajqZN/CL9CerGbVUkiBg3nshgdDXQBoz76ULZ9x9Efwq/fc44s6PouC6DhfDrXm0c8z/doMAsbHc7oW/C6UVlf6vKgJhuqFGSvKW5STBAUCmXEE2HV7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754338; c=relaxed/simple;
	bh=/bgB+q41EPoWiHWc4t7T/MJYgD7V/pLVyjw45I/8+X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/v1jEU6pW0qbqbulrU+srdJmjO/3lQgF8ZtfHLcRbY/LMX4B0xDeHcjWANOJ9ZcU9g0fMnXu+2L+bLGAouIJOMAUtLCcnuppX2NI0rWr0PizA4fToQQTsjBnASTC+fZmiTovxMiq5W7O/p9ThvVW2L6hc9uoLPK2IObzgavMhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=St0oLX3O; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE7E93F9B1
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776754332;
	bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=St0oLX3Oz1YZYKub0/EMBtLL0MI6O2QZPjFtrnZu+W6yXdgzAeaSIZlFtDMkcLtCk
	 0/uNhZA3GZMerIU2RFsDJMCE2AhtMH5FaYWPhTxNCws2zTV1Thr056kHR5WB8ZSxoe
	 zyNO1tTXkifY9dxqGRcGeOF0ednAdkmb72NsgPTLVU5UdUKyqyhaDTFRL+CwNGWQHe
	 SwJmL6CzvOn/qSRFrY7xIehAiEoYcj79xg+JawlNjTNU2uDqasKIHNAdfjcZ7pLGi2
	 6m57tsfRLK547TOrJU5B3lLBa1u7idJORrWwC3vP4pwMe6IBJqMMzG0BvRGMZXUO96
	 C91z0rSQE/BBlFDps2wUCl2ovWcboIhH/2vk1I+nvq+0pEnX93mj46TTwVzbZRrl0h
	 6M0AR4Ud60K0/Ie+moaxLgqS09NYPRHGd1C5LhMtBlUAD2TBGY41xzVmB3S+CLJyJZ
	 CipUo0RWF3lCmfYbiG1gGYaQtTk+jVGz3O5WBlKF8sawG/i7EQKY6+L+OiNjyHZ879
	 zvk7II5FjVMjmGc1eVRsjyjlcNXlWfwoPntD3O6QSIbxRWwOJc2POP0GaqIfHdhnWx
	 aol94yZm6Su1AdpoyxYD/C7UnamZ9StenSganN1IVeQda+3sXd4PmV15OXloOVFB0d
	 nliBfhD0WqWA4Xmr7IpiZ1OY=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64eb0bbab48so7672735d50.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 23:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776754331; cv=none;
        d=google.com; s=arc-20240605;
        b=Is8CSuMCDyZcY5U7shHdDFGUCjhyciilaG2mdGsUS6OymELdWQ1H2RgHogRbgYf/Xd
         Ec22s8wU9Cy4FZYLA3KfKu6twIy1UjfWQho3Mlq8EWqnwGp0PABYGD5RA8anS7KLUtnA
         zOUzSfWbZh2E3Y2MMBQjqmSjIvBifqn8dN9OwhTmlasnwuB5q3DDwrhuMLcrkoYzkSQd
         KkppS9XlN1moAM7I4DOslvl/rhf8cWcIXQNvS3kLBpGxu9TmbT1I322BtE6b48MEwbX5
         ny2PqGCluSsMwmaJQ2dpojTGQkcOoxhzSCEaSggCnDLi8Yz8NRfNqI4t7/gmrOl+K7rP
         b5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
        fh=sBdhctlOsJu+ge2x/9htl7xTYsOc8yuOP2uhYHYGI6o=;
        b=FGv7KauvNg3PWoWfrPbASbA2eG9sG+e36U5lg00eCfemTuzxDnQ3vhxI0yvok/46sZ
         o5rOMA2mitUCvU6Nhnzm2txdSLvfkkGBl9Xu7VqQzKgfKeFek6T25lkDgqujfPuQMvAg
         gu/7bm89p+VlJXUB79RU8GNatPbTE9+ij0M6KW6lytXgDiOYYB+Fr63ZZxqgAL/vSm7o
         h72Henyzlw3MRkurxnsKEKGXotMqOxilAu79c8nKtuer40LtwQroCFxn0OWOfd10GyH/
         tJZqhr4Aen3LNkEazaC5uww4Rz2iKe/JyifISR3JoIydQjT3HdBjft4xRNfRlZ4tXhBR
         0+Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754331; x=1777359131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+RL2CG72Gfe4A5JJhIqbBZ1B82PnGlL44VaM7GQN14=;
        b=gVC8xCUOze5FKpSA17rQo1a4OCfVCnMOIOW7sHPeqxYrnP+ltiZGcqxrbh8WXynxLG
         J+Wk8YsDJ8dspxylm2ur4NlUg4dgsxis8HtbL/bYSonRTg3JJdlhuCtpASmk9h2XG7ED
         1AqCf2YfG4DKBym7mjTVjevfY9osKdst4pdF35XQNiQZU3PYMCMU+DqulmXbfizXfxdb
         LuKP+KBqQ2zofPMkQHykDfeHosdwI72hTHAuRw7wGWfbiMMCPdJ163RdiwZc5HxElU5/
         ivm2uvuk6RdnbO2Ve+8171RQLtyyasi9L+2XZJ+DPDgAOcErglBeJBIRINBXhuh5OkpV
         l9eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nPirfb71T+c/DvGFVRr+9v10shzd4cMjuytWd1+OUjM5yuan6QvsVr2e20M3y31eSrUXQvdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YgLEwFsQNX3aZTYKR0a78Ywt4UeglwInuUN54nZPFFCTyanF
	riPls4KxOia9823aT7WnYG+SSrnqk777djRCmaPBPmwEP6POhkSAbdKwdDfMz1qMSU+ja/KE9BQ
	ABQ07XPqDNAsx2Byr0CHvYIluUL2d2qR44YNeBQW8yO4mUeJmPHoqpO7/K/eo0NhhTBI2IaJuPu
	8lm7QbnUmLzX/7ORNnRKruxNzKANMc/jGPrfNLZDIG+YAcuMvN
X-Gm-Gg: AeBDieugcmijov35qhe60w/mj2ot+key8l+4K+LrNnC80GBIMd8yNAdwskJK+JqsbF0
	ciCUkPkV3PU02w48JQInTZFaAAQ70BU6azBZp1G8ikW2+VOFvDgkj2LbyCF0y7bxm8zsmpcpBuY
	UoG/kWwqMwlhVTVFWfEvufUh7+ZCO3EV3DGTzp/gqztq9RiYsGdQNYwj4g9MP8ZT0MWeLGmJMar
	U1HAWGcEDbWDHO3KA==
X-Received: by 2002:a05:690e:b81:b0:651:c221:9649 with SMTP id 956f58d0204a3-65311aa1c92mr11125993d50.19.1776754331527;
        Mon, 20 Apr 2026 23:52:11 -0700 (PDT)
X-Received: by 2002:a05:690e:b81:b0:651:c221:9649 with SMTP id
 956f58d0204a3-65311aa1c92mr11125976d50.19.1776754331172; Mon, 20 Apr 2026
 23:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416183529.838321-1-decui@microsoft.com> <aeKW4ESwsoK5La-t@templeofstupid.com>
In-Reply-To: <aeKW4ESwsoK5La-t@templeofstupid.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Tue, 21 Apr 2026 18:51:59 +1200
X-Gm-Features: AQROBzCOYLS9ahTqhC3AsFYzvmOgcBzj6fluavm1dAXUvzYAks3nnodb2akIFHc
Message-ID: <CAKAwkKtNGC9QcRVkyChDnR+1j1GA1ncUpKMspMcmt_kisjbmRA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhklinux@outlook.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_FROM(0.00)[bounces-240049-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.ruffell@canonical.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,templeofstupid.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A08CD4372B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Dexuan for all your hard work and analysis on this patch.

I have tested this patch on Azure with:
- Standard_D4ads_v5
- Standard_D4ads_v6

with the following images:
"Ubuntu Server 22.04 LTS - x64 Gen2"
"Ubuntu Server 24.04 LTS - x64 Gen2"

with the following kernels:
- 7.1 merge window at c1f49dea2b8f335813d3b348fd39117fb8efb428
- 7.1 merge window at c1f49dea2b8f335813d3b348fd39117fb8efb428 + this patch

Without this patch, I could reproduce the issue on 22.04 + v6 based instance
types.

I can confirm that with this patch, v6 instance types can correctly kdump and
create a vmcore correctly and restart correctly without running into
MMIO issues.

I can confirm that with this patch, v5 instance types continue to operate the
same as they did previously.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

On Sat, 18 Apr 2026 at 08:24, Krister Johansen <kjlx@templeofstupid.com> wrote:
>
> On Thu, Apr 16, 2026 at 11:35:29AM -0700, Dexuan Cui wrote:
> > If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the
> > framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
> > there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.
> > This is especially an issue if pci-hyperv is built-in and hyperv_drm is
> > built as a module. Consequently, the kdump kernel fails to detect PCI
> > devices via pci-hyperv, and may fail to mount the root file system,
> > which may reside in a NVMe disk.
> >
> > On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
> > back to the low MMIO base, which should be equal to the framebuffer
> > MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Windows
> > Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
> > is not 0; if the user specifies a high resolution, it's not enough to
> > only reserve 8MB: in this case, reserve half of the space below 4GB, but
> > cap the reservation to 128MB, which is the required framebuffer size of
> > the highest resolution 7680*4320 supported by Hyper-V.
> >
> > Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
> > VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
> > device, so there is no need to reserve any MMIO for it.
> >
> > While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> > the > to >=. Here the 'end' is an inclusive end (typically, it's
> > 0xFFFF_FFFF).
> >
> > [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> > [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> >
> > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
>
> Thanks for the updated patch.  I tested this on the arm64 instances that
> had been failing and was able to confirm that without it present the
> failure still occurred, but with the new patch networking was able to
> attach correctly in the dump environment and kdumps were successful.
>
> Tested-by: Krister Johansen <kjlx@templeofstupid.com>
>
> -K

