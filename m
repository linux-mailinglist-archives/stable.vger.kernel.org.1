Return-Path: <stable+bounces-100162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C99E9399
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56671284638
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BEE228C95;
	Mon,  9 Dec 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKWQXUL8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B82236F0
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746330; cv=none; b=GAV5BQTEpDsVNUxQlTNCp1KSaXINTWHIkKy+N6ixv1c7dsY/Fi3AU8/N95M7seJ2N5Uto9Etulw/xSH/KPuXFvIeKSATpc3L/9N7ROgT3Fto2baRqitQhq/KP+rMKIRcIobp3b8Jzfm338RAnl3xLsCiJW9XtJ7I4nE/8Po5/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746330; c=relaxed/simple;
	bh=l1JoMRpTmnW1uj1Nu8w6fh7CzMO3VVmwQcAihiAAe3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtycS2DUsG+4APZN543JnzvuH5ObZ0vOhb4OlxcDAMhIz30wI/NLqA/5gNhCOQlLlm+B5nzEcirh2TBS/OeZJP+i6GFwcO1PXdouM6QBiOsvVeRemw9qhs07aU4YaSUZhDNSRm+uKVpJ8JmPOjLZ11Mnh3tT8+81EijV2LstKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKWQXUL8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3863494591bso934303f8f.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 04:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733746327; x=1734351127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1JoMRpTmnW1uj1Nu8w6fh7CzMO3VVmwQcAihiAAe3w=;
        b=AKWQXUL8l6IeaQ9aGOWc9W+1AdkwnliyTBhtSLC1txC3rfsai4R2sL0ajvDeS4H3nV
         N6MZqjEixULSNQyfWYrTncJdX6cy8SYNNIUMe6AAR4/iGqQ5C0scb1FTLpGZR7bkXGEZ
         mc0rFSsKEphkL4W37CAUO2Cihupv1mqIVyKywHsjbgRLxzhb4EfODYav3Pk+FT15kUOZ
         lRUT6PzodpwE2XYDtF7rPnlMpT3gJeMQLSOg+tCH5uUgz/kIce4Mmk7v9QqYEAfUzV8H
         5LmOBB3md1D7HZGjPc0LFCtyylEZCJQYCJWmS1RO+9IU70JHZ1mNWuZa4gKD0vcZSTU3
         /I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746327; x=1734351127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1JoMRpTmnW1uj1Nu8w6fh7CzMO3VVmwQcAihiAAe3w=;
        b=J9gL0IYLucyF/fWX0vJgXWnSEBCxbp2TJn1xyixGegbWnfbEdoU5tRkOOtxZOpxnZp
         wc/8jH8xmAssWqoQltzDUNlfVRGaSrwTKinTT/+6QgtWdPbw0rsnoW46VMifZMt9YCFT
         fD3IhLWAKLzCwEi5Rx1dPoqFB6g3KzkVb8SWVrM3OSKaCHNWBsH9FeKwfsnfBS3orjZZ
         cTrcJQcqkPrWgCjcj6MVVNJWSZv61KR1AaCC0XHrert4GU6fBji0KIza9Y61Ie8QCNw3
         c4U1cIHi2ncg88rXNX0I5juIcEMxX9dIRWEIl7lKwIWMvapoJnSuJ/9Ul7gp3M8DFnoh
         OOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWG+brxkbIo+V2OPmHTnj5bKBO+DaYO/PGG2+ViTiPASO372YSdcMZFElEqBwmlwZWPdM954=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRX6HrSgdzPkyC3kKH2BuOyNtKDfAGjnoA3y/23pCGFivBGTQM
	JebfPCdyUl5jgQtbM5tQ/1Sf0hwSwp8fhXSI9dABrGkPh9UZSMjgymhtUeaLSL0=
X-Gm-Gg: ASbGncuZdRfGt9o5Vyv3m3TqZKQX9kN0lQf9A3FXYJmYvyxiSdVZ/NLumeJ4UJWDHo+
	fU7QtYRSMHQ2nKtmIaqMIlYDcgA8I6xY03Rpf2Enc61zBpYdP4HW2Ni1Eq0XKL5uIa7ijCNZFKn
	NGpVqnYQ4EEftY3twxW3KFwrB8PkBWKhsA7Eyu8OxccA+A4mY0NXWTk0Jr4Z4tkKXX+6vWMBvXu
	a+LTLdLEaoH4JT5NubukG4jHpc3IaYt1mf8XQrqWVF+b4ffXgSRxQ==
X-Google-Smtp-Source: AGHT+IGcW13qMINPnpk5pj7Fb9NYdE/Mv4yFx8lfFIzKKhBm3ZQrK/rM9r+Xm2FRGAEnMKXLBDYATg==
X-Received: by 2002:a5d:47cb:0:b0:385:ef97:78c with SMTP id ffacd0b85a97d-386453c660dmr87443f8f.6.1733746326983;
        Mon, 09 Dec 2024 04:12:06 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637b79795sm6316650f8f.10.2024.12.09.04.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:12:06 -0800 (PST)
Message-ID: <127a17f0d7cf74f2fb69e996817dd783e768e0eb.camel@linaro.org>
Subject: Re: [PATCH for stable 5.4 v2] usb: dwc3: gadget: fix writing NYET
 threshold
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 09 Dec 2024 12:12:05 +0000
In-Reply-To: <2024120926-uncolored-lip-b571@gregkh>
References: <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>
	 <2024120926-uncolored-lip-b571@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 13:05 +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 09, 2024 at 11:50:57AM +0000, Andr=C3=A9 Draszik wrote:
> > Before writing a new value to the register, the old value needs to be
> > masked out for the new value to be programmed as intended, because at
> > least in some cases the reset value of that field is 0xf (max value).
> >=20
> > At the moment, the dwc3 core initialises the threshold to the maximum
> > value (0xf), with the option to override it via a DT. No upstream DTs
> > seem to override it, therefore this commit doesn't change behaviour for
> > any upstream platform. Nevertheless, the code should be fixed to have
> > the desired outcome.
> >=20
> > Do so.
> >=20
> > Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
> > Cc: stable@vger.kernel.org=C2=A0# 5.4 (needs adjustment for 5.10+)
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > * has been marked as v2, to be in line with the 5.10+ patch
> > * for stable-5.10+, the if() test is slightly different, so a separate
> > =C2=A0 patch has been sent for it for the patch to apply.
>=20
> What is the git id of this in Linus's tree?

I guess I misunderstood the docs... It's not merged into Linus' tree
yet - the proposed patch is here:

https://lore.kernel.org/all/20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro=
.org/


Cheers,
Andre'


