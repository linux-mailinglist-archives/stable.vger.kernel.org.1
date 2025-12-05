Return-Path: <stable+bounces-200114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1547CA6135
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 05:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23753319B6F9
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 04:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C32741AC;
	Fri,  5 Dec 2025 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT5KEUWm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F21F4CB3
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907380; cv=none; b=ZEzOjCINTS6BB7MofG1ycrqvgk9+ybFB+Stg5/66OVgkuS13CS0C0NBs+Ywx2qEaPv4FlDvpKzGxWZJzR8/bjz7OKWB/D1Vxuk5ha2YVLUf442bv3gjuFWT2UYzZlXlDZ1iNB73vJyR3yy9y2EO7vM0E5zl7VANS4Dk8XYvq3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907380; c=relaxed/simple;
	bh=v2f72S6WC3OgKeDBLfDdT93apuWtvOkHlHqzmDzoFNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvFEHuLZvT4bNYyjCfvAL4KdigO0DnBSahqT02O3Wd8xHhoJUojuJQzNS3QiJUZJr7Hd2lgQ9yQnmsxB4c7IpPwx7rQrMPmoWhLe4LbuAETvCFVs1tk0Xv1u1RsKDOb/W1uv1d2c7E0Y7SCzbFPXz/lgjEuUhD9YBFMuzPFnbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT5KEUWm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1465251b3a.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 20:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764907378; x=1765512178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4YLFHYaO1RuaqL4oQw18x4A8MtrlyjgwaPdq7ZKVVI=;
        b=dT5KEUWm/tAcwROe18z4NJpi0ML8xkVQCXLkZLaqhpV/nvWwcngx3MDirivE1o/b8s
         K/qokgvl6GmzSuZ9lAHzr35Tc1Vk11GPQCgo7c8nZJpv+BN/31QgqKefY3Iky0aScvVK
         wvijFitmRQCtlhIgF7Du5jv14BiBauUjWpIMNSA/uCMGY8Cz9jVtg29Knnqd9Npykshq
         Ejm5tV4qEm02PaLHG6+Yw6w8Os6cUc9svSB/T5YUN7O+dA3tjT8CjFad9a3kGpo+C8wh
         I0PPiYu7G7gY0l8YJHptqr4ad9VuhAnmSNYhhGsD183gaa++ab/mvX+kNcK+rzD4Ji80
         jrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764907378; x=1765512178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4YLFHYaO1RuaqL4oQw18x4A8MtrlyjgwaPdq7ZKVVI=;
        b=jJhHmfSFVvZ5T4sfNK8qQW1NncjuNza1/0kwlFZegN3k/Ui/3lOSdqAAqr9DbidTgd
         X5/oLF9kB5mWoB/x+1hco+EyIWNO7mUIL4SobUnlG2DqfCD6M/hP8IjjDVp9/EVUzY87
         EfkfwAmSoCxMOOdp3Ry92MFSjkVMyA8ZBifB/x7vuOY6lHteCuOlAn9r/0i/Clc1a5T8
         /km6u09LfqH5xWF4cwrgha/LP8eErfV/KKYdNbyHacwXYRBTmnsmcAvnZuVbhh3+nHbf
         Uqx8CtZ3CF5HBdu+/nxGtlHDxQgloBXSDGb77Zx9KdpRU3es4fbkcwVV61eO6Wq4CFcQ
         DYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe2LjG7isFyigssPCxYc0Fc7G0naItZPN7/OrcqbJ2IciAJUuPhBUCBXQ+B3G/rMnBkRtCAS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8Y9pKUXw+KGEi9mCbyXkbAWf70D7GNX9c72WSmThXFcnXZrB
	X8FDSUUaNrfYmGGsTYzPH71z0XuXxVlaIKJ/PW/4YuuqAR0svh4HZZRR
X-Gm-Gg: ASbGnct8f4TycXzlKpkxQahX8ao3pXNxSR7AI2tdKFmjHJetQDpOqrBCLsauneA59IP
	UdvHEP67pYAtEG+nglCoDzrCa0bw0D/I1X/omJE3Of3RFg/VqnnTMp7Hn6uS6ypekuwHyPojE+8
	keeVsL8EJLOQltUCjoR1vPE+GXPtzxfs33CZaZQf7MoVlQb1/dpitvXk1qC06ae9xKr+CcFJAu6
	BNzpGznZ8XqAiDZr16N6SRP4yLd3cSj9S6AcV08weBtbnmEiBtA3RFoDFz1fvjhR2Z97QWocNri
	We6iAffe9ecV/va0TEckEIJEjUY0YIl3+EBA4zno3Ya855zooIn8Yo/ACb4ApsKG+hKraRSViJr
	iYlC1BN2IyzuHqrA+arciacDiJGDrebf7yowXg/P52WK2LmB0JCHW2rzdd0KrmTX/E11BD63YLV
	jsstFtRBMRnpThA5ErWlNBdp9lh9hjqFju3w==
X-Google-Smtp-Source: AGHT+IHXAGXujCRF6rIxwM8aJ1WracKjtS2/TUVdygTygDYAdtAS1Iw877vhq37ZfiJWLSvsiX+qaw==
X-Received: by 2002:a05:6a21:32aa:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-3640387708dmr6434214637.43.1764907377601;
        Thu, 04 Dec 2025 20:02:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae032627sm3624503b3a.44.2025.12.04.20.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 20:02:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 20:02:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: m.hulsman@tudelft.nl, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83791d) Convert macros to functions to avoid
 TOCTOU
Message-ID: <695c582d-308f-4960-84fa-cbf6f08c909b@roeck-us.net>
References: <20251202180105.12842-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202180105.12842-1-hanguidong02@gmail.com>

On Wed, Dec 03, 2025 at 02:01:05AM +0800, Gui-Dong Han wrote:
> The macro FAN_FROM_REG evaluates its arguments multiple times. When used
> in lockless contexts involving shared driver data, this leads to
> Time-of-Check to Time-of-Use (TOCTOU) race conditions, potentially
> causing divide-by-zero errors.
> 
> Convert the macro to a static function. This guarantees that arguments
> are evaluated only once (pass-by-value), preventing the race
> conditions.
> 
> Additionally, in store_fan_div, move the calculation of the minimum
> limit inside the update lock. This ensures that the read-modify-write
> sequence operates on consistent data.
> 
> Adhere to the principle of minimal changes by only converting macros
> that evaluate arguments multiple times and are used in lockless
> contexts.
> 
> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
> Fixes: 9873964d6eb2 ("[PATCH] HWMON: w83791d: New hardware monitoring driver for the Winbond W83791D") 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Applied.

Thanks,
Guenter

