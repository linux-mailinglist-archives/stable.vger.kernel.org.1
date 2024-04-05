Return-Path: <stable+bounces-36054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1A899985
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9117C282663
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB661160783;
	Fri,  5 Apr 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y36QyFf2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFxGQjER"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F3142E73
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309608; cv=none; b=lmhSyERN8P+qo/D+qFWBGm2WdAx2fC6oUG0IF6DjMvbh54LRxsXsntI4HO8DCLG3td0xeGi8gPL2YfT/CHrsqd1gDr4lrxCMrJjLYLEr+snsL24uSEbTbo67tdw3Qzaow3mYDX8sJrwHDUl0EK+ZzTt83GysO5iGXGoRZJ4pvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309608; c=relaxed/simple;
	bh=oM8HwKRBrN39Jx6IotPplPlHD3ecXRuQaUSLQUaoDlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3AH68Umg4A57grfvSWGmeUWbAJnVJSQjgDh3Eg33PoIsLjLhF1xNNdl9XySyrcUoW3cBKQw62S09ikM1maZO6mGjB2P7+Mhid7S2/BUlLHLbXwPnpJcb4vnMMby1TqUYzmtiNysL9A8DIst+Edx/gb0ApCWlmrUmaf4KjUHhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y36QyFf2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFxGQjER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712309605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZU9JHChJnO7h91FJFHEKy9VEjq6gMwpAV9HaxePya0=;
	b=y36QyFf2esqn/jAXKpeEUhZ+ywdtDj53njXliQaTQegGmN2nwe9/dZvQumXH9mTkMKrgWL
	tCImXsvIGlhDmLl9XMeJ47OLU5WGUqBJZidY+GvT8ZhTjHe2DiUJXzzWG7/UPnlIswIRts
	hB1CEWx+xRCl+/YCGTZ3TRxhXZDcPNH+wmHgdU+1hV8rEZUqHMNmRjZYR+oB/dp+hu/OBz
	vgytkgJBI9B3jbLsFd/toXq3TQDDPZcPpr7664exZTy2gmjiAFbpuxHUyWj5FyvKI0fzE4
	USZggXpHSMgv6gA+QgnYxJC5WnmSU1yCt8ySYD/6Jnescggh0Cv59Y8Vg9YWuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712309605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZU9JHChJnO7h91FJFHEKy9VEjq6gMwpAV9HaxePya0=;
	b=QFxGQjERVvBCkHrnJOJHu+gkphKpq1RG/2bEAj5LkgyY79fjTWaOQ2Xnzn5LMvPzwc19vX
	502Ti+IQnL3m16Cw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfgang Walter
 <linux@stwm.de>
Cc: stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to
 "x86/mpparse: Register APIC address only once"
In-Reply-To: <2024040445-promotion-lumpiness-c6c8@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
Date: Fri, 05 Apr 2024 11:33:25 +0200
Message-ID: <874jcg9msa.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 17:57, Greg Kroah-Hartman wrote:
> On Thu, Apr 04, 2024 at 02:07:11PM +0200, Wolfgang Walter wrote:
>> Reverting this commit in v6.6.24 solves the problem.
>
> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?

Also can you please provide the boot dmesg from a working kernel?

Thanks,

        tglx

