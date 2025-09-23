Return-Path: <stable+bounces-181539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B6B9726C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 20:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E374117500F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3352DC354;
	Tue, 23 Sep 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6Z7jsdK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13715296BCB
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650517; cv=none; b=HwFujEBjZ8F19xoC1d9t6NBRSWIu4r0Uyc3m5amXuhlcoBtjHKx5R4k2K+lQAB61bIChf+HH+v60FxiNHr62Ay855RPqPVrTT6USWNtgFWc5t8zNzi4UdcSqdIy27Wx2YDZg8T5g5iBMWdQEDlEfhFBtblSOiNAnx/2L6NOU5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650517; c=relaxed/simple;
	bh=tEXaouI0MQFxLgn7NnEkdk7xivByJDQ2TC4JxchAi/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW2y7Xnr38fEuf3Ls3h88bzQ+nhN8EcdY7a34AFBQxmjVUADZZN+M+HRE5KzzTry5BKdqwVOIfMNsWi9GAXphvos/PxRecaEw+3nDzHIXsoCK71f+XaDiAJAKImfNhfbXPqU7NsN6Qm+WUd/lojxUM7jCAUw+JuZ02nbuaAHolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6Z7jsdK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77e6495c999so4428831b3a.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758650514; x=1759255314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVCnZnhC/iJw/eHP2Tq/7o3gN4lfNQT30rEnkFKHPLE=;
        b=R6Z7jsdKCZTGikl/oFHgz0Qetv2dckJlOUM3AEdwhL/lENxEOmH8dl1bfftK7o9r6D
         C9p3bkOwh6AGy56f/nKS4W7AZRfs8GTe+t9vYh3dQjK9RUI8+DnQR0lf8V7uKmHj4lRL
         pgwO+ZfXMZCI0L0+1bMMrUobKu8bd1Ah481geXrQE5hcMf6oz6Lv0MByuBHx6E8ZFm6r
         99m8p3v1t3f2kQmMXuE6gN99KWquuWiEcunOtj1Jy0YIZf8AIeMv5sPON4ZyCng3Y+Ym
         tqhOBO8i0mNJK6N4qESB3q9rPXZCQBgyJA1WKJKwtMr9J+yrwvJ6ppK0M/E9ZqyNI7vy
         vj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650514; x=1759255314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVCnZnhC/iJw/eHP2Tq/7o3gN4lfNQT30rEnkFKHPLE=;
        b=ixSp/EBvCaaoLix0Qug6diDiZCNA6XT7Q0FxKF4prCGqDPFtdNpoSqk7F1IhTTvgRl
         P4e+8jiw9IQROXAHonVn3pyswvO7DYOOqZ/tnqrlOwsQexfiusYXuL8p5KCW4Be2k0Fc
         RYnw7aCEMb6qlXzicXGPnTrrtMflpqnXL11x3V9IAZA+vkKS/LFmuGLnFWhyLhRgv+FQ
         aBb9Pcu2ip2OuxhwzjrMpv2hmx9MBTUvKC1qVDcWmzBVPptoShepfYsaAdEw6v8cGeAf
         GETQpzlDCmm1J/qrtlq8pKe7rcxMwOM2OX/twgK3ymcUtgnkjKZEmrIfvm3h9bUmG2n6
         HhVw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0/bwUuHWmOiaiyWFkd1J5Q3bkTi2/V1JoYuYUFrCWUca6agNv5YYZgT+0MRbta2ak0g97JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvzyEC9gIsyyMrH4el0OfjQeP+4oyNTYxh3FxCDI4GEfhZP05
	ZRilOWRwLnsh9JBWQvVqJihrsPS0vKUIwvLKZoh54cYT1yIbLz4sgIEewCuG+Zqip6A=
X-Gm-Gg: ASbGncuM/zUe+0al+jHjv46QQocTaUSGIphjaybIjQN9S4efCuX+5m6VFyEyCTJCWxl
	4x2AlbLZnav/GttUiA5SE6Q7zVcJW++NEE21k1CiZMSTFDr/b8JkmqgyKTRAYD3Wne2Y+gaBZDQ
	SG+DYDkYZKoLiWyGl/nkBaqQRb1axMezSRH9MVU8/luR8MVs/QM/zmM6e4uFmd5BoPnPU83/kVJ
	2P8aA1aejL9UddS96VCkT9NP9Ux2BvfHI11IbXNllmH6Ladgxf2FEAOLe4CDOOd1eZ1xuSItoS1
	VYCVYLPKnZ5MfUndVP9BYjkJJqKRGQA1xpVc94meeO3iAbKEd2XXPss194AKUBxxIwGTlM1g6M5
	c6Q7jq5i/T7Ds7rk14PMt4IF/MFGs0w83CIvtpsKozNZrogI4SiVkm9gn1jNBpHg9vnHsF9HWeW
	qsdH2WMTMD94KT40EIp2kyLu1U
X-Google-Smtp-Source: AGHT+IFjLlhraiDIPC6DXDrYq4fvv/nZOvvL3T1wFQpFeNsBdDOHpuuAX/nL8T3cbxqFx2Sgp/+lrw==
X-Received: by 2002:a05:6a00:9189:b0:77f:620f:45ac with SMTP id d2e1a72fcca58-77f620f746dmr1459597b3a.2.1758650514295;
        Tue, 23 Sep 2025 11:01:54 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e369:98ec:1aa1:e6ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7ab8bsm16511273b3a.11.2025.09.23.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:01:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:01:51 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: pru: Fix potential NULL pointer
 dereference in pru_rproc_set_ctable()
Message-ID: <aNLgj49Gm9-j4wbe@p14s>
References: <20250923083848.1147347-1-zhen.ni@easystack.cn>
 <20250923112109.1165126-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923112109.1165126-1-zhen.ni@easystack.cn>

On Tue, Sep 23, 2025 at 07:21:09PM +0800, Zhen Ni wrote:
> pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
> check, which could lead to a null pointer dereference. Move the pru
> assignment, ensuring we never dereference a NULL rproc pointer.
> 
> Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Applied.

Thanks,
Mathieu

> ---
> v2:
> - Changed "null" to "NULL"
> - Added " pru:" prefix
> ---
>  drivers/remoteproc/pru_rproc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 842e4b6cc5f9..5e3eb7b86a0e 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
>   */
>  int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>  {
> -	struct pru_rproc *pru = rproc->priv;
> +	struct pru_rproc *pru;
>  	unsigned int reg;
>  	u32 mask, set;
>  	u16 idx;
> @@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>  	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
>  		return -ENODEV;
>  
> +	pru = rproc->priv;
>  	/* pointer is 16 bit and index is 8-bit so mask out the rest */
>  	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
>  
> -- 
> 2.20.1
> 

