Return-Path: <stable+bounces-163441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F0B0B204
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 23:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1013B80F4
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8822689C;
	Sat, 19 Jul 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8h3Qka5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04C21CC60;
	Sat, 19 Jul 2025 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962316; cv=none; b=KhqPiOWjpUkUQtB+JIb1CkSzHsoGLM1iG7CL5+b53/oCkAa078qhVqmWRSFiQqTJ3USqhfTxHp+ZjqqXSZkPxNz0iS4G4w85vHEbUtAd5qyhe40nq3Q3BCGBWD4OapvAIi4Uc1zqy2v/nqmxic9Ji9OXybzHGIuebUqDu2Eg33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962316; c=relaxed/simple;
	bh=ijItil8V62O2kVUtC26QEXdBMLktypTb3rG3Iru+Z7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRqvBcf0PgRNd7NOm9IyANTzBQ7K824JZitbvY6Eg+EN24XTXemGDEENI65v9/BuuhwhtsCDP25cvFMDjlG3uNKfbxmWA8YPsqtw4B6I5HmqBr6nvuhVy/E/4zcGqFhigyL/VyXwFUMoaikhqdFziO0lvn5bgSLSrsrvEGsJrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8h3Qka5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75bd436d970so127707b3a.3;
        Sat, 19 Jul 2025 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962314; x=1753567114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPrj2roU+BdR8kXOg9jpXmZzV43hAStF4vi0GsTae64=;
        b=N8h3Qka5VP0UKJSXph3qW6sjeeP6D4lQ733jjbuQLy/cZ38NEH2if+34J3YqumsvD9
         GMl3win5o3ToB1V20F5dgsnjUalih2lsTNzCtMU5RTcPnnxjN7nv7Ozs7rUmz5t5fawV
         fyYm0hkh2SED7V0n6bDWFINCnPI39jXE/QLtIaL/4yqGfUumdUA75UFPhSGrtlPf5CMd
         iqfYQRwvf2xjRkOpW8fa0Dn+k6yOmiDLMGvUFitSUouuEG3WmVDwUdNuGTVtmWcO8M8e
         ICzoh3cXurAz8qPMR4I3D2zDz9kfH+rNeGY2vhFvRFcArBzighfrUd3KTHvY8/7juz6P
         HW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962314; x=1753567114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPrj2roU+BdR8kXOg9jpXmZzV43hAStF4vi0GsTae64=;
        b=eZglSfLmQnxQqGGedcGN1xPknW6zyb/MS6YyxbtMKMEeMUfMo9CGYGRVfU3qUKBOzF
         ccPXXTxGbkLiucLSkho8V5Rk11bPYFwaO4rIDiNDOyOf13IK6Sj9x/xE0MnceSOP6JBV
         /mdEHF4zbOe0uzjq6/ZNzzsgnLFx0b4564GUf09zfTAeMCJBAEyhwUR67Zc3yljqmqjF
         7qwLdaqtkMLZlz0wRT3FZkg/KfmKLCVDdSGUm8yCaUMtc1vKspdYA4U22vQTtVtdTpVw
         it49d3w1f3/ImeAKLQE25vioFmWLhdkIPwzPSaaPn23wrcPAI6S2skUmuPTyAksg6m7S
         sMxw==
X-Forwarded-Encrypted: i=1; AJvYcCUYb7tqH3LdUMrm89y3W/SEQtSM6FsbEOE/OyPoraqfyWw5OZ1RgVn+TvPFcGMRFPIFfnxtgvX6@vger.kernel.org, AJvYcCVLVi8itjIa6Xe474onxHL2iHqAdlnG7O2cEHHdX/U3SYvpaCI31iHE5+CGhdzI6v+EC2bxLFoI8lj/fg==@vger.kernel.org, AJvYcCWjT066gpE/rpU36xad9Sp/7cRI8FumYXMvQ5Lf82SLFZMCKI/3fgsoPHzFztJinNbcBaph+Dwsle4sg+Qr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkDjve95cn4fWp7AU52O/3JlJ3ybyzTS7QCKD39kyXoQfFIZj
	3oqiMD42NV+s2GeshNuoHTSPi9ovL2LzJpKHB+pe8DeIBIWfZkNKJof7
X-Gm-Gg: ASbGnctYPKK88Y1Jp2HJh5Y5XQ/xDrIOinJYKcBV8kFOu6+nQnTXpwkcFRqYl9ew8WP
	/ga37au2fZgEpSrx/hFeTOoSEkM3/cPxLWzSnD9Ap2RSA1F5dTuIYXVvsltyHBcorf21Tbu1oyd
	rZju6fwwh8RrpjRMNMJS+fbNQs5aRxMTLGk8JXnLGBSd3KB+y1r0NjNl6v7h+Dobur30333b0G2
	/rMC+GZ6gmEPS6DMWRpciSwQ+6oDI78o4COnKjBZTGYYJhlIgvwmow9Eeqg9QMTsBu3u6lmeoed
	mZDh22D+J9HCJA761yMDxvJf91Rj2b7+apcIAkMEjKH1I6QI7qQ0TiE05rgCXBVH6MZUVZgQoZC
	7RtmDCD+27K45c6ofoUtek6/9qpVQ7bHro+w=
X-Google-Smtp-Source: AGHT+IHMXiqi0F8pzkYB1crNV/L8f7gosSFBqJflURAh463jF+uee7gA1PpkIYraE/5mn+AOQ/XCkQ==
X-Received: by 2002:a05:6a00:3ccc:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7571f911982mr21889437b3a.0.1752962313597;
        Sat, 19 Jul 2025 14:58:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e27a8sm3313815b3a.21.2025.07.19.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:58:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 19 Jul 2025 14:58:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gsc-hwmon) fix fan pwm setpoint show functions
Message-ID: <10e92428-b233-4c7a-b762-36980ce104e0@roeck-us.net>
References: <20250718200259.1840792-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718200259.1840792-1-tharvey@gateworks.com>

On Fri, Jul 18, 2025 at 01:02:59PM -0700, Tim Harvey wrote:
> The Linux hwmon sysfs API values for pwmX_auto_pointY_pwm represent an
> integer value between 0 (0%) to 255 (100%) and the pwmX_auto_pointY_temp
> represent millidegrees Celcius.
> 
> Commit a6d80df47ee2 ("hwmon: (gsc-hwmon) fix fan pwm temperature
> scaling") properly addressed the incorrect scaling in the
> pwm_auto_point_temp_store implementation but erroneously scaled
> the pwm_auto_point_pwm_show (pwm value) instead of the
> pwm_auto_point_temp_show (temp value) resulting in:
>  # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_pwm
>  25500
>  # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_temp
>  4500
> 
> Fix the scaling of these attributes:
>  # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_pwm
>  255
>  # cat /sys/class/hwmon/hwmon0/pwm1_auto_point6_temp
>  45000
> 
> Fixes: a6d80df47ee2 ("hwmon: (gsc-hwmon) fix fan pwm temperature scaling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied.

Thanks,
Guenter

