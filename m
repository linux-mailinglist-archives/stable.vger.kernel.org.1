Return-Path: <stable+bounces-179593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB07B56DCE
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB633A3FEE
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 01:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A31E521E;
	Mon, 15 Sep 2025 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFu+ld37"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F31D54FA
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899324; cv=none; b=jI64zyKwTZzbbyUBq2U3zsfuEjsENkL5KX7UiBmBClcBscNL/i1uczGnIdQtg/PQm8fMgufspdv7pLHG+6xfJadmHU8T27LzLYr3Xoe0xVZL4FwF6u7RwkIAdd5eGiLORDSt+pku3I9q2DlkU3RgmVeEZ+8XYG7ugaBJR7aMWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899324; c=relaxed/simple;
	bh=AjKw6PEaz3BcGdiBDSwiRmCOJqo1nibhkDfGdbCSQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKXxUzKCkcSObUMxor6n/p3lyOr4+j9ygW/pzjtGwSLXgrb8r5p+gp/mCy1NOAcnYr2WP19sYFmeLEvgUKwaFGDR3yjqNtGhpzKmXCyJcYHsMyFO3FBLvuBHa/PurJZKR1oBnoIBJlDVUDXoc2QYnUG/IztjkjmUg7zAP9Yzgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFu+ld37; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso1807294a12.2
        for <stable@vger.kernel.org>; Sun, 14 Sep 2025 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757899321; x=1758504121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhrGXtUHP77SSFf0UteGZvmmtOiRSwSPGvsy3hAXYxc=;
        b=BFu+ld37nf9FiKKQ7L0kPWRxYjbvyGCD3ZtEzdQD+JC6IzI7iwx9dKe9MCmOMP4SQt
         kOVyrxfAX3viK0oQE3n3Jew44Bb/iH4+gMbV67PGNarxLKP7wAgwpku1r4JqHcvwugBh
         MDCj85GMjKDrtyfWACDh2HAps5ka2ZMAECN1eiU8MIIjbUgFy6wTKFVmbuRZtUrVJnOs
         MPVL4BVVj88nreLwMJxUyLO2mCCSQW5WwTyXCtvJeHE4r6dVpWDLzpjGpeWTugOTSvoL
         6N4hdEHjN/TK+gqEvvZ4WcX4Pv0c0m3gx9piZWua19iHPVtRF0CCmBiWGcvNCu4oDSIV
         E9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899321; x=1758504121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhrGXtUHP77SSFf0UteGZvmmtOiRSwSPGvsy3hAXYxc=;
        b=BY8L0L9FHSIEvU8w0Ali+2Lxmo6NHe8IfCjPFm1Ho2xoshw/UE6kzNYHWNV90rq9uw
         8jja2JYyHwAa4PlBBHddMLWqjgLmUYd7W0FgrMMP2OkQKWkOhQOpCWJxChZEQnA6RUCO
         FMXhtB39KpEERMQyTuOVvv8EfN8j6fgkO8JoPrvlN7/RfbdFhfHCqbKfucWdt3I8DA9g
         WrvW35qLgt376xTe9KKvr4y0kJHJ/+7dT8cJS0VHCyk0OO2kRq1OFnq4486ALVq9y/LG
         Pe4dSrw/tjds5yQlmjziwDwY6tBebISk7L5CUCm1pjZFwx9quqtod5oQc+TRe2Zoeui3
         Cn0g==
X-Forwarded-Encrypted: i=1; AJvYcCX2bJnfO3MN3+kUfwH3lUD9PH4QATCY013Bc+7BtD5/1/JB/FvLE1jXL+BmnJDKE7tfBFYFZc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzafrm7WURynIX4OtrEmOIJkju1HDC7eYDqpiU09BrPjQSTJlrb
	bYZfDG2KCNz74m1qd7Jw7vnUK6puAbE/VJCvHxcTH+qj2RK7hBdR847j
X-Gm-Gg: ASbGnctkmmLpgAkdWEd+I9iG+1841klf+q6XhhMCgRVRfwIN6XML/10/fgHr0cUQRq9
	3sOGNYCIRNiqnIaMqv2ij0RCH87or8gch0J89Q3G4t+mKpSPMwmmxrPFJksWYMk7crUiQAU6aCQ
	/JEgpbvKa4lP0edTVCcWcjEyMrjsRTLvfnvIqCMM0cLN763TmXNyzhG0CKBP5SFW0XxcmbMCYTg
	FG4K1G35XZJOCWrezgMBEZxaBGOnJZVPs4VyRIk46a7Tp0I6+sby2qtYwRn0BUGPhKUKBvuZP8n
	kjr0JZZSDWIt13pCbY1vam/K9kAeUGLN75fRt47P0TFtIp+CJL76Xp+wwCxN7AUgjEibESecNlu
	G3n9xcoo32WHhEdsEL/jJWw==
X-Google-Smtp-Source: AGHT+IF7cZF4LyNOq8KLkkPfU+soq4VEFgYqOlZpq0rovEoiTKXGjy1E/ebjq0srKeY/xi5pzGFAvg==
X-Received: by 2002:a05:6a21:e082:b0:262:8bce:33e4 with SMTP id adf61e73a8af0-2628bce3f27mr5200250637.20.1757899321383;
        Sun, 14 Sep 2025 18:22:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:aa7d:7a2:2fd7:5bae])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa9234sm10446429a12.54.2025.09.14.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:22:00 -0700 (PDT)
Date: Sun, 14 Sep 2025 18:21:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Extend software-node support to support
 secondary software-nodes
Message-ID: <kpoek6bs3rea4fl6b4h55grmsykw2zw2j6kohu3aijlabjngyc@7fbnoon3ilhw>
References: <20250913184309.81881-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913184309.81881-1-hansg@kernel.org>

Hi Hans,

On Sat, Sep 13, 2025 at 08:43:09PM +0200, Hans de Goede wrote:
> When a software-node gets added to a device which already has another
> fwnode as primary node it will become the secondary fwnode for that
> device.
> 
> Currently if a software-node with GPIO properties ends up as the secondary
> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
> 
> Add a check to gpiod_find_by_fwnode() to try a software-node lookup on
> the secondary fwnode if the GPIO was not found in the primary fwnode.

Thanks for catching this. I think it would be better if we added
handling of the secondary node to gpiod_find_and_request(). This way the
fallback will work for all kind of combinations, even if secondary node
happens to be an OF or ACPI one.

Thanks.

-- 
Dmitry

