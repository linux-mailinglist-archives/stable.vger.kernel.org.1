Return-Path: <stable+bounces-108439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165FDA0B865
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F544164F17
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43822F16A;
	Mon, 13 Jan 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SceRTCQI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1E433C8
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775750; cv=none; b=ugjBUpgGvDURHmKZ22p3pPF6KltJEcsdbuf2D0GY44WUmhal6y/osyCRXP8Dg2/cUbD7lLD7jFplBnpUNkUCrLD1MvzAQqmw2Yen+gYtkQAHlxfCtgqw6LBxy2frcmuXM0sr0xAwd0sg9WT4jshoFCb/YynvQCY93U90RHeQUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775750; c=relaxed/simple;
	bh=3QJHsmMTM6dH0YGCptmQLoKTJZOe4cB2lFQfVgJQnjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/P0RAgdAlVgjinJa+ZYjH+woIA9PgoyUN0/QkCAZP2GuRiywSvEwN6MW4g2cR49zK3oZZOPdJlA/cUF4HJPaxfF0hVIZ0yolKVs3ork9ZnekiWSZHyhlpjRHf3EFeS2acPWHGGnVfNk/ZCuj56bDg6xX0KrjypiMc/ocV2RzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SceRTCQI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f796586so44447605e9.3
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 05:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736775747; x=1737380547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X97wGoya4UQq1kA6RNcK33LUWiHL/CoWKGoyQkqMvkk=;
        b=SceRTCQIXjz2NY6DCDr2VSwznHXMPSEW0duUH5cisc8AsDBTbPkp3Kw1m5nVghZQea
         DvdGVkVyhNFdkpFvHGEDPNwvVbnHeHw/5FBrmhJDHVYUT7ZBFsPcoeFZhoTiPiEP8jDc
         CDdAMcytpN0Z3VrW1nA94Zocb6evceX1DnxoRXEIf0jYlB95o0Da5UFrAhY9/x94vOIo
         Xgpz/QSHpyqEWeDeVrUeDtbHtf1BUyX+GNuNnXOVjY4hNH1ZGj9ijDBcVaJiTXvdy/s4
         4+qe17EA9NvNq7yxNdbX+dZPAbBe7GQ6OJ9viubfF3koabanESTva02omATG/ft/FsLp
         jEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775747; x=1737380547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X97wGoya4UQq1kA6RNcK33LUWiHL/CoWKGoyQkqMvkk=;
        b=voMk9mvuNcomQT7PrCkTwMfMHFrSDkgyzcw/0mwuN4Fgncxnp8dl5tAp+wYSTBh3Nc
         rYCJpZUjyc+msknNA5RUzNgd5v1GEE85mfHy/hS2US8mQ46N+WEqcvtiiDjOIyzz7drB
         iuPsO6Gv7TtkhVf+v7taCTwCNVifPQfjaxfNb4FA4nH3ZMOuRiLLQI/4aje3HWsYQUl4
         MhXRMghk+uN6FgtegFZtyqfim9/G76tsaTts2vHQKNNP/sTSm/Q/wXY/FWzo0+q0CW9+
         0R1HYKLAETTBZMYcmJa+GdPYbzQj4+S4yfnrt/anjVy6wEYnXM7Xx5V3esg511vOTMCl
         4GHA==
X-Forwarded-Encrypted: i=1; AJvYcCVjZkbMg3h4hSOG5v1H8ms6YNUPNR7lnEROAxoVYXmW0c4VqUaHbr60T38WE1xRNc5MEcGCf+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+X8/PRCbq0rvS27aZDBDS5iD0Xqf5FV7u2naaat619ni4RRT
	rczHtEvGdXmSPqyFP5DnIhBVtlCzcshkOp06gitr5Kf6yxFXI9rX9Hfn/MHzsqc=
X-Gm-Gg: ASbGnct0rMZ9w3r/SyGEFIxiEkyt6tlt+YmnQ5o38FyTb03fM1aanCJGU9dxWAPSusE
	0c+Qz4HGXpwWx6LG7rk52csHbFA0+42L7cXj2Im2Sn0uCTEUeUaKEYry7Mu66YdwY7fwTHxLgq6
	gGWgQYWuejEgrFiGsPyd3fxL5Nly01hZHZRmBIzjb2USWjRFue2ZRwGHDyK+O2lXXWrwWS/H06W
	YxTz1/HUJ+tqKDGAhPf76wgtjL+7XNaKanfazB+wdVvYsoh9OK9Rj60uQAV
X-Google-Smtp-Source: AGHT+IGapJ+VZSro2x8LJDMDSAh3VRB+eJpi9PBbS1ECgvlLeDPwXL4yp/4ArB4ipngaE2Loe1Qmbg==
X-Received: by 2002:a05:600c:450d:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-436e26a8927mr234858635e9.16.1736775747037;
        Mon, 13 Jan 2025 05:42:27 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8a326sm178970895e9.35.2025.01.13.05.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 05:42:26 -0800 (PST)
Message-ID: <d76bfa59-8515-43ff-967d-fa7f779bf6c2@suse.com>
Date: Mon, 13 Jan 2025 14:42:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer
 supported
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Cc: linux-security-module@vger.kernel.org, linux-modules@vger.kernel.org,
 stable@vger.kernel.org, cedric.hombourger@siemens.com,
 srikanth.krishnakar@siemens.com
References: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 10:31, Arulpandiyan Vadivel wrote:
> Commit c7ff693fa2094ba0a9d0a20feb4ab1658eff9c33 ("module: Split
> modules_install compression and in-kernel decompression") removed the
> MODULE_COMPRESS_NONE, but left it loadpin's Kconfig, and removing it
> 
> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>

Please use a Fixes tag to record the problematic commit:

Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")

> ---
>  security/loadpin/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 848f8b4a60190..94348e2831db9 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
>  	depends on SECURITY_LOADPIN
>  	# Module compression breaks LoadPin unless modules are decompressed in
>  	# the kernel.
> -	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
> +	depends on !MODULES || MODULE_DECOMPRESS
>  	help
>  	  If selected, LoadPin will enforce pinning at boot. If not
>  	  selected, it can be enabled at boot with the kernel parameter

I think this should be updated to:

	depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)

-- 
Thanks,
Petr

