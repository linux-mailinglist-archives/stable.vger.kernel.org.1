Return-Path: <stable+bounces-124344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA33A5FCD9
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189B33B4D56
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93626A0B7;
	Thu, 13 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFpn2Kmb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A9269D16
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885227; cv=none; b=aRWs66uvPMflnJRFf7+gxuL7MOmKRrwFMeVqbwx0T62+yII7JBxfEwMNFBYe1eXQR5tLcka7vTYLX8TB8YygoTiKgafqVcJr3FeINwIjXnkawTCeccbhZmjYDB54mSI5+xNQ8uAiNkZueXPN+5JuCD7iBVz4FWKLtdCAu9mzgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885227; c=relaxed/simple;
	bh=31dmEYbClSFQ+777iEycvnrwhs4MHxlaRIx4vP74XmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUr7WZAhSpLzMF3KE6yexoHhbi6N4K6tzQeMyC43bNhW2MtH/h1bstsRYF9Zd45sdOBP1paRaC1kUp2ZGdy/ufQQ98e9rDHKrld0JUxrJtSc6m2Rw8Z1S7PpZM41P9nl9Td8hkJyC2SHGq2z3dq974Tf9JS9sA4lXNHCGDu347k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFpn2Kmb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so2308048a91.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741885225; x=1742490025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Tusq3pDNFXo3UBk2NCC4K0gAQ8d6jHbFL+kELh3G6w=;
        b=xFpn2KmbE4ixFx+8g3XTFLeaywT+oDKejLkemtFiMNh//2iHk3l7iUEIcm2gwSj3Ra
         RFagGlL0ou180vQYvUW2ubmOxCQUnbt3NXBpFt21100TTsjaMNHyuwUcKuCGVbjnibSN
         vOFaqnogc0/UOQtTZBSmNKXsVRK89pL74kMJ7RHoeZXyPv7AJ7csqTMlwEFc83WFOHoi
         rdUhzmuW+EhjJgpUOIU8zPpyzvBk96Hn+HgtBRN/Af4chadJQF3XyIgre1WIqe2MMR0x
         MtrBPLLXr575c8T8M4RQo/eX/L0cT3f/uO2uZ7N8irD+Qe2tkNX+V37MFAx6sIelQ3Tj
         eiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885225; x=1742490025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Tusq3pDNFXo3UBk2NCC4K0gAQ8d6jHbFL+kELh3G6w=;
        b=mwK7S7frQGrZC5m/QOjz0aCe7jOa0qxOX6uCpbvmeoLcHoMv1d3Ec9rgxUjeJEkl2S
         7RVZMXc8iYEho/U/V0QzhjbEiMKssceAqTOvx4Q+J0fqC1cdNOtNVVtSQRfvf+JUjpQG
         0spplLgMMIr+mANvHlT8Hx9qU84h0nkBor1ws9sI/Xn8fqymFyuxMmjN5CHxL9wplQYX
         s3dSihY1JLWG0xZCysyh7Hsua9LEmVvM7OFHaU1idj/UbvM8YLlCw9kFRha1NPDvGq+o
         cDDmZYB2uKDJ5nfmLcM50n7BTPLNseW3C1gbr3xkjCBi6PAaEp165bpzPLyLO0O0hIIN
         4B6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvGo+z5WpLSJ3X+p97dR6LDq6LqvmVE2sina1pRSZ1oecOa2q5FGqK6APfdYOW5wXjDC6sRzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0trhph88e/ykj6LWhPSiPJ1ohHRg1yr4eNMw6u+fI4/CcCqnX
	+zIr2td3kW8klmCo2colxCkj8mDESkYs3AozlGLjZeyWRU3fCYxeFLOTFdQ3OQ==
X-Gm-Gg: ASbGncsh+U7YZddqSpULkWhxKCX4MoZQFjQ196vEA7KOlGzsDXveCDzXW8UiJiNbDFO
	0nYd2sFSXHFxHiJum3RnHghdI3pVieh4l9bg1hfAufRhKpPsrMVJEMl0NUC5mU9qgSWbgfKWLP5
	p3uu4pyhQezYOTZZ/6xeAJYSsBoDvIemzhlNzhL6ViAX6OdmBtn5ALDFZoV5Xo9DvS/rLMT4not
	zmeGAa3sptorQfYfLTGdfz3Py2/NdKJ0y1+eT0YNdUTzuPFj+mze0iYVaMge6OB8t2JRoijjbzA
	Um7KUh2ONtxu0x7GvXnxlbZNDW2PcUTZ9DY7+Bk2Nz28Ws0Gxgc3VQ==
X-Google-Smtp-Source: AGHT+IHrhxG8cBBN1mLcB50PY8xDofHLIoxLCvQgTyzYBBZ9ISoM3YC4LO95ACXRFgZFksUOSpVtyg==
X-Received: by 2002:a05:6a21:68c:b0:1f5:80a3:b006 with SMTP id adf61e73a8af0-1f58cb44e1dmr20356279637.21.1741885225140;
        Thu, 13 Mar 2025 10:00:25 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9dd388sm1504361a12.20.2025.03.13.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:00:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:30:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 4/6] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250313170016.oeq2pfbfyal3hq74@thinkpad>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
 <20250225110252.28866-5-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225110252.28866-5-hayashi.kunihiko@socionext.com>

On Tue, Feb 25, 2025 at 08:02:50PM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, "irq_type" as global and test->irq_type.
> 
> The global is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> The type set in this function isn't reflected in the global "irq_type",
> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> 
> As a result, the wrong type is displayed in old "pcitest" as follows:
> 
>     # pcitest -i 0
>     SET IRQ TYPE TO LEGACY:         OKAY
>     # pcitest -I
>     GET IRQ TYPE:           MSI
> 
> And new "pcitest" in kselftest results in an error as follows:
> 
>     #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
>     # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
>     # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type
> 
> Fix this issue by propagating the current type to the global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index acf3d8dab131..896392c428de 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -833,6 +833,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  		return ret;
>  	}
>  
> +	irq_type = test->irq_type;
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

