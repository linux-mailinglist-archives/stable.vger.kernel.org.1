Return-Path: <stable+bounces-271663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWIoHCBkR2ppXgAAu9opvQ
	(envelope-from <stable+bounces-271663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542406FF867
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:26:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=b2bnoQRR;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271663-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271663-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 564C230074C4
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B5349AE0;
	Fri,  3 Jul 2026 07:26:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173F33E348;
	Fri,  3 Jul 2026 07:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063578; cv=none; b=Qw3VOlW4lt8qtWj7grt5S+bLDLKjWtTYt60o3JxbUa183+g+jWqCTVf87FrnQmdtooTTUQFlSLANUB/BJa3ge4/d/kfVoUuTlQQ0VHzlJZvof4heYGjHUqhTtaJ2QDdjDATveE1zwYWjkiM8nVuOCqFJv7AR6dFFEVLYlwOzUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063578; c=relaxed/simple;
	bh=82ace4T1QLf1ORYfFcQKnl1kimk7Al4BqNVye0ifHvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv1XgtggE514J0cQQ2de4v+727+EAVwXkx3waIVaGVo7UPk5uZS1SYzfjix0nb3bhZ/W2Z8foZSp5D0ZLgSpCEycuFWHIws47EAcGTM2U2EYW8wo/AU7B17YIlpDRZeCgrtjN1ldcow/YmjrGpRFK6XGHhRJAovqRsTGNq/gE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2bnoQRR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B2C1F000E9;
	Fri,  3 Jul 2026 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783063577;
	bh=Y09hamLsk2lFCfUJqQ/uF+LdBEsQeHwi17uiwPsXhY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2bnoQRRhHGw2qL2GPXKNwBmNZ1Y7rzJSGiYIKglcuak7OMfMHlDuKj4j7sU/JEdX
	 yJPVjkVHvTKRSh9cKB93j5B7VhTgwZzQ153m2nqXukhKnfbUFPuTJhyQ8ZCTWNcFrL
	 BDFBb2gQHr1BSbto4+U1UUKZcPqFcE6Qw4mOvYT0=
Date: Fri, 3 Jul 2026 09:26:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Yanko Kaneti <yaneti@declera.com>, Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH 7.1 097/120] riscv: kfence: Call mark_new_valid_map() for
 kfence_unprotect()
Message-ID: <2026070321-manhunt-sleet-c3fb@gregkh>
References: <20260702155112.964534952@linuxfoundation.org>
 <20260702155114.965608834@linuxfoundation.org>
 <6c5c0723-66c6-4f9f-8021-2562efc95c6e@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5c0723-66c6-4f9f-8021-2562efc95c6e@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wangruikang@iscas.ac.cn,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:yaneti@declera.com,m:pjw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271663-lists,stable=lfdr.de];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 542406FF867

On Fri, Jul 03, 2026 at 01:05:30PM +0800, Vivian Wang wrote:
> On 7/3/26 00:21, Greg Kroah-Hartman wrote:
> 
> > 7.1-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Vivian Wang <wangruikang@iscas.ac.cn>
> >
> > commit 8d6c8c40e733b3fcaf92fed0a078bba2f6941a3b upstream.
> > [...]
> >
> > --- a/arch/riscv/include/asm/kfence.h
> > +++ b/arch/riscv/include/asm/kfence.h
> >
> > [...]
> >
> > -	if (protect)
> > +	if (protect) {
> >  		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
> > -	else
> > +	} else {
> >  		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
> > +		mark_new_valid_map();
> 
> Please also backport this commit's parent, the introduction of
> mark_new_valid_map():
> 
>     9ee25d0a70ff4494b4e1d266b962d0a574ef318a ("riscv: mm: Extract helper mark_new_valid_map()")
> 
> before this patch.
> 
> IIUC this is needed on 6.12.y, 6.18.y, 7.1.y.

Now fixed up, thanks!

greg k-h

