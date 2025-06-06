Return-Path: <stable+bounces-151619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956DAD032E
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FD6189E8F7
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9F288C9A;
	Fri,  6 Jun 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4YzpGvl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D4433AC;
	Fri,  6 Jun 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216500; cv=none; b=b1rCbjb2U/3CORzmh/9flZcNCvlGE+IVInTjbAjM2J4xmS+bgMVuOgMzI0pMyjodWUoO0pJgB+CBf4iN/2wb5rm8tCuLkymTkLMyUiTzZqwMiCnY4WKhiWEAgX3dECuz/KptAF3+I2VmB8pT0BCTH8+Q9LwR8BZEzW5ylNGn71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216500; c=relaxed/simple;
	bh=lStWFN05KBUEosEhtBYZ9ONh/8t5JOiGDv2syrsmQe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4GmtXNeKCVcXJE1kWB+Aqf+PRCg16a0yyiFR26D6Jrg6/4oSEn9XI7LozlgWa4hf7yWp8JiSl9X1TfLD9Okqw2jDJhL4D6Fa07ZQour/6Y598NzGplXGYQTjMPUZqSL/NKkRBPbB64DA5shqGk1z5GflzQ/b4wsTpRRimJsbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4YzpGvl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234d366e5f2so25580015ad.1;
        Fri, 06 Jun 2025 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749216497; x=1749821297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTegNuqrzt3gKagTIOaKfGpBHiW0UAiaKMfj1a7uVEs=;
        b=A4YzpGvlbKN2k7RnY7DikQVAae2JxfLdB8dMCVjTxeTAzqKzDybEq8s2LA7BtWJQYf
         Bj1e2kP1I3tJcfPdMt1zvxqtRt8u4KpQ7y8cbBRlM1wA8kpIdjIyluW93WtISdJj801h
         jiR5McvyylRAd6Fk46g6KJX8LZ2i1eaAFsfxs9XLCpuh72oLadJDbKWMZlab8goxW7Xd
         7AEeewT3mZOZDfcp2dWQ+0EycPSVpMUvpM06IhbtxbhfkSY41WMM5rOrdUS4CPzCNT2o
         mMZwnpX5mNXdq/dSellELlK44jqVKxckoOri+kcTTEYIj6Flq5FE9U3t6Su0S26C00BY
         L8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749216497; x=1749821297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTegNuqrzt3gKagTIOaKfGpBHiW0UAiaKMfj1a7uVEs=;
        b=PCPfh2JSbFTiAWuRVTNMNJbkCJS76uSRajYlbbr/hl13yAdYQVfFGabsUfxA2DuDXB
         mxc3HCXHiT3v8DWeDiVJ53IK4ogRTzElNIfzFAI7UUTp3wSi3zs0Yg/gb5+6hvO+yct8
         hZOXTvGnUFNcaFr0ez5FqpTb5B5dWEDpn17cATBYU129W+GSY9+aoL1U0Af+oZkwfOZb
         /DRHFxeI3K0pvqE99o1HxOGmK3IKMVr8h6hYGgQ0vi88qkMi0/qRZQEWi/Nx4ggGDe69
         PFC1LBa9OqWuq0BtewOx/ySVUo684nPi5kFtpZ4jZCcikfD4yNl8F7Tku/46yoExhO/2
         hV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIBEMElSkysdbETNNwF1vfp1sza9f+O+ePRsAXiAluMHPuFjA8YbuVT2jcd761dCgfPSGrfGoL@vger.kernel.org, AJvYcCWgs2tS4DLivFxGkIDVTbq+mPs6m2Ah6uZslkSVCGiFbEXX4LAVFXvkAaGcJn6PDBiThUhib01K3ua1zA==@vger.kernel.org, AJvYcCXIgw5h5o0mVAsMh1hwVEnH/3prCeFn5rYzOayeWj1h8kOB5y9aVsRT/Pu9N2aHJxzEBeLpmi7O2iOqkE9m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IJu0HfBlclvlnLl04tJ/LnDnYPhzPdqMOBfkvLq95k+yVugx
	1wHcI5Zng25ytuBYJqRnL9+F/oHDzHATnxJoytL0HMI6DHJYfFTX+vn2
X-Gm-Gg: ASbGncvf5QagD+V/NwUN0XuUa2nn1KLSu51m/lQJcnz0/lYYoomtA2H6fI4jh1syqew
	HazqYnDk/M/VAprHEt/SyQadv97xFJSJPXKGCp3wbhvRpDICCB7AF8yZASNdeKaIafricaNf2Nr
	Y2mpENT5mrydR5vPmy+5dnnDZrDd/E8K7CvYI6oWezu+SuIWvC/BvLojqzmj8CI1I+gmGtZETrd
	RtLjBPfELt6DSL1RZiz8bv9hom2hE//sqWCigcYmAVQAJ6K7TwB5+e0ET9PVO3Wkhzh6mNCtCtk
	j9tbEag7WJdXQX8/qpoKjyc6vLuxjwTnW/Z1PXuePitS6XvwG8EN1BlX65xEbHHzDtg61aNVMWQ
	=
X-Google-Smtp-Source: AGHT+IHE8g080vlp+6jRvIwvEJW60lAMP7cUpeAu9+WDcZPbdxQ6k42dMYN4XsYp4WIx1kOYxtI9IA==
X-Received: by 2002:a17:902:e80d:b0:235:e96b:191c with SMTP id d9443c01a7336-23601d25bcbmr50342415ad.29.1749216497128;
        Fri, 06 Jun 2025 06:28:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcf2esm12172135ad.123.2025.06.06.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 06:28:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Jun 2025 06:28:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ftsteutates) Fix TOCTOU race in fts_read()
Message-ID: <98f33209-be61-4a5f-8f0d-41f6570f79dc@roeck-us.net>
References: <20250606071640.501262-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606071640.501262-1-hanguidong02@gmail.com>

On Fri, Jun 06, 2025 at 07:16:40AM +0000, Gui-Dong Han wrote:
> In the fts_read() function, when handling hwmon_pwm_auto_channels_temp,
> the code accesses the shared variable data->fan_source[channel] twice
> without holding any locks. It is first checked against
> FTS_FAN_SOURCE_INVALID, and if the check passes, it is read again
> when used as an argument to the BIT() macro.
> 
> This creates a Time-of-Check to Time-of-Use (TOCTOU) race condition.
> Another thread executing fts_update_device() can modify the value of
> data->fan_source[channel] between the check and its use. If the value
> is changed to FTS_FAN_SOURCE_INVALID (0xff) during this window, the
> BIT() macro will be called with a large shift value (BIT(255)).
> A bit shift by a value greater than or equal to the type width is
> undefined behavior and can lead to a crash or incorrect values being
> returned to userspace.
> 
> Fix this by reading data->fan_source[channel] into a local variable
> once, eliminating the race condition. Additionally, add a bounds check
> to ensure the value is less than BITS_PER_LONG before passing it to
> the BIT() macro, making the code more robust against undefined behavior.
> 
> This possible bug was found by an experimental static analysis tool
> developed by our team.
> 
> Fixes: 1c5759d8ce05 ("hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Applied.

Thanks,
Guenter

