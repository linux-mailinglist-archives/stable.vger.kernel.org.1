Return-Path: <stable+bounces-210451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A6D3C1D4
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 495BB5C3F74
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD283BBA1C;
	Tue, 20 Jan 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aD0nDc9f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fha83y4m"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F53ECBD2;
	Tue, 20 Jan 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896069; cv=none; b=UtJURdTl+k9KecFYRNUFE7AZKxHnhpQ+qu+mh6L7qOzSb5SS1QoLw/JJkV2K5ROFRbCJYQW6OFjlKoSaT66oVHn7f9pYoWL67xVGMZwR8+dGNopw6jTQEprbpxm8GuK40kJ3Rxua33h8GCV6PtorbhCIYdekUvYTtLobIxjgsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896069; c=relaxed/simple;
	bh=RmSONWxhlOTRon66C5OvbQm5Uu4yj8N6syflI7E2r94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlk0U4E3sawhp9F0o4l0eKvTM6NBuK+2UFXo+r8mQODzd+ax7ed4WnkxFCMqwAB/Kc/LuSyTb+4CndeKWhYn/kPUkx7NTuuoDyMn5Jx+fUWcHuJfmJvbv732nqYF6m03wYvgaNayymO1GeGJbWg4kiEJ3ljIAwYYzQNzawsknNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aD0nDc9f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fha83y4m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 09:01:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768896066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpegz2UFo69eXg0vefVrJoKsoZDXsC5W1aFCrRzd8CU=;
	b=aD0nDc9fmotbeEvKlmW+0NRHteRu0DtQPjp+DQu68qFcNpiAEZ1Olc9VJROQi1LRIGZPjb
	QPBvoCEaxVnhbG0D+3EFDZYvCZDGY/vgswYkYBVS/lpaAW6zy/te/6Y/ufvNMpazVmLy52
	WtKCc2VoAIwTo5UwilM0mfoQtLZ+rhsCmfSgFfKEtPQUnbGjBpA4tPOMIk55Epeuq+sjP8
	Q0M/OrANUr5vsfVKtEOnAOtns0A0IV1dHWztYV1Eo6uieI+vLGIuFO+lrhMqBls7amUWN6
	ZAre1mqzOAKRkzVrin/HfpYMIFvXyOqKujSjlZQ5+FrJTOQEx9rWKOqH/AD+1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768896066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpegz2UFo69eXg0vefVrJoKsoZDXsC5W1aFCrRzd8CU=;
	b=Fha83y4mAFlYmogNkePwXJD5ZnJs+t45w0hkB1V7eKbrTyo6ZAsQhYiREU/NX8L8OzpdAj
	HloYO6HuwUT7ypCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, wen.yang@linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <20260120080104.0yYtfQR7@linutronix.de>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
 <20260119163026.aA1PeSmP@linutronix.de>
 <2026012040-unmolded-dreaded-6e06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026012040-unmolded-dreaded-6e06@gregkh>

On 2026-01-20 07:03:58 [+0100], Greg Kroah-Hartman wrote:
> On Mon, Jan 19, 2026 at 05:30:26PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-19 08:25:34 [-0800], Jakub Kicinski wrote:
> > > On Mon, 19 Jan 2026 00:15:46 +0800 wen.yang@linux.dev wrote:
> > > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > 
> > > > commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.
> > > > 
> > > > Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> > > > used by drivers which don't do NAPI them self, RPS and parts of the
> > > > stack which need to avoid recursive deadlocks while processing a packet.
> > > 
> > > This is a rather large change to backport into LTS.
> > 
> > I agree. While I saw these patches flying by, I don't remember a mail
> > where it was justified why it was needed. Did I miss it?
> 
> Please see patch 0/3 in this series:
> 	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/

The reasoning why this is needed is due to PREEMPT_RT. This targets v6.6
and PREEMPT_RT is officially supported upstream since v6.12. For v6.6
you still need the out-of-tree patch. This means not only select the
Kconfig symbol but also a bit futex, ptrace or printk. This queue does
not include the three patches here but has another workaround having
more or less the same effect.

If this is needed only for PREEMPT_RT's sake I would suggest to route it
via the stable-rt instead and replace what is currently there.

Sebastian

