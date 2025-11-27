Return-Path: <stable+bounces-197512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77647C8F722
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 079C2350F00
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C889332EB4;
	Thu, 27 Nov 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNdwRw+L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2F3370F5
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259728; cv=none; b=YBstWk4ftuH8WOiznKS2NXySoZyEyLa8b2zDQQqcko4ME57LDtwUUKFG3ZL8vBwB5z7i2T49K1wcmVoHxa3Pc/ogngm3KtSMV0l4/RmC3Go87aP0wohT2I0pbvsgo9bpMck7Lq9ZVskKFSx2/jjNbScNfsjnfWMPAx6wckyQ3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259728; c=relaxed/simple;
	bh=ta5nvtkAvSEQ0YgT7d6P/ibBZiqxnWaoK6Psv3QiXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMcLSu10b7ulrVQ0zN0GgsAwJXCvXjM9fjGVa/WwjhmRrqeCyboBqdJyFBQFxn+SV9juOLQINH376dg2bWO8uslpYVgLpkgj65ytOJurwOs94THMJOSM4cnWWSvZOJYqrfLezZ4nMYQv9Ocd1GXc4i74Gxa7GKkinGIIHdMCLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNdwRw+L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso635815a12.3
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259723; x=1764864523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8go5ngYUd73cjKuDGIyMFUa6ctvuEnzg99jFKgPO6g=;
        b=KNdwRw+LMlyITikDE03NnFBTKHvy+xLI3xhIaAY4EhkZ+fZKQYcZYMDZGv2ZgXqcyK
         RG1LCX3fKrSU7OXfEKIdMUpdH7BD+m+lfinMODZV1emmVxskBJuP5+5G03+IGxD1RVAe
         jp5cnHjktpDCCqluaTvnvJDJbHuOOkN7/WaDLpSczfmDuEFG7nW+/gQyfrWNXMTQ6Q5S
         UUWHMC0OvmSVglvrl4oskkARsBvugl3IWt+A/9YiAL4pBnYGtmQsy5jh03fHPSUiEdTx
         FQ0K+EX2X3GMFYe/N+nvARoomXOItfsEiLdOvyzv/YnquuEORCRmvJSMeHTk/ErFvCMH
         Pm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259723; x=1764864523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8go5ngYUd73cjKuDGIyMFUa6ctvuEnzg99jFKgPO6g=;
        b=lRL99cAyfVQcnV207Fllv4yL9fiFw9WJhHrI1pTeEBZpQz/7oPEeO4McunefjZFtAQ
         A9cH4FH19PwDP6YiMMOZNZvusUrt90f9ldGf2cK0t8Xbldw6TWhW2c5h3C4QY68RXf9R
         HsM8tYksvPg3nYjsp7mNntDy4RplZYu+pS9O8jTyEvJx8BeHi0wUmcucnSw9RXm4+1xr
         Ho8yae80/PTG44S/CpE1Qj6ew+6mg4et+j7t21Vbbr9HuPepqBSEyDRCZ+FIiXhA5qDB
         J7e4aEbxlJACvjke572GJjlv7VBv9RolNyDlqqmZU30rh1ixOHz1zp7tU5x4TyS+dEWT
         hsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf8spDfQODigKOCjlUIo5D28NpJKexy6+ryxgXzUUpwpDOBsNrzGDllhn0eYVjPXYfKalylmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydl2u4ApAS+SFOgHHbPy+T0Jaur9qBKdmLKdUA1swdT8arTj9R
	n9sPoETkSYct4PypLawbXqQtGPVIwOO/a/juMQilpFgF5PsCZ8148jXG
X-Gm-Gg: ASbGncv8o5QqVKD4Z6/DuWWRjZdwVYzsBp1kIqNVwQl1x2P5bxeMowL2tRuhmnYVZLg
	2UjFLOMDuHRZbPD26diqIf4RG5/I6dg3iNEnmYrCzVRH3qd/XpMzow7hiRd83vacJXXQGrkGzBu
	jpUCs0wPb4ogyVYPkGRCmCg4qdjzTC5ZLZROA/HCCEBFdoDYTQRaRv80isDsnRUvsaf/zMOi36E
	SpeVME8D+6Kc/0HXBGM1OHzu7Bji3zI35fQ9ycQVZqiZUilF7kznVk+VQM0BYVFh2l4VkP26xtU
	1QOOFu0DcLm1VrJJ3U8bcBWd0MVW4fdyB9TDi2QshveAAeh7Zqa7UDF7dU6in0vFJ5uYl+tUTj/
	z8p8j0pLOa4AEWTPVYJW1yRir9sJDnU39+fAfKQnLy+xHebolbMNraJhD3Vn5ZAJtOLtoGsAY81
	3YTMf1oDt5ULCSFhHo7rP4swU=
X-Google-Smtp-Source: AGHT+IGNzEBkzLWPObgUvVK78LZO7aewF+H131l8nSXj2T2UBjAmy+ewdhC6bKVn3L6oihLw1wQohg==
X-Received: by 2002:a05:7301:dd98:b0:2a6:9ea0:6db with SMTP id 5a478bee46e88-2a719fb9759mr10317934eec.28.1764259722530;
        Thu, 27 Nov 2025 08:08:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm7617756eec.6.2025.11.27.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:08:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Nov 2025 08:08:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Johan Hovold <johan@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max6697) fix regmap leak on probe failure
Message-ID: <e837ac90-5d2f-4c58-9d76-d2076ef52f1d@roeck-us.net>
References: <20251127134351.1585-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134351.1585-1-johan@kernel.org>

On Thu, Nov 27, 2025 at 02:43:51PM +0100, Johan Hovold wrote:
> The i2c regmap allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 3a2a8cc3fe24 ("hwmon: (max6697) Convert to use regmap")
> Cc: stable@vger.kernel.org	# 6.12
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied.

Thanks,
Guenter

