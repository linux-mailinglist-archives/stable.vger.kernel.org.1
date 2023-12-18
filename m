Return-Path: <stable+bounces-7824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC808179EB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248801F226E6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A011DDD1;
	Mon, 18 Dec 2023 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKtw7Wu7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA1D130
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba2dd905f9so2297908b6e.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702925145; x=1703529945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vop2uFv4rXB3gLGa/IM62jEvSbype2QIt8DlInO6Kyg=;
        b=tKtw7Wu7w/utRMOp1DqvDl09EaKLaSOElvlt3ZCGcwiHg3efmV3orXSTrW4Dbzy4qg
         sGr+e0VHDqlfgZzx1J1j1jYFKi9X9Z1Gg81io4dXChMExUNeIGczpVwPUdOgNE3d/qwQ
         x4kf6IrptH4j8Orcw986vUEby3+ACwYxjBj6okOvkJOLFxwdOqB0vkq9zz/rlNNlgB0M
         2CitSu2nbv4WxmG85snNgnFr63w5lPgkIabIHPdT/0J6rUI+ARQLRrpn+/zchFTwzPdl
         9lfBV2RPIy3ggnprY2M3vF/mzaIdgBG4qPMCvuS71rhTM5QJp6G9LvEr5FZq75AKiKRv
         g4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925145; x=1703529945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vop2uFv4rXB3gLGa/IM62jEvSbype2QIt8DlInO6Kyg=;
        b=CuRo3EIXbUxBZvouKuiV5fJZa7qerLzmbLxKGnu1S7sbtcubq4F0XJ8EROiPDcAlSS
         u2Dn1VCo4euK3fVA8Ih+zkXqO4ogAbM0ZPVLgAObbTlYCgPa4TfYBQKZ/CXCJcLe7Pn2
         9vIHPVa7boW+NqFRIO01xgXMTIMslwY1GyFqCnqmsIji5blbsisryEzwhYlZw9NSxFLK
         4OzPb14TPDJKIgkyQZvviyIc8DqoLazF88QpBtw2DVZv+Ie8OR2PGQB4MwkUajdZDScE
         VmFCSENuVeXNOxDYHEBa2IWYSolosNwX6MOu31+keuaI0FkGjoZmRsqTOJ1noNWdfiEN
         adCA==
X-Gm-Message-State: AOJu0Yz5zcNs/X3GDysR1xpg56iyosn6eTsE1h0C+3gaNJLDjIL9w1T7
	3VO3l9xK3J0y3TdS3EO15ACdiwIgR8NuBuRpiT16nA==
X-Google-Smtp-Source: AGHT+IHAkZlV51+wTttl7nrvpCpK2nk37v5GU9SmEXlt8T4CP4cNDlbfxTER3tnl4vbwVHc/mNtIFA==
X-Received: by 2002:a05:6808:4487:b0:3b9:e607:515c with SMTP id eq7-20020a056808448700b003b9e607515cmr23269565oib.93.1702925145614;
        Mon, 18 Dec 2023 10:45:45 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.99])
        by smtp.gmail.com with ESMTPSA id f17-20020a05680807d100b003ba3249652csm1783274oij.1.2023.12.18.10.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 10:45:45 -0800 (PST)
Message-ID: <6299a661-5ae5-4f7c-9fa7-96c4e7ae39eb@linaro.org>
Date: Mon, 18 Dec 2023 12:45:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 13/36] net: stmmac: use dev_err_probe() for reporting
 mdio bus registration failure
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20231218135041.876499958@linuxfoundation.org>
 <20231218135042.347406314@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231218135042.347406314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 18/12/23 7:51 a. m., Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> [ Upstream commit 839612d23ffd933174db911ce56dc3f3ca883ec5 ]
> 
> I have a board where these two lines are always printed during boot:
> 
>     imx-dwmac 30bf0000.ethernet: Cannot register the MDIO bus
>     imx-dwmac 30bf0000.ethernet: stmmac_dvr_probe: MDIO bus (id: 1) registration failed
> 
> It's perfectly fine, and the device is successfully (and silently, as
> far as the console goes) probed later.
> 
> Use dev_err_probe() instead, which will demote these messages to debug
> level (thus removing the alarming messages from the console) when the
> error is -EPROBE_DEFER, and also has the advantage of including the
> error code if/when it happens to be something other than -EPROBE_DEFER.
> 
> While here, add the missing \n to one of the format strings.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Link: https://lore.kernel.org/r/20220602074840.1143360-1-linux@rasmusvillemoes.dk
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: e23c0d21ce92 ("net: stmmac: Handle disabled MDIO busses from devicetree")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4428,7 +4428,7 @@ int stmmac_dvr_probe(struct device *devi
>   		ret = stmmac_mdio_register(ndev);
>   		if (ret < 0) {
>   			dev_err(priv->device,
> -				"%s: MDIO bus (id: %d) registration failed",
> +				"%s: MDIO bus (id: %d) registration failed\n",
>   				__func__, priv->plat->bus_id);
>   			goto error_mdio_register;
>   		}

This patch doesn't do what it says it does.

Greetings!

Daniel Díaz


