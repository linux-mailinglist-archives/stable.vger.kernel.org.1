Return-Path: <stable+bounces-42769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E18B7575
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C1BB20941
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318B13D2BF;
	Tue, 30 Apr 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osk4MT0M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+DEe6Lx1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78594168A9
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479050; cv=none; b=c30Xjeq5pjzWx25rHBi57fzy8rsW6lPHOnSKfejWtCB3ezLR/eZkINzQg0N4swlU8u8aCHmZPLlmm5zAkw/X1Fx1K5PpjIeacqz/m7OE/VQZvGLJZ+7vXnjt8ruz74HGN6Fd6Kx60wo/56og0v8Dbmf0RW1JHxYEUev5bPCeqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479050; c=relaxed/simple;
	bh=bEh5Vs1WoIY2mBPzabUvoz+ypZr41Ha0zC0niygIaX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCQYZ2+pHyyqUBMmFCi+l3S67mwWfxTden7OHMD06i50njk1tCJnXZSntsM4Aolse7+/0W9bdv0En7mfLgbSNQXCxs3RlOnq6UUQpT5KwVKlK3umwoWRJP0DPG9Cj/9ZOgKxaNilWE/M0OKWyqbA6oC1sKdRRl6jpS+8G4cED38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osk4MT0M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+DEe6Lx1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714479045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paS8ub3mcHOtHhOivLOmpuQhVzTQgxott+KAKZqPytI=;
	b=osk4MT0MsAtKzw2slKb1SD9Mpv/bA8qjVVQz95yCigYACgZBa4u4nBk0C4bNZwZsoi+iX9
	wyUtrRaOqlWA5lexGQhhm3NuERYFIVU9LAkNgvfyXQ4yn3KTB9n97h9/HccdICLKG11hVN
	AP6DYiLetqZhG3RCrjf0701jgIg81YaiY9G+sqhHH3BzIRyZ3NXtE8kkAjJtTZ/Dbvg1Tn
	ii6cwMB5Tj/rNhJV9v6y1Uer+loXRa5rGWmR7qb/A1lq9lhVGOFiuif4fcByjBnI+asUhJ
	zHVD9+RRObqJriIm5XuXGuK+T1Wf8mMp/qY85VoPPoJtyr4kSPBQlQfkQEfCPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714479045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paS8ub3mcHOtHhOivLOmpuQhVzTQgxott+KAKZqPytI=;
	b=+DEe6Lx1HInlUhnmUs8hz0tQ0pu8CSBPXoR9nLlhA7PElUIQ/WevLKJoJHHmx1hSA7urUh
	nrjkBe1Pdw9yriCw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 4.19 53/77] serial: core: Provide port lock wrappers
In-Reply-To: <87y18v5dlo.fsf@jogness.linutronix.de>
References: <20240430103041.111219002@linuxfoundation.org>
 <20240430103042.703277875@linuxfoundation.org>
 <87y18v5dlo.fsf@jogness.linutronix.de>
Date: Tue, 30 Apr 2024 14:16:43 +0206
Message-ID: <87r0en59vg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-30, John Ogness <john.ogness@linutronix.de> wrote:
> On 2024-04-30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> 4.19-stable review patch.  If anyone has any objections, please let me know.
>
> The port lock wrappers are only needed for the new threaded/atomic
> consoles that are still being developed for mainline. I would not
> recommend backporting all of that work when it is done and therefore I
> see no reason to backport the port lock wrappers.

I took a look at the full series and noticed you are pulling in some
uart fixes that are using the port lock wrappers. In that case I suppose
it makes sense to include the port lock wrappers.

So I am fine with this going back to 4.19. It has no functional change
anyway.

John Ogness

