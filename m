Return-Path: <stable+bounces-118384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2FA3D276
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872157A2F3D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAB1E9919;
	Thu, 20 Feb 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWOcM0t1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AE1E98FF
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037290; cv=none; b=EIXgLc6WnjRR8XvJl/l9/KhfRyHTL3nVTpNqiXqshEcUR7EzBAqhhZtrlAIgRopWPoMlQ1W2YGkAW/iBzlsmnQ0JgfB6G25KdGFzE2+X7Q254oY0Pt+/+R3UC4A9DThPuIiV+QJ/lg9H9Dt1S3YNI2Paa7r6L2RF3uTuFeM7TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037290; c=relaxed/simple;
	bh=FcvfMD+JBBVNDDsu7+aYWKzpf97y9eyX6wNGdgF4LxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0aOwLwmMLvhNQAXw5vNGdcbGJtQAVUon9cxbt1bBfZThVaHCWK5htLG4zSW4o2uoqnsKKym+MGEdQU2tlKINjW5Y67PzcO/kep8DT1HMsHpLG70quTfUoMIkgUwdK+MS4KIv1p3WZpH6TavaPfLn5+G79wzWwDKvdarRKwFej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWOcM0t1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f2339dcfdso10987495ad.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740037288; x=1740642088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azToiCO+oZ/zxxr4mX51zUb1S/Hn5fc+tCyD7exrK9Y=;
        b=dWOcM0t17tV11JLGEzr2KGJ3nNSjbcS/eN2UFGZ+d4Rv/hT+x1PYgB8I8JhJRPWEPM
         2V0Cb9wxKJsY543PLSveE+4P05DuKp9GbFujxdExDtpXOZuSMktWiSSHRF9LUZZQWGra
         hBKgf1KUYJ3nVoi1OiHvJLaZEMTx+Jeemf1f6MxFYYHXoHUj8GxmDWmKsYUHS7CvObI1
         yEQmkCb2LN9qV1mItygMygEJ88p1Ds85aRukSwy/m3eWkmh3qBIDo6ISQpjK0H4j2Vkv
         F1iBJLx6FrVebWHudPlozimDh1xqzbi7NQ3uGjqGjgT0R0YSe0U93D+0zEysHuU0wtdX
         sgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037288; x=1740642088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azToiCO+oZ/zxxr4mX51zUb1S/Hn5fc+tCyD7exrK9Y=;
        b=Vb3nqnPcfY54OtDolUAXpTbWoF9xRYhIymCCC56FsYa9CoeivqvleWGLqZmL5qoV0K
         9Ju6qVRntnvxE8o57qxNEphIpeE5AhNOa5sBrX+YBmKNjVSpSijpn/GS1DNo4alWY3rr
         NjG50XIfkz3Hkt6FrSi9rgl+UM5OlcwUejZ9e67dgmA8jxp/HOwz903GFWxkgKVFhpZ6
         SQMFkOxsJoYQMDo4pLE0pmB1pM1x1jXS5WEUHwdHEcgnsevk8FJE7u2ucdeTZvKavVNa
         bJxdfZsC5JfE5llZ4QaBk7WTJOc4mkQkzp/4b7OGqEnT0V49TvsMKAIQWBHLOiLwyg7y
         wh1g==
X-Forwarded-Encrypted: i=1; AJvYcCXa4Vb81DQblhF4iq2uU0bKECT5R9A/XrXru7jJAEooM6WqsUrXTPtwhTZZqDKLIN+WHAEtl2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIUDDDM/j8FTCUuZdrlmt+jgvn+oCKiVxIWuViaM64rx6XD2/
	gtWR063Bq8gKGZmUhtBG0p26kTOfs3lyxQUxmdUKiyxCJXMFSyE6jWD3WZeaeQ==
X-Gm-Gg: ASbGncud303XCGLAa5Ip1YBOXYLQK+m24DtJpkCGXhVGRX69QK6pNWIGeqUjyb4PiA+
	WK+RLxaQrRgJZG1z1gksWfPsVV55v79n9e98m5kYSf8KnjSVc7mKNfroBEOFtLbj2AV3pgaWdQn
	KNwY8TunDL7HwCXFTgldjC6nQfCx6B7Bk4RQKQSqq+Ek3OPryvvf2LvaeNNig0uXy9UMlIj7/qG
	OUbi/xS2a8Uq9sGTJecnfcx9Rj+sQIYjLTCLARAeERjZ1wfenVEHI5cErfNWE4cD5fdIO1y/YqA
	Cc7ADNF170TNA+KSYdIj6l0msw==
X-Google-Smtp-Source: AGHT+IH0RZscPfw2CZq9/P1TKqceXF2BijFi/n0CVEH6aHnPTW2U7yD19fJ4fdTDIp7uABus7lNjyg==
X-Received: by 2002:a17:902:ea05:b0:215:9eac:1857 with SMTP id d9443c01a7336-2218c3d080amr32992605ad.5.1740037287863;
        Wed, 19 Feb 2025 23:41:27 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf76sm115597885ad.131.2025.02.19.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:41:27 -0800 (PST)
Date: Thu, 20 Feb 2025 13:11:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250220074122.xaeefquqwh2xwsxz@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
 <20250214172533.szrbreiv45c3g5lo@thinkpad>
 <36cc27be-4ba7-4d65-b32b-2a1e0b03b161@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cc27be-4ba7-4d65-b32b-2a1e0b03b161@socionext.com>

On Mon, Feb 17, 2025 at 08:26:44PM +0900, Kunihiko Hayashi wrote:
> Hi Manivannan,
> 
> On 2025/02/15 2:25, Manivannan Sadhasivam wrote:
> > On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
> > > There are two variables that indicate the interrupt type to be used
> > > in the next test execution, "irq_type" as global and test->irq_type.
> > > 
> > > The global is referenced from pci_endpoint_test_get_irq() to preserve
> > > the current type for ioctl(PCITEST_GET_IRQTYPE).
> > > 
> > > The type set in this function isn't reflected in the global "irq_type",
> > > so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> > > As a result, the wrong type will be displayed in "pcitest" as follows:
> > > 
> > >      # pcitest -i 0
> > >      SET IRQ TYPE TO LEGACY:         OKAY
> > >      # pcitest -I
> > >      GET IRQ TYPE:           MSI
> > > 
> > 
> > Could you please post the failure with kselftest that got merged into
> > v6.14-rc1?
> 
> The kselftest doesn't call GET_IRQTYPE, so current kselftest doesn't fail.
> 
> If necessary, I can add GET_IRQTYPE test after SET_IRQTYPE of each
> interrupt test prior to this patch.
> 
>         pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
>         ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
> 
> +       pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
> +       ASSERT_EQ(0, ret) TH_LOG("Can't get Legacy IRQ type");
> 

Sure.

> However, pci_ep_ioctl() returns zero if OK, the return value should be
> changed to the actual return value.
> 
>  #define pci_ep_ioctl(cmd, arg)                 \
>  ({                                             \
>         ret = ioctl(self->fd, cmd, arg);        \
> -       ret = ret < 0 ? -errno : 0;             \
> +       ret = ret < 0 ? -errno : ret;           \
>  })
> 

Ok.

> Before applying the patch, this test fails.
> 
> #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
> # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
> # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type
> # LEGACY_IRQ_TEST: Test terminated by assertion
> #          FAIL  pci_ep_basic.LEGACY_IRQ_TEST
> 

Looks good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

