Return-Path: <stable+bounces-152555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84740AD7275
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 15:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A63B121E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8924061F;
	Thu, 12 Jun 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FNy+Gp+E"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF00A55
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735760; cv=none; b=b/05K1SgcvzwZcNpvmfED5sIIYvXzWxqa8Xo2OdNyMRYkF5hHOvAWwgMLAyLt/SM85JSM+zuT/Hvc/lRiDyh7EuPhiIuK4ni19U9KjPCO78ktb22R/HicHoeBdV7AEb37RaZnQDOKaFP7ajtXPHGOG7sumgnkNXWjmaTjHEZKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735760; c=relaxed/simple;
	bh=8P3kx8Su3GbGs6CYpfZjnM2WQ3V243GbCO4qI9NQSP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g1EuzaK7FIQq8wcCBQwGNTC84eaeQbh5eNs0XN1snTci3v/3a/T57nZ+kQFifnkI2xcqEERud7d/rU/nrEwka+dqjhxZt6vijP0jy/HUJkeKeDueX2DpaeQLyXh7XcI1db+Ea219ztVeNwo+4/cYt/YfwNMztPE5E7GMp2pIg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FNy+Gp+E; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-736f9e352cbso573361a34.2
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749735755; x=1750340555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qiwn3/1TkHILuVLidYe2e/5HOvpCiz+iKreAGOvxNlE=;
        b=FNy+Gp+ElDMidfHWAQWG7Eb47oIzYqQsuNEIaKQO/saH4HZ+4Znxkrvno0yn9eEFF9
         1JlmIBhEn7Eloo6jp0wdQ4+BaytMP5HHxhjjuQqdI6wVkfrgAV0NBTHTtVEtZ3JsWWO1
         Dk1Ws9GbmBu4nBX5lzdpAX8Ih8zNMgr5ru2dcKP46P6v0xycj7XcHaQ9TGSGA16iqzW1
         3Amh6uba/tK1DHsQa/XJo6EW4+Kv0ycpJfUWZiaXBbN2e1r1AjO6vFD8S5MJtf3B/2If
         B+XKi2mesJFz2It4zFSS3sbpojcN8q6dqLnumsfVzJ3FcYXCICEgKWfM/ctLYm44nHyn
         I0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749735755; x=1750340555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiwn3/1TkHILuVLidYe2e/5HOvpCiz+iKreAGOvxNlE=;
        b=nvqrvMtOT1cgzD/S96oFT9DL3SmjiwMdgmuTYNRBCcf+wY8V9EWt6NSYXadRVij9g4
         koZbSfh/32AjJtWs0BHhx8A3Ny8dRvyKLHbpB3c4/hxTKNfbH3tpAlUjLvdEOINZUKC4
         9xtzvYNiquazHiTSL5R4HSxJxyqzEnJhDm/GXC7D/h6A/JWZP/f75ne8+33PP6+v5Awn
         LA6Eb2L9EACTSsvuuqLHhhZhUZL4RoEQmb78tL2ih+j6Qqxhg3Nr9+Vw1RoCRr2RsNte
         dtVONroKPoxAYSO4TSyqhNpyXBIS9XJavHTQebqhE9oM7gUcxQeqdQ41CI0vVRTKiorP
         04UA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ChrhADMtWygfjdQuDri77l6zesDdQEp+gKhWOQeBHICuPXkWoTORWZwV3vdyG+sFqGu01eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQZjrjq85cGnrFu08zPCIeVAkHPaIN6ws7UfhjDiG2eP7wiX0
	jceSij0ARG4Dxyyz3UavsK3g5U+JnLfRybV1CbmjkwkjHy//Vpy6c7xmuqRfOrViou8=
X-Gm-Gg: ASbGnct6Njg3C8ELy5uMLjynXWR8fpUMZjJuOS6k/coZChaSV9VXLVzbMI3L6LDT7xN
	1kng/Av1XtqJsVJ/a2/BqILwg6mak3F567OT3b++cD7JZ06XZtRgHZ699nqs2Y+sp8PGisv11UL
	jx04hMKMjSNfg6xN4A/r5pY67QGTogSb65EkSM1m/5Bfu/lG6vhLLnZATQKkls+e7B2vUCr8xry
	QR307HXr4zRsOr7G1lRyOY2javhdCKelri12A+R6iciYsqQWg53C4+Bxsc/Y7GpkJJcyk5wrUO0
	1un4kUBWtzDXVFOIP4MWMU1ZhnklL5GEzawDq93iVUuzseHg34PKkM93ZpyHTnqxQfQxXn2AmXc
	nYh1wGo4w8+hFOBKA1+4SGOfSwNhXQV07hMLWW3RpI31hwjoZTA==
X-Google-Smtp-Source: AGHT+IFCFNMANrSlUJtGJsjZ/Y86aLqc5f+xImxVor6RG/oaN/AKEv7RM8zWNyPoO4u8/oOc13awsA==
X-Received: by 2002:a9d:550c:0:b0:72b:81df:caf9 with SMTP id 46e09a7af769-73a13a5dd4dmr2171111a34.8.1749735754635;
        Thu, 12 Jun 2025 06:42:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a16a57960sm273097a34.16.2025.06.12.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 06:42:34 -0700 (PDT)
Message-ID: <dd93fd01-8eab-425f-a1c2-72b5241409a8@baylibre.com>
Date: Thu, 12 Jun 2025 08:42:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] iio: dac: ad3552r: fix ad3541/2r ranges
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250611153723-67792efb94647fa3@stable.kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250611153723-67792efb94647fa3@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/25 9:22 PM, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Could not find matching upstream commit

Not sure why. It is there:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e758b613212b6964518a67939535910b5aee831

> 
> No upstream commit was identified. Using temporary commit for testing.
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.12.y       |  Success    |  Success   |


