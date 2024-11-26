Return-Path: <stable+bounces-95479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3FD9D911E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 05:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F8EB245F5
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 04:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F085931;
	Tue, 26 Nov 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H01l5V74"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2F14286
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732596734; cv=none; b=NxGVc2h/IsBNwFo1jaMjsgK4B/Zfy0aFqIMmTQSa8a913fg+6OKEbRjFMq6xeJnV69RHeqvJkj1jokLAnBVLBEoqUkLYwQ5p/UzZ4h8Nxm0oShqeiZU5Q/+5vo9ve4ZRCeZ16btgQfipmhheScBVCDJlHwNLZGRAic8EITP5Q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732596734; c=relaxed/simple;
	bh=UMaGgDkF1T2aYUdiWAaQKUuv145YTS1tpH7aMLKiQmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enzm5E6OROWCQxkOT5TrgxyTLypuWItTMbvWhIAeg1XXH9NEVsmXJwVj9X3LGQCWk/ISw5j+43ZH1/3UPfyENCW2I2ddblsXEtUNSJ+AEwqvtuRZHk8b5nQ9EYbzVgeI5J1wszhnPBLzuETR58UQQmKP7DnNt8V+EyiV0v+CqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H01l5V74; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724ffe64923so2442182b3a.2
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 20:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732596732; x=1733201532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rem8LGZXdVnZ/PI5gsaQii+kftUkAG4f3mUtkM8OBis=;
        b=H01l5V742yTAVdomk5Oc2AXbgCIGX8hmkHGgtDtxdFR3qig/sVzN8Dye5uD9TGoCt6
         xsWI6DGv5o6vgr6HsZjLS3X5MxTj5OB1VPL3taGiYoa2XY0HLu7UNbzH/bxHlRTb57M4
         8Qj0ee6yX8WmH/tDcbov0Bnp7PwHpIBnNUIDkd9aKOK7R0ECC0QNboRJSHXlyQdU1twH
         VOM2EYD+0AV1dckpnpTubuI21OrL1cO6K3jLhAjzO7hzvFD4ZBXYM8sCIZhQz1DqrJgv
         I6bf9GUkfxEaDcyUHMlEmeMP+tQXFgS6K29tOh0z5hDWd1Hn3hEPgOVgrwZ+SXYwlGAm
         C1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732596732; x=1733201532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rem8LGZXdVnZ/PI5gsaQii+kftUkAG4f3mUtkM8OBis=;
        b=X+tJ/VZDaF5UXRaJ4xKpBKA+zJOnA3yYc9LgbkaSPrXI9+EXTWLZrhd3hrM4h1VnUm
         JnRlDlgV3pX3Juhh/xy/0u+Pa0WbSlCUWFKi/32cJgLx2SdWvzjGXHG8YIutuLp41OV4
         w5/GmO/EEUTBu5tPuzdoeIVM1ncEzsIbeZ5TlSE1fj56nhEuEBv1g3Josa44dhh9oQb1
         rU8ywro73PWwzIka3VG0+EQrnpkWsF6VyqF+QrrH3PrPOT5qDV5rXITyFR4qjoCHM1Gp
         xTfwV/H9IR0BzVlCgENYgIdd3W91Z+kTe9dKCtcBiDcRaopE5rqMk99DEXpnvqu/q1Ej
         HuRg==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ+mVAShT3ybJ8lbxJ+bOm8PprTgHUy8MsF0S46fYUD+9BSCJtxvR3jZybrlAVIflD1McfTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUnUtO84IskC9LRkY3LCsqqpAGImPsdbJ0eoFkwnLzNk+CS10
	KiFltXUOzn4UIkgOJJK/lTw8gccMFk/GBNO0Nnm3EMiL6ugNlE8aBhe08XOGrA==
X-Gm-Gg: ASbGncvZdFOzeELLhAvuy1Ya6CQaatV7oyBngLPvYJeRfcYs7uu1/MGAA6RkiYxZRFL
	AFw5veAqBIK0fk8ct27ZxMoVpb7dwF36Ya/xm7CihsGrT+X16ivfKhZUCrkuEsEYTIx0SLgihXH
	cWAcGlKx1sS7PPQppkVMTqhFcJPVoNQmH6WN4YAojlQ89MTqd5t3v2wcAy2IYFIb662D1Hmse09
	sBGjnVf+1BvPKxIhiZiM64njYk+6Hq4c8mC2mwJb35MyCDW6CzX1lUjgbSc/MU=
X-Google-Smtp-Source: AGHT+IFLS2CiMe6uFsk3VjOrgamDEQHKYFhaEEUWVyLY/IZqdSO4oF/zkuEQngAEkYwNRZrt7cVwfA==
X-Received: by 2002:a05:6a21:3389:b0:1db:dfe4:daa4 with SMTP id adf61e73a8af0-1e09e40644fmr23624442637.9.1732596731951;
        Mon, 25 Nov 2024 20:52:11 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2c5fcsm72746705ad.280.2024.11.25.20.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:52:11 -0800 (PST)
Date: Tue, 26 Nov 2024 10:22:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vamshi Gajjela <vamshigajjela@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix link_startup_again on success
Message-ID: <20241126045206.v64iypeiyt22lcei@thinkpad>
References: <20241125125338.905146-1-vamshigajjela@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125125338.905146-1-vamshigajjela@google.com>

On Mon, Nov 25, 2024 at 06:23:37PM +0530, Vamshi Gajjela wrote:
> Set link_startup_again to false after a successful
> ufshcd_dme_link_startup operation and confirmation of device presence.
> Prevents unnecessary link startup attempts when the previous operation
> has succeeded.
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> Fixes: 7caf489b99a4 ("scsi: ufs: issue link starup 2 times if device isn't active")
> Cc: stable@vger.kernel.org
> ---
>  drivers/ufs/core/ufshcd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index abbe7135a977..cc1d15002ab5 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4994,6 +4994,10 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>  			goto out;
>  		}
>  
> +		/* link_startup success and device is present */
> +		if (!ret && ufshcd_is_device_present(hba))
> +			link_startup_again = false;
> +

Using 'link_startup_again' flag looks messy. Can't we just check the device
state after first link startup and if it is still not active, then try link
startup one more time? (Assuming that the device state won't be active after
first link startup).

Also, we should move the link startup and its associated check to a helper
function and call them instead of (ab)using the goto label.

Like,

	ret = __ufshcd_link_startup()
	if (ret)
		goto fail

	/* try link startup one more time if the device is not active */
	if (!ufshcd_is_ufs_dev_active()) {
		ret = __ufshcd_link_startup()
		if (ret)
			goto fail
	}

- Mani

>  		/*
>  		 * DME link lost indication is only received when link is up,
>  		 * but we can't be sure if the link is up until link startup
> -- 
> 2.47.0.371.ga323438b13-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

