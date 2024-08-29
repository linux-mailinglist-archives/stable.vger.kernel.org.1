Return-Path: <stable+bounces-71487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF49644C1
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216201C24AB1
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E71AD9DB;
	Thu, 29 Aug 2024 12:34:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728E1AD419
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934882; cv=none; b=oM2k2q+OYnFtB1tQhCYj0u9dUsdp5W6hs8SivkHcbXT5jWCCvd9kWnzo+QDIq0aZoEKqCN7c2cVwXEzP6HpN4E2ahyzgudiM54C2jwq2nG5VcgqT4hhUqSzU8l+O4JqcSpQBV9+Y3F7nepm6pjW94AOZ6tOL1Pt+v+9LL2RtqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934882; c=relaxed/simple;
	bh=HKjwKwvzbKjmVaUO91Irytsyx+WvJ9b5wVoWMYjWRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFud2GTGzN3NYSZt4p/hAzL+0K69teZq09JImxRns9OPlhsMnxg6cdf7Itzdsi6kwh1IOFQCFMA4ttj4RfVX/MTArfkRxONjBzSgxP45/cWTnh6ttbJyv+22vPV9345FgosWCgeMtcYJtlcAaM5HKxS50hmgmMkYvkF244Vc130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CB7A1477
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 05:35:06 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95D853F762
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 05:34:39 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:34:28 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: integrator-lm: fix OF node leak in probe()
Message-ID: <ZtBq1G4GRo-hw58Z@e110455-lin.cambridge.arm.com>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
 <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>

On Mon, Aug 26, 2024 at 07:49:34AM +0200, Krzysztof Kozlowski wrote:
> Driver code is leaking OF node reference from of_find_matching_node() in
> probe().
> 
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/bus/arm-integrator-lm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
> index b715c8ab36e8..a65c79b08804 100644
> --- a/drivers/bus/arm-integrator-lm.c
> +++ b/drivers/bus/arm-integrator-lm.c
> @@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  	map = syscon_node_to_regmap(syscon);
> +	of_node_put(syscon);
>  	if (IS_ERR(map)) {
>  		dev_err(dev,
>  			"could not find Integrator/AP system controller\n");
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

