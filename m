Return-Path: <stable+bounces-194508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF9C4F037
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06AAC4E647A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E936C5BC;
	Tue, 11 Nov 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL/G8kH8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC3350D47
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878183; cv=none; b=EZNgtBVDTJk7X20MacIzFiNns6HgEfk2jX6cFdTSwV0GUkBokgzC21kO4uporeuzkG0gjJmbZ7dT4TJxn9eLNdTIoZpHTrQrK8sxd7a1ONiJFh1aoGBbqXNVdWDFrJ4mcICDvVVWvSQKEEnV70T1ThYAt7F0Cabe2qvuTdXVXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878183; c=relaxed/simple;
	bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kqqw9rGsTYl7A3GtpGwdGeiVYgiZceCA9W84aY07IgdkWnFyUri1Arpk1J8B46T5MpvjcEHPNM6sWZghNGK4uS/MBXelBpwlWDVwdhS5veV1Ik4qE6zIUGIZpc62XiFqmlZSsfkTsNfhB0esHwT2bj2fNEyoLMiZhMu6j27rXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL/G8kH8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2984dfae043so476225ad.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762878181; x=1763482981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=iL/G8kH81/IVaSdfe7lXOFWjh9H4zjgAEAoxS76cOnW6kGhhpZqTUbkxRjmxoO2kRQ
         iNu6hnMTSPicDUPPK9/LM8OG+IovhjVYHfJA7zi+7czQUeL5sPEug4sw+iJ686cNXNCJ
         SOqYcm7Zbfl8jeY0pye58C9ojZf9Tn4OaxwWFpI1jCArPuvs60534LRLL9suYx2w+el6
         UYNuIrPiWVKLXO7/oAjtPgVPgOWLRT6wdOJWf5rjJpXBh+rLHQ53J6/kbnoqcTOsVgrr
         SgiCGejzYNEyR40HeQHOem++GcRtbbCxJUEM5GwnBhKP6ngCh59/jA/b8qJCtTDBDFe8
         eXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878181; x=1763482981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=RH7S9kPymXZ6nInaphvm4N2bgNQupVmkdVibaitBsRQeK19n0yXNaZWvkZW1zV4+Y4
         xVTpVY3KbqKtQLIDBcJfAfodAxgNq7t6ZpwcOS67+h/a1I26A8l2Lu4tiwXvQ4a7ZNLl
         MhGLiJyekc1JI1Nq03j+LQyj3UJ7HPCQcW+0rfwj9TZUhFYonBV6kwtlAGqsUogEBd9B
         97ncR8r0xgYwGaviN82kTq4RddHNcHczNrX6mVfTEjFJ0/6I6VZtU+Eko6lpuwJSeD9+
         1w8Ua+w+6mb2hUh8Xau4QTR7w7BJ5J/78Za5MKahlUANWUACY3HrR+UdSBz91/Tg89zW
         +rYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7DkHKto2QmpKraLMxJYusOKlIdxEVcVq797CtzcGKqP0ePS5WUs2ptMKko5trQ4Rnq6DmfO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgYXBVA1E5yhAVXneai9ehW2d0muQ5KId/wavRG4gxVIEgA7F
	yktIW8q39IzO8W1pfNrfYTSrPkExU17mebA6ewmW/yEziqJMK+8JtC1y
X-Gm-Gg: ASbGncvIbQd1LMrbzHQaGxVcFq9QmAQgcs5Aj7mtxfpL/aP4ic/1cBpmY+bAvkMEqp7
	rsk6/GASh+mF6J8m6owsbTJ4ZymWIL8vPLsEFu6ZDe9woaLEVbvg28brapupnHuIKjrvqIE9NKj
	qCIuCe5IHUmg7EcJdB6Lp3K6eEXyE+cqBS65o/nRc+IDrBH7QH6hq5WH9IAuUy0KS32gVKADRxM
	L+9CadZQ2GHAAqM3yeSd3He296Dqpxl3iyyYQpqtjo7lcb/WcXHG/n4u31YyeV2j9hJJLgfWaIx
	qi7bzdwJrX29PzV1hesYjzW1fBFC3dtyfFGBPbXbvOPQIa+3MWAS31y/Eqdokg9B3mRtjxmwMKd
	oxigE2neFd83Qo3vRszBhlEPN6DMIVpKZR/oEkyVu5/4ozIBIpYnfvfO1yZpdOPtaIFCXZUgTPi
	KD1wDOwQqChZ0LGNBpmcqk2Sg=
X-Google-Smtp-Source: AGHT+IEIxU6B/C+/gaE5krPsjCGJbHME9xr/mVp0iRWSOeqny304a0jPzv72fNDwODfJiyMz4oZbcQ==
X-Received: by 2002:a17:903:19cf:b0:297:db6a:a82d with SMTP id d9443c01a7336-297e5668a96mr169381405ad.26.1762878180793;
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Received: from [192.168.1.3] ([223.181.109.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf54e6sm1713765ad.37.2025.11.11.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Message-ID: <fc82ba95-2c9c-454b-9d32-8f5639671822@gmail.com>
Date: Tue, 11 Nov 2025 21:52:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fealnx: fixed possible out of band acces to an array
To: Ilya Krutskih <devsec@tpz.ru>, sdl@secdev.space
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251110134423.432612-1-devsec@tpz.ru>
Content-Language: en-US
From: I Viswanath <viswanathiyyappan@gmail.com>
In-Reply-To: <20251110134423.432612-1-devsec@tpz.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 19:14, Ilya Krutskih wrote:
> fixed possible out of band access to an array
> If the fealnx_init_one() function is called more than MAX_UNITS times
> or card_idx is less than zero

The code already validates against the >= MAX_UNITS case and card_idx
can never be less than zero at those points under normal circumstances, making
this patch unnecessary.

However, card_idx will overflow with enough calls and that is something
that should probably be fixed


