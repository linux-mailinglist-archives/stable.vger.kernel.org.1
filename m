Return-Path: <stable+bounces-158415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998EAE67CA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC61177068
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24462C3274;
	Tue, 24 Jun 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dryjPqWP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06922C325C;
	Tue, 24 Jun 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773923; cv=none; b=F75Sm4FPyul8AxcO7Kv6pIeal1uBvXt08WEcJF1sjB8q/D0u8Xdbm3ecviusMvUynRhkfbhKebltpruliJSBkiEqUbs+K1Q1L2g5REHxyGcsRyL5tzxOdzzbmfBY5GW8Psmz1SS0COrrNyte419GFH2zKzPruJnkUbRlkybokhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773923; c=relaxed/simple;
	bh=UYfKJQ51OoSjFVpevUegxoGdWXjPksTuWKqp9qi80xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBhQpouD4YK8hTWfnfI1s6T/X7HEQxQuk6lZ+UXgxPkSxNYiiF04hn29M1fJMsZbqlwpwud7w4/cYdqt21GyCIal40Rd3j7P1mY2En93ABjZ9DZEgEH6z6HELj7tP3KPxilvP8G+x5RPhKdgYUNwkcTSBFOEg1Z0J0bZYximvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dryjPqWP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso42307315e9.2;
        Tue, 24 Jun 2025 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750773920; x=1751378720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVx9bXJz85X0AIi8dirAE5yJh02zKPnSukKA5bbFUzw=;
        b=dryjPqWP2RGyOBQWD4HnMKXEFcuZ1aI1s1BOefc1Z11hB3y/3+fQt5WYTWEmM7D23U
         Ebl4Xz9HmR3AK+MEZace9v59pueUf8ccHugrA0pBGPT0Zpyk9dx37CqJjVW3O4Cq3GtJ
         Ui2SwQ1bVfW8gIk6VotaH8/sexC3qW26pkmUugc5JGKgl88n5CpF9vyGBDZymMJ28YHd
         zyKvlbIhpNKbcb47pn5D4EEgenaDhgMnoN2acz5UbJ32/+PK7y3vf2MSj7PzplaxffPx
         oXTpceIIyV+kokiMBuXQnpu20qKEmjYqYJQkY6Vjpv8lq3TYA5F5wef8zdZxL6iGX0gm
         Y+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773920; x=1751378720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVx9bXJz85X0AIi8dirAE5yJh02zKPnSukKA5bbFUzw=;
        b=qna3JvrvjMiAM6b209/aAHWPkKPbKFjeznKtyR5gkrZJXGaXhgVCL/hEFXyQdIQCUV
         9lAAjSv0rOrpwH3cWrhX71+nbJ5JI1lSk9HaenYYkVqa696v38F2zTtWXPHzPhI0LqnJ
         mYlJWaessox+RQ+xf/pPly4n3vinpmauO7W5aNutaQK+9zoYxmLDxHH2lNXmF1Nuo9Hv
         C05LjEli2uhLeiAGYHfj+f97yh5IQgvu7dnvD+AnPyrnZ5VMJeR2JQp5+0iWNZdEv/tF
         RkLXO5urSP9ahT0FcutgRT8JwrLyG/MPg2kczvNTfyK1F9KwxNxnk0hxJQuGQyod8rmv
         wLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIL20konTL/8m7NiOlI5cmap4dhMo/SC+rRkcKRXc9mO7wfVmjHj3M3wHtwGmM9TIvoP5xKeMd@vger.kernel.org, AJvYcCULKcOUWqwcGCB6okUYGuOqu9OCXhEURTvP8wr5RxWRDfv6dmVDiyoaSUKAC294RusNtL6/PppAZMFS7Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxOfrVkPeoD9JnkFcg3wMecwkeJGfUco7rhVUAo3qAsa3hSR7
	L70V8WFIV/jk4QKYDW0fEF4fSOnnGEhzBYbv3P7Lqx178csZF6kr2ZSc9Il+
X-Gm-Gg: ASbGncsY5wD3efsBLgnHvaKenss3xvxwKhnIE32IvXox63yn3eomNniO8TQhpaigx9X
	n/oepn2C2Y5xF+iUvCuwcFvxK31Um2MvtmMIIollkc50Kn+jicVt65prhCsVvea1oix5MVKKVbC
	VyjYv7tQwFdSvh/PiAv4T1yf6J7FU/dY8SrfsYDNtidY/7eknWpYgxtSOD+rZSRvC+qP3YjiSgd
	BDej5CqyT68wQtrLGIo3bRMcRvU2gvMTr6qlWRZ7v3hinfqdLKIj7UVRz2ZqD/YZyYSAfIkZ+zF
	u1hJZWhP4TI3P2LxthW7rkqbNE8bTLXSlPwA7B2GJaidFjimm1UqBbOvaDJGmAPWhVZwHvmSmCE
	xC2FJdsxs+9k3Q2R9J8YhN3f/v4SUxRPmRyUgEokwwtZ74Zm8Ag==
X-Google-Smtp-Source: AGHT+IGhXZo8PwUG9MrPe6dDrnuEQWtmRJwqiIufEElS1kyj8cQPQUPS7ezdg1sIivOdFytqMzSeUw==
X-Received: by 2002:a05:600c:c168:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-4536c253eecmr120228145e9.14.1750773919591;
        Tue, 24 Jun 2025 07:05:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd47.dip0.t-ipconnect.de. [91.42.205.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e19sm176599485e9.21.2025.06.24.07.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:05:18 -0700 (PDT)
Message-ID: <02261e8e-324a-4332-86d2-0fb7c04d93ae@googlemail.com>
Date: Tue, 24 Jun 2025 16:05:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/588] 6.15.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121449.136416081@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250624121449.136416081@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.2025 um 14:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 588 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

