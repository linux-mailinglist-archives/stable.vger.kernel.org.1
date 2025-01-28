Return-Path: <stable+bounces-110970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624CA20C1B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E65518862AE
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681F1A8F79;
	Tue, 28 Jan 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgO12zhB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5266166F3D
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074759; cv=none; b=AQ7XKajR/O8mYTeodan7vEUwzzIMdnIetwY4IXrAWkn9/xRpOnouRSk90F2xyUle9ZfZukgt5l/tBAHgSkY+CdhUcTwUqVoQJwgUyddNjibA+ILpIUD9PV3h8lrfU0Av0Dt/n4OAvwvxje5HkRXR7q+HqFfWz3fEGDlLvuW8xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074759; c=relaxed/simple;
	bh=DfF6AKkeQJ9s39d0qnwtzoPNsU1jU/ex2kbKT0qqLWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBi2e2MtugwvHxXFDL9ij8J5D1NAyXIxy05IuVkgBdghIQACEzR86Hp74LdMSw8JGUOVex+/v3HmYxci6x7nMw6iqql9sj6z6tyRlkh2FLatll+9dXshiA/u7bWQJ6zXna0DDs13tRW0FXtDYhBFykpI6H5oJj9zO9AsQMnox8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgO12zhB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so10019789a91.2
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738074757; x=1738679557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ytGFSJelmfyAbIZkJrfrYgDzAu7eCY7yXn28mYqrVA=;
        b=wgO12zhBLqpvEu4Fsrh3MATw6dZ1XDirTdbnO13JWWu/cHQhIa8xLwUIRUlS0eTiaX
         5ip80LX3mA0+nwyxEcbvxGsWsGOHWNY71GZfOV64ayLnDiBi6Ok0vX4N5k3BIWSuaZ1M
         b3anb7u/TTTw/scL6JO424zRd29KRGYKBoaOY+yZ48lzhFqE+QZWMZVOWuIGiuNR9Ft/
         IVBlgUSbCOegtxzmjXOV7KyQBeI6Vbi9jyz0+ek3ZVDmMd8MF3rDiKDXAYxhQRR7jt1h
         XpHGsHHAOuRE/X+3Ld5UBER1Ic8EsfqmYsz+kE16tiSYGpxYk+x5ugOfSjqcCvdAB8pU
         cu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074757; x=1738679557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ytGFSJelmfyAbIZkJrfrYgDzAu7eCY7yXn28mYqrVA=;
        b=cfwM2hfKG8iZW2ClUZMVg9ejlA4HdyGWGj6T5H5aEt+40QOELacCeWSB1O+H4ZhMEN
         tHXwwl4A5Cr+fFvmwggV+akSColCtvKppeOCrGKKQAvniIhKwZUIWFcjddP7AL9ykbJG
         BNsmlPiXh9994yvuW0jvHwnj9FeraWxl2xk2FT/Fp54+88tjKCB3IZdpoSyYPstISXGt
         WKfOtwvYf856Be5hFETkY1anX4jh+moyhaUBVOY7EDeoc8pYBjwWr8GWqk1gKdqRsDN3
         VykrTexryjbYjhqRRHEztHNGQbMW5cFCfBfKg4wVUvsuSyItOZp3wPU+RAKguU+hrDZf
         tP/A==
X-Forwarded-Encrypted: i=1; AJvYcCURabdj01EjQ5zOcywsl7dZ1RsZT7whXwWSq7greSX73t+zXQStumMiZUQQNDcMBXvE4EdsWnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BnblA4N2D+3BpS4WM7Wulpw/noO3Zm0TQCf2uKgkZN7N9FNH
	gk0tQt6fQ+SmpuuDHFCFsqgORuNtWSG6rKwoB0uNbwBNceY7OtDVU3Aq0fPXmQ==
X-Gm-Gg: ASbGncuwP3ZchY0CH/XR3Gg1AmCLNDyo6x8TzzfOyCQNLbLW+q1piiMCEeSrPbE0a/F
	AE8bAwwbWnpwjE5tjnRwmmEQPDEWbWSJqIyXLpGIPgMVcrVquW4NPtG5ggCAQPRW8OZZNiLOFWX
	0RQmbZcOfEPmlVPezcL5p7DwfMj8FLChvIQxutyfqq1ohba4ZYZXTAlwy4c5vp5H4meQpL5jT26
	q+7dcW2UpYcY5T4GLVO/d9olTTpDvNqNcXZC35e9LIw4r6MNhOW9z6G2McMwvGH8Pj/H+VIuXeE
	zAAqy9AbhpDuhu9XWWEV3DjQ4Op04FjP4a6vBQ==
X-Google-Smtp-Source: AGHT+IHHBcGLSrZYOToWg7qO3bGQZT+tJEWzrK5gis2zSKbuc5s4OL8oEbmzqnJFR3zhwx01FGI87Q==
X-Received: by 2002:a17:90b:364c:b0:2f8:34df:564e with SMTP id 98e67ed59e1d1-2f834df6095mr1800399a91.14.1738074757024;
        Tue, 28 Jan 2025 06:32:37 -0800 (PST)
Received: from thinkpad ([120.60.131.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1c2b3sm9357049a91.48.2025.01.28.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:32:36 -0800 (PST)
Date: Tue, 28 Jan 2025 20:02:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof =?utf-8?B?V2lsY3p577+977+977+9c2tp?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250128143231.ondpjpugft37qwo5@thinkpad>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>

On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, "irq_type" as global and test->irq_type.
> 
> The global is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> The type set in this function isn't reflected in the global "irq_type",
> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> As a result, the wrong type will be displayed in "pcitest" as follows:
> 
>     # pcitest -i 0
>     SET IRQ TYPE TO LEGACY:         OKAY
>     # pcitest -I
>     GET IRQ TYPE:           MSI
> 
> Fix this issue by propagating the current type to the global "irq_type".
> 

This is becoming a nuisance. I think we should get rid of the global 'irq_type'
and just stick to the one that is configurable using IOCTL command. Even if the
user has configured the global 'irq_type' it is bound to change with IOCTL
command.

- Mani

> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index a342587fc78a..33058630cd50 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -742,6 +742,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  	if (!pci_endpoint_test_request_irq(test))
>  		goto err;
>  
> +	irq_type = test->irq_type;
>  	return true;
>  
>  err:
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

