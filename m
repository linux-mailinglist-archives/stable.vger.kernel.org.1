Return-Path: <stable+bounces-66342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442894DF34
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 01:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593CCB21596
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697FE13DBA4;
	Sat, 10 Aug 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdWNY4Q5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8G2Uw9K"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731A1366;
	Sat, 10 Aug 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723331303; cv=none; b=GJbkZxTZE17mP6CpqrgjmG0Kwz5WDbAiuGMI/wYIEnFYb+CPAsOFQATgPFsGzCrM+dYihZMVNiZaQXkRGBNQ4cxhdHk03+EZ057l8V4y42Q3eZcwz8yNzMH58qW2JoY/8sTvRHrvP6A4LAIZSdDUzXZgcV4+VvFGDNHo1P092vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723331303; c=relaxed/simple;
	bh=vpQyC9yZO8mzmhciWHCgibsDALPFEFY3eLohuawf2d4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=javf/LB2qnS082xaNC7qSZtdFrY8z7r7k8wfYz8N2CX19vROZYHXp7mNsviAePI6OhHaKBV5rjl5qMySNh4rg3mnCRVx9vnLP+VAjrKzqhgm0uJUS91focaG7HiaaBDkVboJRXGo9i22a6ciXMGGIyzgtYh/8a61GkPsPDdw/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdWNY4Q5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8G2Uw9K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723331299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5NsA2fsSGS/KLaKt9QKQVXX2D4Vu3loVg166ql4zZQ=;
	b=UdWNY4Q5uKTF6WRy3SLhod/sAv8tySOo1wo7VVGCVTpmKFxYq71WASM9jDhnuge/fvuMhr
	qX6dIGLdh4KSTn/P9dETr8fc+lIhV+hQgjbDgtYTwckuQ+sh076VIlPCalmW7Y1tpkBNLZ
	NUDYLkAs+QMXnH8q38OL1grIbWIL4LIQZT9qpMZju/60UxHxZTtRKMaH6+bbUNuCyIgUqY
	cQA8FO5MA+9okGe7OaM4vzRI7JtxSKm+urTQYO9kxGRB0yM1oUkJCPm+8YkbLNhFr4XxIE
	Lwp0gF10/vdMCjdPeVjG+p8AAYMA4kjw8FZ3VL/ZgwLDwaaac7pOWxjFveLUkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723331299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5NsA2fsSGS/KLaKt9QKQVXX2D4Vu3loVg166ql4zZQ=;
	b=f8G2Uw9KjJ74rVNnqjTXTnhWsfo7vfMmpzfXU6nZM3vaPnE/tBH2Li35aYoF5Ea8n6pxpN
	chIntsTWp0dAiJBg==
To: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH v2] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
In-Reply-To: <20240809-xsave-lbr-fix-v2-1-04296b387380@gmail.com>
References: <20240809-xsave-lbr-fix-v2-1-04296b387380@gmail.com>
Date: Sun, 11 Aug 2024 01:08:18 +0200
Message-ID: <87ttfsrn6l.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 13:53, Mitchell Levy via wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>

...

> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> Changes in v2:
> - Corrected Fixes tag (thanks tglx)
> - Properly check for XSAVES support of LBR (thanks tglx)

IOW. I provided you the proper fix and now you are reposting it and
claiming authorship for it?

May I ask you to read Documentation/process/ ?

Thanks,

        tglx

