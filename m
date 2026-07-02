Return-Path: <stable+bounces-270538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FCBFJ6R1RmpMVwsAu9opvQ
	(envelope-from <stable+bounces-270538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:28:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4726F8E04
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VLRG5QSx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270538-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270538-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FDCC3010F53
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C7494A08;
	Thu,  2 Jul 2026 14:23:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D41D86E4;
	Thu,  2 Jul 2026 14:23:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002195; cv=none; b=ip+lXsWmRuWvjANho70vOOWIEPo3ae50PHGqsOlA0xaQ8lPeYXs+b6GpwBqhjFj5u8EhH0LQpTLAYuJ7Zv42KKbziZvEEgos8qY/kIwwfcgJWHE1/Yv213k4aj1u20cluXp+PqcZJwB2upnohbfcZcD2KokqrkgCMxSmjLMFs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002195; c=relaxed/simple;
	bh=N9CiUzfveiKSfNKcnnofw5fkXZVWxTpVPfEpxdad3H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjhYWEHo3F6ITmKDRioQh1cuYoWX5foVG2chaUKvB1+HUxkh1RkZA0Gkm+VKNRa3AJpDtOhrksPZvRPPEYUosNLzeDRmR2AKd29NHh7wNABqsgHKsexxw2xwG8BCRqyAvlYBclLgtDXfqkoqKX3Mz6gtwX7jOoKvqU0WDFp/oMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VLRG5QSx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C21F000E9;
	Thu,  2 Jul 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783002194;
	bh=TvMG/L57vNYBQCE2dS+MQv8x6hlxZY8ENHAizbR5Un4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VLRG5QSxyrZqqwlmQEyMrrrXaEf20kAus7K/6Gl5G5kYtELjRvMNFn7bxdT7ENpY4
	 mkdgoqiiIoXiDnljaxrhHHR57jUGjKhjHaxej/mQ1BxGugYYrc6w4uiqMDtCzgKJaz
	 ybt5wBtdjRP+F/pm0laMnWc9OqodLwvpawtx2pQk=
Date: Thu, 2 Jul 2026 16:23:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, x86@ekrnel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in
 resolve_full_path
Message-ID: <2026070259-slider-mortality-f9ae@gregkh>
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
 <20260617011303.3969027-2-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617011303.3969027-2-clrkwllms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:clrkwllms@kernel.org,m:stable@vger.kernel.org,m:bpf@vger.kernel.org,m:x86@ekrnel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270538-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C4726F8E04

On Tue, Jun 16, 2026 at 08:13:01PM -0500, Clark Williams wrote:
> [ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]
> 
> strchr() now propagates const when passed a const char * argument in
> newer GCC/glibc combinations, causing -Werror=discarded-qualifiers to
> fire on the assignment to next_path. Declare next_path as const char *
> since it is only used for pointer arithmetic, never written through.
> 
> [ clrkwllms: only the next_path change from the upstream commit applies
>   to 6.1.y ]
> 
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks nothing like the original, including stripping off the tags :(

Please be more careful when you resend a new series.

thanks,

greg k-h

