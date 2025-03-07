Return-Path: <stable+bounces-121345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6DA56210
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 08:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C67B175E50
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D374C1A9B4A;
	Fri,  7 Mar 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G85GjxPh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C41A9B2B
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334046; cv=none; b=ZDuJAyGUJaKg5XYLWqELorGFRrCRMsClxD/ZBzGULkFt3m7m1jb3F2+CXeTlravqwtVWEHexhCKDxzFnB+P5daII5GRRA1bxQbwK6LsykqFDlBCDfjY3HAJwf/dcvs3qhLIQi5FcCT3Zc/vftyYr4gHQ7sbGRWoqbvYIvUqmgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334046; c=relaxed/simple;
	bh=pR/IPm52Dmzz7euqedDIW/qKpLuxfuVEAfUk0HQW4Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNVtYAMqzx/EANTkXxC9OqXK9bFOUsmEOrkiac+Dpmm6ZYyTm5oOwqwmbs2QHeYM73I7CwDzXBA8plXbVrVysK1XUTOUTokd4zs/vThq77Cb+rErBLpXtQlNcXTa4+YkDTvpTvp+v1DRDluN3UaSOePWj5BALtM/fPRBMYgjzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G85GjxPh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39130ee05b0so673973f8f.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 23:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741334043; x=1741938843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jivBZbbpeUpC37vr59Lus7C69ZvI+/qcef+nWtlt/Z8=;
        b=G85GjxPh5tBYTBULDd+1PWFUqSKDOztUofZZ8JaXfCDtb2YYHOLX2UyhWmTV2aH8Ih
         h808l+8d80Y/hsLWUDoVF2mEZk1GjgpeMTrDVSqtpDlz3woDrWVVGCzLaScaqxoiZkF2
         COkxStDyBJ+X6/EArc+56pSyuP5jnu2JxFwiw6fcp4jFA+QoJ4hsM7++0sIm+eZnLInp
         sJO7iDbYGbeghHBek/f3lSI73yabZD+G9UwRL1mjYRcHgw/jjUIXlVXbQP5FvU4S3qgj
         OIWVIfBkasMmMDTCfImFWW3/PbHZ83tbPqU5dXnJKTitAel1DytQPf7NI61nQaoGVKP9
         mcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334043; x=1741938843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jivBZbbpeUpC37vr59Lus7C69ZvI+/qcef+nWtlt/Z8=;
        b=vxcooMEcYLt6W9WZGb+NJie9sptRODA2gg7IhUWT06gZ7XWVjjQ2uLxXDsn/00s1ev
         +OfVdAUdQAmMCcyUqCCsHxA/TyYH9iP/kHUUz5B6muS36TfQ+BE9Zs1VFo3w5sVjsga8
         f9HOdme4ZSl+GSxzM27urSnxl/PH5pNWmOIeL/Jc0tkqyH8l+ckUMwuJdtGffXWJYHRC
         Q5TUVaG1pCw7Iv59FX5u19Un+v77ohsUB3C05J2a9YtrJeb4LsTtjXHPpaUNsIaptrgn
         FLiuw1yI4QIz6pPx4vIwPQHRFUql5lQwlmPSrJbHMYOaafSEtEHqz/E1UI+zvsxpEdIv
         ITIw==
X-Gm-Message-State: AOJu0Yx5xxOva4GCntEeQ1ql2yn9rnDgA4QQ+jj4Ls3xDvMHbf3xIBFT
	lrKIToPcXI0fwrlYAZb32kebRKfPXR4ClJEbp7aEmknPaxculurBpRqgj4H04LE=
X-Gm-Gg: ASbGncvZS5xIqdzirP3nqGsKX2rePjHrR1XwPQQi5S5vJxqfSVwH/WjRhj66OYGt5E1
	9Mzz8XTduZNQwUId0xA6dtUS9tHOD1Jgyb3spZoGtnNjv4kEPb22YR0jA720WRPX/P/qpKrSG/x
	GuOHR8FOV78JsLmwq1uqR6kmfn4Dr7GEKOiGZGT6VPPXahiOAlnDQRBQEySS5S08Zrkyr5ttL6t
	fvf6aZ21SJBPmA6G5OrAsrVRK1jPAX8W/F1Z772KButFT8MH5hXUiQcdJenHoRxO1a8Cy6NoKyg
	kVhgS7x+EL/4WcVtpGClaQpMbfrQ8nywtkan217mww/PhMsAksc5Doff/G7e3zmXTxG6AwFO/YV
	ic3tOgBd9
X-Google-Smtp-Source: AGHT+IF84dx46mQjSLVGU2fwl0MIMB+9teoe3MWhOKYeBMQn9a4+JteyS3aCEq/ZWOCktwprXzRy4w==
X-Received: by 2002:a05:6000:1884:b0:390:df83:1f5d with SMTP id ffacd0b85a97d-39132dbb4efmr1337542f8f.35.1741334043195;
        Thu, 06 Mar 2025 23:54:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm4579617f8f.35.2025.03.06.23.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:54:02 -0800 (PST)
Message-ID: <b651acf3-ae10-4f70-a879-3b5d6ff39b02@linaro.org>
Date: Fri, 7 Mar 2025 08:54:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: stm32-lptimer: use wakeup capable instead
 of init wakeup
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, tglx@linutronix.de
Cc: stable@vger.kernel.org, alexandre.torgue@foss.st.com,
 olivier.moysan@foss.st.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2025 11:25, Fabrice Gasnier wrote:
> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> "wakeup-source" property describes a device which has wakeup capability
> but should not force this device as a wakeup source.
> 
> Fixes: 48b41c5e2de6 ("clocksource: Add Low Power STM32 timers driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

