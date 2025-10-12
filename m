Return-Path: <stable+bounces-184112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72607BD06C9
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917621893E9B
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8C2EBBBC;
	Sun, 12 Oct 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ETxmNZEV"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6F21FF49;
	Sun, 12 Oct 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285879; cv=none; b=RMdsoaXEyWmx1Ob0MuzCXQ3F2wRcbWGRgeDwdK5l7rkjcUog1VCrXL9l7Et29u/elQNNcDYoLZFwaWEFQh9cG+XIt282BfzbQqNdBbn4hDDVcirffDjylKYWXTHVOrV4O39PCZUIVgCjYAEHUi03bG3UiW7KYPuZw2aOv9Oslk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285879; c=relaxed/simple;
	bh=+IssMN716sz1qM0563fe4m6SNHJl+CEnATk8Tq8D6CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFbA8ArNgVPU63j462VCMggV75/zgjC81iqeouUr10wbvaPS/P8AOK/1ofK3LXOJro2hg+YMkZMgrVVJjPnCOUeINN6m5p45BKbSxPCRPHXGDJR1UCp/wMdQXH4q3sJquu5CsF/NExCmbHdx87MZILTS8DGKGBfzybFhD6yeilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ETxmNZEV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E7B4640E019B;
	Sun, 12 Oct 2025 16:17:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FDAVJtRq5NpK; Sun, 12 Oct 2025 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760285869; bh=FdZcfzIU4sUZFrTHdbRlCNu+DnrdIPzBWECNM/ENhIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETxmNZEVHpklDhaxBYfYZ3VO2CLqnjclRa3X5RIw59Yo8ObrvBnIvnVxJSD6evvZF
	 joCiVjDwCvV6WVh8/GhmgAZi9AV5rYaiWEI53he9wz4wdILq4clu/SPgZfCUNz6KzU
	 YgkhP4cBG1mJMgqBUbSyr0BwKDmlSP6FAJ3T2KozM4+3ZsziQ60kayWHU/RsNFSMEK
	 F/pgV8fcWpP5KVp4KMXS7fswH6mvTygdY3sYP4GnZd1S4cJomLsEThJCSTFWxFPFJl
	 EmJIUSQXpuLpV08vrDmQGPfaSJFF1bDZp4QAijAlKGMyc/+cq504zImywf8TqwTaff
	 XMCvfM0/2BcI4zXz6+2SFq8HWTZjv4Z4+e2/oiw0ePyIyvzHjNFSyLLfYozrxfyG5L
	 2S6fiEZNxyxRkcTi0RZqzZx7CW26tze9/F+A/EEuQQECvS/DApPo8/Dgy7uoEa3QFa
	 oK6ahu9QbHFGvmCyjmJkVg3fNcF2l6MRP1WD4U4mtEtLR4Lw8y53EYQh469xoF/qrq
	 L9kzchpQkmaUkV4aFbExO+qyIQx35DQavry9eCq0prZNuRK8CYSMi3ICbxlgNaWaP2
	 B9DJMNKDaz/kvHAztXD0UIkAingCYb/xu95AUVUi99uA69stz/fbnHfq65FtAGguo4
	 mJU4E6TAnwspwHmKsf/6ya54=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EEDA340E016D;
	Sun, 12 Oct 2025 16:17:39 +0000 (UTC)
Date: Sun, 12 Oct 2025 18:17:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: Patch "x86/vdso: Fix output operand size of RDPID" has been
 added to the 6.16-stable tree
Message-ID: <20251012161733.GAaOvUnV8pgVvLs2i_@fat_crate.local>
References: <20251012142017.2901623-1-sashal@kernel.org>
 <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
 <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com>
 <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com>

On Sun, Oct 12, 2025 at 09:10:13AM -0700, H. Peter Anvin wrote:
> Ok, that's just gas being stupid and overinterpreting the fuzzy language in
> the SDM, then. It would have been a very good thing to put in the commit or,
> even better, a comment.

The APM says:

"RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction into the
specified destination register. Normal operand size prefixes do not apply and
the update is either 32 bit or 64 bit based on the current mode."

so I interpret this as

dst_reg = MSR_TSC_AUX

which is a full u64 write. Not a sign-extended 32-bit thing.

Now if the machine does something else, I'm all ears. But we can verify
that very easily...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

