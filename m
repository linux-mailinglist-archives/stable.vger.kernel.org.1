Return-Path: <stable+bounces-262575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nx4FJXHLKWrPdQMAu9opvQ
	(envelope-from <stable+bounces-262575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 22:39:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E451166CD8A
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 22:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=AunPGuPv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262575-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262575-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 044FC304A034
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732E481249;
	Wed, 10 Jun 2026 20:36:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48114391851
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 20:36:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123764; cv=none; b=pzkOA4LUN16ywkjbA8LkjxibF7jBvanivY7XyrH8Qgegwaj4xwzc2Opacib7HG3rGAiOpuXC99AbRBSWNUIIeGuB5BCq+bI7OBkxTdawKKr5Sa/7Z/9RgVBSdij1moHknaCalWaxix2/iXgO2hq3MdtPzLrzMPJU25hLkHkMb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123764; c=relaxed/simple;
	bh=wb6GFOtiK08quQqnkJLPY3BdjTCwjV36wrC50UFwjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkIRj5tFcVnMbhY/88zFtRekOO5gRIW/pecLtHOIyUPyP3EdT0Y+96TTK+w6kp4MPWgFp6Zt2VawErT0eWl4jM8qS5z3RDaxDgCy2D9U6dhyA8DrL92V+qaPqclNIp8T9NE9iaI8Ay2/tajMHioFNlpriRee8Ll02JItGTsShhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AunPGuPv; arc=none smtp.client-ip=91.218.175.171
Date: Wed, 10 Jun 2026 22:35:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781123751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2PKffW0yFnOLJ006xyc7fGdbCEocZeEVvYFXi5d+95o=;
	b=AunPGuPv4u5HcwqVIW2LaZMCjN4JCaz8Pg7Ea22zwaiRnQoJbVQ+sQaXkrkJ3wH89x91Kz
	YDZfiw+Q3svoheTjFoTdHvMgGlVfg2FMGR9Y9UQnMDHksYSq9Ie1z5Gv4byOiV5rEacYxU
	a5Z7FcTJVqw3it6oymEc0jzMZvDrKsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix event_size output in
 tpm1_binary_bios_measurements_show
Message-ID: <ainKo2YOGN0hxWwE@linux.dev>
References: <20260522094440.583766-2-thorsten.blum@linux.dev>
 <ahBSJ-hVcVHEWTeZ@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahBSJ-hVcVHEWTeZ@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:colin.i.king@gmail.com,m:harald@redhat.com,m:stable@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:coliniking@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E451166CD8A

On Fri, May 22, 2026 at 03:55:03PM +0300, Jarkko Sakkinen wrote:
> On Fri, May 22, 2026 at 11:44:38AM +0200, Thorsten Blum wrote:
> > Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> > split the output to write the endian-converted event header first and
> > then the variable-length event data.
> > 
> > However, the split was at sizeof(struct tcpa_event) - 1, even though
> > event_data was a zero-length array, and later a flexible array member,
> > both of which already excluded the event data.
> > 
> > Therefore, the current code writes the first three bytes of event_size
> > from the endian-converted header and then the last byte from the raw
> > header, which can emit a corrupted event_size on PPC64, where
> > do_endian_conversion() maps to be32_to_cpu().
> > 
> > Split one byte later to write the full endian-converted header first,
> > followed by the variable-length event->event_data.
> > 
> > Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v2:
> > - Minimal fix without using seq_write()
> > - v1: https://lore.kernel.org/lkml/20260521093639.162095-3-thorsten.blum@linux.dev/
> > ---
> >  drivers/char/tpm/eventlog/tpm1.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> > index e7913b2853d5..0397e3361020 100644
> > --- a/drivers/char/tpm/eventlog/tpm1.c
> > +++ b/drivers/char/tpm/eventlog/tpm1.c
> > @@ -236,12 +236,12 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
> >  
> >  	temp_ptr = (char *) &temp_event;
> >  
> > -	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
> > +	for (i = 0; i < sizeof(struct tcpa_event); i++)
> >  		seq_putc(m, temp_ptr[i]);
> >  
> >  	temp_ptr = (char *) v;
> >  
> > -	for (i = (sizeof(struct tcpa_event) - 1);
> > +	for (i = sizeof(struct tcpa_event);
> >  	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
> >  		seq_putc(m, temp_ptr[i]);
> >  
> 
> This was really good catch, thank you. I'll apply in a minute.

Has this already been applied somewhere?

Thanks,
Thorsten

