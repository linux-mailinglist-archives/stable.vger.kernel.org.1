Return-Path: <stable+bounces-156150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176BAE4BF1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95964189E3EA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629142BD03C;
	Mon, 23 Jun 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJfiveFu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F92BCF6F;
	Mon, 23 Jun 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699847; cv=none; b=pezFE9ZOIo8TCrnYKk72No2Oc+ADtWAcON51DO9YlvUMuKN8P0WjFgxl/acEI+lwSEjwCyHT+EOctY02Z1Q+Faih7PlXnbl+2IhHCNbNdH+UTbqDEKost9A8wrb5HQ8QwtLZx+ubOX6o8YqCwJTotWvv5d1s5Sb97Q30MVdp82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699847; c=relaxed/simple;
	bh=2BesTu0wNz7KZJSu07Q9JK+U9yK47g4valN5QlTVKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRK8T3xwXmGZui9wS5FEAcY7CjvhL8dNNBQd57odtcdh7mlDZyYqCtI6+QJowvso1nByTCoADZXDeUBIy2hx649m89pejq6ytIKarPjVkkJEbFiVHhOt9T6A7plqXsIk4NFgk3OfsPg2VmfH5RP7HvGCRzjMm/vahFyWqWU7mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJfiveFu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2505218f8f.2;
        Mon, 23 Jun 2025 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750699842; x=1751304642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXQZ1cIwev/BQqGGXRhlocv0p9SFoF8/dusQc6F0a2A=;
        b=cJfiveFuwVL/iQQ5n+mt8z5Gguh3YT5L5K1mxIQy386Qy/Va0ysYdEmUnQANYnn7HE
         eMfcXWxc+IGp7U5PN55ZsMDAoNoxEkBib2BZ8YIoG96RMK3W/z4SZdJM4LlST61dR5hc
         oR0q+aLCNYrwPnWaniCHkeucwmG7eOOM7kG8GduqhD0Ebf5cUhdrBiqw/7roxflfvX4s
         L4bqzCjYV8npjy8OMCBQP9JsV/kx41BlXxAqeaxCzuKwlk391gnSs5cMFO1o0kPQWhNR
         ilo0GBxc0lEBS+z4/b6GUpGba0jhHF+Ej7o3mL9rcRxblwsaJUEyZLrpyCvItaKCGf+v
         TC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699842; x=1751304642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXQZ1cIwev/BQqGGXRhlocv0p9SFoF8/dusQc6F0a2A=;
        b=gEo467hkhUTxovUeEIsoXCr4i83ADsKfD4eSmiQyfqJ3MWl81ijO2Y8X0Fiut0Ryy4
         ZC0vi/1We1qncfV8ebFK7WiAY8WZyWJscGZhazfEj0nWY6524WkG3XLxypy1fNRfe/H6
         JmyBU218yAGmSI9sNcHsfvkXEJw0PfsL2fP6xU0BgDS008dQRepDPPlw4/GjORSIA5lv
         nreribtYN4/40VIbWBwWwjEzh2rSNNrfRsUfhxNbRG2/DP6R293CxYvTGaIwawsgJ9cz
         3OtgVc0F4SZEj8nND5sFX3pcAfgg+HLKOi9bdutrud4Nx0r2YgKe4V0kLPWeaZQYt22E
         gGwA==
X-Forwarded-Encrypted: i=1; AJvYcCUNBxji2wO9hr4/CdHd7dTbZcGf8v7vr0W0T17vshGoFZHCqJHI6hKooOnsO+Pj+6RGgyt+wNGXhUk=@vger.kernel.org, AJvYcCUjqOsGXLTQFjuHEs//I8HDo8u8l0+Cgo6S0Kbl8kUd2A9dvWvQGOTZpuJbsD0ymVCJ+/9bmYZY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vG1AhXWr2hMY544gOQBXSTZRtaALtZblRhHBf7gH3jJF//n/
	MfCYEglay+OwTjk/ST6sfFP3a7e16k++zQn1/I4zqN/ydX4Qw1z4jX59
X-Gm-Gg: ASbGncvSO1Tt6Vy5RJD+nEL7H8XPo8WsffhvlyffcTrO0Dev7Y3OSwbOiWmdl0n4TE9
	hJbkEEPhEcEFzH5TMz0z+zqn/4fyC5y/oOr7bWq1N/+wmmoV6kmSulDvmNzRuxVg9RZ1qfpTZi8
	ThuWNP6UQhE9D+kqouwxXL3aBzHIbYyapxQWtAVn/4C2HxtMReiYZnWOWWjOBLNzNy/3YkSgxAX
	M56RQ9EBx06XuTErr/cIxz2Hed8onWOxa07kCoWbaC4rvoFPIUXCEwNLqwbZcAHoSJH751sDspM
	pNY+DPPDTxJXaylK0O6S01lUEWjurnTCcJAQpWLlBMHsgY++GPm9odVeuC5xHwKpoCXUd8uBpdc
	k0Q0nozSgWgv1DnHRj159Lqr/EmNfiQ==
X-Google-Smtp-Source: AGHT+IEs1XjUK+7RdkSK9C+mWF0kQF29FZVxtmG0QAQoTQntyWVyT19lNoq/l9WZJeQpLq/vI6uOZg==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3a6d1301ffemr10136431f8f.20.1750699842006;
        Mon, 23 Jun 2025 10:30:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1188c6esm9692456f8f.81.2025.06.23.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:30:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 20CA4BE2DE0; Mon, 23 Jun 2025 19:30:40 +0200 (CEST)
Date: Mon, 23 Jun 2025 19:30:40 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Jeremy Lincicome <w0jrl1@gmail.com>
Cc: regressions@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org, 1108065@bugs.debian.org,
	stable@vger.kernel.org, net147@gmail.com
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
Message-ID: <aFmPQL3mzTag5OxY@eldamar.lan>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan>
 <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>

On Mon, Jun 23, 2025 at 05:13:38PM +0800, Shawn Lin wrote:
> + Jonathan Liu
> 
> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
> > On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
> > > Hi
> > > 
> > > In Debian we got a regression report booting on a Lenovo IdeaPad 1
> > > 15ADA7 dropping finally into the initramfs shell after updating from
> > > 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
> > > shell:
> > > 
> > > mmc1: mmc_select_hs400 failed, error -110
> > > mmc1: error -110 whilst initialising MMC card
> > > 
> > > The original report is at https://bugs.debian.org/1107979 and the
> > > reporter tested as well kernel up to 6.15.3 which still fails to boot.
> > > 
> > > Another similar report landed with after the same version update as
> > > https://bugs.debian.org/1107979 .
> > > 
> > > I only see three commits touching drivers/mmc between
> > > 6.12.30..6.12.32:
> > > 
> > > 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
> > > 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
> > > 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
> > > 
> > > I have found a potential similar issue reported in ArchLinux at
> > > https://bbs.archlinux.org/viewtopic.php?id=306024
> > > 
> > > I have asked if we can get more information out of the boot, but maybe
> > > this regression report already rings  bell for you?
> 
> Jonathan reported a similar failure regarding to hs400 on RK3399
> platform.
> https://lkml.org/lkml/2025/6/19/145
> 
> Maybe you could try to revert :
> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing
> parameters")

Thanks.

Jeremy, could you test the (unofficial!) packages at
https://people.debian.org/~carnil/tmp/linux/1108065/ which consist of
6.12.33-1 with the revert patch applied on top?

I have put a sha256sum file and signed it with my key in the Debian
keyring for verification.

Regards,
Salvatore

