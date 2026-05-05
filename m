Return-Path: <stable+bounces-244139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJzkFn3o+WmdFAMAu9opvQ
	(envelope-from <stable+bounces-244139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:54:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84944CDFE5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5613A3002782
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A3423A9C;
	Tue,  5 May 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="V3lNqB6Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0E37CD54
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985656; cv=none; b=szoZD9Hs3bCEBJHUd01/m8HimXZkJGWcjvYb/JpFNkwejel0EnkncAAKd7d5OOWIUh9f6Ut1z/Fyxg+89zoAGICsxutW2FUHny5jpQMKF3SUE3vqe1fhz5Tcoo1CWkQIM3YpfpTKehcDAa9L5UvCHKhNQwU3lG/RAzUqlokPnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985656; c=relaxed/simple;
	bh=97dcqovbHD0hlxgjvuKPi4RQ7TGsWrKChMfLAXdeKSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+5kXn1Vo57/8XEeJCmY6JNKyjxXJ71nhR5cOntoqx10N7fglfCff4JwJnffaHRy5jooY8VEJWnfj5ofsrRaquxyuy4rcxh5xSuDPLbPFE4fdvC0oEstF+MpFH5UbuilHd43ACIUUQbBquFsn35JCsY7AXFvQ7HGQyQemqwzlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=V3lNqB6Z; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so2306930fac.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777985651; x=1778590451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ixHlQF/6N+sd7aWPsMAhIdhMfBiCGbCBVVjJcBst60=;
        b=V3lNqB6Z879k6pmtD2ZTJhUK6Ds65/u3CPQk7ku8w83Q6AHloAGDhypCC6kvYJcCLZ
         P5UNk4zi8MCZByqTfKrcMoWSU5RaLYOqgUZV7jtaX5oPz14RzgevBsBf3BhiU2XP/JK+
         DFvXCAs8vnpV5xV/+0zTBKoEPIM2aZowrWE+JCgliGSGEpyGJNFxo3AxPfkZO88OZrkA
         B4JH2FE8h4s8iexgEyryGeua/Kofh9GZMS89B3rdq/nZsMjyVZ3g/yZ9xMxQS25fi0ud
         RLImNTt3ayrXELCZ6dqDqhFInxFXvkBfdEGZ8M+e7yLGpL83TFRWx1sQAUN1nS5faYb7
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985651; x=1778590451;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ixHlQF/6N+sd7aWPsMAhIdhMfBiCGbCBVVjJcBst60=;
        b=c5B7imoQSN62eNP39OX59YroB+oBUg27+nBnhGYqDH00bF7RP+KlVkC4I987fzRnTu
         TCln2LS6oF1tJaPx75QfbQwftOAOcoA1Znnm9axcv93x+UkU7ZWP3bbbJUs5oVzwqrMy
         L9x0wFlci8/WCvVWEeAhH0vi+VB5Wt7pL3z7auSY24w/EvL2kJ6ELitPqCOdJwFecdu5
         pZ9jM0UqMVGnzjR07e74spC11Z5SrF5GCkE9nx+8avgs+orWl5jfT5AmBrgoQDzXIXdJ
         K/ifc6DN9WEphGbWFP5c7l3e1xOHzq3Rqqa3W+SLOpc3yk+DcN0u0rqSPwoA8pRTGB+6
         wTKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZR7XmBBqy/s7CIRsSB7JPa2MYqI4xXnQsWh+5iuz7re0saV8BwClH4RoF5WabNf5vG0aajOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuRobsS5Pu0Vu7Pl8dI74CmWRkQ3u3iobvGE7KduFkZlL3Lwk
	n9b+kLIER8Djw0WC8tY9H6WZLRtcarDFIUGBAmbSNXLANMaycs4ELgK+RjYlJF+wfaNIdXrpRkd
	OBP+E
X-Gm-Gg: AeBDiesTmsAUdTeFM325k/JyLQJhh5h+dj7ltTkWbvZ1POLd9UQ1ybC+Aj2qIpyXWVe
	K/EbOSLfL3msLYg6V879YXhjSFmUiULFKD0Eh9yWiKWdwMZm1NO4z9xDqeu7IIgrFTewAURnDlt
	F/KtJCXFOE6XQSDqoEir+2C1VfMIOEHD1fUHHbOyo+B1UWtdq/OZNXwBS8iVjMPE7ghiqaMyaGy
	VqLEofCGFf1CG70t2Et6s/XeHq4rvsxs6ugpLQknDcN2ivVV3ZT8SrUCO2D/Opqtu8RMzBILE7j
	k3XT/MONPC0bMkNZfMt61sGc3skeG2G+hIzgtKL25MzFsV+ywPzDhaVf/ZCpXjaMp31W42IqnXg
	jT4+nShD35AnS4/EVhbAbURSPRkplvXTfqKo4ga/5lyVf2KCZ5faBDjPkA16FoUWFUxLr+ofCYW
	73sP45+k0OzkF0Nsl57vjIVsaqKyzspoeJINN4SWYtkNiJVbvzdj/F6BuC5k1j+PX0tH0lySQ2c
	snfIZqTwO5lSsosHMRMYD9kH3RonTXARw==
X-Received: by 2002:a05:6870:8197:b0:41b:c797:5953 with SMTP id 586e51a60fabf-434d412d2e7mr1588313fac.24.1777985651507;
        Tue, 05 May 2026 05:54:11 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4a29:1d2:a1fb:6ae])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548ccb52sm13616431fac.1.2026.05.05.05.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:54:09 -0700 (PDT)
