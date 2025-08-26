Return-Path: <stable+bounces-176428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64758B372CC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913AB205601
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAE3680AA;
	Tue, 26 Aug 2025 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="YdqXUmVx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740731A565
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234971; cv=none; b=jC5SGeS4u3sz9sDJMu9+YFzZqtZiQ6MayeAVY/NO0VT/TBz/iPmdUTT92zaTvNNPdn3R2b33z/khj/HlrdRJZnYI/q+bU69icwr2T50GhS3zE86Gf7bVMphKPj3z7hhgSLriRNsUResM45Gy1NLEBogfEssZK5Mi0bpOHbggiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234971; c=relaxed/simple;
	bh=7x79+zh//7YFh1Y9wEfUzNzcV4XLQzX7xw+JK7+SEqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzlLC27s5ah1G2yhuF+Ge5mTY7ISNkn71Y82eCc+kmqZU/CwLo4LQKJcx+olW6C2EA1F8aJSTX6BFyEjs6m6e3PRkpWvW0CY+uzpEdUKWDp472eh6LXlrMLXpzYRoul+sh8SvHZ6SDKFQJSZ1kU+LbR83i95v14tvZiKgNMc9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=YdqXUmVx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c84aea9d32so1417976f8f.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1756234965; x=1756839765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muAtNomh3uRMDD+C8qIcn8EryY4r65QbrtftiIWEqDk=;
        b=YdqXUmVx46HJQ+D1AFOuvtIG5+acJurkLkR9KPsPzP0Vz7A4AyVRYkP5ZsG+KMOEeW
         206hPQ0C1PClTqyI/U+uPI/+iaDkaJRcsky69DSZI0VwvNl0FEbVh3BHC54LZzi+QS14
         qXiu7StQTixEoQOIb6yj3pM0+wvTE6oB0aXn8DdiC7jZi5YNyRvsuXW12w8Q+/BoVgDN
         f4HeUkH71T2jR3cNOAMYIyerwUiCfrbERrwJN4B+TeWmSQhzKOBFz4wXPysuXms3bWAX
         LVF9vbYwHEA7SLLsBMZqM3qh+hBjNtYAfPnDkmGSRIY65BKav7ecwt52znzu+FO8AfwT
         SYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234965; x=1756839765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muAtNomh3uRMDD+C8qIcn8EryY4r65QbrtftiIWEqDk=;
        b=k/L9j+8od3GGzrMleLdKCfPWHjtSyf1LuLBwdtIQYa1bjx+5GlRPYYcz+asPQExj6T
         zh/tYCZimavSO+QrgJZuYW0uXJlXQuevbLXwW7Y2l8tfvdciQ/+Wk5nzyprExqAlVT6s
         z4P4Y7hoKGusK+yZDSKX2ca1+cdTYR80+uDIX5nuswvWq2m+MriGWatLiv4mUkDHsObk
         TBIHbjm3wjs0R8saoaqSHBvXEh0Gz93LhxPfZuYdBm0m2l8Uf5bDnsqWBnzYemC2LI68
         rEPfelDv9heFQ0VOAx8PFEIXiLBfq244cSmEog+fjzlEs79cHUmapmVqCh4Xwxr9cCOD
         uc4A==
X-Forwarded-Encrypted: i=1; AJvYcCWSxgUDKyeI14om28rHcPR+ygp+y4mFguzGFK8Wmqb1c0wcn9GXqbkCStr/gOh0wAOHLi7qrCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJU0S51Kos4o8e6iJ1+togiotk/18DoRojidbI8+4qr7mhbIZ2
	ry+SQg7VxyMYSJ03JU4rKxM7xTe9wTg9rI8G23XNuDQU8pA48OTVgDeZ/JUFe4J5jvQ=
X-Gm-Gg: ASbGncsvLEbTwfi+UhGB/5909kkRNt6xa9kkmFbgIYAtqEcnAKCg5nLz13KT8hp1L+P
	UmZmkJpPUW2ZMoqv1CKBPwcJCjWb9b3c+5IItMnkAkDR/0xQfHD2xQZLsFMF65zYSyt+twrhves
	4Y7hAwswupwHvqDKTdWSDGFLf0c4KRxc/0vMX+UCC+HePCaFUia+Fc0LMYEagtZmmx1F0tK/ek5
	j+U5gCc9G4B6DAWwCg4MZeOQpqYA9eqsq6S5ZiidwSUQBgVePm9pJt97Ulk7PI3iI89HTwzJiPT
	6QH4qP0XTLfYsIwnfM7WovYBF//2eWNc0sHmgxxYCVA4+pn065CsNsNUhMeeIIiGZTEzLXiSKXC
	FEXWa6oJLOrzLEfqHDlOwzlavOtOtGJCz/26hGFJHwKHGzrkrIjVdhw==
X-Google-Smtp-Source: AGHT+IFXcuiHsbEuq8+VI2WG/VGI4SV1N2ehkSLSB3sBTwfW5BnW/f6Rv11KJ5q7K8d7WaYTot53Ug==
X-Received: by 2002:a5d:5886:0:b0:3c7:f9a9:7b3d with SMTP id ffacd0b85a97d-3c7f9a97e12mr6788361f8f.30.1756234965440;
        Tue, 26 Aug 2025 12:02:45 -0700 (PDT)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c712178161sm17210512f8f.67.2025.08.26.12.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:02:45 -0700 (PDT)
Message-ID: <29b001dd-92b5-4afd-a871-f9fbe875e91c@freebox.fr>
Date: Tue, 26 Aug 2025 21:02:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: do not permit 40 MHz EHT
 operation on 5/6 GHz
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>, stable@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
References: <20250826202553.a6582f3abf57.Ic670429dc7127f68c818b4290d950ebfb5a0b9e1@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20250826202553.a6582f3abf57.Ic670429dc7127f68c818b4290d950ebfb5a0b9e1@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26/08/2025 19:26, Miri Korenblit wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> The EHT PHY requirements state that 80 MHz must be supported on the 5
> and 6 GHz bands unless the STA is 20 MHz only. So if the channel width
> is limited to 40 MHz on a band other than 2.4 GHz, then disable EHT and
> downgrade to HE.

This is wrong one way or another.

If we follow the 802.11 standard strictly [I'm going to use annex B's 
items so it is easier to follow], we are implementing EHTP3.3, so a non 
20 MHz-Only STA has to support 80 MHz channel width, therefore a 40 MHz 
(max) STA would not be compliant and we have to downgrade it. The issue 
is that HEP3.3 also requires that a non 20 MHz-Only HE STA has to 
support 80 MHz channel width, therefore downgrading to HE is not ok. We 
have the same issue with VHTP3.3 that requires a VHT STA to support 80 
MHz channel width, therefore downgrading to VHT is not okay either. So 
that means that the strictly compliant approach would be to disallow a 
40 MHz STA in the 6 GHz band and downgrade a 40 MHz STA to HT in the 
5GHz band.

If we follow the 802.11 standard more liberally, we never enforced 
VHTP3.3 nor HEP3.3, so why begin now with EHTP3.3?

>
> The primary case where this can happen is if the hardware disables
> puncturing using IEEE80211_HW_DISALLOW_PUNCTURING.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Best regards,

Pablo MG


