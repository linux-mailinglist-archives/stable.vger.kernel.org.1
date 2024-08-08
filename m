Return-Path: <stable+bounces-66009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2600A94B8F8
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD59028AF8A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152981898EB;
	Thu,  8 Aug 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S5fDgCzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E10188004
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105525; cv=none; b=Q4i4No7BXpP+0P+LWe7QxbAk/zrNb+GTP3SKZ0JniRWRe0XvQ1UIUZLGqUC2Vh0i/Ysdhgb+FkRg1XIf3Q55gaAy6XYfQCW3MA1i8c6rLgmKVV5H6OeGbskHp9oi/YTht2RUoXf0STFWrJ/qp2sOsMDhMDEboDZHECYURvu7quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105525; c=relaxed/simple;
	bh=YxGufwd9ZP0RAM+uNjC03nZfOIl3APMGF5EUwjJ/Mnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxXfBHIcYzbMdGGozodHw6BLzSdfra1iBfODlK/87onBxoiRU2M71Hwt0FmRdljt7xudCQAV1zu5kf/3V1L7XLEaaXy6XAS12M1siPZzbMh6ZVQk5laeFA0IPLtOuPeO9FDZvxS0D8ApxAL7qkr3DvWXkqKluXLKbRApeNx22jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S5fDgCzo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b796667348so5865476d6.0
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723105522; x=1723710322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lZa4iL5XprHrN5HHLymuFJropJGE7xvng0lU1qszo5A=;
        b=S5fDgCzo3F1KrsNjlVj5u/QTn/FEAhvsPsJMbXT0vtYk5DBG2imtbZuY0bit3YBUYV
         Kbp70FyTc3DeSNE1SVcjius1tYnlJ9NOj5pglH1SlbniTXsQQMjjb5WGWmhO6l7dswjs
         CqLuZa9Sxkf30ZgYOjOsM3nDnT55yV+uQ3Joo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723105522; x=1723710322;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZa4iL5XprHrN5HHLymuFJropJGE7xvng0lU1qszo5A=;
        b=dOhLzxoaHPry5wF0KImOvrnQi06fEVM0YIVGZDiwcHQV6P3MrnDi0wH/X40h0TnSra
         K/3b3Q83PcWAismgvqi6Iq3trAA7qWk2jwOQbg2A/1IVC3QNCTSi9cJbLeKuIrCiepo2
         W4/7K4I96k2XKl5PEcEAMer7Meu8waAoTcJmgbZ5W0Q7NSMWYIEkag01hRihEIasy8gY
         NAZQRepUGGOfvYGVOqH/Fcz3jfVKTGdVDjfBAz/Esm0ut5iJsJGC37wGqw3b/o8L4Jhd
         Zp1glufMRHKFmcF4LOJ/sh7hbo6dovQTHtnGysngjnkI+G3Y/x1Yew5K3NjLYky1pFr7
         n4/g==
X-Forwarded-Encrypted: i=1; AJvYcCWr0o7FKciVvFqd38NVAyzO0ZzBYXn6lICl42RSVEaK5paszkLFDHEaL2Cd69bH82lBAFoCr/Tz2oY7XfzJ1HkiVDfV/IuO
X-Gm-Message-State: AOJu0YwK3PpYCpMGJdtI4sCcFME7C4YGsyAEVmSVKUzNPY1wVTDZxTdM
	0TVRVBJoxFK02VpDCzJNmE4nLQFPy91DEicBbUY/GdQoBWp6j3oYANOqidUaug==
X-Google-Smtp-Source: AGHT+IFCVFsE7N4pVcWELICWR9jjvv0RXXNb11DeQBDB26YzXpwJn9iFi19LjHTQAAk8Wt4yH7vfvA==
X-Received: by 2002:a05:6214:d87:b0:6b5:d90d:ea4f with SMTP id 6a1803df08f44-6bd6cb1191emr16330526d6.15.1723105521683;
        Thu, 08 Aug 2024 01:25:21 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79744esm63892586d6.40.2024.08.08.01.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:25:21 -0700 (PDT)
Message-ID: <15c3fc2a-8298-4f6b-a5b6-ef8786f07585@broadcom.com>
Date: Thu, 8 Aug 2024 10:25:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
To: j@jannau.net, Kalle Valo <kvalo@kernel.org>,
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, stable@vger.kernel.org
References: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20240803-brcmfmac_pmksa_del_ssid-v1-1-4e85f19135e1@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/2024 9:52 PM, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> wpa_supplicant 2.11 sends since 1efdba5fdc2c ("Handle PMKSA flush in the
> driver for SAE/OWE offload cases") SSID based PMKSA del commands.
> brcmfmac is not prepared and tries to dereference the NULL bssid and
> pmkid pointers in cfg80211_pmksa. PMKID_V3 operations support SSID based
> updates so copy the SSID.
> 
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
>- Cc: stable@vger.kernel.org
+ Cc: stable@vger.kernel.org # 6.4.x

This should be applied to the wireless tree.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

