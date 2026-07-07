Return-Path: <stable+bounces-272360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mymqFvmlTGpfngEAu9opvQ
	(envelope-from <stable+bounces-272360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 09:08:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2421718486
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 09:08:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=VrFm2b+0;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272360-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272360-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67DD300CC91
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D61A6813;
	Tue,  7 Jul 2026 06:59:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105443AC0D0
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407571; cv=none; b=VbokZdpUhZ74cAwPeP7SwGK8HNUJ52ybkAzYQj+4wWZvOiAw4YoOHU6kKp80b7Lomx1Riycy2YEFPa1bURl3vUiBJRrBXhPvkYXPrlhq/XI2kqMRi8Mu3RyccPSOrLHb+Tp6Ve6Rgdo+8OqBRyY02PHNYXPWhpfTSc7bh6J7/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407571; c=relaxed/simple;
	bh=vIxIQqpTIhDDpxaWL/KxlpymPgYqFIm+IIELYKWx95k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4NjxXIh0yFadJaQumLxayySbUarWd9npivv+TuWtLJcci0vLc6qQBCIz6sdlnrwWMxiQbfP/qUxbrnxM4iLKwW2VWHhBiZU0VQVc3iNncp+vW3tUyveNl8VN3DLzQEm1xXpAy/tLRy1x0KV1yVpPQJeHQANMvJOLnbF0k0wMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VrFm2b+0; arc=none smtp.client-ip=91.218.175.177
Date: Tue, 7 Jul 2026 08:59:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783407567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3mZO7NTFKwd7aHo5QwYs5BUY5MkVsANllXsSCa2qZE=;
	b=VrFm2b+0l3DoRENXcu2oq2+VoUSPORFXWwBWSpMDShvNzdUzeQux2FVSRMbWyi7PZesnE6
	icAHh1s7Y8EC9bFxgk5HBn+5/6R8DbllGINY5Ep+Q8u3x1nqo3F9hwlX7k5FYRHJPoIweP
	J25P0up1nNwqJCdsByOUKUsimX69ZmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/boot: Reject overlong acpi_rsdp= values
Message-ID: <akyjyoPhYdmzYyvl@linux.dev>
References: <20260621170010.276591-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621170010.276591-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:fanc.fnst@cn.fujitsu.com,m:stable@vger.kernel.org,m:bp@suse.de,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2421718486

On Sun, Jun 21, 2026 at 07:00:10PM +0200, Thorsten Blum wrote:
> cmdline_find_option() returns the full length of the acpi_rsdp= value
> even if it is truncated. However, get_cmdline_acpi_rsdp() only checks
> whether acpi_rsdp= is present and does not reject overlong values that
> do not fit in the buffer.
> 
> Reject overlong values and warn to prevent boot_kstrtoul() from parsing
> a truncated value and thus from silently using the wrong RSDP address.
> 
> Fixes: 3c98e71b42a7 ("x86/boot: Add "acpi_rsdp=" early parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Drop the newline as warn() already prints newlines around the message
> - v2: https://lore.kernel.org/r/20260621131836.175468-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Warn on overlong acpi_rsdp= values (Boris)
> - v1: https://lore.kernel.org/r/20260617130417.36651-4-thorsten.blum@linux.dev/
> ---
>  arch/x86/boot/compressed/acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index f196b1d1ddf8..aed27604c11f 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -184,10 +184,15 @@ static unsigned long get_cmdline_acpi_rsdp(void)
>  	char val[MAX_ADDR_LEN] = { };
>  	int ret;
>  
> -	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
> +	ret = cmdline_find_option("acpi_rsdp", val, sizeof(val));
>  	if (ret < 0)
>  		return 0;
>  
> +	if (ret >= sizeof(val)) {
> +		warn("acpi_rsdp= value too long; ignoring");
> +		return 0;
> +	}
> +
>  	if (boot_kstrtoul(val, 16, &addr))
>  		return 0;
>  #endif

Hi Boris,

Could you please take another look at this when you get a chance?

Thanks,
Thorsten

