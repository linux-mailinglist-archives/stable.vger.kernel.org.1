Return-Path: <stable+bounces-197620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CCC92989
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D572D4E369C
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD1285058;
	Fri, 28 Nov 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6QZuUNH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5526D4CA
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347804; cv=none; b=rMu6TyxfOK6NTsbDCO3ZmEBUB7LMRxqt/1DthCNT8IWbDkzK5Pe4dxJUBljP6DAHZMXZSrQAJPn3Ao2I6PQ7eGveeeKJBZ5IJ96JorsAUkelfObtzriy6E9coobj6a6AUp+mQ5Ahux3sSVF8U45gZLkhjR8u2bxT3WeH3d9pyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347804; c=relaxed/simple;
	bh=kr6XAX3GH731cjzi4VKnV2LtQU3uss0kHe5M8FyBSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjvwzqoRyHfbej6zCZ9tDzT9wuvlfa/BuEOwnBtv6poMmf0VM/hIzmwgVbdTF85dr0I++TmzA09Vi07L/bGsOa45+dVlBj97ZM/uvsBr0dLj1tgZloQDvsx0nFCpst6mTAwATxO7M8pP0YM0GIywW2ARO/058dKAUGuBZjArbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6QZuUNH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aad4823079so1822155b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764347800; x=1764952600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbNHKya0E2lKJwlLyC2FOZsBy0/KISJRow+SYNbETeQ=;
        b=S6QZuUNH05x8dMVLUFDVVU+AvVTOw9c1G12h9gQdwBB21OTYvyJEbHCOVhKXEb0ZSm
         QpBLMYsTWHVl2+mFViMdoi70u3A5Gtw7vFCV/8L8SsVx8BK4LJbjl+uXS4HgiiFo0AZX
         lC5lvFE6BYlK4gtL7w7hF9MdmveX8TpJ26sHP5AseIEhhXrW5vttNBRjNCPs4h4e8Hnv
         cCdBizhMWQ7hzIs0NHxnDC5Z7BVtLjn7mF+68N8Q4lJp2RLonojFBpKD9wrO0ZfQp1vk
         jDBZx30tsO5NX3S5XzSeY3+VOkpbbzH2h3EuhsIK1ZteYe61/p6nwfmqVBzoZYAWxEyJ
         paQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764347800; x=1764952600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbNHKya0E2lKJwlLyC2FOZsBy0/KISJRow+SYNbETeQ=;
        b=dKkjEzyNEB3o06nTJOK9bwMmUPz24ffvGbkGd8N/GwqFmmz069hIwEdKNB+V4ueD0V
         GOD961JTaMhTjOWTWkuOspz10Dm1ccPsdl37ClzjLjhVFroGJQZisPPuT7KfNzsCF5o+
         ZZVsWD68BT7lW8sPCufz4MHhXY04etTtMfZ2+TAgmmkujHkXUOxgAsqN8LxnaC5RrU+p
         StaFuKmAU4v4iGpxxFZYvRuBj0TbSDg0AYurXcFhr4DeNyXFp+3GQzs2nIAHcbm6qw/o
         ux8EH1o5hLqf8qwd7YyX+yFZjjVM/ZOlsJ9YoudOlKlyaY14dKcc9JGisv8pAWIv9C1w
         Gr9w==
X-Forwarded-Encrypted: i=1; AJvYcCUpA2kJ69gV1OeLAQc5KKDj/6IfLrEGSU0w8ssC2BmdCBUe0jvlVdLpDwc8YQR478JwPaYkXt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEQXn/zm9VfqvuXV3ZGbP2M8tEflBrdknNPBC6sykerxiVrwi
	ojW5/oc1akj/4tLMw81Wc7ueORjU+5wnimNRoXqpRGhZq+nV9L9Ayyle
X-Gm-Gg: ASbGnctmMlgLdVkopEPKdVCy4h64434/FqxSNo7v6sXWRScsCwvByDBT3BYtzhK93nk
	+px4Cp0h1EmTjT+BZppjpO2ryZTrBCG0G6SMGbXNGIxhVh1GuUYhgZklnXPfvIqpi7dxGMVYrIa
	32lzO0FeA526tXZQGm9IuAl+bA0PGlIoDTFT+vPirJwDOXO7aYfV+nudXOSvPwmvlDg7CfOpbPM
	fjQiTW2h/E82EdtBLCbf0eaMNLZzrkJh90Z2lEj/WHd3YA1t6fGL5VaEF1HyNeIxzE1qNmNQpNo
	7ShKsewHzi9Y9/zkUHIyiB4MP3q/ax+FVFxOM8hE4OZtVYLI4ccSxzxRqOiIaHmVUXBFfE7xhnA
	WE+t/qNpWy+pYcsaK7rDCClYAx2SL7u1hpWsmXQGh6tAUo6wZKUgDHEP5AqACcPzgXvzR9WKq/x
	9qLoJLN4V6LMctFUVZJGSIAF0=
X-Google-Smtp-Source: AGHT+IHDO0GdukXZKQcUx5DsNAW5rrV9c26FtcSfU7VQ9695O3cefK8NgHmf3K1rDez2TgCnIGzh3A==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr18511999c88.35.1764347799759;
        Fri, 28 Nov 2025 08:36:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm22692911c88.9.2025.11.28.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:36:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 28 Nov 2025 08:36:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max16065) Use local variable to avoid TOCTOU
Message-ID: <2fc6a617-3537-4c13-a8cb-1fbb79817319@roeck-us.net>
References: <20251128124709.3876-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128124709.3876-1-hanguidong02@gmail.com>

On Fri, Nov 28, 2025 at 08:47:09PM +0800, Gui-Dong Han wrote:
> In max16065_current_show, data->curr_sense is read twice: once for the
> error check and again for the calculation. Since
> i2c_smbus_read_byte_data returns negative error codes on failure, if the
> data changes to an error code between the check and the use, ADC_TO_CURR
> results in an incorrect calculation.
> 
> Read data->curr_sense into a local variable to ensure consistency. Note
> that data->curr_gain is constant and safe to access directly.
> 
> This aligns max16065_current_show with max16065_input_show, which
> already uses a local variable for the same reason.
> 
> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
> Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Applied.

Thanks,
Guenter

