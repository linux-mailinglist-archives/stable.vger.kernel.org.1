Return-Path: <stable+bounces-119685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F7A462A1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781501896F15
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE8221736;
	Wed, 26 Feb 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wn0+bHMy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316F22154E
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579894; cv=none; b=CXhcg7I1mN2dFtFwOjUGFF35e+DRvjAGUsZCLPBXVq/7kbns/GpRLh63xP/zjCAOX2rt430nafWM+iNx1xUPRNJZSFaFdLsoOjrkeTe+kWmWzbm8UI6n2p41IxWPWwXGM1HpQP97bmPfewcY88sjKPAycj16ZKPLt62ykv8/+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579894; c=relaxed/simple;
	bh=j5EgVv6d+kyiKhWyckDkYkwqFgiVsmt9E6yGrK9raLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYeFWCnHPMM6AwK98ITQeoAjegDMfXbGa2hCal59Vyn6PLRWxCng0wVpjjO6TITcbhRHxUeoWlt/VVq+A9/teGkbmKDHZ1gyeWKpdTYKBozqnPKJB2V6HADy57cizzhKRtjFDvGlHtC/bkN9tWSS0wOlfXa05fcXUGyH5k3kS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wn0+bHMy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso1645743a12.0
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740579889; x=1741184689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaKzYJ1iRW+gT1IZX66/MBk7evQghVEHdi8TUh6olgc=;
        b=wn0+bHMy3ra6Dk9RtKWvrsP7lII4rG/KOiK6T66XlsdGHZOTY3vYwT/0LhB1F4gc6o
         zyaz6h2VrXi0SrvSFLBIBcsam1AObaP2pPNqGCMsxrgVJW3mTrqzIXcYkY6MoAEz+GIo
         Ol5AayWAQ1YTS4wxVdLwIG06gJ8g+e6dHhvWmCcDNfl/8TB0Xfc+/DQJ981m2wrryZxX
         42GtnI4C5Q0poB++czsb8p/dcrhgavfHRc1pFJtfl/DqLLcm6FuE9eDmMPE6D/hQE385
         PbsfIcm2ev9frgkqU0me93x/R+6JftNGlG4iOrrWhlTJYvjPeoPfCQtNkoNhr7m4sBcS
         NB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579889; x=1741184689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaKzYJ1iRW+gT1IZX66/MBk7evQghVEHdi8TUh6olgc=;
        b=UpjydVosGRA/sr1V0xxhbfKV7JrQCDkXq8BXDHDo729sdB99ZpfAUq1AH3SFFa7i9A
         IWMA8357JmgkKzNKP69hw6c6FvOp55iY6epe9IwOYcSxyBb7dFJtm+xHNHzQy+okFLFY
         kMuhZ02JYyCvRkz2+WvQiAY+vlNSlZrpyiWl/9Wc4hcwxIIMXGPf59zdwkjuUAuXme61
         FxTwxuNqdQZXHOgsVIBqt6of5p+wZfM57o6S7F8cA4lH6Dr98kTOdWhhpRjnM9/WhDZB
         c+UZyN/1BtHtZpmS3A1p37X6tPYEyiJ/2c9snNypPv99W2UFN91DyyHQpPAmUt2927tb
         vsdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNktnTL1T2sfmBbLFCnJl/uIGJUpNMiG4qgG3+Cs3V6nPtcJWW85eOktdzqFputGOvdQEGZb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3KYV6zl+d6KP6oBK+TfkcsdmvMoLYaqI9W2qu8Qs9cRAI48C
	aDid3UUVy7VbOMppywEyHeZNrVYpUCntUU/fUmjbJJbs7wuOZgsrPiNvNl0lACA=
X-Gm-Gg: ASbGncvQm97N7EL8mny+T5YO7EVEJLXCYWhpd0Zu0vhJ+FqdHqoWjA+97JDXKRlfum5
	/eJ2RnYInggcXC+FHsD45RI++JQan0I0nOQTsd+ippNgXRRO6+3DWhnxOgQGIa/TOqtEH80egQF
	106UG2+4OVsZOWwDlyJHxI5dVxCLJel4fzpwema807Kzu36QiEz2zxWJl5mRA9FXK2hPbvCbAiI
	lyARTesxi4kVPZNyTJe8yHIFVqRJg1L28BHn7dJL1EQyVSFwUunmvw33My3PoyYdl/JMitUhHqi
	X2Zh76SFPQJH5SQgnjJHwid+kqM0H/V2qo7VavnvGvc2UqpKGzDWeg==
X-Google-Smtp-Source: AGHT+IGJIqgQNaPZX0a6W5ewvuM4Gn2WI+QaD2er9M4fEBIE83GKmsFVhaLQNCuycoVnCTpaVnktFA==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abc0ae5728bmr2420097366b.10.1740579888970;
        Wed, 26 Feb 2025 06:24:48 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d54e08sm334745166b.41.2025.02.26.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:24:48 -0800 (PST)
Date: Wed, 26 Feb 2025 15:24:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: arkadiusz.kubalewski@intel.com, davem@davemloft.net, 
	jan.glaza@intel.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com, stable@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2] dpll: Add an assertion to check freq_supported_num
Message-ID: <74xcws6rns5hrmkf4hsfuittgzsddsc3hnqj6jbfsfu3o2vvol@gy32jyg75gmd>
References: <txrxpe7tmpsyiu4cwjd2gbs3udogmzdo5ertjwmhbeynu23iep@dcryfdoi7o5x>
 <20250226030930.20574-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226030930.20574-1-jiashengjiangcool@gmail.com>

Wed, Feb 26, 2025 at 04:09:30AM +0100, jiashengjiangcool@gmail.com wrote:
>Since the driver is broken in the case that src->freq_supported is not
>NULL but src->freq_supported_num is 0, add an assertion for it.
>
>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")

It's not a real bug in current kernel. I don't think it's worth "fixes"
line and -net tree. I think it should be just sent to -net-next.


>Cc: <stable@vger.kernel.org> # v6.8+
>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>---
>Changelog:
>
>v1 -> v2:
>
>1. Replace the check with an assertion.
>---
> drivers/dpll/dpll_core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 32019dc33cca..3296776c1ebb 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -443,8 +443,9 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
> static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
> 			     struct dpll_pin_properties *dst)
> {
>+	BUG_ON(src->freq_supported && !src->freq_supported_num);

Warnon-return please.


> 	memcpy(dst, src, sizeof(*dst));
>-	if (src->freq_supported && src->freq_supported_num) {
>+	if (src->freq_supported) {
> 		size_t freq_size = src->freq_supported_num *
> 				   sizeof(*src->freq_supported);
> 		dst->freq_supported = kmemdup(src->freq_supported,
>-- 
>2.25.1
>

