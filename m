Return-Path: <stable+bounces-43461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58928C0227
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DB61C211F7
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F35ECC;
	Wed,  8 May 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbpWtO5K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4C633
	for <stable@vger.kernel.org>; Wed,  8 May 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186349; cv=none; b=pNjb4g6p1SdK+HmVYm6G9BzjcdEQR4uqcurRYApiepiGtnNeZ+FjlhA8iwhizb6FdyGEFZzqrM6HGIYMPgM2XxXj4kwYSh3J656HLkHrcGEPrX7A4yOwol10YPlCZAhoIotqUjw4J7seqcXQNvYh8pT8pW8q96KenvScINPdRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186349; c=relaxed/simple;
	bh=eXSo6LODCjadFOS+EQ+S+4IbdWK65dyA5w3m9oMB4lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIxTICQRRRzmNoQdLS2kUKs3dioreh/hAg++WqIhKtp6H0PPsEjZn0HSg5lABEG+byJIY+rmlLoykmvd126KySJadXcEyRp1eQsXmwA8VluqlBS6cuwKT1GKdLsfcn0acffPbmT4CgcTUnn7r6VY+qpHlce8U6AnEjm9dl+cFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbpWtO5K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso993070366b.2
        for <stable@vger.kernel.org>; Wed, 08 May 2024 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715186346; x=1715791146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJhRl2DGBF5j+0kWEi1ldoyZEE3ffy3xPMEl3BQlZ74=;
        b=cbpWtO5KKdePbR3iyzQjMsTieilQhwZBts5QbZsrvyKd5lbrQQLl30wHoOhm2Tk+Na
         1kySECIGN8nBBKBLMtCnsTTxfzsl+IV8LABU1iCF29a8GR6gSxiqeBdHUzJwgwAFMrbE
         jR17tDVwF9NG0lmgRTGxKh7xvVOWx9Gksq+8jY+uSj+fZDLVabNpEo+4n1ILgUt+N6Dx
         nK5BtmTw9AIVXQJrALNFT/y5p9MZVa0qG0C9/AsSiL5wNwjph7lOhuJ6Jr9fB8awZam3
         UgPfB4oWkE3OwVx2GHT6JmHeWZwZPc14J2QlxBhiRbX+A7fFlZ7/i/eVUFGXMZxNVl1N
         06DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186346; x=1715791146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJhRl2DGBF5j+0kWEi1ldoyZEE3ffy3xPMEl3BQlZ74=;
        b=hfLbqIHjJqnAjGNUIMXltU/mROifESQnpWfqAq/gp3OSwdBZzBafAZxMR3ONvACG+1
         JybS0IvhQ0fSkRmjR1+kl9A7cXIE6ksz6YBCcYN5XRXg8kBdcu29IXu6v0/T7N3KHpp9
         K2Y3cef0Wp6yt7vepM7wq7kQ+lOzLquoSsn5fSt+6/hw358pSVeja833Cd5BcO+0kwVX
         BCvDyvf+ROX8k5H9drYZw8WrZeFHgdZgPeCxGduyljn/4qNQq+++fLye2gkWfHQ2TOpG
         RggYhBJe+JpMMH60kxWTue0E8VKTUEk/bVl5gjxseor1rrYnRAONB4XuW3RlKTHwWMBC
         HSUw==
X-Forwarded-Encrypted: i=1; AJvYcCXlzxp//pgvBZHnyARjOfZJUoreglvWtB6sTuqKmEbJqtEUKQ0mLmPA/YroiTFnXyO6CAH8pem1aOqg5/1i3QHzP8NKw4It
X-Gm-Message-State: AOJu0Yxia4NlrThiB46JJJa8rnv4LyX4YkDdknnHhr1455yd3gO6cMhx
	iAFYZrYR0VsyKUWxYzYgSgy4HhFSXDKBAINE3BU6pkq+mjwHdBNRnsbKVrFLItc=
X-Google-Smtp-Source: AGHT+IHCZyqVbpsx0DOVZ1A4z4AqaM4SNm2yM5sWSBx/6eRKLtXlUNVtYwQb5CKbqyEuaYhh+TU9Ig==
X-Received: by 2002:a17:907:78cf:b0:a59:ca33:6841 with SMTP id a640c23a62f3a-a59fb9588bamr195153966b.32.1715186346181;
        Wed, 08 May 2024 09:39:06 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.168.217])
        by smtp.gmail.com with ESMTPSA id fw17-20020a170906c95100b00a59cfc54756sm3716424ejb.210.2024.05.08.09.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:39:05 -0700 (PDT)
Message-ID: <f7528434-6780-48f6-87a4-3d56d87f44fe@linaro.org>
Date: Wed, 8 May 2024 17:39:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: microchip-core-qspi: fix setting spi bus clock
 rate
To: Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20240508-fox-unpiloted-b97e1535627b@spud>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240508-fox-unpiloted-b97e1535627b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/24 16:46, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Before ORing the new clock rate with the control register value read
> from the hardware, the existing clock rate needs to be masked off as
> otherwise the existing value will interfere with the new one.
> 
> CC: stable@vger.kernel.org
> Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: linux-spi@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/spi/spi-microchip-core-qspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
> index 03d125a71fd9..09f16471c537 100644
> --- a/drivers/spi/spi-microchip-core-qspi.c
> +++ b/drivers/spi/spi-microchip-core-qspi.c
> @@ -283,6 +283,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
>  	}
>  
>  	control = readl_relaxed(qspi->regs + REG_CONTROL);
> +	control &= ~CONTROL_CLKRATE_MASK;
>  	control |= baud_rate_val << CONTROL_CLKRATE_SHIFT;
>  	writel_relaxed(control, qspi->regs + REG_CONTROL);
>  	control = readl_relaxed(qspi->regs + REG_CONTROL);

