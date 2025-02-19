Return-Path: <stable+bounces-118236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54685A3BAF8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B53E188C9A5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC41D5170;
	Wed, 19 Feb 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5B6YAD/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fi1XoGpA"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAD1CEAC2;
	Wed, 19 Feb 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959165; cv=none; b=HSEhq94u6NDveei9Wg3jdWrJOMoIkvAIgsU+Ae0ADITfPgdRKcVaSnco2U/asVT1qC2dFpcNOqmTHW7NrBpkDJHLCjtnDlExdw3bTgYuXwO1jbKXRvknUTgzwuQHpLnKV7IM/RVlWGc1UT0f+k2e8QBOyOoKNwnnNaviY2/Mdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959165; c=relaxed/simple;
	bh=13rpN6RTVCPeZGKlFoTLIzdTpkJJJNelH1GQ6W4+ZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOi+zT8wAqxAMU1ODEPCSn5ibZR8t4dvanZhp/r7KG9owY7SrwaUIrrLnO6CII9rg1AYyuvDq6SWHgP/7lKZ7Pyur0o+tf32sSYtEE1DpBvj/ZvGiVsySQdPHEJJAqeGZ8E1VCLcfniVsQT0jZSmvKD6igoUc546p29ObJ7HZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5B6YAD/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fi1XoGpA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 10:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739959161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C153Tu4Vj3ShkD8eHOv/1QP0HltMFJWGJLPHp5KkfUQ=;
	b=B5B6YAD/E1zTnWabZBVWgkjVC2xNha7wchC1a/Si4dDWvNO7F7K27Gd9W86a5twmELyj6c
	3yXsevoxVmmknanAgZE4sToMtnNpWM1FUL2y+5sSdga4hig0rRftX4h9DD3eNYh0Ue0gL8
	gjEHGFNXKPB0a8otXbj92ndapCXD67vqa1O6isMudppCRNeXIx6uvEIGcorCvSeJr2LV9P
	dv7qcnIXCC6y9MHKZTxvREAMRwX/imumxt1ad8O6lGXAdbz//Sx1jOBJeICqvXw9VBAqE/
	CfyVr1wGCbKFGw2zMO4f+v8PzTRenUW8DhjfgVb3IKvd0bE1DP7fyRgEUACj/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739959161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C153Tu4Vj3ShkD8eHOv/1QP0HltMFJWGJLPHp5KkfUQ=;
	b=Fi1XoGpAJgXRJJU7FWX+z65r3W86TCwHXQ6i3TNzHBeV7YV9ihxOSWaO3XAdGtBfOz/Ew1
	UqUH9o6oxz9WCGCA==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "joseph.salisbury@oracle.com" <joseph.salisbury@oracle.com>,
	"williams@redhat.com" <williams@redhat.com>,
	"groeck@google.com" <groeck@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"stable-rt@vger.kernel.org" <stable-rt@vger.kernel.org>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Ziegler, Andreas" <ziegler.andreas@siemens.com>
Subject: Re: [External] : Re: Please backport: netfilter: nft_counter: Use
 u64_stats_t for statistic.
Message-ID: <20250219095920.DcfuDtUZ@linutronix.de>
References: <20240927155656.Z-s6BO9B@linutronix.de>
 <20240927144126.0dba172a@gandalf.local.home>
 <bab856cc-7c9f-4ee9-84f6-ab228b2648c0@oracle.com>
 <20241004073934.501MFrgf@linutronix.de>
 <7f82afc61cee2ab48e204bd472674b8e7d457a5e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f82afc61cee2ab48e204bd472674b8e7d457a5e.camel@siemens.com>

On 2025-02-19 09:24:37 [+0000], MOESSBAUER, Felix wrote:
> On Fri, 2024-10-04 at 09:39 +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-09-27 15:01:00 [-0400], Joseph Salisbury wrote:
> > > Is it needed in all stable release patch sets, including v5.15?
> > 
> > Yes. I would appreciate backporting it all the way where the code is
> > available. The dependencies
> > 	1eacdd71b3436 ("netfilter: nft_counter: Disable BH in
> > nft_counter_offload_stats().")
> > 	a0b39e2dc7017 ("netfilter: nft_counter: Synchronize
> > nft_counter_reset() against reader.")
> > 
> > were already routed via stable.
> > The problem is that the seqcount has no lock associated so a reader
> > could preempt a writer and then lockup spinning.
> 
> Hi,
> 
> this needs to be backported to all stable RT trees (just checked 4.19
> and 6.1. 5.15 already has it). We observed the reader live-lock issue
> in "nft_counter_fetch" on 6.1.120-rt47 (leading to a system stall) and
> were also able to find it with lockdep (see stacktrace below).
> 
> I'm wondering if this patch could be applied to linux-stable, even if
> it is just a performance optimization on non-rt kernels (not a fix).
> 
> The patch "netfilter: nft_counter: Use u64_stats_t for statistic"
> cleanly applies on 6.1.y and 6.1.127-rt48.

I assumed the backport did already happen. So at least 4.19 and 6.1 is
missing you say.
4.19 will remain at missing it because it is EOL.
6.1 would be Clark's department.
Could everyone please report what the status on backporting is?

If you want to pull the performance card and route it via the stable
tree, I suggest to ask the netfilter people if they object. And then it
might work.

Sebastian

