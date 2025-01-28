Return-Path: <stable+bounces-110959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57567A208C7
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A521884712
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6819D087;
	Tue, 28 Jan 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WNFLx3YF"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050F1552E3;
	Tue, 28 Jan 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061079; cv=none; b=FmrvaOUhGubftPsEalS+nREEZOfXQEViO6oSwB/E3/qBxbMbt7hkODES0zVgfaulxYpkNCXxjmZlN2qMkgnfqhrfWhB5vkrj2T3e5QqVL3SgC5KqEt+BYabQKBc8gHw9JJvXgzPbY+vEsO1KQ8RuOYGwnWUBU7tijK59PwZmLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061079; c=relaxed/simple;
	bh=yEg1lAFxoXAhEHU1VEETd+Vp4yfTsw4yiVGXpqpB9Rc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=vDPqPj95xJaUjogyL/IITNAwuzZY4gU3Z16ezLRjBFGdcVwYAguqKucP5FUajSwrctP+GGuIUNelumbHf1ZvE/NSL8PWc7CkkND/YHlzHRUoeroNUThXZxd8Qe71mF2gyNYOqXg7m+BSnUpOh0G72DRNI+kOm3T9Lms2R/bF0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WNFLx3YF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1738061074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QH2HlRrsM2GhBqfQeM842UlYrI8bH7FA97PniLkwhl0=;
	b=WNFLx3YFReVPhS8mPLJ+8dWLkj7tr6Z5rlcSM2MBg2AlKXwjQwOYTyUZ7BuIy9cl88zSRg
	9L7QNBrhJTIxbdft7iM1P+wPCvkXVvFBA0CDNbX9oKzXFYPKCPZVjzH+e9KVXAMRll4JG8
	boKosHygywwhKQ7xIsa9MtIZVb8M9nk56NLhzf1qVSLLxENSJqyM6+dM5JV9JrBqhw5ESm
	eqrdC+qqUJ7QOL5Wq8OY/pcLTF8jFTfl4/B92L6B0g2k10D3DUNLajEFHQpL67DMSYhIKV
	knmDzwnuzqgJlPsEFmi/PuyL9iVg57bBwNfmLLkPTkT29wL164GeBWvft+kNEA==
Date: Tue, 28 Jan 2025 11:44:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, devicetree@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
In-Reply-To: <CABjd4YwCH93-=Cqck5TiuJoTUkYbRh0495J6w=J8t93oHdt43g@mail.gmail.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <CAP1tNvTRER=QzC29Udw4ffOetVECWV+MfZ2o-mbUFvuZ0_i-Kw@mail.gmail.com>
 <b57d8a834f5c07e37e0e7ee74346c700@manjaro.org>
 <CABjd4YwCH93-=Cqck5TiuJoTUkYbRh0495J6w=J8t93oHdt43g@mail.gmail.com>
Message-ID: <1498db1c6664b39b49cfc71d2e4eb5ef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2025-01-28 11:30, Alexey Charkov wrote:
> On Tue, Jan 28, 2025 at 1:24 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2025-01-26 15:25, Alexander Shiyan wrote:
>> >> > > I think it's actually better to accept the approach in Alexander's
>> >> > > patch, because the whole thing applies to other Rockchip SoCs as well,
>> >> > > not just to the RK3588(S).
>> >> >
>> >> > Anyway, I've just tried it after including the changes below, and
>> >> > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
>> >> > pinctrls under tsadc, the driver still doesn't seem to be triggering a
>> >> > PMIC reset. Weird. Any thoughts welcome.
>> >>
>> >> I found the culprit. "otpout" (or "default" if we follow Alexander's
>> >> suggested approach) pinctrl state should refer to the &tsadc_shut_org
>> >> config instead of &tsadc_shut - then the PMIC reset works.
>> >
>> > Great, I'll use this in v2.
>> 
>> Please, let's wait with the v2 until I go through the whole thing 
>> again
> 
> I, for one, would welcome a v2 that could be tested and confirmed
> working with and without driver changes. Especially given that:
>  - the changes are pretty small
>  - hardware docs say nothing about the difference between TSADC_SHUT
> vs. TSADC_SHUT_ORG, except that one is config #2 and the other is
> config #1
>  - none of the source trees I looked at seem to enable PMIC based
> resets on any RK3588-based boards, so these pinctrl configs appear to
> have never been tested in the wild for RK3588*
> 
> So trying and testing seems to be the only way to understand the best
> way forward. Unless, of course, someone from Rockchip can comment on
> how the hardware works with TSADC_SHUT vs. TSADC_SHUT_ORG.

Perhaps the best approach would be to have the v2 that works without
the driver changes, so it can be propagated into the stable kernels.

Then, a separate series, which I'll volunteer for, :) would introduce
the cleanups and any needed driver changes, which wouldn't be propagated
into the stable kernels.  That way, we'd have the minimal bugfixes in
stable kernels, and the nice cleanups in the latest kernel version.

Of course, detailed testing is mandatory.

>> which I expected to have done already, but had some other "IRL stuff"
>> that introduced a delay.

