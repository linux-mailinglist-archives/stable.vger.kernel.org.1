Return-Path: <stable+bounces-210376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B0D3B2A8
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5E2B3111D3B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9613B5309;
	Mon, 19 Jan 2026 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaQQHcLl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jRlBDX4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB93AEF23;
	Mon, 19 Jan 2026 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840230; cv=none; b=GDRGN28IAvRoWPyDfoBT8ehWX99yBiJEszMVN/Sb+LS0LCy9bUuAsMCr7I5EOxY/JA9tA8Oe27Np+PR1A4DKdJyD/h1e2J+EVJ+jl8hDiv3zhpKo6EC6swWG/2gdhDJ8uqq7aNEwsSQK40A99IU3VcTwUOizlMKW3HzIhxVFPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840230; c=relaxed/simple;
	bh=sdGG5M09hkzsJSFJ0MO46ADpx7k88eDsXuroOJ6H/mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/6SEkXddaOGbpaVIcrKScdh3lYmwFJtONNGKcl5XvgPZXwyxolAab2uM4xUa+ONUjFW4RxAn3bkXX0bpzgH7lxjxkPsd3o5GC+27xOUhmQpZwPxiQ0/pW7bHWe7iFQ6J64+mkqFdao1KyNak9jw72MuCbeC4RXbMIBr5ikraUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaQQHcLl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4jRlBDX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 17:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768840227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tg4r0hM12VEhzCtDP5l/YG0RGcFgSHWev83wn8qRALQ=;
	b=OaQQHcLlxOmdqZfs1sXIjPA/cpZeHHx2LVLWa4BHY78rEH66NdRzwSNUXjLoyH/wuNW6G5
	h9AfkNspt2tPmxsXmaaTm2LESMDQx25UIWXr4UDoSV+c3N6Sn7PEhnasGHd5www+r/+jOv
	hlphdtbW+3yGyDIuEhnANPXevrhSTpX8oskGstD7ePtWSU9meJQFf2nIhfnmOIO9GC4o/z
	BUkW0/WFO0iFSywaz/MWJ2IRIsuPizlZRtP7BFy5mw2gZLl3/D1QZyBcZcI+trvK3LoH31
	LmthDXbjrW0rESdyKjp+DJOYgpFk0/rSjMmKjpJE/T/8J20CHKquk775JDbBbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768840227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tg4r0hM12VEhzCtDP5l/YG0RGcFgSHWev83wn8qRALQ=;
	b=4jRlBDX4Os2TuTfYy8/9OET2fehGZJ9VPIwMUpnLH9boySdmpNXhDgs9HMABNtal+PtFOH
	sgvjVSvusMR4YsBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: wen.yang@linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <20260119163026.aA1PeSmP@linutronix.de>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119082534.1f705011@kernel.org>

On 2026-01-19 08:25:34 [-0800], Jakub Kicinski wrote:
> On Mon, 19 Jan 2026 00:15:46 +0800 wen.yang@linux.dev wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.
> > 
> > Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> > used by drivers which don't do NAPI them self, RPS and parts of the
> > stack which need to avoid recursive deadlocks while processing a packet.
> 
> This is a rather large change to backport into LTS.

I agree. While I saw these patches flying by, I don't remember a mail
where it was justified why it was needed. Did I miss it?

Sebastian

