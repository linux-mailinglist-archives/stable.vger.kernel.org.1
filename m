Return-Path: <stable+bounces-43154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2478BD67D
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A181B1F230A9
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306456B76;
	Mon,  6 May 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PYAikddT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04715B567
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028426; cv=none; b=E8G4IvknNIjm+WYjs71z10peJdMJ6PNzO+sk1jBb+jg9hwHnLqIoswxwCPSqrk8N1J6fMSTUjC7ivlslNlFfalrcQguFXRZ1RJLEOOe1JumwMUdQx1lFxjGYommD5hmdlfzovNr9Goc15F1LnZOtMX8YMtk1yfablaFA8fF5Dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028426; c=relaxed/simple;
	bh=TFcTW+xYn1n9U/CrFk+fNUHw5umAte+MehdUr67auyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7jhjIxPKZx/gWpiOE5z0hGbBP5vekkergOD0Lq58RIUqGmC6nI1vUC6apMYEF2KU2SRcyBqqTdUnQDyiB2EnOiY6U0zHlB2/AOMhSHZlAVJKwXxGg5qf6k/iDQ3hgUPi5cbEXtkZ7zSYbZGGBOm5qtokS8JeQWg0cMjBVCbuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PYAikddT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c8644aa3feso1710123b6e.1
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028424; x=1715633224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GrSWG1zN4/TUeRSVEKockQnd8AO73Op5RF+47BQPZ0=;
        b=PYAikddT2lklDZwIVvpqPIaVb0V7xMA1xjyEqKkPlTq9VKpvZs9XxAKMBMOvdprDC9
         r+/jTGYl3Te3sKeduj5rtjFg5qEwbmH3FXfe2bDOdwjBN7ElcFPd5TcjrdWqrLFbiqJ7
         jmyxbc47kLzU/J5ZogUYKhI8R/sW2z/0xgNyt72S0VfGt4BR5gpDZbofKxUCvUDhqUqS
         +un3wHesJyrv66WkvTg7kUApqIWcaOnwjfJMONa8+EF+dqNi0rq6Feaj3r7e6EJRSOdn
         CQ0qktto6EWxAjIVTIwUSAksYRGy5sOx06m6b9J/4TBB2Aooj6X+Np5AhyYayu+HUa8s
         ToHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028424; x=1715633224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GrSWG1zN4/TUeRSVEKockQnd8AO73Op5RF+47BQPZ0=;
        b=pgKTmv2iGhqqmhNIX5Ij6U88VAbzSRRlhqI5rrSWhRs3hVKoGMuh+mkDJriEHq7ww2
         9c0srEem1XjWTfNbUodWYv2L2mXIYPlVi7MlqYc8jKLgS53MxRKmaqX5iSMi5YAMlkNy
         khpc1klNopjV9raA+G9/Qz54adxkIWTCJEbHI/1T3mYIUGF7QdL5T1Y5iUlch/lCWdTT
         b84cS03X81ldnkLh5VTARG3RVWgoKZ9E6omiydHcz9Ac4EOCIq3f1dFrjJzwbhQkbQzO
         eagv349EtdQBylmzFh0IAUWF4UqSXLGEWHBtW6mhAVUv4pXKQ+vhlfFcH3q7SkytXcMB
         idtw==
X-Gm-Message-State: AOJu0Yy7N+UQ5oJCF6anbHiirN2iy6BIKOoRP/qA8eSlPxaq9xDXdgpk
	3mgTJxN97MAcPB+guY4Su74a97uItc5Gmg3RXh1GaEUzLNeUKoo/HNzp/l9BEYZmn1TenmdcNNA
	EoaY=
X-Google-Smtp-Source: AGHT+IGvUtaUU5nabDEn3y0Px6C6xZp6JDcd1d7GRM/ROhIM1cGX2OT+Gj4EokFmvnV1ccxYAKrZ1g==
X-Received: by 2002:aca:903:0:b0:3c9:6aa8:9f25 with SMTP id 3-20020aca0903000000b003c96aa89f25mr4916930oij.27.1715028424082;
        Mon, 06 May 2024 13:47:04 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id q27-20020a0568080a9b00b003c97843fad6sm232801oij.7.2024.05.06.13.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:47:03 -0700 (PDT)
Message-ID: <ff1189d7-afb3-4567-a8ce-627cf57f3690@baylibre.com>
Date: Mon, 6 May 2024 15:47:02 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: fix version format string" has been
 added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193025.272042-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193025.272042-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: fix version format string
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-fix-version-format-string.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.

(only fixes theoretical problem, not actual documented problem)