Date: Tue, 5 May 2026 07:54:06 -0500
From: Corey Minyard <corey@minyard.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Li Xiao <252270051@hdu.edu.cn>
Subject: Re: [PATCH 7.0 073/307] ipmi:ssif: Clean up kthread on errors
Message-ID: <afnoboEQIXI0aQSk@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260504135142.814938198@linuxfoundation.org>
 <20260504135145.562837603@linuxfoundation.org>
 <2bdd7732-e20d-4d67-8f3e-2b9a9a791edf@kernel.org>
 <2026050523-blandness-calibrate-93c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026050523-blandness-calibrate-93c5@gregkh>
X-Rspamd-Queue-Id: C84944CDFE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244139-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,hdu.edu.cn:email];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[corey@minyard.net]

On Tue, May 05, 2026 at 12:06:29PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 05, 2026 at 11:10:29AM +0200, Jiri Slaby wrote:
> > On 04. 05. 26, 15:49, Greg Kroah-Hartman wrote:
> > > 7.0-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Corey Minyard <corey@minyard.net>
> > > 
> > > commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4 upstream.
> > > 
> > > If an error occurs after the ssif kthread is created, but before the
> > > main IPMI code starts the ssif interface, the ssif kthread will not
> > > be stopped.
> > > 
> > > So make sure the kthread is stopped on an error condition if it is
> > > running.
> > > 
> > > Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
> > > Reported-by: Li Xiao <<252270051@hdu.edu.cn>
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
> > > Signed-off-by: Corey Minyard <corey@minyard.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   drivers/char/ipmi/ipmi_ssif.c |   13 ++++++++++++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > --- a/drivers/char/ipmi/ipmi_ssif.c
> > > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > > @@ -1268,8 +1268,10 @@ static void shutdown_ssif(void *send_inf
> > >   	ssif_info->stopping = true;
> > >   	timer_delete_sync(&ssif_info->watch_timer);
> > >   	timer_delete_sync(&ssif_info->retry_timer);
> > > -	if (ssif_info->thread)
> > > +	if (ssif_info->thread) {
> > >   		kthread_stop(ssif_info->thread);
> > > +		ssif_info->thread = NULL;
> > > +	}
> > >   }
> > >   static void ssif_remove(struct i2c_client *client)
> > > @@ -1916,6 +1918,15 @@ static int ssif_probe(struct i2c_client
> > >    out:
> > >   	if (rv) {
> > > +		/*
> > > +		 * If ipmi_register_smi() starts the interface, it will
> > > +		 * call shutdown and that will free the thread and set
> > > +		 * it to NULL.  Otherwise it must be freed here.
> > > +		 */
> > > +		if (ssif_info->thread) {
> > 
> > This 'if' reportedly needs:
> > commit a8aebe93a4938c0ca1941eeaae821738f869be3d
> > Author: Corey Minyard <corey@minyard.net>
> > Date:   Tue Apr 21 06:50:22 2026 -0500
> > 
> >     ipmi:ssif: NULL thread on error
> > 
> 
> Thanks, now queued up.

Thank you Jiri and Greg, this is correct.

-corey

> 
> greg k-h

