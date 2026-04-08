Return-Path: <stable+bounces-233823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPZoLw8b1mkxBAgAu9opvQ
	(envelope-from <stable+bounces-233823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 11:08:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3A3B99BA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304F9300A114
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3935A933;
	Wed,  8 Apr 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+JLbXuC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F61C84A6
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639070; cv=none; b=q7lpqM7YQomaDePII6dyr9Bn2MfkvfibXi3FBOGKJSA9CJROnRSzlRbTl9DAZubrx/XTOAR6pGe1ouSMihuFGEo2kjHnZygem36FIHWIai7NXFUjJaRYZDNL7pKuP4vjf8fTyd9iX8EDYdcIajGhmuF+hiRxUHQHHmEv9dxfAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639070; c=relaxed/simple;
	bh=Hf4AR3X4Jku554EJUXICua7KBz3Q+mG+2x5b5uP4zas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAaAWUrbWj93Oi+p/a6+vT7nii4GPfvsNYDYoia0QF4eyXZ6yMKpT26nexpM1WI4xHh4j2/4+l5fU3bcHPvTB3QYCpO11rb3EQxwHzJUOiOEdzRxwm4Hs6+3mZai+yvDENkPrBIIauIR+FtnmKIFazqKu2TxnDIdeDng9LELik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+JLbXuC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so47509135e9.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775639067; x=1776243867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONtgHo/ibMHxFcK/bkUiwx1+imCGkUo9ttALQtsF3Q=;
        b=f+JLbXuC/V2vybscXDYltvTI5ZVN1O/sSocegcp4ASbLfA8FJovF5cHnHzeVRD/+V7
         aWNM7d85TShyZKGcg0Crz+nuZgoGp+CoJInVp2BuJjUIP8f+H/NGFpNh6v4qEM0r82Yt
         C/b9ewPpTyKysofS6RBP741nMvAJIiScUSE6QD0zwJNLtsEsir6sT6ontCUK/kcA8ic5
         TpErIHv8Gcxr+vhX5WA7i2O2stKmKsn2876J1EsrjVR8zsUhum3p8sthPsdj/b2D52CF
         FT6DxxdAvP+SjJa9gALBtS0ey36wSBj1i/C2kBzIkFUwRsZ/ohfdeNNYP9jkS+P/CvJl
         MrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639067; x=1776243867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yONtgHo/ibMHxFcK/bkUiwx1+imCGkUo9ttALQtsF3Q=;
        b=PsfjP6D1PL9lxyHZuKkR5JDR2EUfTHZc+ZZb28RONlP4GiBGnz/aN3dBlUhqa1MtDI
         bb1xJp1JuWcxd24eEG95/HiahVaOSoT7T+x3klAYwXVEJFDHHaloB9mr4j5jEfYyBAjB
         Y8JphDSI2tscLdPWs49/rkYcG1mzbBc5xfQHD+C7TK2IY3yxJiYEClyK4iuZ2EzrY+68
         QiIzHdeSFHxqPQsRZSO48Dorp8CJBlHHBF62UoQ+4t9dhEIS/ByYLfX9X7mibJn2MAuU
         /C/NLlE2nqsXPNQK7jRnhqIFH4dp058LdW5VWSihWkhFq9nL0b+yuVXvOPc6rrXuc7mX
         riJA==
X-Forwarded-Encrypted: i=1; AJvYcCVYGIW4vQSUqRdbcl17XXu/IUugIptjV5pwasKD34xadY7Zd4DigVGKNiT5+qPSLTSjh9WRCSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3UTUVcagVRBy1UuHlDmsUcacF+fRE0vBpv1VrNTNP6rsPesk
	jqCgqNueq4bLzIbr4dXBJ3eKruvuFAi9B7H5sdLA+XgN5o88i6VPnrfp
X-Gm-Gg: AeBDiesx2Iioxm2uWFjPWr7lEZ1CE0pWH78X00ss6fhvGXhbX1F57YpMlcud/MG8Etq
	/DqgGErsdYfb/Xn//ylYjk9zRzHe17IQuRDoA7ZJmlx6eNyaEvZl9tM/RTW6Mrzwqwm+VzlBeEi
	TckBPv5OOuPhsMY9Gy9IihPET5Waa+x23IoMe2hbRBS0Bz+XXMqcbJ9npdujZlUlqG2CuINW6oV
	lRJ5jWww7lUePCEo0u8kQoq+isK1Rs4bINoi/6nncHPgxsZoWumVST3Rs86PsrBagI99e2yYHcg
	ino0fZEQaQjt2BJnVdhtjslAzY4BbWPqj3NEpVLobuK0v9s9ZKdOBsBsy0APv7l594Afm/nYb+p
	nz7v/eXV3kOIazV3ckycfRo7STPaUepmPmrDWIrWCFj7qHjHvwa39kyTw1/R1KrvPkMY2gc9/+5
	FX/f5KYR5p2f7wECabY5tqKqdwbFGIIF5zos5NF2mgeBBzjD7r2CyKq/iMfuuFo4fVcD8kwj9NE
	iE=
X-Received: by 2002:a05:600c:8b46:b0:485:4006:960c with SMTP id 5b1f17b1804b1-4889978e22emr291042355e9.16.1775639066900;
        Wed, 08 Apr 2026 02:04:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c555def8sm16296545e9.13.2026.04.08.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:04:26 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:04:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tamir Duberstein
 <tamird@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260408100425.7231966a@pumpkin>
In-Reply-To: <adYCyvTlIoTdnKcL@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
	<20260406111531.779571d7@gandalf.local.home>
	<CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
	<20260406123232.3dacbe94@gandalf.local.home>
	<20260407160809.48d5fe2a@pumpkin>
	<adYCyvTlIoTdnKcL@pathway.suse.cz>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233823-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,suse.com:email]
X-Rspamd-Queue-Id: 26C3A3B99BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 09:24:58 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Tue 2026-04-07 16:08:09, David Laight wrote:
> > On Mon, 6 Apr 2026 12:32:32 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Mon, 6 Apr 2026 11:21:39 -0400
> > > Tamir Duberstein <tamird@kernel.org> wrote:
> > >   
> > > > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > > > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > > > by default [0], which would probably interact poorly with the change
> > > > you propose.
> > > >     
> > > 
> > > Branch profiling is really just a niche that is enabled specifically for
> > > seeing all branches taken in the kernel. It hooks to all "if" statements!
> > > As you can imagine, it causes a rather large overhead in performance.
> > > 
> > > This option is only used by developers doing special analysis of their code
> > > (namely me ;-).  
> > 
> > Is there any way to stop randconfig picking up options like these?
> > It is rather a waste of brain-cycles trying to fix them.
> > If you want the option to test a specific bit of code it is easy to
> > hack/disable any problematic parts.
> > 
> > Even having the KASAN/KMSAN code compiled into allmodconfig is a PITA
> > when you are trying to check that code compiles to something sensible.  
> 
> This does not look like a good idea. KASAN/KMSAN are very useful
> features. People will want to keep them working. Removing them from
> randconfig would just postpone detection of the problem. We would
> need to deal with it sooner or later anyway.

True, but when I build an allmodconfig build to check how the asm looks
I really don't want them.
For the 'bot' builds you also want to know whether they are defined.
Changes to how things are built rather than what is built can throw
up unexpected warnings that are very hard to pin down.

It is bad enough finding things that affect one obscure architecture
with a specific compiler version when the compiler just makes slightly
different decisions, without having unusual compilation/config options
is the mix to muddy the waters further.

	David

> 
> Best Regards,
> Petr


