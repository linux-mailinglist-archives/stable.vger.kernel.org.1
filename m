Return-Path: <stable+bounces-76863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E197E29E
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10D91F21929
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD22A8CD;
	Sun, 22 Sep 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAybw/64"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6021CFB9;
	Sun, 22 Sep 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024515; cv=none; b=iCNFw9TRB+wCTYZonMzqiLPX2JRuCFwJMWzWTq8/eUH/SdrBEXiRXI2Hyw9aPr9spLiFAMeQvpNZzqSXU10gr0vIkXMsJtuWLlUsTqZ02F1rimp+HGNp8AOOf50RZVcia+0yOkdEVNnrvjDzwu7cqSGdfiMZxNzlPIsPaE8CJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024515; c=relaxed/simple;
	bh=W0Q3t1cD54SXXSBH7q4jVSfQ0CDLGNlbuw5viLLpA7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1KrcMoUqgV29/8CyWKcQjp8DwrmG706NVuBlHba2yA0ZO3N5scsSe1Kb3zXwmz4CCLllm2iIaSYrmlKGJmEbLFXZVFzAdt8SFvyagzbyZBwD+o2pO8NLRG18zjmEOQ5+Z8HtCpuxR69qOvXZw4c966soxlRueQCWHDIaH1dtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAybw/64; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so28006775e9.0;
        Sun, 22 Sep 2024 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727024512; x=1727629312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6OYj2UJLtKO0PzA2lDG8Hf51QXdlmbxTS6bMeQGk50=;
        b=FAybw/646ad8wCLqdeUJPrL57SCol+w9qHfNKJwW/RYRFeXfmKZtL4DqtTt+jaKgef
         0nSx1uKncFCni2+SMDU2wupQlmvUlv8xdSlUVLLmO/Bh8io5Ux+vaY1zR50xNFK8bcO+
         OXkwlKj9b72pcw1HgHaSJ9f51ZrS4uX/QXG9mCbDxjs5IIg8oqgQHJHy+D8LeahUe9mV
         nU3cywUkN3VFF6m4smT237SDooxclgT6N6yFGLi7xSZwH8vAaO7saw0WhRXn9HR2wMvg
         PfmCRv0ob4/DFV5/iORApc9S3luFb6vo6gPi4IIo3BOjRJYkbmfBi6SqSlXThiysW6eO
         jbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727024512; x=1727629312;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6OYj2UJLtKO0PzA2lDG8Hf51QXdlmbxTS6bMeQGk50=;
        b=umWQAif1DxoGf+nzFm5YjVIpcmGt3xeXIC0duDw8fhbcYAjjAmbRSB+eTjAwSbhfCY
         Li+mc31CjzlyssTThxKAYRfIcJWHbhC6Y4ppSyRwajKDVebn5xmSZAvk9pECDwKaXmPA
         U7COxhzQmmMWslEE6eSI/6uP5M/YN3ov706+JOzaO87E2SX04MMOB4jl51P064vMptwr
         yqYF4vIG23N63TY0mepHtyvTNhW85//vOUls0w5BJl88dOYtiHE0CtCQtZ8BgpZ3WS6c
         aW/MbN67w2x5kPjFCYd2JtyDj7KYzOrkKUkJXGlTG2juws3r/GXhzD5gueQUgZv+dafy
         V7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLbqVpYE8s0drJg1GNtJeyGcDzO+SjxrKV3jII4Y3Zq3HiyWXHFoKC3Y1o8sDNQS/wepSuK8iJ2zN@vger.kernel.org, AJvYcCWjcXei0g/oON2AGHR3R4ZIAcMMCsJ2heKFY4f1FZ9ju5h2tNRz2XIevFckFQnUScMmAz8kzTvG@vger.kernel.org, AJvYcCX74z/0nY6T28K7a3Yd0NdQoNBxHd15p/rzRj+b+/T5uI0e7FnDngbwXOMaOiq9XxnKldGFildvVaN/CpL3@vger.kernel.org
X-Gm-Message-State: AOJu0YxVV+AGMrDH14c5SoETEQtP+VPQNiwvHQLNSYmdmXyarclC3EGn
	iuczfEjSBXgyVu6TJ3xg26w6h5EwuXTy2IDaSIc03srwfRBAjzBy
X-Google-Smtp-Source: AGHT+IF+lPG/TGg29MYlU3BmR+FnM5mK3gvHfmebpJCRc6aD+5GdQAF0EcnCJztjRJv/IukZAZEtFw==
X-Received: by 2002:a05:600c:358e:b0:428:1310:b6b5 with SMTP id 5b1f17b1804b1-42e7c1a3916mr61839915e9.34.1727024511350;
        Sun, 22 Sep 2024 10:01:51 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c643csm104582835e9.45.2024.09.22.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:01:50 -0700 (PDT)
Date: Sun, 22 Sep 2024 20:01:49 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to
 accelerometer
Message-ID: <ZvBNfeg9uowsM9ub@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, linux-sunxi@lists.linux.dev,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>

On 24-09-19 21:15, Dragan Simic wrote:
> The way InvenSense MPU-6050 accelerometer is mounted on the user-facing side
> of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees counter-
> clockwise, [1] requires the accelerometer's x- and y-axis to be swapped, and
> the direction of the accelerometer's y-axis to be inverted.
> 
> Rectify this by adding a mount-matrix to the accelerometer definition in the
> Pine64 PinePhone dtsi file.
> 
> [1] https://files.pine64.org/doc/PinePhone/PinePhone%20mainboard%20bottom%20placement%20v1.1%2020191031.pdf
> 
> Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for Pine64 PinePhone")
> Cc: stable@vger.kernel.org
> Helped-by: Ondrej Jirman <megi@xff.cz>
> Helped-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     See also the linux-sunxi thread [2] that has led to this patch, which
>     provides a rather detailed analysis with additional details and pictures.
>     This patch effectively replaces the patch submitted in that thread.
>     
>     [2] https://lore.kernel.org/linux-sunxi/20240916204521.2033218-1-andrej.skvortzov@gmail.com/T/#u
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 6eab61a12cd8..b844759f52c0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -212,6 +212,9 @@ accelerometer@68 {
>  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>  		vdd-supply = <&reg_dldo1>;
>  		vddio-supply = <&reg_dldo1>;
> +		mount-matrix = "0", "1", "0",
> +			       "-1", "0", "0",
> +			       "0", "0", "1";
>  	};
>  };
>  

I've applied the patch to next-20240920, built and run on a
device. Sensor now works as expected. Screen rotating in Phosh
according to the device orientation.

Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

-- 
Best regards,
Andrey Skvortsov

