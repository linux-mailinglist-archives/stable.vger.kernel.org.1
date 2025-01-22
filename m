Return-Path: <stable+bounces-110104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B9A18C78
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C2B3AB162
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747B1B4F25;
	Wed, 22 Jan 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf/EmdUN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB414F9F9;
	Wed, 22 Jan 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529201; cv=none; b=cmNgWN8UsXhl4zOwRs5bscVBp/XXoqVGRKi0DU8JWUWRYckKCF25gSN5G4Zd5MwPB+Bw+ua/s2o+5T+9oVDgZJ82LV6yv2Bz3uH8hnSbDf87gJL223M8Q2/FamnZxJ3bFE6tlpOOYNmIuwdwGQYaxWxlJ9sJF4tiupTXk0P3u3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529201; c=relaxed/simple;
	bh=Qac9ZsyKN9zy2Kv2WAAPDqc3jak3MQY2mUqOwW5HBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk6xmRU9Bv4TR1EG71UR7NgARJ0A6WZ/eZYEx9mRmcQMrUS/en69xvOwhaAKcydBRHHgJhhZyDyic1acc4gd7byFmiV0jJARJZMaOMDFNwPK0T6DhPVuXxEvrLJ77BRvVdlSurjbXmpjSREHHzBdKXqJQvJXZTgn/jD8/xOjhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf/EmdUN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43621d27adeso44461045e9.2;
        Tue, 21 Jan 2025 22:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737529197; x=1738133997; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Yibl1DTsw5hMa93yGIy606M41eaMPfp8i87nVBP6k=;
        b=Jf/EmdUN6LvCKTav1MO2unrNwSvD5YnlVDY8l+3u/gvvyEmpKxBZx0f6Uzw88STYTN
         mQbRqAIz1IQbtU0Nm6kUbJjqGdTEA7b+9OfEOTVWIk/6mbaUEOnEo7MoEpI1tg22rGnf
         +9c3MX4UPwAY0DDMnlnr8t8pRmooD+2PgmSnyy82nrHuWVq9CeOaaPLrzC4mPEGgNGLm
         uAJ1qkziFsxa0NXVIBOE7pKYT15ktfgXIrUx0emvmg+zX/aQ9CDuno+HvLAUsKSFlQoc
         +FaPT6YqY/dQCTLnm7/VwZDY9sa5eXerLLTW9C5OOOiRLBnP0hS1R3ZtpyqLbLwTYutt
         NK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529197; x=1738133997;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3Yibl1DTsw5hMa93yGIy606M41eaMPfp8i87nVBP6k=;
        b=ppCFEN/Kyc7acJkoXYy7bETYOB6v6QPIDvhYluDKe64Nz29blvSfULBrg6I/bzO7p2
         aayAz92yIBrieGNSn2VQVZNf+Kyh4eV7xHe145aGpMEE0OjnKMDJxnAbbQRsuBr4alvO
         jfqgBCqWLeHSciWcv6etRzhp005K2+0Fgs9m/JYFvz/dSkfAI1N1+T3ukhCeyETOwduG
         3zrJDpUN2HWoe3JLAETME/TUK6hRR0ctNqyPWbbSwDXNQNTsbDne2Fh6RmiEhFf8FCxh
         UL80ds7XYLDhuC9X0fb7ITFX2wBbXqeHZDMXWYWQoQT/j+VyGGk5UTouZ1wh5fD+VM53
         8rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzwOEJvw2lhAgZcZ/YBn+MvDC1kiJ46H1P4JFn/woOkbZZHQYaRyAo3r7OFxscudhNUvWKi11A@vger.kernel.org, AJvYcCVnyeAzBimtgVlx/tUqpdcydNM0hFWvnLN89Y3x/GeoqTQ2iFaeOvLQqBGDKI2P1jSImWG63TZXtTlhlOw=@vger.kernel.org, AJvYcCWqoyKeQJyZblkcNHS6fA5KcGvSUpB43eJcXv1IyQBnW9lyVCGkJwSXLvXbbaV3smjBNEBexHWv@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxKBwxv+p7ngreaSnmz7Emf67HWcUDogDjKwbzJPHotx4tFoc
	a2tPcHNrfC6EUM0M4vc8res7g+MYcgNLSEunC59Pa7Dm96Okkdeo
X-Gm-Gg: ASbGncs+cXKGXiJerZMU1XKll774BGtipcGE3y5cfpjUmeIWTIAprsysoHwTnmQDmCm
	t0khFWmI+QWgbXAKuIdIeC27IIZ/RX2fdnfxjC5tp9TOVAzFHGqOZXHbZ/oJsD+91y4xVLunsFO
	yEGN6sdkclI2MJtWb7KmwS3i4aFd6aQ2rS0+kD3Ii3th4vRxHay+6BHJOQPTg28qKyX4F7ddmx7
	bHYxxzw3sfofL8hcnKODQJdtIffoWBldUbWKY/zcunnzO1lw8krp+RSeATiUjR+6CSUxjcY
X-Google-Smtp-Source: AGHT+IHTeVqdKFv/mqmajh9ZY75b/iR/e1QnWbOpmYFTnjck1LwK4oWXUoWipA6IBNTcWFUpES2ENA==
X-Received: by 2002:a05:6000:1a8c:b0:38a:888c:6786 with SMTP id ffacd0b85a97d-38bf57c063fmr18594600f8f.52.1737529197200;
        Tue, 21 Jan 2025 22:59:57 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b5asm15158131f8f.21.2025.01.21.22.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:59:56 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 55A0E5A003F; Wed, 22 Jan 2025 09:59:55 +0300 (MSK)
Date: Wed, 22 Jan 2025 09:59:55 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <Z5CXa0HAhdNo22Gk@grain>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Jan 21, 2025 at 11:41:24PM +0100, Thomas Weiﬂschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> Plumb the compat_ioctl callback through 'struct posix_clock_operations'
> and handle the different ioctls cmds in the new ptp_compat_ioctl().
> 
> Using compat_ptr_ioctl is not possible.
> For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
> it would corrupt the argument 0x80000000, aka BIT(31) to zero.
> 
> Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thanks, Thomas!

