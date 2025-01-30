Return-Path: <stable+bounces-111750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA9A236F1
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C93F3A5499
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4491F12F6;
	Thu, 30 Jan 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSkJIVEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84591DA5F;
	Thu, 30 Jan 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273751; cv=none; b=sflngozXzhTXQs493pSS96UkUPvFkvtE87QLHLrDo7yGfJ1cu0SWvNqkH8iuKLss13QiQslRnU5mQfOtzOJmNR/O9nYYGLXcaOMr6bBQBBZ7d2aJMAc7gIyiuIzOm6ppBwl+BmESGCRAtTq5WwuqoXvQH2gLGC8tEefTKLU2eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273751; c=relaxed/simple;
	bh=v9cA1UeLXNARJOxVOlCXVATDoCFX4K7MnNcdOFH14rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svM9cFjwNHlJlV1xCqiuaFG/B06dLkkLAnDJvWiUmc/Y5xHItRmiI/bmIpgWxCRlH7gwmNcyBlnhqsaDUV9ISyogYGKno/27r/zo6M9Z++C0Qx4x50p3sPJ1AdwEVT1Kxu6JyVgla3HR0yfJa5gjj6YIrKdDpKrOmhWNZLSQbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSkJIVEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC5C4CEE4;
	Thu, 30 Jan 2025 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738273751;
	bh=v9cA1UeLXNARJOxVOlCXVATDoCFX4K7MnNcdOFH14rk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BSkJIVElc5hm3FBv0tBJK/9SQvqb3rg2WqjDGiRayeIG18GV6uN/QXgZ6har2Crmy
	 2q01SbUOlCvwDptGAGz07dF2DroOh00wMr18QP6Ee0Qf72dVI7To6OUS+D367j7G41
	 MXrrU3ZkUjyZzyQrkiITZuLmqUObDhVsBMM3SgFy1pB+tE9ms6SjwPS+hXCWLTzlrS
	 JHASK6K81Pw6AWCOaBCbP/48B3nJ0snbcMBBtKm9F0GtGmXMQL4jcKZPRuayJoyJ4e
	 dSdm1AhrD9juO5Z9omChhaBsX1DJ9zJOGVow4GyHvoP+I5tuRAYRhTBiGhxtytxRlN
	 6b1q57SY1BJSw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso1333811e87.0;
        Thu, 30 Jan 2025 13:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUonKiSLxs3Stj2g+L0PKEIxCSEw2lC2ipzbBMKePH1kquJIS2Pr5mdNqpppsLkvlNJ1Na04VXg@vger.kernel.org, AJvYcCVWs/q1/mvE/71YErSOA2IzSPtxxDq9A7jID1/afKAuwQ+tGbWI7d80ZnTKKemvpGziMevoRYiMH/h6dek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh5N8VTdAXoGMGzx8MRNpQUXVudATJFDM1Vis1SkdZFL9prA0
	VoVIcIfJ8By0zByaGmAVsrel3q+kGzc+j02sk4NHBs5xpmyVa8DS3lT9GD8yd0/kff/ru6uOW4h
	70E0LRchz5S6a0KJeZ5c0xu0giqs=
X-Google-Smtp-Source: AGHT+IGvsZ9UV23BN7NAzI3cBwpZgGYzUNfAG/ADzOOwOyeo8NhgHVLMg1B/e14T3YmWFv4z3T9psdaM5dSo92pIl0w=
X-Received: by 2002:a05:6512:10d6:b0:540:20f5:be77 with SMTP id
 2adb3069b0e04-543e4be00e6mr3243865e87.3.1738273749389; Thu, 30 Jan 2025
 13:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130204614.64621-1-oliver.upton@linux.dev>
In-Reply-To: <20250130204614.64621-1-oliver.upton@linux.dev>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Jan 2025 22:48:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHchMo1dMAd5N--vZOnegoci=kRDQ2N06dVZueixzzhaw@mail.gmail.com>
X-Gm-Features: AWEUYZnBwtpu0VhT2GWd3rq9lUk_NVWIl74tK03ECfTc-9lJwZURu3xgt8g3hZU
Message-ID: <CAMj1kXHchMo1dMAd5N--vZOnegoci=kRDQ2N06dVZueixzzhaw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Move storage of idreg overrides into mmuoff section
To: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	James Morse <james.morse@arm.com>, stable@vger.kernel.org, 
	Moritz Fischer <moritzf@google.com>, Pedro Martelletto <martelletto@google.com>, 
	Jon Masters <jonmasters@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

On Thu, 30 Jan 2025 at 21:47, Oliver Upton <oliver.upton@linux.dev> wrote:
>
> There are a few places where the idreg overrides are read w/ the MMU
> off, for example the VHE and hVHE checks in __finalise_el2. And while
> the infrastructure gets this _mostly_ right (i.e. does the appropriate
> cache maintenance), the placement of the data itself is problematic and
> could share a cache line with something else.
>
> Depending on how unforgiving an implementation's handling of mismatched
> attributes is, this could lead to data corruption. In one observed case,
> the system_cpucaps shared a line with arm64_sw_feature_override and the
> cpucaps got nuked after entering the hyp stub...
>

I'd like to understand this part a bit better: we wipe BSS right
before we parse the idreg overrides, all via the ID map with the
caches enabled. The ftr_override globals are cleaned+invalidated to
the PoC after we populate them. At this point, system_cpucaps is still
cleared, and it gets populated only much later.

So how do you reckon this corruption occurs? Is there a memory type
mismatch between the 1:1 mapping and the kernel virtual mapping?


> Even though only a few overrides are read without the MMU on, just throw
> the whole lot into the mmuoff section and be done with it.
>

This is fine in principle, but I suspect that it could be anywhere as
long as it is inside the kernel image, rather than memory like BSS
that is part of the executable image but not covered by the file.

