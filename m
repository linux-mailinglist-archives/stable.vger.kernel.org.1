Return-Path: <stable+bounces-221223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK4zLv9Ko2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:07:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636F1C7EAD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE22430A401C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075423E5595;
	Sat, 28 Feb 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HiOKF5MT"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82263E558D;
	Sat, 28 Feb 2026 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305603; cv=none; b=Z+i27ReMXOzoDbWz0KmAuHXf6Tol9/7VgVgyjhjxlnO2hq7BPbkSlkqscOrNL5jGEzj+RKSicpl68iwFY9l3RVdUPFTP2GPfQffV6D+fwrrichSzg9ITHMSDJ0JTN6w42cN/pDWoBtLHZlkmFeyNHypQ8YdFKpvr3TjU2sYa2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305603; c=relaxed/simple;
	bh=6P9enaKfyxrdmWlDpN5CqOAocDrcYC4Wfw6upmYOnNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJNwr2d8MIsKu5Vbq4ngQmVxW+OseRvbslfSomLB6H4IjJJdZW75WGVnYAc0Fkm8tK5Yn0//TNwd/SCBOFM8gBa+mb27YUaozkYPTFp/IlrMcuVrH0a97hcDFFt9M1UCcEM8Yr+Gb1kExJD12+F3YxjVrgG9sVKzvELaUNqgYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HiOKF5MT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C642440E015A;
	Sat, 28 Feb 2026 19:06:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5ew-1l9oeVzc; Sat, 28 Feb 2026 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772305591; bh=wbeQPiOafkw0nASUI9c15sAtm9STJg5mJ+SWjuXem+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiOKF5MT2Kp5G95HBsytprwX0W7CzweAN/EEDi064pYmdCLqjI7kAwCGaVMANSFPF
	 RzzW6DNsU3/WKap/4+t65AT87k5qTw2WIJnkzUafdSXLPmTUVkSvkdyJTFxWPXn6ei
	 ZXRN5tGViXhd+8/DMggImYWiOWMkBDa1D9aJFGqw95EQCHfngbRhS3F+aWXdIwd3L7
	 +gosUwSIbOsLuPot92dd4B4Y9Kv8ilWwy4OwDkSPGjlNlrDx6CKGhl//6vlMuMtz07
	 tTm12l4HbV+8Iyn6z5odQ7lkSzLgktNeyN6eU2QHOBHPXPIG7hY64PUB4cDSzNlsjk
	 a2k3OfzQ6BOnrGCQtU0KIDZVKNT3/oLU9kMeDQben/dWNvDzMN95rirS70AXqqcSR9
	 tIcYVMzIE4c+DFURWlpSz7H6KLSIOSGqGjiP0jPf1FWYNPSGAHVbvaVDHI+Mzd32UL
	 jdvUsV1RZCaJLRl+HMYSwtWgzJTP8cSYayDAybwLjm+/jttgbDo5JpxgizXa/K++my
	 kSlnKdR5fUQSAZMNx+D82bafa9U8VMdNreccbv54YhtxQ2crUvmJRIYBzbdh9yqM3y
	 ULacJEOUefe0UOA3udoDjaacgBFnjltfmxBUi2zcup2LnSiZuNrlAd2uG1RKfqlTri
	 oXji2CROoLqAv/VOAr0hp8mI=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 420F640E00DA;
	Sat, 28 Feb 2026 19:06:22 +0000 (UTC)
Date: Sat, 28 Feb 2026 20:06:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yao Zi <me@ziyao.cc>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <20260228190615.GDaaM8p65-qJFWzgK2@fat_crate.local>
References: <20260228173704.62460-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260228173704.62460-1-me@ziyao.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[alien8.de:s=alien8];
	TAGGED_FROM(0.00)[bounces-221223-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[alien8.de,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.891];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziyao.cc:email,fat_crate.local:mid]
X-Rspamd-Queue-Id: 5636F1C7EAD
X-Rspamd-Action: add header
X-Spam: Yes

On Sat, Feb 28, 2026 at 05:37:04PM +0000, Yao Zi wrote:
> Zhaoxin C4600, which names itself as CentaurHauls, claims
> X86_FEATURE_FSGSBASE support in CPUID, while execution of fsgsbase-
> related instructions fails with #UD exception. This will cause kernel
> to crash early in current_save_fsgs().
> 
> Let's disable the feature on this problematic CPU and warn the user
> about the quirk. x86_model_id is used to match the platform to avoid
> unexpectedly breaking other CentaurHauls cores with conflicting
> family/model ID.

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  arch/x86/kernel/cpu/centaur.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> index 81695da9c524..3773784ba6a9 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -108,6 +108,29 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +/*
> + * Zhaoxin C4600 (family 6, model 15) names itself as CentaurHauls, it claims
> + * X86_FEATURE_FSGSBASE support in CPUID, while executing any fsgsbase-related
> + * instructions on it results in #UD.
> + */
> +static void fixup_zhaoxin_fsgsbase(struct cpuinfo_x86 *c)

s/fixup/disable/

> +{
> +	const char *name, *model_names[] = {
> +		"C-QuadCore C4600"
> +	};

Why is this an array with a single string in it?

> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(model_names); i++) {

So that you can loop once with it?

Silly.

> +		name = model_names[i];
> +
> +		if (!strncmp(c->x86_model_id, name, strlen(name))) {
> +			pr_warn_once("CPU has broken FSGSBASE support\n");
> +			setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +			return;
> +		}
> +	}
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

