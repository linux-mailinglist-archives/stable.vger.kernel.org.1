Return-Path: <stable+bounces-131811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE3A8117E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403047ACBD4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B122D7B2;
	Tue,  8 Apr 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T641j4Un";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F28H9YGA"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93763A9;
	Tue,  8 Apr 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128312; cv=none; b=DAmb9cEIoIhJjaOXE4aEZGvbpx+L0Ny0qGEkZyBDuIWdKW4fPaxXCX41cDhUnKQGKzx93aHppQc69IKqXCe1kfed7rrebme+QGQy72Fsyx/ldTq6Mvshk7882oSDj/g+hfhFLaaVX+d8IVFfv3q5PGoICN62/x9vT921Bm/OWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128312; c=relaxed/simple;
	bh=Bul8n2HqBK5HaxZWiL9cD+VYCHhnK6HWIKmTk3OoomU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NiorwHCe9gSMjlbT/Ak9vm6MM9keb5BI4PgkjQXb+RObV1hz+j+VYjI/BaRT5D4goJ9V/cR2AwV1jaoWp+ie8oiZYw8Sd1l973OXptS7FjSOOPWvCeczOYR3JNhzGhwbLzdm9DFjD1kNc7QQgqBK9VKPDnaXJ8qKPAQSZ4Zg0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T641j4Un; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F28H9YGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744128308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnN5WiyeTB4h3Ec6LnU3d9BBZisxrepypzd6MoCtTMw=;
	b=T641j4Un1+Rj/VWuq63hqsFG2Ivpj7npNV9ICLgQ6vhIITnAe7HUNe/L2a0ojNRx+fnSzB
	qgHE2H9GzC6V2u1l+06ZHdgo/aVdLLA6wt2haHdCLglWH3LO8bSQ4juHo0pZG4Y+q+4dSU
	NOJLMiioRMgT4aimJqh7m7uBVrp52dBeCIQn21NE2bYlNdj0pmJo0ATz+z91H0O6uN7XNe
	sME6jYJLTDOSTKqSGUuz5XhaKhLzVHWELSYly6tbSilNvVthBdnzndJ1HcHOhwvEdu7HDC
	Y1T2KeF6PBqwkTWgju5/PRJqRfJuTuTzl7/IFWYIfIRA9h0qNWZQ0bIMauh9bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744128308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnN5WiyeTB4h3Ec6LnU3d9BBZisxrepypzd6MoCtTMw=;
	b=F28H9YGAIGMMzlpBJRXOktnnCfUMr9wfIq7HToRk3KCQZDLeMBPNtvSkysl2B0qToXFIDA
	uzpAZ+xhHJVafhDA==
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, Yinbo Zhu
 <zhuyinbo@loongson.cn>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <CAAhV-H6tUvwN9UejTRf0zKXdhGG4o5X4ZOppE+1oQhL-rADFHg@mail.gmail.com>
References: <20250402092500.514305-1-chenhuacai@loongson.cn>
 <87jz81uty3.ffs@tglx>
 <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
 <87bjt9wq3b.ffs@tglx>
 <CAAhV-H6r_iiKauPB=7eWhyTetvsTvxt5O9HtmmKb72y62yvXnA@mail.gmail.com>
 <875xjhwewg.ffs@tglx>
 <CAAhV-H6tUvwN9UejTRf0zKXdhGG4o5X4ZOppE+1oQhL-rADFHg@mail.gmail.com>
Date: Tue, 08 Apr 2025 18:05:08 +0200
Message-ID: <87cydmvdu3.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08 2025 at 20:37, Huacai Chen wrote:
> On Sun, Apr 6, 2025 at 10:20=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> This is the card change detection and it uses a GPIO. Insert raises one
>> edge and remove the opposite one.
>>
>> Which means whatever edge you chose randomly the detection will only
>> work in one direction. Please don't tell me that this is correct by any
>> meaning of correct. It's not.
>
> From experiments, either setting to EDGE_RISING or EDGE_FALLING, card
> detection (inserting and removing) works.

You might get lucky in that case because the switch bounces and there is
no debounce mechanism in place.

> Maybe the driver request "BOTH", but it really need "ANY"? I've
> searched git log, but I haven't get any useful information.

There is no maybe at all and speculation is not a technical argument.

It's well defined by the hardware:

Present           ________________
                 |               |
Not present _____|               |_______________

How can you detect that with a single edge?

If the switch bounces then the signal is:

Present           __  ___________  __
                 | | |          | | |
Not present _____| |_|          |_| |_______________

which makes it "work" by accident, but not by design.

There is ZERO guarantee that this will work with all other drivers which
request EDGE_BOTH.

Thanks,

        tglx




