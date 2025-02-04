Return-Path: <stable+bounces-112121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC8A26D5A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 09:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578863A3F33
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B63206F34;
	Tue,  4 Feb 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP+LwwB7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73974206F1B;
	Tue,  4 Feb 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658046; cv=none; b=BfL3BCfsPP5nTZRh6oprxmXGFZH3qq9PBf6Ad3gys9iOEkQnvlwdfDflq8zCObttN1jA0NrgNs0zEf3ZkcqKF5ZBaoSiEonxy77b43mo4OnV0x5nQ3Pri3PEs30kHjSuPU+kH78niBochZU3HelviIgDXxNsd5JBoESAejn0IOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658046; c=relaxed/simple;
	bh=VHICTY0v/P/XRcN3ZQD+U1TexkYgFSnnw9shFLZHYKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/GPn99rIDUlZqVrHwCQNkEh0lc+efd6Un+VATXZiSF+VU25LpMEd6Zgx43Peps58g55kPQbBn3INJQZnlFDbwfYqh87aZqulr6V4HrfSNWM6DIA0tho/rUgOAtz5A7GH+P1N3gtfDy1sKciQCXRc5N00uRjT1a0fGcm3KmTLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP+LwwB7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000fso5158266e87.2;
        Tue, 04 Feb 2025 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738658042; x=1739262842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUOy5y0yxsgKWiNWydVbfINSfu/t0HuZpyd/npoH3XQ=;
        b=XP+LwwB7r6a85IUi4Wio6nPHs1Pv8qfNAoF4gErqWzAmmz25Dtl0Y9B3tTv/UBN9M8
         /yMFko2Esx18JmWzQCV6g7/UVdTOVaw++rNyxKjwNRVH6apHwQg3e6n7nBCgfUbhMsRt
         3c8rZ/5X5iJDR+aElPQk+MOXY3N4y5VSdsT6Sr4ZQipu90ByjM8FGEIAxs5y10VRgsFT
         wVqfpOM3LvPUEmpRIOQ8UGGejQtf5ByhuZrCUgcfSId6Rd/JluHAW12/kFNwzFXOkOjB
         Wo06YOhtylSb1cCka94Akn87MpzWe6NLfVJcXjZY1XGQXkFJVnQXHMn1Lmh5MpW3gGSd
         EYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658042; x=1739262842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUOy5y0yxsgKWiNWydVbfINSfu/t0HuZpyd/npoH3XQ=;
        b=UHJxuVBUh6kYdsfJC9cH1Eb+MHdHsqasS+hg7IykEtEcUlxhP3ZaqhSB34sa7BFsgq
         TSUF//Q1AIHm8yp3xlbWzTokh0ZuKvj1/dfJvy2r8a2qsnEuMW5mCGU0jCpTPZmhWIvK
         ITIiUjLBfRguLxoefLLIqBGgWe7ViY5d2f+OxbOTraXNxm1I7SGoageNibst1QAGEjxS
         XhdTbgNilapFYJn2RK+/7uzUNkdQNV/O9AEQmH7ofAnln8C8jVSzwIIaDCfEl9f6aTHo
         635jp17I8WU/LRlgJRNorYrcjC39SsyFz6EHZuAkRG7TVKhbSFqLTCleMqazAuRAk9PJ
         mabQ==
X-Forwarded-Encrypted: i=1; AJvYcCUddSm3iPKJTs+VnSQQGY/zhHVCRZQ3IqIcAoZo4SADKVElyTR7VXTx2WhWyFVLQV2TvoA2RF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMves0RWoH2rE6zvm40ntYD7hiHdwYedvhsu61VCn4YMS0LLL
	no+b4mMksuRXiWnhmHMkCjpy0BJRhpgea/FSR2IbrUpSXAStK4Em3DH8yw==
X-Gm-Gg: ASbGncvxntnYcJ7hYYH0jGaN0JGIwMofn2Rn8jw0kuZlHnXmVU+15RkZ99hTkun33Dj
	0CwuZubQD9LrDtbH44rYYk9hBkCwkFzgezlvvlGgMrW55F0FvOTiMJCg3Yg7RkvMSloOsc7yvqw
	ZuidDb5DNGz974dEAdudEjGstNRASKpY/RduuD6pBl68J9RlJRYYZEBJXVomztmDqd/jql4lB6G
	C3ThDJHeVOXIiYsovcRa5SPK4MWahTphM427iLIjuF8DkkdYaIkLz8UJOILREOg/gjA7UuYYNw1
	kN5M67sBX/V8/454W1HvWWa3fJ03
X-Google-Smtp-Source: AGHT+IHQfaQHoAtZGFzbC8xJD5xe70Eyb7uUAOgyq4UAxOECNyD9eiaAT//DHs+Lrql82V7+Ljb8yw==
X-Received: by 2002:a19:f712:0:b0:540:3581:5047 with SMTP id 2adb3069b0e04-543e4c415fcmr7555392e87.48.1738658042155;
        Tue, 04 Feb 2025 00:34:02 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebef1esm1519465e87.253.2025.02.04.00.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:34:00 -0800 (PST)
Message-ID: <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
Date: Tue, 4 Feb 2025 10:33:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap-irq: Add missing kfree()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, broonie@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Jiang!

On 02/02/2025 22:05, Jiasheng Jiang wrote:
> Add kfree() for "d->main_status_buf" in the error-handling path to prevent
> a memory leak.
> 
> Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

This looks valid to me.

I still wonder if you could fix also the missing freeing from the 
regmap_del_irq_chip()? (AFAICS, the freeing is missing from that as well).

> ---
>   drivers/base/regmap/regmap-irq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 0bcd81389a29..b73ab3cda781 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -906,6 +906,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>   	kfree(d->wake_buf);
>   	kfree(d->mask_buf_def);
>   	kfree(d->mask_buf);
> +	kfree(d->main_status_buf);
>   	kfree(d->status_buf);
>   	kfree(d->status_reg_buf);
>   	if (d->config_buf) {


