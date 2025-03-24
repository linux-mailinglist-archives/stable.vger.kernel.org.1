Return-Path: <stable+bounces-125872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CBA6D797
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7857A5524
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064425DAE8;
	Mon, 24 Mar 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EvPCPcEv"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35C25DAF6;
	Mon, 24 Mar 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809019; cv=none; b=tmV0HSmV5Pw5URcG4PrI8xqGlx+9h6hM1p4OqSZexgff9qx1yKoisNW2ccWYp5xLdcjSFOrTngtr9wOOsxikOUmt44dcGnCrl12FuCb10g2w41pJ6q2lR83DhqY9H3LxOpJV2JRDgl4T6znxHgVR2CPd4AYeUg6X8NEBGyFm7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809019; c=relaxed/simple;
	bh=tm8nETwBFY8xvceTYwTrlANHRYxXbk/mhl35P+x0Vo0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nW2ojUqyZTx6Hrzd8WgQmilCRSsEAjW0qwS3sEwnfP7Ci5Fq+91MuTEyVvMCdDhPVAVt89nxQzFq/wmzNXma5R84k/tIRRpUHJ5rWplo5TdVGY0RqK1YSWp3ChZvueAthBKifms4i8uImzRT2v9JPY8B/8WDwumn1gEVPQYdl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EvPCPcEv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742809015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFNrF1+QCqXJYQ2BxaXDZ6u0WsATr1kvUb16OTMEuz4=;
	b=EvPCPcEvEphlFm4vzCrED3mmJuyz5P3exj1vtXKjA5BDHBcTewltFvy66o4BOPEX8mz0kY
	rhEnfkbWToQg4L6QoDMvFRXwoTUGWwFn3deRY3BC2HrRqSzWS/u0M8ihvbzaM83vloTDjl
	+JfonB2rs1O5tFvPmSfj+u9sakL0xAzFBFWbLjeXqS9dnjSCDI1zzr2iBoUBnMiUxsIyYv
	SH3ITh28J/6HXzUkm3kEbDjz7JXTjKN3ENv4wf/cHFv5ptAyFgvQvDgHa7iYHJrSxCei5s
	aqFPjayZCyGU+6SsUlQox67BonrIV7Vwoa3eO0ZKvuaO+7aFoJl63rn68lV3Fg==
Date: Mon, 24 Mar 2025 10:36:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, stable@vger.kernel.org, Alexey Charkov
 <alchark@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
In-Reply-To: <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
References: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
 <71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de>
 <960c038ad9f7b83fe14d0ded388b42f7@manjaro.org>
Message-ID: <460503eb831485ede9a49dcf226aef1b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2025-03-23 11:19, Dragan Simic wrote:
> On 2025-03-21 10:53, Quentin Schulz wrote:
>> On 3/21/25 4:28 AM, Dragan Simic wrote:
>>> The differences in the vendor-approved CPU and GPU OPPs for the 
>>> standard
>>> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J 
>>> variant [2]
>>> come from the latter, presumably, supporting an extended temperature 
>>> range
>>> that's usually associated with industrial applications, despite the 
>>> two SoC
>>> variant datasheets specifying the same upper limit for the allowed 
>>> ambient
>>> temperature for both variants.  However, the lower temperature limit 
>>> is
>> 
>> RK3588 is rated for 0-80°C, RK3588J for -40-85°C, c.f. Recommended
>> Operating Conditions, Table 3-2, Ambient Operating Temperature.
> 
> Indeed, which is why I specifically wrote "specifying the same upper
> limit", because having a lower negative temperature limit could hardly
> put the RK3588J in danger of overheating or running hotter. :)

Oh, now I see what you actually wrote above, which I misread a bit
initially...  In fact, the upper ambient temperature limit is the
same for both RK3588J and RK3588, according to the datasheets;  it's
just that the lower temperature limit is much lower for the RK3588J,
which the patch description says.

I'm not sure where did you find the 80 vs. 85 oC difference;  please,
see a couple of screenshots from the datasheets, linked below:

- RK3588 datasheet v1.6 (v1.7 is the same): https://0x0.st/8j1a.png
- RK3588J datasheet v1.1: https://0x0.st/8j1m.png

The v2 of the patch is coming soon, with the patch description improved
according to your suggestions.

