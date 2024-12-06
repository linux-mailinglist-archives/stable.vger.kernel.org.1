Return-Path: <stable+bounces-100009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C079E7D0E
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF91B16D44B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451231FF7B7;
	Fri,  6 Dec 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SSYE5Tm6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC81F3D48;
	Fri,  6 Dec 2024 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733529501; cv=none; b=qKF7AP2yOKrCfIky1O2S4tXE++oRezaSWkwz9l07TwJi7HV4Lx9U2QDk1rOMDnUgERKCoyx/Q+y8BYkl9lLGTwCqOiczhc80s1vASh6Oi2YbJ8kgF1G0oRtTJH8wybjQLja6Zoe0RpNw952L6ZYlOwmmY1rV8e3eAH+hthxtCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733529501; c=relaxed/simple;
	bh=NP4LB1TdrbwYoE/qGnK6kqxraStnmXD2ZB0lHgcUg8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EevxqQK7srr/ADrlg17utMYqlz8OdBnL0lCxwG65N0hI6Vi0F6mfz/2dSgdOxdVVR9HNRpY0gkiiZ6/q5MzbONpayYQdNu00mjpAtzTTCsJCyVPc42skcPbOubO+3D5U5pW0LpGhom73xnWQki2G1/tsWwvkDwRdv6J4mO3G07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SSYE5Tm6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a044dce2so29126465e9.2;
        Fri, 06 Dec 2024 15:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733529498; x=1734134298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joUDrwCiOf41zwhP9RpIICtMQhuen0a1v3beKVMGZQ8=;
        b=SSYE5Tm6C/akoZYxI1TA/gbB3a/3V3VLB6OsFzAA13jKK+CLBNjHbfWvXbNNQfvYXn
         lGpgDge5yBTqBf/jG0gFSZ0ouClLLf8LXH5fUkB74UW4tACPlx3NS6Cn7ZnNEqB9ppZX
         8c/e+M8LrAyhJoJAS9xsJAgb6MfARn1txpo/Vshy+cab46IF1Z0kHIe+c0WBnbsOoshW
         7Ssodz1LLpg1Zpsec5yXubIi83Lbzd3Ljwxu8+U12YyGVXC8H5cJ3KFFlBgGh/a8tq+T
         fyIueGd1iKo9r6qNwN2WPFzYlabG8AY1pWN7SXmapKjvFo3cDv+aaQudmDB0n2tjVaqq
         mIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733529498; x=1734134298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joUDrwCiOf41zwhP9RpIICtMQhuen0a1v3beKVMGZQ8=;
        b=mF34e+2XFy1VL4KgxBYFLolvD5INqzABSl0N7+UBCcpWx0SAv0TbkyIMU7i3bbBsMA
         rot8lt1REVhp8nnJBxMSl04lDAUD/d+1U2Nn3ltxC8BP5gRIVsTBmq6A7Sxt1P9IEMWt
         ytVMu+ClLgOmJktGFC8I0qdygwAn96UdixD3HkV4ZcxIvDNYtZOMT2TNp0w9xdeim8c+
         +7EE888YkCtLX2BIPXBGAcofrsbtMPfcpHft943em0W09ESLImSGr8isegx5mEW2jjOu
         hf9ONx2ltiR7yWWSb5iaATFMlOvJlzLozOUfcMPYtfZavAFyUChydGVoFmlPsxkjSvmQ
         lT5g==
X-Forwarded-Encrypted: i=1; AJvYcCU4U09FNVyseDgSpBcCnmpAhfoopmcl7kGRfffLx/QFFQo0sZOzR0YyaXT/XTKUgElsBMS7KTju@vger.kernel.org, AJvYcCW+soG9DYH9vsaojuFCiL+CPfrdCw3hXmh3owJ3D7N1v85rY937DP91I7Wz1nW4wxYUv75G+E5U9QJJ92U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyZgVbSnuZcJkrpAYHcBoO1SdW4JbPcOB9bOfhefIITSTN2BC
	1Fwan3DUVy185jBoDCTyHS7jNuMScnMUkP8J0ckQR3xDkhvTDrU=
X-Gm-Gg: ASbGnctvJNvdovTYFwSZycZHtfa0tIOXtvpBVW4lKW63/jaWaPyNe+eKbvE3JfOMP38
	cD1QVES2OmGH4HQIAwNau8qMOGjlgPWi4CQAFsMTCYN6nRaVE7Ihmh9/Y+hEVMsj/tPe6P/MQJm
	X+2XuveRf2lIwnvceQVKpTm5TsNstfKAPyWvFBdLfLCBBsS7nrhNCjhoeGsb9R68xIYpQKcLOWF
	MLjnyU8GwmxOf9zHWS29DMlMHMZRUiA4mA8s69v/Ya+s+cU8OJeu1+VilFnUosAmBTNN9ML6F4d
	oarxvK6Ub3Mv4jDLKPFwSce8aw==
X-Google-Smtp-Source: AGHT+IFPmPx0Suf2weJBJcMcRL2iILyN9EfWHl/6GUyqeSE1eZlDPG8bTqZUZM0ji+1N6Jg7lfCWIA==
X-Received: by 2002:a05:600c:a45:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-434dded8234mr43416955e9.22.1733529497395;
        Fri, 06 Dec 2024 15:58:17 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e5c.dip0.t-ipconnect.de. [91.43.78.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527eeedsm105792745e9.19.2024.12.06.15.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:58:15 -0800 (PST)
Message-ID: <b5887a1a-169a-4772-879b-fc4934acaf32@googlemail.com>
Date: Sat, 7 Dec 2024 00:58:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/146] 6.12.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241206143527.654980698@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.12.2024 um 15:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.4 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

