Return-Path: <stable+bounces-110969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C332A20BE1
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E521627A6
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290181A4F1B;
	Tue, 28 Jan 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIvS/djk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A03FBB3
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074026; cv=none; b=chRnLwoSnNw6NghImaLSq9woVUp2V/aUNQaWT2u6K7ltMeuyJJbd8zfaA6UaGLgb1F1qQCFz9X8CkwTAq9OqJQvdShXbgE7SjI8vekfO4CayQou4Ur9Y1akkjKYprAwniG+ghi5+BTNAuhZPv/HWzWm6qCe+m/rd+MnUoXqzbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074026; c=relaxed/simple;
	bh=0MZs5idq0szx9AV9ILdGQMpK/KTQRHnhZ74NQ8sF/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u25OcB1n4h8lYEiCOTcS1lFWMWy28qBSZmTmOQ1r6VTsKzj6NSwftxekcZAuIifX2WS6Ht4XD1nGYbMrERfTJmqT99mVzTLrK+h3+YAJMdJWEnrctAYhpKJK8cL/VgJK16dic7FFsKZtvMmyxSVcPqirBde/KHa87oWBS+YqgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIvS/djk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166360285dso96744545ad.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738074024; x=1738678824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3KCYjdWMMGDvOb9PKKoJ+9LqVtNjKtc1PkbXjIXAiM=;
        b=LIvS/djkUx6eBmJdqoahH+zD5vULNKX/uz3fUinRpjYSLgBOItTxF6wea5wWsznNXE
         hYg6/YYV/g87nfuUWbIrI2rot86NLm8Iyvl8c3fXoPK2gbt7By/qMWfF4cI1TRU9drbs
         A52YQAIseq6bwySxXg1l4m4iCuMLP0Fs8JXHw34jlrIKg5050dZWzG/0MrVVVSQ6M4z0
         dGitJ377U/ZCz3RvjJuXhgMK+OKAHgNTnQlE5PmWc17/otWtMwNBqIMmDOewF3mtYj4E
         Py84gy/DghnfnO1vVRDXrydWsPnb6Hdamg/ptj9q/vJfK8yNZ/hGWmNHdYiNIqb1FERt
         9XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074024; x=1738678824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3KCYjdWMMGDvOb9PKKoJ+9LqVtNjKtc1PkbXjIXAiM=;
        b=ucilbkiU5Fr3iUNOltF4zJuRTOV4IjTNp2ngcw072Vc415UWPchUBdjt4kMYrJ6Cgu
         EstRA43bX+/Rq+g4Ut6OJIv8DJBJNcqkZ/INp3PWL0UmAuSo4w3rwOpr2IN6NPp6vxbp
         FtZdDs8x+l5rYNpSfcrfLIKQCWL6CWZjQp/lb4aVQg5kYuJvWSrmgNrRUQJwb3F9Mspl
         Vw38e1cv+z8EKLgqsdg9+gDGoJQuCw4G+stc5baticQ08TObKKh/iSpy/GrBY2UWXEy4
         U7fOFVecWsqkYZBIwaLLMlvWEPoazeMehDEI+9la+0dQYzCT26qGbehnXjPOTNis/37P
         awvw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z9SnSfzNhkpDYy76X41CKeCuHgjtTXSRLg9fZG8KmiJtz2teIBvPrtjrTn0+4IbWxSAIAlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywex1OZJK/9CpJAmvqcANs/LTz247E++NE+RIwPlBbuZqsztxBu
	1CHVUhgMGfA588PiLLhGwZuKGlRiRYgqOWN4gw1XE+Zq3Vo0HvD1Qrfn74/Z3Q==
X-Gm-Gg: ASbGncvdXIyBPScg7twY+3dbcy2NUDKLR1whKCxlT5mJBOtTnIRC+MeWpaSPeknFLAK
	VmNpHAPqHd7ZdwrbN/ArlFHRQ//I9+qSEFKyaJ/n/MSux5a2+UXOjnZ0sUHvFi3UHsMzjdfZZeM
	ImLqlNNXtHp8rvtKOw7Vp/frXY1ySWhOs88pP9pmBe0IyEAvBEc1wDu86AeWPEJphyhScwigayq
	4eDTEJHknbofQtq6N4gXREjN8cYLakZe2Khx/YV0VSF5R5BjycE1u70NJ318mp2ifhMoIhyWcI+
	M4zT1favcRCXNHcFHuEuUhIzITg=
X-Google-Smtp-Source: AGHT+IE1wVU9w8+Wk88CIRXF+UdLrqy0+JwQsDxv9zxbMcNk1CdQIbSdxAv48cv6r/JMBAYdgV50sA==
X-Received: by 2002:a05:6a21:32a2:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1eb214650bfmr72004607637.8.1738074024634;
        Tue, 28 Jan 2025 06:20:24 -0800 (PST)
Received: from thinkpad ([120.60.131.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48e84e411sm8298835a12.2.2025.01.28.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:20:24 -0800 (PST)
Date: Tue, 28 Jan 2025 19:50:17 +0530
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
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Fix disyplaying irq_type
 after request_irq error
Message-ID: <20250128142017.hoq77lo3aybbbgqr@thinkpad>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-3-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122022446.2898248-3-hayashi.kunihiko@socionext.com>

On Wed, Jan 22, 2025 at 11:24:45AM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, global "irq_type" and test->irq_type.
> 
> The former is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> In pci_endpoint_test_request_irq(), since this global variable is
> referenced when an error occurs, the unintended error message is
> displayed.
> 
> For example, the following message shows "MSI 3" even if the current
> irq type becomes "MSI-X".
> 
>     # pcitest -i 2
>     pci-endpoint-test 0000:01:00.0: Failed to request IRQ 30 for MSI 3
>     SET IRQ TYPE TO MSI-X:          NOT OKAY
> 
> Fix this issue by using test->irq_type instead of global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 302955c20979..a342587fc78a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -235,7 +235,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return true;
>  
>  fail:
> -	switch (irq_type) {
> +	switch (test->irq_type) {
>  	case IRQ_TYPE_INTX:
>  		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
>  			pci_irq_vector(pdev, i));
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

