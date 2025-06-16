Return-Path: <stable+bounces-152733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93737ADB942
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E233B46D5
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241A289838;
	Mon, 16 Jun 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB+0zJbI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DF2BEFF8;
	Mon, 16 Jun 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100483; cv=none; b=tOqd5GODyNlo2LDcpFhEKe2zkR/7a1AcjS2r5tI6z+3px+7tXnPs51K018xBV4AAFV++kgAgXdInaLsdcPl6hlbwjqHUkNEZjo03I2IM7lExDkJs4blumRMcs+yZABTpV0P2Ez0w9Gx3kNJkYmX6DN8hZ7P4aULYeOrkZ9EpTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100483; c=relaxed/simple;
	bh=8Najg4tKQDsS9h2EkDVSFDjNH5y1uQdsDakDwvA5AnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q57VUcLGLOxyRRFwsmJgencdgHuht5Z7DqRkMyT9yYwTy5YmYycDoTRfArL4/5ab9fpYtazGH1h0UbskUOKht+Bseegde/yLe/1bBBObcmd09CNAvjT4tzsZvxtU27AGAf9MtBSsUsbReHFWuJYjiXk8mu61365mvYCcKBcx2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB+0zJbI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3759053b3a.0;
        Mon, 16 Jun 2025 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750100481; x=1750705281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qP0MJeKCfnc+z8UUqm5xWvyGsPsKt0xCuAfIUgmUlC0=;
        b=jB+0zJbIfEOSCegiS5521LsMGFX7y/SsdPW92p1dfhVbUQbwVycaFF+YfgKkcXuc+t
         EMinbDZyTZDC5A5+5R8FaIyj/hnTnuHyXoFDHdsa84Hs8qV5MPRdA1wz5e6BCupLpLI2
         bPvjGzGJkPsky2624b6UlFlCVW6i4BQ3P9UfbVTqpz2F78PP9d8e7IEXOyEblqAYjDz2
         ugAZz45B8GktfFUbZi0dUxOhhMl+HG/iZx64v3hnEMMJIzc8x6U+OBp43iqLIk5OYy6Y
         Bo5pyOBPoavyQR84wKSuwOaHM6z9LvsvDWFqxb+y+V58O4bvpznbn3cM9Qz3y+4J2Vdw
         zggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100481; x=1750705281;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP0MJeKCfnc+z8UUqm5xWvyGsPsKt0xCuAfIUgmUlC0=;
        b=UJPuq20HqtOl0xQSsyl0aeM/fC5Frr6Cg2hPyRS3E3h/HPWqDM7q0Tg0/OTBHapl0o
         BswHG6mc1kixdrQy4muAiN1Gm3sPftYRJw88CNphC3SZUHlEW7ZzjxHhfQA6UB0wR74g
         McP0zf2op8JvUKmZvQSQocS0uyzYQx4Aj/8LFWLj5ZO1f59Ifi7IINbyDUZhmM6Bvdwx
         hsr67/FVrxn18QEl9VoXhS/l7DKkG74eQyTo8g9ykH6CoeIof95eePDPMZFWL7lYUf+i
         5UMGIUQBva3YGcoH+XicSKDnfZPlimqHZvbnpXv0+wW3igYMnSobnwCqBbXhtyNO6/Ez
         QcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwM2aoWaKlkpZr4x87w/qdY1kT8+3AX829kHqRskZb20zFrOSeFxsyaUM+muooFRSfbc9ts0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvUXB26eaewjAIqZQp4lzlM7nOXILD+wpv7/moKjxCVe832ke
	8Ae2SoUM4u57R6qGtzO861CQKdInXKYpTEK4e0YVfxeVopXl2vzN37c0EP2G1l1H
X-Gm-Gg: ASbGncvPG9wewGd4xvZpSnwGMvzhbTi5iOhHTLCsR3+vxX39KxbUMzm9WLfMrsKh3dF
	AYHasYQL7P3BsJHBWgDljGFtrfU32Ngb82N5qOJqOu0DH73MVZlecGRqS3RD89tVdDJqkXimPvy
	2v60kwKA4ljwwttuJiQHDiUaWd3rVi8UY+5r2N6OmDzdPRb1uZTenQGoCPwzsZffJxJwASGKOUV
	GLscEk9nqVsk43hPzt8ohXLK0mwMi08yshzJlL30n5kWUkbe1WmIXwgXIXRGQJMwl3fu4G8NN8c
	3A1Av+UdfwpquUwTbWA5QqXmcKrtyQElPdDSxlTafOzILogYtvcVqTWiUA9qeQxxw95UEr8Pay4
	Rrx2/oIHvMjUpPg==
X-Google-Smtp-Source: AGHT+IEDqw3PCa/dTNp6WKCgM0/H9W0uWXjW2E7ypDl1vD+Zi7CC7PHG3+B+KY277pQ7odyZij4GGQ==
X-Received: by 2002:a05:6a00:14c2:b0:748:2e1a:84e3 with SMTP id d2e1a72fcca58-7489ce0c6bbmr17257763b3a.8.1750100481093;
        Mon, 16 Jun 2025 12:01:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd29sm7212400b3a.31.2025.06.16.12.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 12:01:15 -0700 (PDT)
Message-ID: <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
Date: Mon, 16 Jun 2025 12:01:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tulip 21142 panic on physical link disconnect
To: Greg Chandler <chandleg@wizardsworks.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <385f2469f504dd293775d3c39affa979@wizardsworks.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 11:53, Greg Chandler wrote:
> 
> 
> I decided to test this again before I got sidetracked on my bigger issue.
> The kernel I repored this on was 6.12.12 on alpha, this is also that 
> same version, but with a make distclean, and just about every single 
> debug option turned on.
> 
> I left the last line of the kernel boot in this output as well, showing 
> "link beat good"
> 
> I pulled the plug and it happened again immediately.
> I waited 10 sec, and plugged it back in, and I do not get a "link up" 
> type message that I would expect to see.

I was not able to reproduce this on my Cobalt Qube2 with the link being 
UP and then pulling the cable unfortunately, I could try other things if 
you want me to.
-- 
Florian

