Return-Path: <stable+bounces-110968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF304A20BCA
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ACF1888F0E
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B41A9B34;
	Tue, 28 Jan 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/XkcIn0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214E19DF61
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738073569; cv=none; b=YWXr2/smIBZ459Q7xo2guFDlPZSPDyIQCsteyYCW0Zlnk4r87lVC2xcAxpAXLArr0PoIxX1FQavp2UZzrU+eWZ2MdpF2B4crin82HP956ydJZnJ4a4SMvIjnTpfEdiCwiQmcvdUA3m7EdicxGptorWQMU0Wrd7RwT1Aq9R1hJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738073569; c=relaxed/simple;
	bh=yn26uxdUejJFoJ0PZH7zJ3oCuCmVZlc9RaH/CiDlxq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVeSUmboEhEFlUhPbv/+cju0Vvvg9MUgIZ5mL7+MH46ax1WBWi75oWRtFIY5xUEas08NMe3G+Kq6PFh3YfRic1g6AdYb05QpV3Rskd3DaAP/z1otGz3VyWzITFj3jKrnzwGcVBJ6fqO05Xj22FFVUS7qPh/A8muL2etx+XPljYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/XkcIn0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so132059275ad.3
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738073567; x=1738678367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXDfra07WHKzdDWwIeK5+DGSQEf0MtRujOHeerUffjY=;
        b=o/XkcIn0YEraR43tdorLNNoOJcKU4FM0Upgar+1aCmjdlPW2yEZG1/25dZxV8oQmoJ
         4Nf8n1ZfQnM5kzea1JRIqf1bFvjUug8qQjHT7zx/wPxK5hwj2akKemYTWSyayX6lVROf
         5pfWOkF+6/o5Qy1DYtMaVCLMJe32w3e2uN7mycZR1JBlbkVxoXYZpqM1mhzm20Rea0Z1
         sDtJBZ9KEVgCPiKE3C+Ifc6/KoYrTGpph2dYi8m86d3r4VlSivATT7Rv8KZyNjkJdJbO
         Mgc/LWAHt7Ena+ULis9rYGKjLdoO0VXMb074BUqo3dBVIPBZTx8NAoaLgodV9fFLbtBQ
         Bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738073567; x=1738678367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXDfra07WHKzdDWwIeK5+DGSQEf0MtRujOHeerUffjY=;
        b=nymDyYEieqttoVVhg9l346T33UW6ZCeDCt4BkUqJMq0GSiv3p1NxZyDGeKnPwl3qkG
         8RrC8QixAGjKeGmKT/D7joOD5pN7SuEFLNrM2wrm6roNSq48TGOqetzZ0DhGIHNxVN9D
         ZVYVYX8equpBvpiJK3v4IcaQ5ERMw1Bvk8AFws5GfipNrKyp6MENA+M7CaT6MlLPfUyR
         J6i7juRf4Qz1Le1zBnzVXBia0ifb5yPf+XZyOsWYmqp9tNlSwns7mHEJ2nng6zQbjx4z
         9jneGxtVE1161jXan4KeCI4VO9qree2pkRGgZ8C2W7r/Ry9lmLpqaRg7Uec8uNFMHrJv
         JHdA==
X-Forwarded-Encrypted: i=1; AJvYcCViTjf11j9zE23iVnuIx1CF/ZaHPVMr3J+BgqHwPU/1acvrQnOdXHWZPpeEYC/2YnlK1D/HxqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNqmeRVssTE17+k/slP3UrRh6fXHYaAziZErdd0K0wloUOLhm
	brcpacq9i+aUtoL9L1XozhZ9d9hyepSn4TY2q+UzhSny6I3Edur2qG1O+xalkg==
X-Gm-Gg: ASbGncvIYhZdDNx75KWo0R3/4h2Kbw6oZbNVVfzw6Ho0cX2ul9d9J79Mnv5/mDmdYN0
	kqh/FXx6lDRPEbfHQo7EVfYVoWzZojs09Otp2JgndUQpAtCCR+1LnmfrVbvdnmp7BAQYANIgNg6
	EgYdUVOu4Iv+eHjD/wD4w/UfpfLfZx0Dkr21ZTWvLk37hthK+0d6mR33BlS/YbWVDU+0qc6kT0n
	9FoWWaG4daY1WOpN/q//bA+fiBMixseDzJNhOi+HmNGLYNSWU385czacHgeyuRNiXdTXrms0RCq
	QiJwjy31rFa4SlEvokVRfR3BaR4=
X-Google-Smtp-Source: AGHT+IFugNHTESDdvy1aJKYszFZHQc3MsPWo016YwDGUhS0yiprn9wYgeiw7fydV3lTNoZrAswQLCA==
X-Received: by 2002:a05:6a21:3285:b0:1e1:f281:8cec with SMTP id adf61e73a8af0-1eb21498383mr67710934637.10.1738073567270;
        Tue, 28 Jan 2025 06:12:47 -0800 (PST)
Received: from thinkpad ([120.60.131.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fdd5sm9498571b3a.10.2025.01.28.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:12:46 -0800 (PST)
Date: Tue, 28 Jan 2025 19:42:42 +0530
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
Subject: Re: [PATCH v2 1/3] misc: pci_endpoint_test: Avoid issue of
 interrupts remaining after request_irq error
Message-ID: <20250128141242.pog2tuorvqmobain@thinkpad>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122022446.2898248-2-hayashi.kunihiko@socionext.com>

On Wed, Jan 22, 2025 at 11:24:44AM +0900, Kunihiko Hayashi wrote:
> After devm_request_irq() fails with error,
> pci_endpoint_test_free_irq_vectors() is called to free allocated vectors
> with pci_free_irq_vectors().
> 

You should mention the function name which you are referring to. Here it is,
pci_endpoint_test_request_irq().

> However some requested IRQs are still allocated, so there are still

This is confusing. Are you saying that the previously requested IRQs are not
freed when an error happens during the for loop in
pci_endpoint_test_request_irq()?

> /proc/irq/* entries remaining and we encounters WARN() with the following
> message:
> 
>     remove_proc_entry: removing non-empty directory 'irq/30', leaking at
>     least 'pci-endpoint-test.0'
>     WARNING: CPU: 0 PID: 80 at fs/proc/generic.c:717 remove_proc_entry
>     +0x190/0x19c

When did you encounter this WARN?

> 
> To solve this issue, set the number of remaining IRQs and release the IRQs
> in advance by calling pci_endpoint_test_release_irq().
> 

First of all, using devm_request_irq() is wrong here as
pci_endpoint_test_request_irq() might be called multiple times by the userspace.
So we cannot use managed version of request_irq(). It is infact pointless since
pci_endpoint_test_clear_irq() would free them anyway. Instead we should just use
request_irq() and call pci_endpoint_test_clear_irq() in the error path as like
this patch does.

But this should be a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

