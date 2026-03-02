Return-Path: <stable+bounces-222683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHxDBr/lpWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:32:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822551DED6B
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A1E6301D973
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B947D941;
	Mon,  2 Mar 2026 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kp2N98Iz"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F647D93B;
	Mon,  2 Mar 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479928; cv=none; b=S78GLemj50v7Diyh8qgUSb+FazCZDeT/E1S97N74r/0f1c/c8M3tmF+s7kLHX5qPfJQifPlGcDp715ObgY2qDwkO3jLdZSwsteroyCl3HqTwo+8H4/zkwMKcR/j2pIp1EK34VevKtgS4z+iXrPKOIgqmKjWbfK/PRi7FwLjZd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479928; c=relaxed/simple;
	bh=q/6dL5rAtVKO0i0wKmj/EK5pRzFUoK3R2KT6IgRiRX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGUp1L2c6N7jZ54CSmVVHTJvf8b/8qDMB3qFLo45Xkdjbx8+4tzrq3YiBbA06PSke6c4z7Y2/T1UfhWkl5OeRTuCBR1B6l41j1ne5ai1aF3N10i6XeEH9fhpqw5Zu5k8D9411gEaFtojtwpO+OWySnQ6Puwgf8xZh2uagpNIvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kp2N98Iz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADE1A40E0174;
	Mon,  2 Mar 2026 19:32:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id li0joR9ULUlv; Mon,  2 Mar 2026 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772479919; bh=JkNsIxKBYcaSC+UpgDNjGaubt6khyt+YwVeqhHLOWNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp2N98IzThHilpobGs/PokGCfOAvx2/1xmOG0CkypDrjp1tsPDnbXaXzV/fquZzZ7
	 Pi4C18nsnoUdFEZ30YIUQzmyGo2jF5XICeciKbvusEZzoW43Zk/0ZMKqkNXfQ73c5F
	 Hp4ksbKJhuipyWPqgBaSQTVHUSdzkMdUcOvtGyzeZA++rFVmz92BnUESTBRYaYryLp
	 KroR7jp2fRN8lL/2cIQmG5min1inmitPWPjCxKPREpm+0pEN8kM2FFhKVo4yarWNU9
	 c6vOL7bsFtgHeyY08eFTqWnp2eh3Zjs2CjMim5bbcqiXO/2VOWtOsbaVjACX/ZxAqM
	 0g+4EHiHDiIyEKokvq6q0oGJEzouvaHDav30BSAGOgNvkzV13dsLtvzNOvVbRI7+k8
	 kU3Vg0X20Cbm0bMHlalhh7WpqgG7i5CPH1RMkeGQ5JL1QtF0yfBRWoFJM1SY3p4Mwi
	 OZodqFU7jf3O94k02XBwkyKM4YJ7VDuw3mMgsCw962Z+NkCybbIobc+cJDwm1LleZn
	 imBtVfMfg60OuDXmCWJz5ut/Gyef5nQJfZ2bwd7+yJxPicG/f4pOOXhFwljyEeM4Ba
	 qzfaqpRjkfkq7yhTXl8/6ZZYBoNUTct2aregM1buUvttuANWmI1kyx7NqIlw710HjV
	 q8yvnFzj4v980JWZCu5KAhaw=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 24FA140E016C;
	Mon,  2 Mar 2026 19:31:49 +0000 (UTC)
Date: Mon, 2 Mar 2026 20:31:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Message-ID: <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me>
 <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
X-Rspamd-Queue-Id: 822551DED6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222683-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,fat_crate.local:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:25:10PM +0000, Maciej Wieczor-Retman wrote:
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> 
> If some config options are disabled during compile time, they still are
> enumerated in macros that use the x86_capability bitmask - cpu_has() or
> this_cpu_has().
> 
> The features are also visible in /proc/cpuinfo even though they are not
> enabled - which is contrary to what the documentation states about the
> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
> split_lock_detect, user_shstk, avx_vnni and enqcmd.
> 
> Once the cpu_caps_cleared array is initialized with the autogenerated
> disabled bitmask apply_forced_caps() will clear the corresponding bits
> in boot_cpu_data.x86_capability[] and other secondary cpus'

All your text: s/cpu/CPU/g

> cpu_data.x86_capability[]. Thus features disabled at compile time won't
> show up in /proc/cpuinfo.
> 
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220348
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Cc: <stable@vger.kernel.org> # 6.18.x

So why is this going to stable anyway?

What is the serious issue this is fixing? Really...?

> ---
> Changelog v6:
> - Remove patch message portions that are not just describing the diff.
> 
>  arch/x86/kernel/cpu/common.c       | 3 ++-
>  arch/x86/tools/cpufeaturemasks.awk | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 1c3261cae40c..9aa11224a038 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -732,7 +732,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
>  
>  /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
> -__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
> +__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
> +	DISABLED_MASK_INITIALIZER;

DISABLED_MASK_INIT is kinda obvious already.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

