Return-Path: <stable+bounces-110942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE0A20746
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581271689AC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2A1DF998;
	Tue, 28 Jan 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RwBEXPtN"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF91E521;
	Tue, 28 Jan 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056283; cv=none; b=ij2N3F9bvAXl+VvBgnBfvrOuNe+9smhszm+s7R3HLFEkAN7ua4T0Gfy1CZSY4RWFObGIKUvwfuP/6cDWGs14eMWGGjkqpI16yGcPlXh60Nc3AvnwcMwsIROxbmJtTRy2SXYOBqNfSIOE5vl1lah4W/ncoiWWYoFst8a9U3rZbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056283; c=relaxed/simple;
	bh=PE0sYlUT9OfFJ8ehhiSAenKDNBYW1RrVTrWTzyg29sw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lIvE4XBoP3+gKH0gz7zsSWG+fbi0xl6/wIFIfs+PkBbTQZj17CtQJeVnFuZQvmXXQvRoXDgW6bGS1Il1ch3b5QjzydKYjSZTqeFsF5X/KygkntnruyDEFbchdPDB+lBb93fgHuL+1rK5Inm4CxYEDeBh2dITnm2Bl9tgmEGe7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RwBEXPtN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1738056274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD6aGMkGgUesAlsT3HDG5pObkWdXtnRJmAMs5WiLGeg=;
	b=RwBEXPtNpHhxIK0t1mNdkDQc4WmPYgNvEIrU0KFOUGiJhLvU1tUPFOFS4REGW1ckPFLfrQ
	H8qzihaB1kt/C2NzPQ/gy4Qr+9qvnivYaw8kx0sBiXNVyc25ul18bOiE9rVxx2JQ9Nmlp4
	aQ6nuSf5CI3yuCt29gsJGFDLnKKCRB6gP8KiR0Jraq/MFqpysbGp1GXosdIUa2tZLWEBGV
	QDRtFGGuTuVPxOftgmEuUdOUPXG7cxigRIg3sXFAXQc2+ZbghIhOmlJ2xNXusGwapbPj8s
	ugEVWMbUsodqcY6N/wV/t0Optb2qVQebaMc+aQFHPP7w4zQwdxkMDfYexkJong==
Date: Tue, 28 Jan 2025 10:24:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexander Shiyan <eagle.alexander923@gmail.com>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
In-Reply-To: <CAP1tNvTRER=QzC29Udw4ffOetVECWV+MfZ2o-mbUFvuZ0_i-Kw@mail.gmail.com>
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org>
 <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org>
 <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <CAP1tNvTRER=QzC29Udw4ffOetVECWV+MfZ2o-mbUFvuZ0_i-Kw@mail.gmail.com>
Message-ID: <b57d8a834f5c07e37e0e7ee74346c700@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexander,

On 2025-01-26 15:25, Alexander Shiyan wrote:
>> > > I think it's actually better to accept the approach in Alexander's
>> > > patch, because the whole thing applies to other Rockchip SoCs as well,
>> > > not just to the RK3588(S).
>> >
>> > Anyway, I've just tried it after including the changes below, and
>> > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expected
>> > pinctrls under tsadc, the driver still doesn't seem to be triggering a
>> > PMIC reset. Weird. Any thoughts welcome.
>> 
>> I found the culprit. "otpout" (or "default" if we follow Alexander's
>> suggested approach) pinctrl state should refer to the &tsadc_shut_org
>> config instead of &tsadc_shut - then the PMIC reset works.
> 
> Great, I'll use this in v2.

Please, let's wait with the v2 until I go through the whole thing again,
which I expected to have done already, but had some other "IRL stuff" 
that
introduced a delay.

