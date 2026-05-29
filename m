Return-Path: <stable+bounces-256618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNdNLHOGGWouxQgAu9opvQ
	(envelope-from <stable+bounces-256618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:28:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B360244D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3944D322AC80
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BEB369D6B;
	Fri, 29 May 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKgyE5Ci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHVgbi/z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58E35A3A9;
	Fri, 29 May 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057302; cv=none; b=kZLvEPockjoJBn6Y+kPrbs8T+zRxIdTWzPIBmmtvQcjk34o/2p0mZtFe8CZeCL8MTn3Lql+/Tjz/KYw+xefz5A7ntoRZJo+pwLug5OpfYqU3kSg0gLJcAlfKBmdFocv/YcSmFNn0PiXRrFX0lBnVX5VvBzHU3xaP/ynKQDtZIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057302; c=relaxed/simple;
	bh=K+/FyB5WY2rfHsP/2J2VOpMApdZG6GG+CHiM/Tcqx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RELb1wi3ly+OSM29Rmdcm4GuC9LwJ7y4OYbfW8YAAeKm7ZhmAa3uk6YPrLD/wOoklBj5rlHIvn/hhrxS+U6x/x3xiP1ci040oQLbZiUE6f2hlay099s4eHOqex5S2FVrCtWa9dw7V3lr1dOwb5R1Hophjl/B7Z0a/3ZftRB4Jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKgyE5Ci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHVgbi/z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 May 2026 14:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780057299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
	b=MKgyE5Ci4fmUYnA5JOEnB4n4ljFf5Au4EUx66ry6llbuCwmprN1bF9bi91TPTzfqcPG/rh
	UdAaxjYkl26wGci7upMeJXE4aQsyKimpRJKJgu10pRFDT9zDZe+u7U4jFReNbVB4dBmoG4
	+ng4kxcR1YkcKmhaT0vcTbtHI5S4FWmujTC9+qlywDmoNIa2BUEv9NBG1Cl8k7nAhuvhCB
	Rs15yPqHLzolELj25UgKJia8ckEm+ikv2vKE/CMgmAno0K3n3CLwIm7wE49P3BUYDRDKBz
	IxwTtVBWHzfrNu2G0QG1sHHjqzoatLBVyxmMj4OqGbYxf0X7iJojHr7fdvEkeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780057299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
	b=oHVgbi/zFlD1tQdiDiwM6YKnRLFgyzv6Lnl4DT2HVyxg5F/aj3ru4qKlT7az3qQRzXBfv/
	K0fGA1qi1JoTY5AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
	clrkwllms@kernel.org, rostedt@goodmis.org, jerome.anand@intel.com,
	pierre-louis.bossart@linux.dev, tiwai@suse.de,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Message-ID: <20260529122137.VZtFvQvw@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[seu.edu.cn,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,goodmis.org,linux.dev,suse.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 2D1B360244D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-29 11:50:18 [+0200], Maarten Lankhorst wrote:
> Hey,
Hi,

> It's been absolutely rock stable since the last time I submitted it.
> I've been using it on my local machine, and the amount of times >100us
> (evasion failed) with and without PREEMPT_RT are identical with
> the vblank changes.
> It still applies cleanly when rebasing.
> 
> The vblank patches are the most involved change, and they ensure that
> absolutely no lock contention happens in the critical path with irqs off.

So that is the good part.

> Unfortunately the status is still same as the time I submitted it before it,
> and pending reviews on the series.

my memory is that you have no work items and the auto-CI isn't worse
than before. The series just waits for a review then?

> Kind regards,
> ~Maarten Lankhorst

Sebastian

