Return-Path: <stable+bounces-47727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807ED8D4F7C
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBF51C237E8
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCE200C7;
	Thu, 30 May 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLV/EBIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmEMXyMy"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAB2032B;
	Thu, 30 May 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084442; cv=none; b=D7nbYX7TIhA9HNJ5+oRr0QfoefrULYtzfyXFC6fWJ5kdPp8hF/IJ6VQP+ahblZWYTjoZPYuUStT6hCb8M1DGaagGgDMvugPJjzgEb+BRaurA9IPwlLDiBgWUC1VZnsEE6ssVA8a95iXe8qOrJFULyH1vf8hfWbB98erCEn6c8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084442; c=relaxed/simple;
	bh=U7VSdvkRppI4+5gQVYR0PivyY7OcaLt0GbifZweu8Po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tuVUJ/+zJW9xXGMzJiv2JoUX/wcRHYnoa7jAO0EotZD+pdIDhdYcP15GR2BvZGb8pg1Y/8m8NSH0mWxhNoyYZF1Z27N2ErBsbjcRw8we1gE38E34WoGXOrnbO3v8ENgOyezKgpHEzP0kKzbpicdIALTS0x0BeiGeYRsWMcLdFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLV/EBIK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmEMXyMy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717084439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ox6TcwsfqOasr2+SZmfSYOAcvDO9ex7bbe4NVHqmo8=;
	b=NLV/EBIKCGXQYzIMmA01GDSfafV6osmQbm8rD15QiOg0goVbFWny2wdyVfLQqwaR4otTFV
	rfBgUY4ji7zNVOnPZkm82FrK0SuoF7DnpaVyGSfzwRnDhzeLft914L8JCQHr16I2ClyZ/e
	fEkrGzBuAR+O5Qod3S5fTO4U8WgV+LgYc2zSwwOC6hvMbYEcOAezsdFKnL8hywdR0Wl4mL
	yTfkeMhcoRvx/Uz2hzRqutRaJQXV75RWUAJ5sj7ZpY5IuT7/zbqYUAxdpm0iV01OLHgzAH
	gmxQSN9oqfAGl5zmmzshmWpY0VcKx3AW2w0pMRpogoNFmGscsL5xJGRkEkY7GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717084439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ox6TcwsfqOasr2+SZmfSYOAcvDO9ex7bbe4NVHqmo8=;
	b=zmEMXyMyHlCHGOGxsvilmvTf0fyJS4CjpCAaLVxI8KtCHx4yiqeUffVLiG/jMvGx7/5fJQ
	suJqIfVMosgQ6qCg==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <87r0dj8ls4.ffs@tglx>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx>
Date: Thu, 30 May 2024 17:53:57 +0200
Message-ID: <87o78n8fe2.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 30 2024 at 15:35, Thomas Gleixner wrote:
> On Thu, May 30 2024 at 12:06, Peter Schneider wrote:
> Now the million-dollar question is what unlocks CPUID to read the proper
> value of EAX of leaf 0. All I could come up with is to sprinkle a dozen
> of printks into that code. Updated debug patch below.

Don't bother. Dave pointed out to me that this is unlocked in
early_init_intel() via MSR_IA32_MISC_ENABLE_LIMIT_CPUID...

Let me figure out how to fix that sanely.

Thanks,

        tglx

