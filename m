Return-Path: <stable+bounces-88181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4A9B0956
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87CD1F217A0
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1317C9E8;
	Fri, 25 Oct 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NkQveD4I"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6398170A31;
	Fri, 25 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872668; cv=none; b=b1FaDhPR2E/dFBge2wAgGHGOkr0daV02Z6P0EywAsCpUiQw1wJsF5c792e2QXPh4LjfKiQCsKl9qN61/9vSvzvj1CDPHI12LECfVBo6dMee/Wg0+837K7lG7fY95hCwvXNSmu54pkwLqYsNleO/2BaAZH8hAZ0ReCishqvE+IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872668; c=relaxed/simple;
	bh=W41hJnhNQLCvtcUj0/7OFMCwUbb3LaViC2imU7/jxs8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p8imSrQgLNy9u871yirQWkc/M8ZEb0WOqQwaoXwxcdgi0AXROKe9heQjkLq4ZLbpF6gogUgglu1LLxTlKygamIF09/01bVXKH8nUu2dOoCgQDQH/lH2oZnLea6H2Ig51ihcHKcr47zArd9AppSt1T/GkU2+sHsckGx7wKb/LpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NkQveD4I; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729872662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Iw4mSeihGj1YsgWe8Zsotpic8lQYd8a9F0LzrpwBY4=;
	b=NkQveD4IeJyVYkwl4GNW11zstxIvo/Pkwm9FiFHL9Bu79vy3H890U5m7g1JxmTLm1xnuh/
	Gkkd+S9bwz+MA/6wG/u1lvxrG/88/tEat2A6sW5Uk2LPhZgAh7GHstuFbYjBFpUUaSeJfj
	hD3+6yQwvxWA/HqQvDI+p1hj7tDc8n3XXJ5AzuNQIN6jM1TLr6GwPwcGXO4F3jmGufT62T
	bAaYRoGAdKyE3mUaHqfFjOPmL/ie+INilHsXVre0CNwM5X+TvQQTgBIGufdKRgUZvdbhzX
	Z6gKNlS/v39pS6OZTZ5QP0NSAwknEXY6meB+kPmgTfnSEoZNytTH+mfPWvIG1A==
Date: Fri, 25 Oct 2024 18:11:01 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>, Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to
 accelerometer
In-Reply-To: <CAGb2v66aody60h=Bpk49pxogq93FekmO48uThPET2RKxvx=OGw@mail.gmail.com>
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
 <bef0570137358c6c4a55f59e7a4977c4@manjaro.org>
 <CAGb2v66aody60h=Bpk49pxogq93FekmO48uThPET2RKxvx=OGw@mail.gmail.com>
Message-ID: <cfc090cb87a8b926116d1a436694d17d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-10-25 16:47, Chen-Yu Tsai wrote:
> On Wed, Oct 23, 2024 at 5:11 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-09-19 21:15, Dragan Simic wrote:
>> > The way InvenSense MPU-6050 accelerometer is mounted on the user-facing
>> > side
>> > of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees
>> > counter-
>> > clockwise, [1] requires the accelerometer's x- and y-axis to be
>> > swapped, and
>> > the direction of the accelerometer's y-axis to be inverted.
>> >
>> > Rectify this by adding a mount-matrix to the accelerometer definition
>> > in the Pine64 PinePhone dtsi file.
>> >
>> > [1] https://files.pine64.org/doc/PinePhone/PinePhone%20mainboard%20bottom%20placement%20v1.1%2020191031.pdf
>> >
>> > Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
>> > Pine64 PinePhone")
>> > Cc: stable@vger.kernel.org
>> > Helped-by: Ondrej Jirman <megi@xff.cz>
>> > Helped-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> Just a brief reminder about this patch...  Please, let me know if some
>> further work is needed for it to become accepted.
> 
> There's no "Helped-by" tag, and checkpatch would complain. The closest
> would be either Suggested-by or Co-developed-by, but with the latter
> you would also need their Signed-off-by.

Thanks for your response.  You're totally right about checkpatch.pl
not supporting Helped-by tags, but including neither Suggested-by
nor Co-developed-by would fit very well in this case, because the
associated level of credit falls right somewhere between what's
indicated by these two tags.

> I can change it to Suggested-by if that's OK with you.

I've created and submitted a patch [*] that adds support for Helped-by
tags to checkpatch.pl.  Let's see what kind of feedback that patch
will receive, and then we'll be able to move forward accordingly.

[*] 
https://lore.kernel.org/linux-kernel/0e1ef28710e3e49222c966f07958a9879fa4e903.1729871544.git.dsimic@manjaro.org/T/#u

>> > ---
>> >
>> > Notes:
>> >     See also the linux-sunxi thread [2] that has led to this patch,
>> > which
>> >     provides a rather detailed analysis with additional details and
>> > pictures.
>> >     This patch effectively replaces the patch submitted in that thread.
>> >
>> >     [2]
>> > https://lore.kernel.org/linux-sunxi/20240916204521.2033218-1-andrej.skvortzov@gmail.com/T/#u
>> >
>> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > index 6eab61a12cd8..b844759f52c0 100644
>> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > @@ -212,6 +212,9 @@ accelerometer@68 {
>> >               interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>> >               vdd-supply = <&reg_dldo1>;
>> >               vddio-supply = <&reg_dldo1>;
>> > +             mount-matrix = "0", "1", "0",
>> > +                            "-1", "0", "0",
>> > +                            "0", "0", "1";
>> >       };
>> >  };
>> 

