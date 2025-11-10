Return-Path: <stable+bounces-192913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93AC4521F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895973AE917
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AA2E8E0E;
	Mon, 10 Nov 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Br9zEjbq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E3231A21
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757670; cv=none; b=s/enHrJ31/++Y9p4QVpDCjVGsq+9l5c/vNmGpibDaW2HzK/ollbb9wehYhZveESzDsQkc0dnWjaJou2lz4opii5Uw8u7pu2FEdT0NGwykykWJZhhc1569nhelJHbORjBiH6Cr5CiMv2DJ62UX1teghuS4dbOBO3+QSALgDNAWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757670; c=relaxed/simple;
	bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwwimwNbVpgDcdPVtIIfHIBzQyAI4Ff0cLvomKX1ge0VApOz9p5Lap6yp0IhlNivTX+urEq8/Noix8mPw8YhxyER3QC4B5IjP1U468U3b6KH/6xM3+1DmkmI4UsJnotaawXQ9d1k7QEZf6SOX1yLCaTgIpwRiaXOvwCL5kdhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Br9zEjbq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so139935f8f.1
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762757667; x=1763362467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
        b=Br9zEjbqG1VIXlTjsll9fsBldskDLAfNTuV9+BN4Ca7+rWfLJnxMPdqRYYoqX7aUld
         NihjEnrIk33vgYwHLVan4cBbh6YfThM+ToKjZB+HHhR6+l6XW9JmQtcIEYxlzNmA8Rci
         1QwQMgbvIE5GTs3iBPJ22QryrygoB2ZZcNYgKp8Hfc+0naI0PhCOdkBq3Hsvfi16qtH3
         MQjnBZa87Be3wg5tHSGbgwCq3rNt5ycRf/w6mxRcbhQ1oH5nnceIh83GdvQn093ZA2nH
         DsGEUHVKcK4QDVdWNagUX6d8EF1psPQUDATNQjRcCwgP3DkB84gHT5M+yT2z9qlU1MyE
         wdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757667; x=1763362467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
        b=w1C5SvG/158enrJO0wQg8H9OICx1Xzer+Jr6gG2uo7ip967iku/o2KmvjNjk9p3zay
         vb99wXVr1g+f4+yziisZP1AbcIir5AXYbIPiUvWnlLmcZR62CtS0f6qw3PklqRAYFnA4
         aug4G4PaSMzAy4boPwEdqcsWUCMcAQka1PHM9rPf6N0iR4onGyoMpawhf+i46LPF6rPM
         x/hzEhYRGPqND3VbPfFuON5fzu36nySR8NsQsqcEGgtzeQhlRVhBYtI2dToWpuKIe970
         nMTvHyYG8GUGVmNXxXti86VFg8vYhtxAj2OjjyMbnYJQuPlyGl+kdpezOnhP9hjg1peL
         jbvg==
X-Forwarded-Encrypted: i=1; AJvYcCUbHe+5jz6bjeu7erW8NG22cOuvu8Bh9G4gERJ9ndM7LWmOGevEm7e9fnSmjtQq4rDglEVpEdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1flkRs4avVZooSdwl8xgwdB49gIza/nzB8PaMQyDb4tv6rdlM
	FzVIBQ+jRPZR0AcTLppikqvHVYMcJxua5WOQVG0IGGg2b0DDHFIhNmLVDn5VAu3MYS8=
X-Gm-Gg: ASbGncuSqvAzuapPxUEytAe+pxqiQIr+GkK6Pbc9VbUNXY7EhbwR3Nk7jvSq+j4Y5F/
	lOuZpqMQ//8yMgJ6I4hfNnl3sSB4s/E6vnPQnj7vLUbWORDTKGM+ZLgr9hSL2WoV5bQlaJNIkoA
	7m3aqSpIDGujMYOfi+8+IQT34wbAlFzVbEJg+mprJ25HCcykRqJrhV8XQ2rpbRCBLpGwwD9dlB+
	/7wtP4l35UxkjAAjaf3w0GEH8GqhNfxguPM++rLtzjEftHUGVzKlUQawCqgo81pagCDr5O9mcVe
	opERJxk22fkjmIWEQc77BZUPViATMd3lhRnjUQjoq/ahx2GhM/CJTdLNr+Avzq/WJ+PNwWKz9HZ
	f0pa8Wn0kFnlEfs+htsLoXbqnlXrvI7Y5typpMh4OgALcVy6CvMXXLk+WwwfDxAFvQ610FnyS/q
	sGI5Cf5Zwg1Uvu8Uc/
X-Google-Smtp-Source: AGHT+IG87FW8xkI+HPhFc3NsIT1cI0tR3t1R9dpEVJouEeUSbLV2nxEXO/MYUxjy/6jIyUp7TqvHtw==
X-Received: by 2002:a05:6000:2a0c:b0:42b:3ee9:4772 with SMTP id ffacd0b85a97d-42b3ee96373mr151631f8f.52.1762757667400;
        Sun, 09 Nov 2025 22:54:27 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm19848370f8f.35.2025.11.09.22.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:54:26 -0800 (PST)
Message-ID: <c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
Date: Mon, 10 Nov 2025 08:54:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Hello,
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Miquel,

On 11/5/25 7:26 PM, Miquel Raynal wrote:
> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
> these chips is needed otherwise the block protection feature is not
> available. Everything else looks fine otherwise.

I'm glad to see this, you're an locking expert now :). Do you care to
extend the SPI NOR testing requirements [1] with steps on how to test the
locking? There's some testing proposed at [2], would you please check and
review it?

Thanks!
ta

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
[2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev/

