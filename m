Return-Path: <stable+bounces-214376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GANJlsChGk+wwMAu9opvQ
	(envelope-from <stable+bounces-214376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:37:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A9EEE030
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1FC300C595
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D268B2BE7B6;
	Thu,  5 Feb 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KImo6pu+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899B1DD0EF
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259031; cv=none; b=c9XmQ/mOXAh3KLsUrtLfPDzJ1UXAg+eFaieWpTgs7luJBr6pjuxmjiS6IernmBe/nrphWPTD3TtCEfzCj5zIJ7kvegSXT/q63TU1Jp1otyOF0Hzul+V1dMugBL55cuHHNsexbax+MpW6EfEVJYWQtMejjhr/9AdRBZC57+sTOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259031; c=relaxed/simple;
	bh=H8Kfzx9Lp7I6MDK4SPAtfArOuUFA6D2GabWF6wYG2GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiyqaUGNVLNpVHa5a6xEEb1Evw+mepeIuBkSHW9EGY01hfp/XqXSPFlZlkchgnjH3uqJu+viNKCUDQl8cnaIxcLhjLiRZx5GE/xX/bxo1UrOdr4+37aYwg51qlzNpJaO8LI0Hbdn6ojfBO7AF2bjuBu8MDGvHLWL6+/QyQVxozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KImo6pu+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso253627b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 18:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770259031; x=1770863831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9auqBzyZROG6PYPSiRaEXLsqMErIrz1GCxdJvW2tYdk=;
        b=KImo6pu+vkybr8iRAu4/9lK30g0dzu8LrJAdqnoAOF9yB5/e29HC70oI3IEyjtvdQq
         ZflK088sPC7om1LhT47YQc7k8mQaLKeFT2XmOHxP4iCZeGk6YpkoTuAo8kvt1sk7xlBB
         VkRiwIC5JyfSidDvbWHk7W/9+2GCkL4+rrMms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259031; x=1770863831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9auqBzyZROG6PYPSiRaEXLsqMErIrz1GCxdJvW2tYdk=;
        b=vij1YC40m1vWI4iJMSljYv1Tgd9aOWFf3eoiEtuKaQYqZ2k0ZtcDyTRxSUoQw6jikh
         lMC+96QDeneRNolRUnSnB8aK3JTE/Ch/KX9R0cFFS0d+6HWJmFZAuylF/axTgjYySGnr
         4chdDqsfm0Pb6N7fxNYEazIQbsR76tjfGnn+VUbnCxfk7CnHJfrgSmMuDnmozHFQHogK
         3UKN2y9fFG6ea6aI0LUZskMgrLUqUpn8hBOe4xBl2+lxXZAfFSs0X2b7TqQXadaGrRz2
         gHln55BKAAaPAWswtf8eT2u1n8jE2sJQ3kqUyi7I19N9aBeMZ87WGEkdvDLHcx7yJsCR
         IdQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1r9bSxlcHgfsiG+4c7AJVMAJ2NpjH2Ps8AP5TAIvHIVmjSk2A/+HQfbrstjiRibFfnwJBbGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNqdo+L9fTaoYLIOHTvmanmmVF2JpOLfEb0KzjBaU+vjmTrNW
	H2i5Kwvl8vAkLcJ+EvLoVdxVvGj95xaWAGWnxvRL1KRSMZbU3+5yANPEQiY1T7kVAw==
X-Gm-Gg: AZuq6aLQQ7gMlggs3j/Cfhwy5M4hhjDMB1GSIXQyvu38yFIDBu4P2VAV7Rg4jehkLpy
	ceqMQjDT2NjXzV/j34UB3G+oqC1Df9r6uqNyrVDVzb+N+lx/1GfoOlAtQ37P3wsRMclRjQEerRY
	zhuY6VDqX+u/+yXFNVJRa5unhdVK+ES7o8dP0DbRlikossg3mGsDg5EoL9dAueIoMdgn5ui2Kbn
	oYki4ysixOUEuCtvR+zhWuMD6NkycuwpBr2W378shaJVh5KaQyWSLfxJ6tR7+kxRgqNR2H462zr
	8uByiiqq5kPZBBb3HdJ6TD1mkqbICH1wzp1K/g6ZKqECohJqALF3HO9R9y09Hd75qWBfXJiM914
	0Sa7QBD/etP2Y0PN283YOE4zDqdwrKnXyurf5Z7CI2AIC/pl/RZcxAQlvxHvRSqmheSE+v99sIz
	wo/DesAPNcuLvzJi1NC+JLdM+sCM/7aazCNkyYJjRTVA1OyXTuZWbnpgnnHFCKVA==
X-Received: by 2002:a05:6a00:3a14:b0:81f:852b:a939 with SMTP id d2e1a72fcca58-8241c6a6532mr4516101b3a.63.1770259030797;
        Wed, 04 Feb 2026 18:37:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:76ea:a716:1eee:9fa9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16a9afsm3689132b3a.5.2026.02.04.18.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:37:09 -0800 (PST)
Date: Thu, 5 Feb 2026 11:37:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 
	'Christian Loehle' <christian.loehle@arm.com>, 'Harshvardhan Jha' <harshvardhan.j.jha@oracle.com>, 
	'Sergey Senozhatsky' <senozhatsky@chromium.org>, 'Sasha Levin' <sashal@kernel.org>, 
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	'Daniel Lezcano' <daniel.lezcano@linaro.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
References: <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
 <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
 <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214376-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 45A9EEE030
X-Rspamd-Action: no action

On (26/02/04 16:45), Doug Smythies wrote:
> >> What is "established" and "newer" for a stable kernel is quite handwavy
> >> IMO but even here Sergey's regression report is a clear data point...
> >
> > Which wasn't known at the time commit 85975daeaa4d went in.
> >
> >> Your report is only restoring 5.15 (and others) performance to 5.15
> >> upstream-ish levels which is within the expectations of running a stable
> >> kernel. No doubt it's frustrating either way!
> >
> > That is a consequence of the time it takes for mainline changes to
> > propagate to distributions (Chrome OS in this particular case) at
> > which point they get tested on a wider range of systems.  Until that
> > happens, it is not really guaranteed that the given change will stay
> > in.
> >
> > In this particular case, restoring commit 85975daeaa4d would cause the
> > same problems on the systems adversely affected by it to become
> > visible again and I don't think it would be fair to say "Too bad" to
> > the users of those systems.  IMV, it cannot be restored without a way
> > to at least limit the adverse effect on performance.
> 
> I have been going over the old emails and the turbostat data again and again
> and again.
> 
> I still do not understand how to breakdown Sergey's results into its
> component contributions. I am certain there is power limit throttling
> during the test, but have no idea to much or how little it contributes to the
> differing results.
> 
> I think more work is needed to fully understand Sergey's test results from October.
> I struggle with the dramatic test results difference of base=84.5 and revert=59.5
> as being due to only the idle code changes.
> 
> That is why I keep asking for a test to be done with the CPU clock frequency limited
> such that power limit throttling can not occur. I don't know what limit to use, but suggest
> 2.2 GHZ to start with. Capture turbostat data with the tests. And record the test results.


> @Sergey: are you willing to do the test?

I can run tests, not immediately, though, but within some reasonable
time frame.

(I'll need some help with instructions/etc.)

