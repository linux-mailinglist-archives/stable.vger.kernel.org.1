Return-Path: <stable+bounces-91919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF59C1C5E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A33D28694B
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F711E5700;
	Fri,  8 Nov 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3lAuRG6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107B1E47AF
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066236; cv=none; b=sucuesD3b1+gfGqKJyMrPRTtzHDO/qaDfbPQTgTVZjd7ZMmf3k6kObbcV+RJ2f1swHy8kzWC8auDdee7MoJmBreUSlCWv6zaBRkgs1moOGDmLKGdLebmZNf8mmRIBDxV0BF9t0S25ehpnLmsgEYzVfor2jqUlEeb20a35Idzs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066236; c=relaxed/simple;
	bh=qjv8Nskk+avwjBuYyWopHdeHY0bXMOaLNpB/xYD+XcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVdP/UJX1elGEBZZeFpMPJTcY7CkmoHMKg66PZohxi94DZ1fpmgomhsjJbumy922JDiQcY0pBMlMTwU2sHleZf7TmQJtViBIROchqkd5unXkrpeWkdeCfGdpEgyqMGIAVUPi+RR9eBS10nKIdH1c4OF+tSn6y+fKZ2gmPh4POPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3lAuRG6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so23817355e9.2
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 03:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731066232; x=1731671032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ouVSbkAT3+S3WMSHYg6HVwCj00MU4w8dzA4pzxSauU=;
        b=d3lAuRG6hA9xd+PYJBznZkyI1cz/xYM1tqJkqaJdCHlr8K39DYX0opc9h+xQQ373nH
         qLotlvCaW2g2YuAUHs5sB8eeP2kk0Xqy9hAA91vII5yTn+/wHM52tr0Gm2xd+Hb51YhL
         b8Yo1U+ChMlJh3aHOW3zV3LPsWbWdb55F/vpVlyGtAJn16evmRd63aKDw1JWFoUJsRoG
         tQVK/p7qJyrUzcaDIcT/6teccvBFW6tUTxBEQpxzKn6S2veyjmaagP+/SuDQ0QsQ/zai
         QIWdV8znnMWQF6wKtV/NXtOSUGg0wLhBA3hq7RA4k+glwkKvEJrEAuTHaHeQoPXOE6SL
         0lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066232; x=1731671032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ouVSbkAT3+S3WMSHYg6HVwCj00MU4w8dzA4pzxSauU=;
        b=gfYfsOSqgdJWj1/1lZ+ZcZE7mPfVbHZ397SMy4/vRocgVtbgEchlCUMPrzVGzCpYem
         XOaJElkRIogUXfHXj4W+BHgh20EgtL6jjQSd5tEJ7MEuKNKGM338wQ4wiYGb1PsnEy3N
         fgHVGxgQRhmqnpluqVKlWdWVU+Y1KT2ZVrHdG3N0BowJow/W8BV9ID54iqUCjKbZ69JY
         IFNqat1/HEFVBoyDBkpnfqFC70fQ8FzJ+9pvXYt6Z1QFi/KmtCi5/9JtX/xYhWCAJwZQ
         zO+9nCiMW/r5c8ae/WOXgTcYavtwGZt3VB3aNRPAGCue2rsOSgc09jCIE+efZIm289Ya
         2jZA==
X-Forwarded-Encrypted: i=1; AJvYcCVhCfe4+p5wIUaAUcHvLcGqhb7DswQsOKo3RTRI0cQH2/JxDyQoYAf3cvFbS+vFwHU2RqXxeEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDzVvbOeyqH/0JBvmJV4KXIhukzM3SZfNCRUhkkVxM5kkWro1
	XDFxj4Ht7MPp79n/ZeHN8BJ67i5vg9q84BXR6t1y+D3w/0OKPC/TvcRj/kc6Q34=
X-Google-Smtp-Source: AGHT+IHenYE2IrQEIw1RwXn2xALrnPWJbFU0VRWzYGh03YSwh3hgPhVUGtDNitZVrXDo/IEmoPy9YA==
X-Received: by 2002:a05:6000:1541:b0:37d:2ea4:bfcc with SMTP id ffacd0b85a97d-381f186bc9bmr2308261f8f.13.1731066232510;
        Fri, 08 Nov 2024 03:43:52 -0800 (PST)
Received: from [172.16.24.72] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5871sm60742135e9.37.2024.11.08.03.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 03:43:52 -0800 (PST)
Message-ID: <37982a05-2057-45f4-923e-7562c683706d@linaro.org>
Date: Fri, 8 Nov 2024 11:43:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
 <b2yvyaycylsxo2bmynlrqp3pzhge2tjvtvzhmpvon2lzyx3bb4@747g3erapcro>
 <81d6a054-e02a-7c98-0479-0e17076fabd7@quicinc.com>
 <ndlf4bsijb723cctkvd7hkwmo7plbzr3q2dhqc3tpyujbfcr3z@g4rvg5p7vhfs>
 <975f4ecd-2029-469a-8ecf-fbd6397547d4@linaro.org>
 <57544d01-a7c6-1ea6-d408-ffe1678e0b5e@quicinc.com>
 <ql6hftuo7udkqachofws6lcpwx7sbjakonoehm7zsh43kqndsf@rwmiwqngldn2>
 <781ea2fd-637f-b896-aad4-d70f43ad245c@quicinc.com>
 <oxbpd3tfemwci6aiv5gs6rleg6lmsuabvvccqibbqddczjklpi@aln6hfloqizo>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <oxbpd3tfemwci6aiv5gs6rleg6lmsuabvvccqibbqddczjklpi@aln6hfloqizo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2024 13:54, Dmitry Baryshkov wrote:
>>> I'd say, don't overwrite the array. Instead the driver should extend it
>>> with the new information.
>> That is exactly the existing patch is currently doing.
> _new_ information, not a copy of the existing information.

But is this _really_ new information or is it guarding from "malicious" 
additional messages ?

@Vikash is it even a valid use-case for firmware to send one set of 
capabilities and then send a new set ?

It seems to me this should only happen once when the firmware starts up 
- the firmware won't acquire any new abilities once it has enumerated 
its set to APSS.

So why is it valid to process an additional message at all ?

Shouldn't we instead be throwing away redundant updates either silently 
or with some kind of complaint ?

If there's no new data - then this is data we shouldn't bother processing.

If it is new data then surely it should be the _current_ and _only_ 
valid set of data.

And if the update is considered "invalid" then why _would_ we accept the 
update ?

I get we're fixing the OOB but I think we should be clear on the 
validity of the content of the packet.

---
bod

