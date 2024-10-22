Return-Path: <stable+bounces-87777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8069AB83C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 23:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9C11C22706
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015E1CCB4F;
	Tue, 22 Oct 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mTVPp93X"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B831C9ED4;
	Tue, 22 Oct 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631459; cv=none; b=hi328+A0tHnCnJnZMnM1/vyByitCWYOgVUO8pxPU+qnrMD8qgroIH0Q86zLqQE9UC84K+G3L7munbh8CERpfs0rak33PojLVtgZw11bKDHPf/a2PRKv9fatswxAO0z6vvhUQdGm2i1+xyck997HxXUKhUKfFl8izUdsRt/VQmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631459; c=relaxed/simple;
	bh=dc/em9XLGr0IMWGi6gCdSPRtcojc9lJvnQ6IDEZddIs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tPJAvdNh+iIssfCRp5lyN/GwI0otSnoT3j47d+vDBacWmQbufDZyyq5Ny6RZYnJT0NfdrRk8QmENNAz9+/dhmYo+GxXWwzxthrqf1iUuJEmWoE1fxOV3QyKoCmn/6D8wh1Kn09uB+dHAclIvJIT9dtY1tVyUE1urk3TDRK5CC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=fail smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mTVPp93X; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729631455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpG8Gwq6DbfDSJARi+S9yYQYQPhocfObsOfqzRoEGDY=;
	b=mTVPp93X6kCWd1yaOPgEeTFZ2CVITdBz2tY14CSzFXNCbLtcpymcrjaKZsvkKNduxny/r1
	4PbQjeFI4AOqProBKrgeYoLad9UlkBhEdMCjHKXJGAzYBGZi2B7BtOE05QQkqDXJ7EgbrL
	NsxsV6QWbf2TfeudtzwmlYdDZZEL3I3zU4ZtgKNgQ5quj1ranStuvTW+c50F/qUksoS/6Y
	MfpJHX2rzwAD10wKrs5T2RyrfkBetgzg6jmKQNOzunh7cFhvI40CXQbDdaXYJ3mw0mAD6f
	Ca2ILEKbkzwgZ/AQ9IuXlDUTciTroNbXScfriME5a8/bt90layqsKEB8mFY/2Q==
Date: Tue, 22 Oct 2024 23:10:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-sunxi@lists.linux.dev
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ondrej Jirman <megi@xff.cz>, Andrey Skvortsov
 <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Add mount matrix to
 accelerometer
In-Reply-To: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
References: <129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org>
Message-ID: <bef0570137358c6c4a55f59e7a4977c4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-09-19 21:15, Dragan Simic wrote:
> The way InvenSense MPU-6050 accelerometer is mounted on the user-facing 
> side
> of the Pine64 PinePhone mainboard, which makes it rotated 90 degrees 
> counter-
> clockwise, [1] requires the accelerometer's x- and y-axis to be 
> swapped, and
> the direction of the accelerometer's y-axis to be inverted.
> 
> Rectify this by adding a mount-matrix to the accelerometer definition 
> in the
> Pine64 PinePhone dtsi file.
> 
> [1] 
> https://files.pine64.org/doc/PinePhone/PinePhone%20mainboard%20bottom%20placement%20v1.1%2020191031.pdf
> 
> Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
> Pine64 PinePhone")
> Cc: stable@vger.kernel.org
> Helped-by: Ondrej Jirman <megi@xff.cz>
> Helped-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Just a brief reminder about this patch...  Please, let me know if some
further work is needed for it to become accepted.

> ---
> 
> Notes:
>     See also the linux-sunxi thread [2] that has led to this patch, 
> which
>     provides a rather detailed analysis with additional details and 
> pictures.
>     This patch effectively replaces the patch submitted in that thread.
> 
>     [2] 
> https://lore.kernel.org/linux-sunxi/20240916204521.2033218-1-andrej.skvortzov@gmail.com/T/#u
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
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

