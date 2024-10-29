Return-Path: <stable+bounces-89166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D399B41E7
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 06:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43961F23473
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965A1FF5F8;
	Tue, 29 Oct 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWFR4vZi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A0F9D6
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730180983; cv=none; b=j167oFVEmwBSx3WjtWBieQ6oIl3NGFSBcxxACrOR1e8yLgF8/xF5pVu8LKZlYF70TcdlzWLRde4FbQ6asRnCYsm3JEqOaxxVNZAZ3OZbpzsQ0Ywj3cgKFQ0K1OXvZWdgbTpNfCaCW99vjtL/5NFCLASWqeU0vz8qCg+25X3zZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730180983; c=relaxed/simple;
	bh=Es8hoM0wCVIAY+xbAmHxI7UFoeOOID5OnPG6VpFFJ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUd4vCysWUaX7s8nz00S9/zBAvf/1jBnmfsGmQL/2cYsM+hxraHeLq0d1P6skhx0uQWSLkcuTNsylBJxXcvqLD2rjryZAdhG+lDVGI8VTIfEKKm4nN3SiYWG6xwRWK0440uFCHGmqd3JyXiFAFR0qREwqj5Wn+9CCNVnbDOTtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aWFR4vZi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so48737565e9.2
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730180980; x=1730785780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pt0suJj9UTxdOe9+QxV4pWlo6QxMg6iy+rjgzc4UzU0=;
        b=aWFR4vZiz+UeGElN52GXDsg7elsVAXGVhmG3/Sp7ElD2927dddsA+9HbkqZmo2hb0x
         eFr1sbv9oHxC92flOE2pEK1emU2m2tw1knRXVBM+kdeDW5otoz/mZD9LiTK1AsrFbP8F
         G87i0BFIF1bRIXVnLscpM+ZLXRDlYMc9tkdtF88t23APUWT717107pmSISATXTUoHilD
         gFk5WM8PBI/OyNTuXLJjXLUs7PcGRJJfgBihIJRVIVev2ZR+yr3r19UCjwxMlu6KelrF
         S3hq69UhcIrsO4kvwqVuEW9y6wTswqtyHqAOAr/hF6Bf3yxbkUA7ApsOL9MbeI+e35oD
         yI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730180980; x=1730785780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pt0suJj9UTxdOe9+QxV4pWlo6QxMg6iy+rjgzc4UzU0=;
        b=hw6fkCGB5ebmP9FKLW+CJn+bkcND7RUYQhV38wCk6c1BYe77gqgbHITjsRH3KPve1j
         XlZ6LLKeWfpHcJuroaFM+euD0hbYZKANnLwOTd70fqgfaQDc6lSfEeBfLRWQbfjlXgL0
         d3K9zQhK159irM5VSmlHRuPvXJttV8wpxZQJMr1jQwKcuwkXv12V3IW0McluCPzZJaMd
         ZjRtwGyb1ylDynwoT1iwpMlmHeMOfhUwz8PdzXmPqUBFlQ24QPrK6A+4QZPPx5lMn2Yy
         9OwJ/81DCrdxM0Ife/3Vb0x3UvUEbsIklKQSNfI/2Af6jpIirwHFhFmlCOkdM8TrribK
         lK6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPWPiWaZljPixyhoGklcDUw0kU52WoJcSqruuZ17qdLeqCsZEUfbnj3j2V3ptIWbqU9hObIIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpj0cW9k2Yuwm2Bm8DyQ4a7o6DcOd2LqZfM1VIK14YWuXl3db
	chjY3t2d8ThGw9I3zzvzMNDnbfYAn3q29Tgq8skylUK09Hz6FzNyBVDPkrOLsB4=
X-Google-Smtp-Source: AGHT+IGuT1xAiYX2tXlbcoOT0DJ64wdwC0/QfJ14trCsK/rfn4Xk7t/kxXKMzUBsrX/ohCU75OCarg==
X-Received: by 2002:a5d:6082:0:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-38061122a87mr7469459f8f.19.1730180979674;
        Mon, 28 Oct 2024 22:49:39 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70f25sm11561128f8f.67.2024.10.28.22.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 22:49:38 -0700 (PDT)
Message-ID: <73d7174a-90e8-45ff-8c2b-56c45e9ded48@linaro.org>
Date: Tue, 29 Oct 2024 05:49:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
To: Linus Walleij <linus.walleij@linaro.org>,
 Russell Senior <russell@personaltelco.net>, stable@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>, Hartmut Birr <e9hack@gmail.com>,
 Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>
References: <20241028-v6-6-v1-1-991446d71bb7@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241028-v6-6-v1-1-991446d71bb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Thanks Linus for taking care of this!

On 10/28/24 11:44 AM, Linus Walleij wrote:
> From: Michael Walle <mwalle@kernel.org>
> 

nit:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
says we *must* note the upstream commit ID with a separate line above
the commit text like this:

```commit <sha1> upstream.```
or alternatively:
```[ Upstream commit <sha1> ]```

With this addressed:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
> again.
> 
> We add the additional flags for dual and quad read because they have
> been reported to work properly by Hartmut using both older and newer
> versions of this flash, the similar flashes with 64Mbit and 256Mbit
> already have these flags and because it will (luckily) trigger our
> legacy SFDP parsing, so newer versions with SFDP support will still get
> the parameters from the SFDP tables.
> 
> This was applied to mainline as
> commit e49b2731c396 ("mtd: spi-nor: winbond: fix w25q128 regression")

invalid sha1, it must have been: d35df77707bf5ae1221b5ba1c8a88cf4fcdd4901

Cheers,
ta

