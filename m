Return-Path: <stable+bounces-86597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CD9A206F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76971287760
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6571DB346;
	Thu, 17 Oct 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uPWXaMm3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48731D8E16
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162899; cv=none; b=j2Oxwz1QoTXVzCR+4aeEhnI+KCN6boQBx6ow9t0W3tNokduFnPXNu1y472Nw97bO/CXayGmm+lIo0VBP2gyshcNdI2C+bJyNdqcHMHMhhYbM8r/dJs5QA6SD9YIA6k4XLZfF/3AidnuoCKx7G+5RPDKJrs4TMWIQWEU9F1M8TqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162899; c=relaxed/simple;
	bh=+MrT++Scx29PaRgKv58oxzVZcqzx7TYELWD2t6Fb0D0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+xCh+ajrSmbptIqGSrXQvwDEqst9pCjtXTeASnXAPf8SoaHHOMEWM0ne34IHi3q7gZaG9HOy1h16FzXj5AAVmo6dsaWKp62YS79y9PU4fcIWaGEKGtBRAFGRW5Nd9Juf/vsQBN7R8V71FbvKm7alVNUXhpnLa7COZ+rWDs9LjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uPWXaMm3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 915B63F2A0
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729162893;
	bh=rBZFdT3MLsNU1ABGIaObRFXCBfywuT/8DVsj8czEnD0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uPWXaMm3Tin3JL+SPrLU5hNvx0oNzxbN/3vcOvcg/uTSDj5qmS9LuPiK/xjbdwCS8
	 Yg7R1PaWMishErWtJwRgJme1GPC80BQqTPOkRgGcdff7pkkY0XRd5xcHH3pdJdwSvS
	 UINzDzSyzbhUNAKpANht83uKt0+2Rcx+b99yasIvNVQPLhzJ04Vs416yEUUMm2mg6s
	 y/MFcb5mBhTUg+2aCOaJkCBL+mjD9DrhknRa50paSWkhYou+zg61mBq68TIrZ0UEvv
	 nf3XGuE2XTs4UrmuzIUFq+E8UcClVVbxhBCSP07uvNqYuAqPGuNjWPUr93BLsmUZK7
	 i/0xf+zGGeWOQ==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-288c53ab7abso657888fac.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729162892; x=1729767692;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBZFdT3MLsNU1ABGIaObRFXCBfywuT/8DVsj8czEnD0=;
        b=h/CfU9k13hhunPsiue4vp8ty4KkWY2UOMEK19ejLKaThuKU9cRBDRrSXlFFCgtqGJl
         11kVCLpKl8Db5/Gbn58q63iqJ+ze9N/SEosIvooR8cDk/NwHV5PSYZmOJsbf6tUOi+0n
         0YznZmhGLotZNk13ENNQXltFSaHCcCE8YpfXoO18tT1aBNfVPD9kdN4e8BDihzAVPaho
         UanLQFu3F8rk80pAFR5CUHmIY71BtnQYPxoWYsybdhHOzg7zOxbuIbDkC4Foidv4TrOp
         7fDIV8Pfmc68fbY5VsFeQwwbi493azk6QJr9079hp8/x4Gx0Yfpu2YiOTDoVBfM2Fd+r
         0LSg==
X-Forwarded-Encrypted: i=1; AJvYcCW+yjY1iSBfoA7v4z/BPCvXbHOhmJSbtq4VSUugr+6+ePmocSm5DdfY0MS4M5Vx6IZF7Fx6OMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBVxtFN7NfGmCycvixO+i9Tgz83FV2DbyX5/1hCXlVcKwzHrD
	p3H1VQXW3AbGvN5M6km0AXN3VZzrGbBb2YLau9kOJSg08vDTeVHgNwyFnRS+e0ty8AHk4GyuSbv
	VBhPo/QyDGzFYpiR+A/wlk2lvk3Ch6/ClWT5x6cVYqLHvsupBzO1EGKmAeFkPRXfhAEpxOTtaGy
	zE3RYCWJZP52FxJd3v7COV/Ldr9owTL1yz71F5KGAm2BbW
X-Received: by 2002:a05:6870:6b8b:b0:288:6220:fe18 with SMTP id 586e51a60fabf-288ede29989mr5858221fac.15.1729162892278;
        Thu, 17 Oct 2024 04:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHMQG+kH208gfIiCgVMibniBpJ9STBwlor/4oG77CWFuIW/8xPcr2jPuy853NfEotH6tqZk6Hzqg2xW/WrByQ=
X-Received: by 2002:a05:6870:6b8b:b0:288:6220:fe18 with SMTP id
 586e51a60fabf-288ede29989mr5858187fac.15.1729162891890; Thu, 17 Oct 2024
 04:01:31 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 04:01:31 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241016-moonscape-tremor-8d41e6f741ff@spud>
References: <20241016-moonscape-tremor-8d41e6f741ff@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 17 Oct 2024 04:01:31 -0700
Message-ID: <CAJM55Z-3R5tbvpQB7mLF6b=FD9Wg-78_KPww2nqOLr566WPOFg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: disable unused csi/camss nodes
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Aurelien Jarno <aurelien@aurel32.net>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Aurelien reported probe failures due to the csi node being enabled
> without having a camera attached to it. A camera was in the initial
> submissions, but was removed from the dts, as it had not actually been
> present on the board, but was from an addon board used by the
> developer of the relevant drivers. The non-camera pipeline nodes were
> not disabled when this happened and the probe failures are problematic
> for Debian. Disable them.
>
> CC: stable@vger.kernel.org
> Fixes: 28ecaaa5af192 ("riscv: dts: starfive: jh7110: Add camera subsystem nodes")
> Closes: https://lore.kernel.org/all/Zw1-vcN4CoVkfLjU@aurel32.net/
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Changhuang Liang <changhuang.liang@starfivetech.com>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index c7771b3b64758..d6c55f1cc96a9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -128,7 +128,6 @@ &camss {
>  	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
>  			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
>  	assigned-clock-rates = <49500000>, <198000000>;
> -	status = "okay";
>
>  	ports {
>  		#address-cells = <1>;
> @@ -151,7 +150,6 @@ camss_from_csi2rx: endpoint {
>  &csi2rx {
>  	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
>  	assigned-clock-rates = <297000000>;
> -	status = "okay";
>
>  	ports {
>  		#address-cells = <1>;
> --
> 2.45.2
>

