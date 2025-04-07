Return-Path: <stable+bounces-128487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30AA7D86D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F153B0DC3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E522A1CF;
	Mon,  7 Apr 2025 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWdH8mHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E001494CF;
	Mon,  7 Apr 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015735; cv=none; b=XEdcGT6UD7HvMV8kRRi76/iDHCWggj6Cx6qKgiylAeF5hPHb+12unkZsk6lJYGNLg/aSX8WNGbKP+oNeMdGilPxLIG8bl9aQQJYn7e88gjtlfsR39MIoy3rzoRV8gWXTBLjwiFXJN+7vXLt/S2Tsp03KsRtJfUmTDnvB+rui1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015735; c=relaxed/simple;
	bh=72umYHellYaKBHhkLItMF10xOjMbeF9Ggf7D76vY7B0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mdb4LTPfyPxpyVEJWLOf2qh7rOUKr90N2v9H/UgsQG/MSmH5aOhcYCXqhIDs9mg7qYP9XIZdTxlLwsCyT7bUulCiHvNPW8yOkyYJ8YP2ZZNDgVe5YF045nxqXrBCUdg95E/dCnFRn0GUR2EXk9ngIpKxqvhGn/w4hmYVWDjgZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWdH8mHz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso44009785e9.3;
        Mon, 07 Apr 2025 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744015731; x=1744620531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETW6l3iz7iXkgvHcK9RtSNHV8piZ5NQWh2YAPd/r8ew=;
        b=DWdH8mHzaJQa2lo+nNcdOv5W4wUmmOey0wHE1cO/HQzZq1QX3qwiV1kIf12+AdK3GC
         4QlHR/JQ3acI5gBEuLDFSV8Ty1GpHPJO8H6qh7DXHrYk5fYoUyPVO36DczA9Bd1bSNZf
         l/08E+n9jeXomjTThuJF68QggZY1G8v8dvNyAqQYIkExybVADXQ/IFA3Rhsl4Leu6YY2
         F/KSZwXSd9T9YyPHlk3CAvA45WhMj/Vix2XTG5t2npI10i1kql1jYPC45AAAWWgdYUgY
         llIdzmUONURGp5h9yGmYpDwuNwc/bRK6QP1uKqNuZ/6g1vtUtzij/xsh5/JugkZruXuc
         tEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015731; x=1744620531;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETW6l3iz7iXkgvHcK9RtSNHV8piZ5NQWh2YAPd/r8ew=;
        b=VDJc4837QdLHC6INM5SqdAdayR3KWUnbaWAdfQghBI71ZQ+E6ozwdrsFsnkGgCgd+M
         OlB5p7+8v/awo5S+IhYdb7Udd9hXNH/+RgrSyKsLB6G+H5nYUvVYlF1rbDemY7KkK2Gd
         o8jlAmXK8JphoVSd2pq2vHebDXC6ICGiq3b+suKa+zVH7RN6NmTnsi4phqKd/XphhENn
         jxLc0oWMLac07QpjG736nfJpoAQIfFelVezqbIZa8wzwfI0Ad3xna1p4EJAxnSusOnC7
         0m9Dyf8xc8gs3QAVAPP6PxXRR+ELdBb4JXOSd1fGaqvq7hWvDIpFiFMxzc8bTwKd4wmC
         mlaw==
X-Forwarded-Encrypted: i=1; AJvYcCUcuUncPu/LDfchp5wMMqfCuQIad5pWhoYlGgnMqaFrwZu/o3NKR4nBfn07FJJGTParhCdDRdcq@vger.kernel.org, AJvYcCXqVCwnLlKe7tVWs99kNyL2tZ1FST7wtAKE6S4M+GG8bDgryXRBV7/Fmmz3wUJoq8QN9Ug7/nHoTqg259U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYuiBlZ34d/vE3XEBKUCHFmyUPyCwoOADo3RV07L3PEjfzeI5
	23vRhF72AOHUnQty4ZdaqHvnHQkt43emEJYFjt1gShpFpdOCxe1G
X-Gm-Gg: ASbGnctpAifhJWVh6Eo+0iS69Gojyz8o/MxTvKLoFxCSSsYTzzyRVlrqMTYFZT2vFzp
	vvBGffcO3+ilPfwPsJFS/vsFJNz1cUg0tbdnkTL6gWJmbDNGgfp7kWrDrIlr1wvl8ytwJ9moqY8
	YGv6u1uITQt1ycXK3KDcPd8+C9u8UDToz/khxZemYnXtt8G3SD+wikXcW/bhAOOAzelousChqne
	kOI58CjoTibFn/KE3844six+tGzl9EgaA5Bn2B5H5g51Iwtepyux4d00wdbiTOPL1TKckYiJpel
	iTNE0TqXrTnxcj1Po6JGFFD6EnWNSeqiF3N2gJajHGleXgQOYLcGZmXQ123+qQgdDv1bQzB9IWx
	kSf/u1rqDbXjNDQmDTlVv089CjLHUER5U
X-Google-Smtp-Source: AGHT+IEmR58OqtA7yslcFQwqx1FxAvmlaq6osCPJB4WDTae12eKXli6ScxQuK1Lct+W8+ncDM1/mYQ==
X-Received: by 2002:a5d:6d84:0:b0:391:20ef:6300 with SMTP id ffacd0b85a97d-39d6fd18c1fmr6079508f8f.37.1744015730496;
        Mon, 07 Apr 2025 01:48:50 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364ec90sm122839435e9.27.2025.04.07.01.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 01:48:50 -0700 (PDT)
Subject: Re: [PATCH] sfc: Add error handling for
 devlink_info_serial_number_put()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
References: <20250401130557.2515-1-vulab@iscas.ac.cn>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <be202919-4fd6-bc22-ab43-09c952db1959@gmail.com>
Date: Mon, 7 Apr 2025 09:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250401130557.2515-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 01/04/2025 14:05, Wentao Liang wrote:
> In  efx_devlink_info_board_cfg(), the return value of
> devlink_info_serial_number_put() needs to be checked.
> This could result in silent failures if the function failed.
> 
> Add error checking for efx_devlink_info_board_cfg() and
> propagate any errors immediately to ensure proper
> error handling and prevents silent failures.

Looking at the rest of the file, all the calls to
 devlink_info_*_put() in this driver ignore the return value, not
 just this one.  I think this may have been an intentional decision
 to only report errors in getting the info from FW, which seems
 reasonable to me.
If not, then all the calls need fixing, not just this one.
CCing Alejandro, original author of this code, for his opinion.

-ed

> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Cc: stable@vger.kernel.org # v6.3+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/sfc/efx_devlink.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
> index 3cd750820fdd..17279bbd81d5 100644
> --- a/drivers/net/ethernet/sfc/efx_devlink.c
> +++ b/drivers/net/ethernet/sfc/efx_devlink.c
> @@ -581,12 +581,14 @@ static int efx_devlink_info_board_cfg(struct efx_nic *efx,
>  {
>  	char sn[EFX_MAX_SERIALNUM_LEN];
>  	u8 mac_address[ETH_ALEN];
> -	int rc;
> +	int rc, err;
>  
>  	rc = efx_mcdi_get_board_cfg(efx, (u8 *)mac_address, NULL, NULL);
>  	if (!rc) {
>  		snprintf(sn, EFX_MAX_SERIALNUM_LEN, "%pm", mac_address);
> -		devlink_info_serial_number_put(req, sn);
> +		err = devlink_info_serial_number_put(req, sn);
> +		if (err)
> +			return err;
>  	}
>  	return rc;
>  }
> 


