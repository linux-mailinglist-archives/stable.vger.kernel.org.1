Return-Path: <stable+bounces-196932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50183C86BBA
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED3783530FA
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253FB2773F4;
	Tue, 25 Nov 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xyhd4zGS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWYpqVqO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1918BBAE;
	Tue, 25 Nov 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097475; cv=none; b=NEVK4mVdOLRx67GdZGZ65DC/dtgoCZIJKT+stMUgbNEkEMjpIecnEhsiVkVAKbv4E8Z3HLqXBhDuI8W0qrciVFXYdNiWYTQY+s5DwvgaQ2N6Y3I1rSUFxS8RfdSR8oPHrB0mRLBXXhon2/KmXiS5eQLxSlEj5sRA+wBlprkouTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097475; c=relaxed/simple;
	bh=ohOlxESVUS5GWta7bMITCRe9Q8q5s8Xw6nLN+Y+p9v8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSUzd3JGd8+3tiwi9DBtsMN3zR5n9cxrjYVY5KwLG1VwKFImbXUjjz0cocbk0WlQiotT3rMyvHxop9UqRyimWoeK+Ph5UJEehN3dZaEwjvFcHw/JpX4yVOXZpQQbDqxri96LyR/aEHGiAV8bNw2im9OK3UQ1TWBOJ213b2d+RXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xyhd4zGS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWYpqVqO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764097472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoGHYDHwZQQrMcaSIQuTum0d3CDmwrfoU7AaJG27DpI=;
	b=Xyhd4zGSpk2YthZrTiDfaXBNQHuvNqYg2oKJEpKnl2a9+IaKQhCVytVHBfrbSZOc5UNVdt
	w1Hp+r+3TMChKtEOe7ZBheF8e0ajR/pfyGCv6xS+LabTtkWrF0WTdGdxklgfjRI9U0bc3g
	l+s+zBxODv3LTPYPK0pJtAf++IjuXAnbPDKDHLclCeyNAn1UBSrmU4wTywbBMw4gj1VMB6
	yP0DWATdGflfmJXD8SbbXStNK6ZSQzp8+4LriNk0GcUMAr4viGLVyIxfkFJi0q+MrAmq0c
	gwc8emA6AF8GTJJxsGxj2Y83lOgky7oSqU7OYP8treadaQb3pPz8PARNnYtxDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764097472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoGHYDHwZQQrMcaSIQuTum0d3CDmwrfoU7AaJG27DpI=;
	b=kWYpqVqOOOeG44/5ESzHmjCOIT0/1+E6Xwk4rHPo72nuBG+g/nPyHLfLlvpcQPvBNgP7vT
	ecrOGNuno3Or8gCw==
To: Luigi Rizzo <lrizzo@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>
Subject: Re: [patch 1/3] x86/msi: Make irq_retrigger() functional for posted
 MSI
In-Reply-To: <CAMOZA0LB1UEEib1WWpUW0X-5+LKx28Ko9eGLi5ZSvU8d2yXkBQ@mail.gmail.com>
References: <20251125101912.564125647@linutronix.de>
 <20251125102000.636453530@linutronix.de>
 <CAMOZA0LB1UEEib1WWpUW0X-5+LKx28Ko9eGLi5ZSvU8d2yXkBQ@mail.gmail.com>
Date: Tue, 25 Nov 2025 20:04:31 +0100
Message-ID: <87ldjugchs.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25 2025 at 18:54, Luigi Rizzo wrote:
> On Tue, Nov 25, 2025 at 11:20=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>
>> Luigi reported that retriggering a posted MSI interrupt does not work
>> correctly.
>> [...]
>>
>> So instead of playing games with the PIR, this can be actually solved
>> for both cases by:
>>
>>  1) Keeping track of the posted interrupt vector handler state
>
> Tangential comment, but I see that this patch uses this_cpu_read()/write()
> whereas the rest of the file uses __this_cpu_read()/write()

You're right. I've missed that. Let me redo it.

