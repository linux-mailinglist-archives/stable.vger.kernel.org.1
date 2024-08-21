Return-Path: <stable+bounces-69804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F1A959EFB
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465811C221DF
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B191AD5F2;
	Wed, 21 Aug 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TO7xF+hh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzppA/Vp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF71AD5CF;
	Wed, 21 Aug 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247834; cv=none; b=J95k5E8LPIbzbZhwBBW4eB0yp3r511mCXiYhtpm9ZAYiWOhsmSgMlLM05eciJj1TTLedvOLBLwBUri9a+Wx+JwX6NEA4eTGR35thZjchIarjPNEhZJgZnwSl0UjF36xnLL+F9mFS75dEgAnviUAlw2milLK+C/qjjW0C6heG768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247834; c=relaxed/simple;
	bh=4Y7dNF/4nzHACXYFEl0M7JhbOvaSxbfLdDzRAmL47bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt/CB+HkF4EptQXxmgQ5XtJm72UH/DjW4qoIXYRwOwPCkFzSfUSBdFelqK9C+LAS5+YC/1iAWefNfgmDdJP7BHU3RpHJb9L3aTKKaJVKjlj8/Bv6eQ6m3lxW2n3SxD/wcR5aLCKCRGboRNuv+hVXvDTYmoMFUb4uPXdjGpCDBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TO7xF+hh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzppA/Vp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Aug 2024 15:43:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724247830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBYyNYTINUYhYamZZE/gd6+4naWvlhAjOpapUiy8r0Y=;
	b=TO7xF+hhRtXenjFa/HKSpZm9zNPrCk+AABDsPVW306mLIKkFBol41PwWanQ/VAlc+EpXNq
	PINPi13YYdqWYbNUdsmsuBVuVTiqrYhTHd0rE1SSaAwmJ34Df3it6Bym/22zNdV184W7AR
	cBQEEPra61WvZDEu8DUCFD+xiXDw56tdl1+Haq/TNcxgYem6L/PSshPWu2dDoMB/Pzo//6
	sDm4EuPQHE/P3VdVDKTCbbSG1JejZAxWZjufknuyWCBW9dgE5aJkEXst4TeC6mHsRbb4Xi
	AVoHNtcKzwSHfLHhydu4kasr2188byEKbSh1lNiTXVDz3ESuiKHYMBcVULpcxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724247830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBYyNYTINUYhYamZZE/gd6+4naWvlhAjOpapUiy8r0Y=;
	b=ZzppA/VpPD7yj7pREn+WQVnv1SvLTjY0odV7PCksGJ3mPGGTbqsyDTYW83y+2LyPvqXoVE
	rhT7W+ziA1ECTPDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: Patch "serial: pch: Don't disable interrupts while acquiring
 lock in ISR." has been added to the 6.6-stable tree
Message-ID: <20240821134348.Mmpc9bW7@linutronix.de>
References: <20240821133436.1667896-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821133436.1667896-1-sashal@kernel.org>

On 2024-08-21 09:34:36 [-0400], Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     serial: pch: Don't disable interrupts while acquiring lock in ISR.
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      serial-pch-don-t-disable-interrupts-while-acquiring-.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I don't think this needs to be backported. It was part of a cleanup
series. It is not wrong, but also not needed. Unless it is needed as a
dependency for another patch, I wouldn't bother.

Sebastian

