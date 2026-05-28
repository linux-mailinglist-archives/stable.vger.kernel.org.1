Return-Path: <stable+bounces-254696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GINjCwCMF2o5IwgAu9opvQ
	(envelope-from <stable+bounces-254696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:27:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D45EB3A3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 000AD3056BF8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D2186284;
	Thu, 28 May 2026 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqqrjKfV"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC934389A
	for <stable@vger.kernel.org>; Thu, 28 May 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928061; cv=none; b=bdVblniLxnqpPD1yi3hnjpCrS6wmlqzNVgit9IfzHDON/qftSBEdJjZXwFdgh7oBFaTIUj4QitH+CcKo4soQbXYI0+GorlT4GHvO1FEOh8eX130eYNRyfae1aYNphBa3zigAHDmenr7fi22e6k6nmdwMm9fKLRHMCT2bOvkmjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928061; c=relaxed/simple;
	bh=k70BCV9pAdhjzFIARI+Ubawvc8FC+M1Mfj6MS2sZOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKx/aQd1hzFIL9iqArB5eCFiHShlFJ4i5bjUnUGHNx2y3Oz67rObC8VH7cnUh7v2r6pwQ/TBHRnuzYYDs90HUkRDPfrZcMV3Rg5PRjdsf6adcG3Fzis5zClccB/Z6B8UIl+kaWUSWuqcmEgh7u4rEMiq30C5apCXz83I0Xx2yAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqqrjKfV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 May 2026 02:27:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779928057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zKbehWNz+h1jiPCKn8iLdYzREzuzwUvF0JgyusPZ48=;
	b=cqqrjKfVHKY+tldoJEQJ7PN/XLmb2AxegEpURDqd/7nB2RV/Upg/fPQTRnSzNo/xsx4mzX
	UQvWo1JhRtLgXPfVQ7NSTppF006Bo0M5n/RWAByT9O6JoUPW4vnYc2YuVp6dIo5Rr2FjbF
	xHD2sNxPBf9be1SRU7DGYAg6ciC74Uo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Yinghai Lu <yinghai@kernel.org>
Cc: stable@vger.kernel.org, "H. Peter Anvin" <hpa@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: validate console=uart8250 baud rate to avoid
 early boot hang
Message-ID: <aheL9BylYvUm_6cP@linux.dev>
References: <20260514143014.516303-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514143014.516303-3-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C67D45EB3A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 04:30:15PM +0200, Thorsten Blum wrote:
> When the baud rate is empty, 0, invalid, or overflows to 0 when stored
> as an int, the system will hang during early boot because of a division
> by zero in early_serial_init().
> 
> Fall back to DEFAULT_BAUD when the resulting baud rate is 0 to prevent
> an early system hang.
> 
> Fixes: ce0aa5dd20e4 ("x86, setup: Make the setup code also accept console=uart8250")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/x86/boot/early_serial_console.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
> index 023bf1c3de8b..28a887af430d 100644
> --- a/arch/x86/boot/early_serial_console.c
> +++ b/arch/x86/boot/early_serial_console.c
> @@ -117,7 +117,7 @@ static unsigned int probe_baud(int port)
>  static void parse_console_uart8250(void)
>  {
>  	char optstr[64], *options;
> -	int baud = DEFAULT_BAUD;
> +	int baud;
>  	int port = 0;
>  
>  	/*
> @@ -136,9 +136,11 @@ static void parse_console_uart8250(void)
>  	else
>  		return;
>  
> -	if (options && (options[0] == ','))
> -		baud = simple_strtoull(options + 1, &options, 0);
> -	else
> +	if (options && (options[0] == ',')) {
> +		baud = simple_strtoull(options + 1, NULL, 0);
> +		if (!baud)
> +			baud = DEFAULT_BAUD;
> +	} else
>  		baud = probe_baud(port);
>  
>  	if (port)

Gentle ping?

I also tested this and verified that it works.

