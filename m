Return-Path: <stable+bounces-76734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD197C63B
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B210A1F266FB
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9971991B8;
	Thu, 19 Sep 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzd1oxp9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE719882F
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735881; cv=none; b=CEglUsNeu8XC3M/bsqgXdOJu4KSvhO1Nz+WFf93RJ27Bq2bZ7dA44Lf0oViLtSBqvLyCYnqT/3zmdi+/7/aw6J3T1KKVi0RiSqMMMz2STNlkq0nuFqMAtRsQ9h0XMQ5dleir3wxm6HxgF9XAiokHF9TUptdYROw8WR30QKWb6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735881; c=relaxed/simple;
	bh=AnH2+fDMdJDfT2wT7eStlGQyoxprTA7rE2T3QoCF3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfxTrcpYuk1J9rDSJasorgqIIcuzHQRwrfcpUpU9UM3af3BcUEgiT29FIfKokj1qVkRyaVjSSXUMZAUzO/jZ5HbGeTbWyUHmQqpeDnFq3pzb6O9ItH5LtdEP5vcRX90KA90aYG9wNuRtpjHVxbfF81HY0dHjLUVpACC/1QTTmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzd1oxp9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75f116d11so6425421fa.1
        for <stable@vger.kernel.org>; Thu, 19 Sep 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726735877; x=1727340677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFHiL3BgzhxbZK16C89HqTbhSA1DEHRKJHHzop0uZPs=;
        b=mzd1oxp9ele05k6dGl5bOp+7I6TPbO3tp3tyAGz/icDreMz2QDT/qlkPL7S5Uic2wM
         CPcYZO3f+YgpE3A2wfxU8K+0OEhDSlkjEJ4UXppEgLX6Ivdqqq7CJ8MUWTmuL40vgAeV
         T5UNr2Tei77zk/9sylZw0HIKjLEKmCbPp4AlC0c6nNp1mjLY3S5Vcojh2Q3cYfadYh7u
         dpMGRMjPmmb1vZ5w1z1nv8PstPFcBUD8KWCSk75OUCi2LNvmYh2Ed+BP0ir01NGRmVU2
         DaeUSFYxHmsBOFAAqvXR4RqgnRz8+IhTP/5HmkDkUfUavnLeIs2eOb4NZXDdVCj9e1FE
         xsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735877; x=1727340677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFHiL3BgzhxbZK16C89HqTbhSA1DEHRKJHHzop0uZPs=;
        b=bod3DMAXvyqT/aaXupMg4oicEt4n3b+EtjDk2YSKWG58t+pU80X94viAKw8t2yAaFu
         xcFk6NwumwXyGyF2sGYCt2zLFynBNUaV3DrXaCNPnimwKbssSx+jZovBgnAD700lLSjv
         oRsauTuGaYldqFoGjL5eHZOgavoiIVCyhMjTdmYrel11wIQQy8VfU8d2GwpbZMJafU6s
         M7K2ICgs6tsttfA0PyiUhnAYpzJrvcmFF34JrR6A+4LwNms+w35VgIW7Rt80It2s5vdd
         SLSLSmBDCex7nc1JRrCMfDoNgcePGLK1POvqQferhcTqgFdYoKMFaHa7B24PLcTa97OS
         aB9A==
X-Forwarded-Encrypted: i=1; AJvYcCXyVWGP1iml7W0xuZSrZxqeq0O6xwMJBVpor7yzZ06fwy4bJK9euKx5whEdq9u2iBRNaCqvQds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/w03F9rkmdZBzMc80Mqf6vMiFw5p/Ynqxs5Hvco63ibLqGOqz
	7fQAiAgN2TnGr0XOBml6zT4VabQbaHPYX7UcAdTfPd7QkFBi3IOevmjTjqC87vM=
X-Google-Smtp-Source: AGHT+IGf49cI4YyHpgiDrXf1LO6sQkn/+x4wD+WKELy6/BrsBTPxz3H1KWGaL+L8fLNfM/X9ym14hg==
X-Received: by 2002:a05:651c:2206:b0:2f7:4ccd:891e with SMTP id 38308e7fff4ca-2f791b4d3dfmr125869561fa.34.1726735877460;
        Thu, 19 Sep 2024 01:51:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37fb34sm16211381fa.86.2024.09.19.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:51:15 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:51:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: Fix arg check for
 usb_power_delivery_unregister_capabilities
Message-ID: <rqnfzpe6hsvsjznbvnr4woso7i33lfye7sqnzkvh7ejnfzgwu5@zbbzsu57w7cv>
References: <20240919075815.332017-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075815.332017-1-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:58:12AM GMT, Amit Sunil Dhamne wrote:
> usb_power_delivery_register_capabilities() returns ERR_PTR in case of
> failure. usb_power_delivery_unregister_capabilities() we only check
> argument ("cap") for NULL. A more robust check would be checking for
> ERR_PTR as well.

No. The calling drivers are not supposed to pass ERR_PTR to
usb_power_delivery_unregister_capabilities(). If you check the TCPM and
UCSI driver code, they check return value of the register function
before saving it internally.

> Cc: stable@vger.kernel.org
> Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index d78c04a421bc..761fe4dddf1b 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -519,7 +519,7 @@ EXPORT_SYMBOL_GPL(usb_power_delivery_register_capabilities);
>   */
>  void usb_power_delivery_unregister_capabilities(struct usb_power_delivery_capabilities *cap)
>  {
> -	if (!cap)
> +	if (IS_ERR_OR_NULL(cap))
>  		return;
>  
>  	device_for_each_child(&cap->dev, NULL, remove_pdo);
> 
> base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
> -- 
> 2.46.0.792.g87dc391469-goog
> 

-- 
With best wishes
Dmitry

