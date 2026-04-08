Return-Path: <stable+bounces-233877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPhZFnFG1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:13:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C16653BBD69
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5F703057AB9
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779F3BED78;
	Wed,  8 Apr 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqZF0DCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561E3BED5F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650354; cv=none; b=kKxvREo2Azfiq8XDT7hRnDog1RZYFwia6zO8tWF/R3EBzr5f+7NNgga+8yBBEKGHh0obJe5wfxSqLqB86felcL3ND5Z6DCNttiWQ33B7poAxgvXh5nZs/DcaM/L7YKUhiHih403q/dDJ1i/OqH/phvDRUsfGGP4E5afMGugxHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650354; c=relaxed/simple;
	bh=+t3ECGfjDU3Jm0nOVmjqUwvL7N6is01X1rzceLr0rf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ted9af9KmkmVlxPjsO650W6lDCFJz8/6AaqKRs9dCMPBS6eLTtENSJJz7OuetG/p5qG0dl77SNxOmRjuPdh2KWRF/qbfQ7o21fkLPhc384Txi7zgnKZHjyF351GQncZU8qZKg3YvJzc3q3nZRns9O81pucWyI8FMm2NOtUKNX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqZF0DCl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so33171705e9.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775650351; x=1776255151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MEtYTVC/R8o3JeFzzDEI2ox+DEqWpYaAESHBwT9e4w=;
        b=kqZF0DCl2nIhn7zH0CpamGOrShtHfr6LUNCKPYMWWVR2UH8tEXQC2j1S0Nk3NxaBvd
         7MtyLW3+S3f2x5yPBXbbvFvW0MT+1capZiZLDVNsDgcAVZEJAvNMPO0setkycQA1NKuA
         2t0WZWO/R/tyx5b6fJMPOKKFB3WKnN3vx0RtLz+JC9WvlT8ppT00YSNIuQFFrfGKxrcs
         w6dF73UUvpyd3xaf6h4DF00kHkpIyYmqMQRqFSwPU/kXrPpmCAQLmwoh93jKX2xdsrAg
         fZbytHd+OkcEpwXq1QnNjJgzWQK9nD2K0buZOxV5L8sQ7vXltymtZmThZPQlbsMdLZH8
         8pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650351; x=1776255151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6MEtYTVC/R8o3JeFzzDEI2ox+DEqWpYaAESHBwT9e4w=;
        b=g6TOncvxcBR4MN5rt0+LLoSN6JBNy3uwTFwA2kbGHmcsx+JGZ4UvGC2DlYbsRnUE5V
         Ae3PHP8dNAi8PpN8XaTFvQh6kx82TGWAf/81HAsnJOqxO54JjUHYaz1zHjZMNUAESMNj
         nVWGdEiqwwYyOJuqmCp+S9Uj6npHBudzR34ChxUJK7USVbmUMh3iM1BPU3suWAre5VvL
         FSOct+K8eNtWYvNiPBqEGLnwWDB/+B2ursBt/jA/SzpOPH3RCcHmAjhNCPcpQ7/WCjJC
         v8Oa1zqKlMbEvKViuDqRBWzKqAhEzaVzTVdd81nq1rkr+fQGrZWSHzce7SFt9JJugGNv
         bgCg==
X-Forwarded-Encrypted: i=1; AJvYcCVvusOPKmST8s/5LmxTqEl4IQ3B2hn70L1Guh4qhz8xlfCgGNk/JgjafpGIQLxKEZHrPBUT57o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMS9nVeXRYMMqrsxu1FgQrL5LN6RCLCCX9WYCKJAhiJsvLX/go
	bgWVZ1tlFI6A3M2urxi5KC4h8R9iZNUsZeo6W4VF3GTSrAt9DJqh/Zb9bH7bK2WT
X-Gm-Gg: AeBDievKFAKYHs0TKtR72WIFJWHt8QKOAU9vKhKlxZv8GsJeVHB0XocIwSpfQ3ZGUTv
	RdHPgfmw+7NM75FgGqrP8bZDAavTQmHsiVjpJKhHu3rd5Stnawl8j7oYKviE2o4Ki7A7UHXmoxu
	4qzbAKcLtE6c2IRuwTht6fqFH1WdVGmsvYsZGZNyjYJNIuDI4LJc/pMf52ccQFI6PSGqeuzJTws
	p+NZZFca9Uekgs29BnqIDcWdJ6n7vim6xyxkBFFyT1I1LIpsxjqebIMfB6W2EQGqS0H1TGByZ5k
	OdE4EC5zwrQ3vNe062Y6Dn9+LWIyGseP3cK1DLaiLBQZPB6ePWHyOQJhyk86ttXd0Tj0pemsJ2h
	W9hVGanOD2ZWySxs82N+3CZFKPxylKVuYIIKznzI/vlSMo0/EZNKQk2C0/eewhfEQOI52oDEUkl
	4zvvUT/nnUXS4gRNslK3AE52CIVpGlH2I7KGtcTc44eAqfvP0V2G7TT/bz5E975UPZzeeJZrKKu
	FU=
X-Received: by 2002:a05:600c:48a8:b0:488:a4d6:69ad with SMTP id 5b1f17b1804b1-488a4d66b42mr108205515e9.27.1775650351364;
        Wed, 08 Apr 2026 05:12:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c530910csm19148255e9.2.2026.04.08.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:12:30 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:12:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tamir Duberstein <tamird@kernel.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260408131227.0824c330@pumpkin>
In-Reply-To: <adY8N2sofhMz-6ih@ashevche-desk.local>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
	<20260406111531.779571d7@gandalf.local.home>
	<CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
	<20260406123232.3dacbe94@gandalf.local.home>
	<20260407160809.48d5fe2a@pumpkin>
	<adYCyvTlIoTdnKcL@pathway.suse.cz>
	<20260408100425.7231966a@pumpkin>
	<adY8N2sofhMz-6ih@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233877-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,suse.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C16653BBD69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 14:29:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Apr 08, 2026 at 10:04:25AM +0100, David Laight wrote:
> > On Wed, 8 Apr 2026 09:24:58 +0200
> > Petr Mladek <pmladek@suse.com> wrote:  
> > > On Tue 2026-04-07 16:08:09, David Laight wrote:  
> > > > On Mon, 6 Apr 2026 12:32:32 -0400
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > > > On Mon, 6 Apr 2026 11:21:39 -0400
> > > > > Tamir Duberstein <tamird@kernel.org> wrote:  
> 
> ...
> 
> > > > Even having the KASAN/KMSAN code compiled into allmodconfig is a PITA
> > > > when you are trying to check that code compiles to something sensible.    
> > > 
> > > This does not look like a good idea. KASAN/KMSAN are very useful
> > > features. People will want to keep them working. Removing them from
> > > randconfig would just postpone detection of the problem. We would
> > > need to deal with it sooner or later anyway.  
> > 
> > True, but when I build an allmodconfig build to check how the asm looks
> > I really don't want them.  
> 
> Isn't easy to disable that in the command line to `make`?

It is a config option, and I think you need to reset it every time you
rerun 'make allmodconfig' to pick up config changes.

You can enable -Werror with W=e, but not disable it if you want
to set W=1.
I did have a patch that let you use W=1-e which is useful.

	David

> 
> > For the 'bot' builds you also want to know whether they are defined.
> > Changes to how things are built rather than what is built can throw
> > up unexpected warnings that are very hard to pin down.
> > 
> > It is bad enough finding things that affect one obscure architecture
> > with a specific compiler version when the compiler just makes slightly
> > different decisions, without having unusual compilation/config options
> > is the mix to muddy the waters further.  
> 


