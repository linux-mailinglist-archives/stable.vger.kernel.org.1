Return-Path: <stable+bounces-267195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gr0dCtlANGr/SwYAu9opvQ
	(envelope-from <stable+bounces-267195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10B6A2474
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:02:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lNzC74sl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267195-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267195-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2983052880
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0E3E3DB4;
	Thu, 18 Jun 2026 18:58:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9E2E7380
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 18:58:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809086; cv=none; b=nMRjfN+okvokU6JznnZKcd4cBxCcXu7XwOTcutQWqZ9leu+BH2or1Ei+iKa8o1LszJ8h6ODvxlOB9AY3S87l4DuzkKP2rIJFdBNHNxlSiza4lPl4h18u3Ht0MocDfsh6too98e5HTLt8qPERbVUlV5fVcJF+fL8oX8x7zNKTaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809086; c=relaxed/simple;
	bh=PD6CHh12XmvOzKqEhPnlPddPvwTRfUqT40UI+Wz7KZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz24TTxououAImZF/reIA3vdDDPzAxXq4mKjkF/kyKHo8rZmMlwoM9/Ll+5SJZUdTG2HClN9vFFxhEEImgZtgBZfXi5WZ/gmTpRWR5Y3UVh+uDf/sAecIAUqpou5EMTpJNfHMsJOdMQX9XZWxgm5A9Vr5w6KReQuFHyMN14sYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lNzC74sl; arc=none smtp.client-ip=91.218.175.174
Date: Thu, 18 Jun 2026 20:57:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781809081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccRwH1M9+EU8H0Zn/3IoMPQP/R82XHic9JmeEjLVWNs=;
	b=lNzC74slItOJob95QVJFnMjXkZVw079r7zo+HtHEUoBGMFNu3qGyeWDFeC9Ko3JHGMcw+d
	OlKXj2G1TRswuGsSFEoDq2kDElQD1kLIH+wp0nwkmc+AulZhYozRgV9zXvK+mFMpcPHM1p
	R3odZB//Mnqlw0CbJN7clptVx4NN3cQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Message-ID: <ajQ_tNrz5hkS1MmB@linux.dev>
References: <20260617130417.36651-4-thorsten.blum@linux.dev>
 <20260618045400.GCajN56AKctO0qB-sF@fat_crate.local>
 <ajQI0mJwobsGHj6F@linux.dev>
 <20260618163856.GAajQfIDh0s31VINiS@fat_crate.local>
 <ajQx7dBWRuRFuKwE@linux.dev>
 <20260618180412.GBajQzHB3Rj0SrS1Eo@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618180412.GBajQzHB3Rj0SrS1Eo@fat_crate.local>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267195-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bp@alien8.de,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:fanc.fnst@cn.fujitsu.com,m:stable@vger.kernel.org,m:bp@suse.de,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B10B6A2474

On Thu, Jun 18, 2026 at 11:04:12AM -0700, Borislav Petkov wrote:
> On Thu, Jun 18, 2026 at 07:59:09PM +0200, Thorsten Blum wrote:
> > On Thu, Jun 18, 2026 at 09:38:56AM -0700, Borislav Petkov wrote:
> > > On Thu, Jun 18, 2026 at 05:03:46PM +0200, Thorsten Blum wrote:
> > > > get_cmdline_acpi_rsdp() can truncate it into a different, parseable
> > > > address and use that instead.
> > > 
> > > How?
> > 
> > The buffer has 19 bytes to hold the "0x" prefix, 16 hex digits, and the
> > NUL terminator.
> > 
> > cmdline_find_option() copies only bufsize - 1 bytes, but returns the
> > full argument length. So for example:
> > 
> > 	acpi_rsdp=0x0123456789abcdefx
> > 
> > gets copied as:
> > 
> > 	0x0123456789abcdef
> > 
> > which boot_kstrtoul() parses successfully. The user supplied an invalid
> > value, but we silently use the truncated prefix as the RSDP address.
> 
> My question stands:
> 
> "Or are we protecting people from shooting themselves in foot now too?"
> 
> Especially users who should know what they're doing...
> 
> IOW, how far are we going to "protect" here?

Only far enough to avoid using a value the user didn't actually enter.

A user can still shoot themselves in the foot by using a syntactically
valid but wrong address. The check only rejects an overlong acpi_rsdp=
value after cmdline_find_option() reports that it didn't fit in the
buffer.

We already reject values that boot_kstrtoul() fails to parse; this is
the same idea: the copied string is incomplete and shouldn't be parsed.

Thanks,
Thorsten

