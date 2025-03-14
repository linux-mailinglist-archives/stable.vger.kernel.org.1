Return-Path: <stable+bounces-124462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EEA61735
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 18:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4181317D555
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1741204588;
	Fri, 14 Mar 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOfIrw7o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B221FE456
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972461; cv=none; b=c8xfCKTrTVVSDTBukM+X3ztIe7eIK2rCdWCMTHmlmt1Z5MqtOCPYipvGj7GOxs0b/jUdPn9vbiYHZX05OCr/L3p9StovkCGxPeOowYMI9gAU6XHyuZc318fIEhPDp5bYFrrwike10lqKHvjzcZa5DEyIgO9aK6pbTHwhG5bwmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972461; c=relaxed/simple;
	bh=5p0iC2SItNuF6AwjE1Hf3HgmLAJx6GZW09MUMx1WDn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/9LZ+WdV2r0Xd/GDM1vigBZLU2FWhg5aMdUgNMUIko31BWO890tMUE9G38ozxGHp5r2wLpqFxtDP2qnmOK1LaTr0eXvIz1l2XH3uXKETbeoWr74yqoruzk7ko7xLXM8/BR4Li3yzUd1a1j37qZUiSRT3KGgI2ubC/LYifEvHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOfIrw7o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso42440705ad.0
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741972458; x=1742577258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yix95Y58aFVDLktEp8lmDmKYUrlcv0lyEDYQZgOfJW0=;
        b=UOfIrw7oT+4b8yEPf7Mh2zudvDHT7LjYjk4PRUR6nDtvJF0TAUvoBvgiK0Wtqpefy3
         K2DeSrNEw5yqYkY/8/Gskgg1juSt3h4RKFgqvxywGTIK3cXUCqeytxE2fwAEq0w+QQZ0
         K7UEssTLnlSZeVpuYoIhv/EJnJAs48MpjhUcwjDqxDj4f2uy2qYLPmGIrU3zYlyka04a
         sj3RPl9mZ5IDgN31WaOCkDmyFBk4mXyDwhyWV0SZyjOgl6k0mpDJ6nAKkVV7f3Zi+Yzh
         bydkQrtjV6L5+s6tfjUE8X3hr7Os0yPQ12lC9+adIWz1kIFTRqv32C7MPbkjpv+lR8P6
         /vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972458; x=1742577258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yix95Y58aFVDLktEp8lmDmKYUrlcv0lyEDYQZgOfJW0=;
        b=jIO3lp/o1UUvADnV8DEi4AQRusag2KSklzfEUN214fJse+VrxguS2KFrJK+BkbhZcs
         ddAdooe+vAIo+h/zrl87g9AtURRJ8IpppqrbZPIowEDidezyNkoPFkJgIppILiH65m8q
         Rft0mwpxofbdzifRhMM5O81ju2pEuWfisj7oLRo9ifTSYmj1EdE1LQyoltc/R210XC9C
         OWe95Y3723/XgCDn5mm/bBQnHXSjmq0qg5DMtkCBsX7VtJ9oSufI423RYK0NluwVKuIl
         VMN0Q3mpWp1cEqe/wlxfi85l6+7p6tKptLIp7HSKECrb1a35OL8h+Iw3/mVI+SCN28g2
         n5xA==
X-Forwarded-Encrypted: i=1; AJvYcCXajxIGHUkCJJzy6kVM2mObgfw+SQvCx9slhUqSWwR5PPF9NORKOL1/VXbIx4ff/u2Ti+ciFaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiu/760Ie/l/5PoCSdVQMHtbtBqpXDItDaCWTzrJxRqXpUPWu
	+dW5qxqbnRtGcj94L/NiTwBWX+aXFOF7eusYi2Hn3kJyPLEcSxc7Q4yB8ijSwg==
X-Gm-Gg: ASbGncs1J9UAHGbaq7RpaJ/u/9daFQOFBqD5F7FpNJCsoLKgLScSlF6UUnEL0NdR2ql
	YHylPKj6tO/CmWMP+Vv+/4XDUt2AZYpU9OQPjmmQXhRiPOWDpmVzK/tIjgZ1F3KUd2sUUECzGpg
	/TEj3go2UVpkH0cBxqjBDZFXp1DatdNK6CZSFxQ275XlSR6G9ajzaM0ZrUiBaN7ruQEvXGTaca2
	XUBJBGTnvZsfD2e1uS7TOnNsT8UUbWGfA4HF/IMcjv2ChQuE+DvZOtdxRTqifaNrO9d/FRkcB5d
	UVFnaR/h5EeiUk1TOYTSKyzusp2YWYnnqr8QihapeXIhxZTESQ96UFae/6A5lERTN8AjpYYS+l1
	m7uc7nRng/L/dVgg=
X-Google-Smtp-Source: AGHT+IGy7HWrkPvjUpMMYhRQbw/am4ugxDMqJdGJdWH8dd6X/1N9h09zGNW9ExGPYF3hEaJz1QwaUQ==
X-Received: by 2002:a17:902:d4cd:b0:224:3994:8a8c with SMTP id d9443c01a7336-225c6613932mr89268175ad.8.1741972457947;
        Fri, 14 Mar 2025 10:14:17 -0700 (PDT)
Received: from google.com (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4d61sm30841415ad.242.2025.03.14.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:14:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:14:13 -0700
From: William McVicker <willmcvicker@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent
 property
Message-ID: <Z9Rj5T8il4rZAsoq@google.com>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
 <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>

On 03/14/2025, Peter Griffin wrote:
> ufs-exynos driver configures the sysreg shareability as
> cacheable for gs101 so we need to set the dma-coherent
> property so the descriptors are also allocated cacheable.
> 
> This fixes the UFS stability issues we have seen with
> the upstream UFS driver on gs101.
> 
> Fixes: 4c65d7054b4c ("arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes")
> Cc: stable@vger.kernel.org
> Suggested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Tested-by: Will McVicker <willmcvicker@google.com>

Verified I can properly boot to Android recovery with UFS probing and mounting
the partitions in the fstab.

Can you send this to 6.12 stable as well since this is fixing booting issues
with Android?

Thanks,
Will

> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index c5335dd59dfe9fcf8c64d66a466799600f8447b0..cf30128ef004568f01b1c7150c5585ba267d64bc 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -1360,6 +1360,7 @@ ufs_0: ufs@14700000 {
>  				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
>  			clock-names = "core_clk", "sclk_unipro_main", "fmp",
>  				      "aclk", "pclk", "sysreg";
> +			dma-coherent;
>  			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
>  			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
>  			pinctrl-names = "default";
> 
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

