Return-Path: <stable+bounces-151592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB0ACFD9F
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 09:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82F21638DC
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE08283FDE;
	Fri,  6 Jun 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyqdMCWH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513D7FD
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195739; cv=none; b=dvLhvm596b7nV9Tx/CHRU7DQnwLthLFnCN+R0GXFPi5GCMXiwSe/Q/MXniqnvqy5wB/f6eBqosf+9LLQPfjnIqsWXEm42e4FZYZaNse7tfQa+Sb8afzM5LhlxUl55hsuiWysvWWzoeb/b5ONny1tZtHbVEw45rpgyE/7f3tL4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195739; c=relaxed/simple;
	bh=JrXEu9V00IDwc0gs2Fk3u6thmp4myUk90+/KCMWMqHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOYOl+wJyZkvvvtZxugMWGx0upgxtx5l5Wf3Nt6D61VJGVPatKKCV0CyI36FDF9rFH9BqW/A3XAvRSqGaORcOw+y8OUO0UCSfVsyDjc5sXjKXTsphLO5DKGbHOkr/f7A1r9x+aPOPJL58qJrNAewsWrvDa3h49Jletw48hrERLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyqdMCWH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so20203505e9.0
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749195736; x=1749800536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Px7TUkiGLJQvkjO/71jKrxllILzPLzGA5siX95GH57I=;
        b=NyqdMCWHOoSp2C6ntTQEqAHoDzvLQxSzWsiWJAkHHcYmtu17UbnJEBc7fHWIC0FiIY
         yIOmjDrh873M0nLI5oenX6cHZd3aZF9LqNHPiHITxZH1D9u4LZHew0+ym7sqrWHf29jJ
         LLQ5AymDNct9M3rtrUb/FLTLlxRbp8JArLr00m1buxCJZldgV9fj89XjNmzsEtoPBlng
         gkfGjW6E+t1xLNUFMa8eWfjtZu4t1b2ikwjyenzfrjB5wNJwC9W//VGgrsAE+BioVOHJ
         wKRmCgpB5026ihZfvenShxWmLicm+cGPLAHYUndNNgHbVfx/aXI61EfMYJxrpxNP2uyO
         LvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749195736; x=1749800536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px7TUkiGLJQvkjO/71jKrxllILzPLzGA5siX95GH57I=;
        b=HjxuIeXRIKUPcR2jsj6QJSL5CTyY5NZ/43i071JYSXrfgmzCC5TY5FiH3sUwzYr8+H
         PcozNuu6faWv43LPQcEmnbLdaXBhNzop3Ke3TT0msn5/Wuptc/4keN4uVFP7PI2JA6xX
         tBVpoeXxLhNZUOq+PzORjhejSPBDf7WjJRN96Vl8ieUdcO/4pNzchWRaFtKlS2+8EnDY
         wgdrLeF09oFWQDvdVfn1Wi9vHe2pRYHNM0rXFr9YCnHnaaSEzm7xF90meRd/1XADlWqP
         E6IP9I+lQwm86xGVhS31+3aYrMUhBPk9jWSibmuFkkzPJkmxtLfwpoBaBotRecTweyVJ
         WwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2sKsXOU6ncnC/LtMWW57ZJamwt8oOmiM0lTkCSyQ4rkf5NWcNyu0+RhASS6u/iGhwgOc7XbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/aZqWjND/MT8p3ibRYG/nEUMzbjVcsCK4SKUHSFa11T8/tSu6
	PKZrfB2kZC8OwgCK18xJhp2qN/krIq/Y5tXqScpGcx5ScAnNz6Dou1tHH8nR0owNrlN7JGsyDyV
	XvcpciGAjLw==
X-Gm-Gg: ASbGnctLEuZhe+6ty7n6ulr2ORuhTQtewCtd1+cW/zRSs6fAtzDg5CoEvXHClNFDsjC
	QlKfIGwkAKpjh0ZSR2fSkV1TmK/Td8/nynddWT4h3Ru8ez6ZtFy1RkVfU7zRbpQQJJAJyPgtmCx
	DElLnoODPnjSrOaLZ/TTolCt46LIVhyJGfkg2wf0Vh/l4/rmCe3/rqc288gwWowb+PkcUTKss7V
	Z5kEKzZuEituMfEllkIfvEFG9HzrApW+myxn5IcpNAaIpLfT/3QZsfv1MeHSantqzPSdkXZzsxL
	FnpBxIHx9xPRvB2+RdWhXJEk57jgqkTnl2GolPvFwKh+n/QGArbmPkYcfPwVUYY0MZJOxvwQH1r
	Jn3Qn
X-Google-Smtp-Source: AGHT+IEDJ6Qm0Ur3ac3Ih5jAsMWLAgYjL99/0S8sUsnqlAT4/rYCzrAkgc1FBvTgHlungYhO6iFY8w==
X-Received: by 2002:a05:600c:4f90:b0:44a:b468:87b1 with SMTP id 5b1f17b1804b1-45201506dd3mr20374865e9.4.1749195736011;
        Fri, 06 Jun 2025 00:42:16 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e056138sm12622585e9.5.2025.06.06.00.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 00:42:15 -0700 (PDT)
Message-ID: <ff77f70e-344d-4b8a-a27f-c8287d49339c@linaro.org>
Date: Fri, 6 Jun 2025 10:42:11 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: mediatek: Fix a flag reuse error in
 mtk_cqdma_tx_status()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sean.wang@mediatek.com,
 vkoul@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250606071709.4738-1-chenqiuji666@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250606071709.4738-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 10:17, Qiu-ji Chen wrote:
> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> 
> Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/dma/mediatek/mtk-cqdma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
> index 47c8adfdc155..f7b870d2ca90 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -441,18 +441,19 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
>  	struct mtk_cqdma_vdesc *cvd;
>  	struct virt_dma_desc *vd;
>  	enum dma_status ret;
> -	unsigned long flags;
> +	unsigned long pc_flags;
> +	unsigned long vc_flags;
>  	size_t bytes = 0;
>  
>  	ret = dma_cookie_status(c, cookie, txstate);
>  	if (ret == DMA_COMPLETE || !txstate)
>  		return ret;
>  
> -	spin_lock_irqsave(&cvc->pc->lock, flags);
> -	spin_lock_irqsave(&cvc->vc.lock, flags);
> +	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
> +	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
>  	vd = mtk_cqdma_find_active_desc(c, cookie);
> -	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> -	spin_unlock_irqrestore(&cvc->pc->lock, flags);
> +	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
> +	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
>  
>  	if (vd) {
>  		cvd = to_cqdma_vdesc(vd);

If the first spin_lock_irqsave already saved the irq flags and disabled
them, would it be meaningful to actually use a simple spin_lock for the
second lock ? Or rather spin_lock_nested since there is a second nested
lock taken ?

Eugen


