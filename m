Return-Path: <stable+bounces-43186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B28BE5CC
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F75A1C2207F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50B15EFAD;
	Tue,  7 May 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ur6Mn4Z+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776A15ECE5
	for <stable@vger.kernel.org>; Tue,  7 May 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091772; cv=none; b=Mh2Guj/EjdMEuNTtHdRRR9qRwWr6ZmhP/h9wjMTKXK0hvva+i83DRQGI1TyCwP0TYx7IHQOZ418RTVcOtm3A59rq+UcxvRpIQiZ4EaPhR/EJy2t3k7qZ4aEss6X7vZYYk7drADvaUgNj24G2SHOh00clIs/0uyDfeVFJICxNWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091772; c=relaxed/simple;
	bh=NG/THRXZ2wPpTeo261bmBCc6k+jKZnZpg62wVDrHfLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUHS8Hq7XtTaPUsCPhrXGm2+ZDRHyKVPDNpXA+HOtP3O4ZEUfBQqq3TDoKptlU/Z2zB1WuMLM70hYYMIBQDc+khM3/cuz/tZIIxhhlCTY8b4we7JxBkZpMKyV5ycfx0kHYazQSty9G747aX+GvkNPONA+Ep2jNmdO0KDw/+oSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ur6Mn4Z+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f065bc237aso1048970a34.0
        for <stable@vger.kernel.org>; Tue, 07 May 2024 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715091770; x=1715696570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP1hrHJ9Cv8JTL3uWKlXzw0k5oSTV4qnW68qRWJWADw=;
        b=ur6Mn4Z+vdQfQJaKeS50r7YTUdIZRD8unQD5nUcOLkGCfTNncTH+2FsHWxNd9rvH8k
         cNG6r2iF6Fc4g3C0kVLx9ROTQ/SaYgGrx9T+fL5jScXQnqozxbOxD9yleW+sI9QPr0jp
         AgmNBZryzFDXcnjUFfa5T6+hFm9pL/Il66ccPFBM5CXyhxGJHTzfC+E+U9tsno/9fo44
         vqOSxDK1eUot3QlB1cwX/HGoTGQVU2h7Fkk4ko7zR2UbDZEV/tGteUHA8rUkqEKwhkiQ
         zCoTnqQVuh9cqMNMTNYecOz1c7t9KRF7mta3URpClT3UDweaR2Jo964AoH2BJAynDDer
         l4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091770; x=1715696570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MP1hrHJ9Cv8JTL3uWKlXzw0k5oSTV4qnW68qRWJWADw=;
        b=TCtQpfsRSyKzEjoBHTpClgArlvR/Aa1T697ssYjSym8Dl9lQN1TaIjqIousoLkkbLV
         AscgHO32Zvugga36OpoEGVq6QaybEP+5ZsJRMVXDcJKE+2NoTPfewe7Vv7xk6vKwUO9Z
         23Nh3B+Va1Hv5/ru/apT68uzrwhiK7eG39tZIddgA5PWnagAW7pPhthUTWtS2HVVP/Uv
         9vn+mfTAHLaxMDDGbfRwKRfsBGEdYtqVAv84GJcuvvofN3DW0vw1Wtluv32iy3/q4Sio
         NmcqI317cS1WUHk5qDDo/jrqUX79mj4iG6DA+vW2XaLNXiUI/QiXmDmnL9U9nbyk1ZP8
         lxRQ==
X-Gm-Message-State: AOJu0YzRm5N3kVMjOVc9X8ZZ5DPwTGQriFS1bZnfcmC33qvAfyqoJM8W
	1qOrlQfmCsRVHyLsWJFk4x5Udu6MPl+ZOG9jutrlvWqpamVBYdAqi/L2Tbu+z/E=
X-Google-Smtp-Source: AGHT+IGuZqZMSillXZZcimayDsp9SLWMxh7VWq8KL91jyf08s7zrDY41Ryy8i0Vcyi1Scm970zS53g==
X-Received: by 2002:a05:6830:3a92:b0:6eb:85cc:db68 with SMTP id dj18-20020a0568303a9200b006eb85ccdb68mr12419272otb.1.1715091769764;
        Tue, 07 May 2024 07:22:49 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bx6-20020a056830600600b006ee4c34efe3sm2512958otb.20.2024.05.07.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:22:49 -0700 (PDT)
Message-ID: <d2857f45-caa6-4d69-989d-bb95dfcbc7ff@baylibre.com>
Date: Tue, 7 May 2024 09:22:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
 <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
 <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/24 9:08 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Tue, May 07, 2024 at 08:59:16AM -0500, David Lechner wrote:
>> On 5/7/24 1:13 AM, Uwe Kleine-König wrote:
>>> On Mon, May 06, 2024 at 03:43:47PM -0500, David Lechner wrote:
>>>> Does not meet the criteria for stable.
>>>
>>> It was identified as a dependency of another patch. But I agree to
>>> David, it should be trivial to back this patch out. If you need help,
>>> please tell me.
>>>
>>
>> The "fix" patch isn't something that should be backported to stable
>> either, so we shouldn't need to do anything here other than drop
>> the whole series from the stable queue.
> 
> Maybe it's just me, but for me backporting commit 0064db9ce4aa ("spi:
> axi-spi-engine: fix version format string") looks sensible. (Or what do
> you mean with "the \"fix\" patch"?) It's a small fix for a small
> annoyance, but looks harmless enough that I'd tend to include it in
> stable.
> 

It's just fixing a theoretical problem, not one that has actually
caused problems for people. The stable guidelines I read [1] said we
shouldn't include fixes like that.

[1]: https://docs.kernel.org/process/stable-kernel-rules.html


So, sure it would probably be harmless to include it without the
other dependencies. But not sure it is worth the effort for only
a theoretical problem.

