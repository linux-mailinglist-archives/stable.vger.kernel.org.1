Return-Path: <stable+bounces-160240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B30AF9DEF
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545FC4A228F
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913C2749E0;
	Sat,  5 Jul 2025 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R+udOw0j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9A27465B;
	Sat,  5 Jul 2025 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751683711; cv=none; b=TBaHV6gzlVlyHOQvDzbCLWc//q0LXBFsYhMlvXrBJH6GvIqvMl9cmFSrnvpln7uwsQpolRFMOi4ioXHOqPCU7I5YaPACYW9LHSV19QhqBCi/87un7cIj5VJK9Hfz5gDAZAiJeciAxVDpdsL+aztXT1dc2MhLgzx63TxqH9ZaMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751683711; c=relaxed/simple;
	bh=imfFZyMuzBbs0QEQxdBQnbPOZu4GObvS+2QnEyp8plE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS//URA0r4Tae0HJbbBX1JaphNdX/RZ8LX3t+zlfvsPr3ql5W18OPCK66HToMexRlc5s92Ka6WcOwM+zXCjQt7EgYrpVShxyga0xxUHh7C/cyhO4/lpK06J3BU+RqOU0u4b1Qtk97Pxob1hRVJpJNpafOTBgPA32Wzh0mxegtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R+udOw0j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so12747115e9.3;
        Fri, 04 Jul 2025 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751683708; x=1752288508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FTc1lp2knc8DjUqKz98FvcZs+AiwQeeISv5z2me7ls=;
        b=R+udOw0jxYpHaymBAbuv+GoNpCBVAp327+7DgkIRihzY1ya4iqHugRGH8JSYBHFtMt
         yW9/VHZkpqMwcI0hyp1JGU0zX6mwhZztlwkZAkq4SffbvR+3P9ml9k9D58ucudUxz776
         YC4UN9uvNoh7rir4jbf/BSp70n0Y4Qf2n7UXsot6kk++lPuoYRSyroTGPFJ/qNWR3xOl
         Zr7HV31d8qVAZvyWmtnvaZFzQ9uZy42wypV378X0/r7G4Tt5PMCHNnnT4FnVUwSMcW7+
         f8HpYVF7rT2WrVB3lHIg8AiWjZp0WLGu2srIsY4U/k+uSJJ29IzWZRjS6ye8myeLBJPn
         kUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751683708; x=1752288508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FTc1lp2knc8DjUqKz98FvcZs+AiwQeeISv5z2me7ls=;
        b=IRR9mzAOL1tkK+URKbTsEtq9LqfuT0nEyF39Az8rx16sTVQ2BNxhuXkixVKvKus57h
         Xwni/pJCAXn/lHsjD4JYc+s1dfX6SsRew4pgVbzPshHBTcJ1x6Fhkt6R1/q/0TLbWD/m
         O5lh4649wymIzo+nhcLZ8IRvXwvxhxSpUQ3GbJt9ocj6yxf60rs1tkzqONEfuhoKqZK5
         pmgiUSY70LWb8mmwwdaZZBN069uXiu1DjgcYediWGSC3+8c8iHItPagSDTFKl6Ws2gtK
         RImZ13ZSSUQGkwRebmfRnMh+ewPBnT8v91UxQoj+5LijOT6kvGLqap0MqGIUYAmMuE0s
         19Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUkazIl5QkbrYwm9dCwW3vyU+F4ltktrNICsr8y2LJH0nvQopvnyYU/OtNjPPl6R2wrC2HxPqix@vger.kernel.org, AJvYcCVKU+EtUrhkV1zZS3R+BcGoOwQEdMcC5QXU/rAGh5Q3mnKl4FDx2ULnMCpTC5jKy1u9VUQBO6L7j4IKejA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVf4UxG5qZUSByHSJlCV24wFOLgBaDlf7h0dkEcIprTrO5b6iY
	O+DurSgISlHOfv6FwzjfqX9rgnMGr2y43RTPl/+sL9QMFt9kGoJjo6Y=
X-Gm-Gg: ASbGncvu/Fg7eQET1G1CBJCxXRHsRasNMIha5C/IbnoR68dAByaFDQXlAVbL22pajL5
	tRfSufste5LXmHMiQoI6vBK5xQZNXaG6rTk/KFPXW21vHuGu39fluCkAtHPGCce/ZThT/AnWEVB
	2hs3LaJnriQGyy1Wucka9QgG8gyBOHv7BMxbHF3Fv7sOgTMoNskw91Ws6k99rEHj80BZXDPXkVN
	IIP+cETeI8h5WcZMc6c/LDT+Nu8Qom9MYdSkkdG1aDU5M3H9xw25jvES+duzvReKViPuCv6jQmG
	fIImj+1x3bPOBbEy0dGFrubaV1NkGJnG2lpUc3qKASW17/C8MIOGQxUmBbRP6vyrw6iRnXnlhpH
	/Xi5FppExZnyUjmgebikHWtIr2IKvPFYAiG8i0hs=
X-Google-Smtp-Source: AGHT+IHcOyBgdFMIsBgcKMgtcgz+vJMHffGBz9giYBlh30rL1aBDoJtL5y4XRqZbTLHnuYIV18H7jw==
X-Received: by 2002:a05:600c:4ed0:b0:453:9bf:6f7c with SMTP id 5b1f17b1804b1-454b4e76919mr44490545e9.9.1751683707630;
        Fri, 04 Jul 2025 19:48:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570c7.dip0.t-ipconnect.de. [91.5.112.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966cbsm3836740f8f.49.2025.07.04.19.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 19:48:25 -0700 (PDT)
Message-ID: <0259106b-cafa-42cb-8af3-85bac6b628c3@googlemail.com>
Date: Sat, 5 Jul 2025 04:48:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143941.182414597@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.07.2025 um 16:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.96 release.
> There are 139 patches in this series, all will be posted as a response
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

