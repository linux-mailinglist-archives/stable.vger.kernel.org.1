Return-Path: <stable+bounces-142008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1EFAADB6C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C024D9A346F
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644231AF0A4;
	Wed,  7 May 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9k+UWsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DA2747B;
	Wed,  7 May 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609775; cv=none; b=t+4q/C328ODd+lke32Nz0rVCdbP9wccxmlLlXiaLyb6C37POCpcfZIrvbm1lVAUYvyFLFUOrqh/D74BQjdAxEb+RDQlXSkiIUTCsQ2MHYMwBeWrjZK35l9/ba6BZ/cIBX0skKQUhGvPnRc4SbHkhZsifoRNZvz9zV4OsWLNGKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609775; c=relaxed/simple;
	bh=yNe/yghsog/b5Puwx6JCvObC6eqIzd/4ueq2VaAB2yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bX598xDlUNCYclkKPpzJJEuA8RQQrRV+GdHGlkmLMYWj+4WN8AJGmJuZm5ATNYR1jlf97OXU8/ElVQKg07ClvYuOrvSdTeSMKA8o81q0EXQJ9kl+K+4cq5MrfNek76fFjQt3sxp7YpQsUCrmgft0BV11VNzfu6nSXDwom2lEf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9k+UWsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA74C4CEE7;
	Wed,  7 May 2025 09:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746609774;
	bh=yNe/yghsog/b5Puwx6JCvObC6eqIzd/4ueq2VaAB2yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n9k+UWsugyDH/IF579694s5FyZt8jd6vyF0dbaGZ3G41pVvUE0jqAgUCuoaXdK+Of
	 BWR8HRi5W9FHaMdDxYZHZ0uJWnFsL6qUgeWVuvfbTXZv5uEBRaKuJRfMOP5ihZHtLc
	 v9GvG+ES3VDQI73i9//Rlc6o1nNSgnuN0thWlVEWoM/dQWNE9GbUF5ONA+f+QVvdfM
	 Ih11WnnRaYooheZbMHVSeSu8j7wOhca06kOmriCjJl4jTBPrDoAPnEEePEzvxrwD33
	 sINnLw5lyivWCX/3okKLrmuwrkn9KUi/pwNf0KMU15lhHFofVNVGAwSgXVs+CARSVH
	 TKZCzywJk75YA==
Message-ID: <7b344f05-70b6-4c59-9b5f-611dde59c09b@kernel.org>
Date: Wed, 7 May 2025 11:22:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/4] firewall: Always expose firewall prototype
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250507-upstream_ospi_v6-v13-0-32290b21419a@foss.st.com>
 <20250507-upstream_ospi_v6-v13-1-32290b21419a@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250507-upstream_ospi_v6-v13-1-32290b21419a@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2025 09:25, Patrice Chotard wrote:
> In case CONFIG_STM32_FIREWALL is not set, prototype are not visible
> which leads to following errors when enabling, for example, COMPILE_TEST
> and STM32_OMM:
> 
> stm32_firewall_device.h:117:5: error: no previous prototype for
> ‘stm32_firewall_get_firewall’ [-Werror=missing-prototypes]
>   117 | int stm32_firewall_get_firewall(struct device_node *np, struct
> stm32_firewall *firewall,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bus/stm32_firewall_device.h:123:5:
> error: no previous prototype for ‘stm32_firewall_grant_access’
> [-Werror=missing-prototypes]
>   123 | int stm32_firewall_grant_access(struct stm32_firewall *firewall)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bus/stm32_firewall_device.h:128:6:
> error: no previous prototype for ‘stm32_firewall_release_access’
> [-Werror=missing-prototypes]
>   128 | void stm32_firewall_release_access(struct stm32_firewall *firewall)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bus/stm32_firewall_device.h:132:5:
> error: no previous prototype for ‘stm32_firewall_grant_access_by_id’
> [-Werror=missing-prototypes]
>   132 | int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bus/stm32_firewall_device.h:137:6:
> error: no previous prototype for ‘stm32_firewall_release_access_by_id’
> [-Werror=missing-prototypes]
>   137 | void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make prototypes always exposed to fix this issue.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  include/linux/bus/stm32_firewall_device.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
> index 5178b72bc920986bb6c55887453d146f382a8e77..ba6ef4468a0a8dfeb3e146ec90502e2f35172edc 100644
> --- a/include/linux/bus/stm32_firewall_device.h
> +++ b/include/linux/bus/stm32_firewall_device.h
> @@ -35,7 +35,6 @@ struct stm32_firewall {
>  	u32 firewall_id;
>  };
>  
> -#if IS_ENABLED(CONFIG_STM32_FIREWALL)
>  /**
>   * stm32_firewall_get_firewall - Get the firewall(s) associated to given device.
>   *				 The firewall controller reference is always the first argument
> @@ -112,6 +111,15 @@ int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsy
>   */
>  void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id);
>  
> +#if IS_ENABLED(CONFIG_STM32_FIREWALL)
> +
> +extern int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
> +				unsigned int nb_firewall);

That's duplicated with earlier declaration. If you need to duplicate
declarations means your code is not correct. That's not a fix at all and
you are again masking the real problem which I asked to understand and
learn.

This is something solved already in all other common interfaces (ones
with stubs) and it confuses me why here it takes so much time. I'll just
fix it myself and I will apply v11.

Best regards,
Krzysztof

