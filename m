Return-Path: <stable+bounces-126804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078FA720A5
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913D03B8675
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCF25332E;
	Wed, 26 Mar 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cVkb7Z2N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1219FA93;
	Wed, 26 Mar 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023909; cv=none; b=f4I9u6EyZ7b3X3gaEQ+DRSTq1o0cn4hk07JN+QLnuw6ZwfV558xDglXVgPZmY6Ji6XUbCDsL8mRvp0IVc5eskAX9A78kNxhoGaV8sjTC552uYcFZrw+ORNp7y72SB0lny//IpaX0xUt/eg1E4edxbn8HKF62nEfr9y0Sd3ko+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023909; c=relaxed/simple;
	bh=EtebjioKBAjwwkcdb6cdmvmGljQ7daTD04eDyBOVc+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZkqXBPmX53FYhFB5QAgYqKDZhUv1x1AMzn7k1BUiFFO0fBo9YzuVJI2fMnlHAcCjiHRc+ZaDTVxfj7HoDHtMbnmqE/CuJM4F21GYWXD3BuxWdw6rudfURB/6qxDUuc5YmnVUfGltM40VMcoFb9bo+gpjJ+bcsBAPYMxCnKWnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cVkb7Z2N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so2731585e9.3;
        Wed, 26 Mar 2025 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743023906; x=1743628706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5aDv4/p4YZ4hvd0+24OMdNG2SUNxl+JoR75kjs+xoo=;
        b=cVkb7Z2NjK262qDHkJyXTatzBUPLrhGuWC6o6S5jZB4B8Q81mxYJk6fj9l5ZHMEwZx
         v/uUYr0mWfEVBGpmC3kIPWt6OqERUhz0Qaqi5YAvbVZFkyS3tGdfMyobo2JLrhQZnK8Z
         lOY0onJLWLwsoHbozeiMRw/zwhW3QjBryovI8shBX3NwkrJ/HpyWs4XQgNL6VbvThIVQ
         813jDIen7COWMncNAvGTONs/TAZl0j4t7/rLMyTYFL0A24vVkaH1eJYlkrpvAsom1AG2
         44kv1pJYQmhrUMHrFsarD5TCOtuy9+x2NdELa7PwPH/Y84agamG73SOasgBQ3Hz86rh8
         bMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023906; x=1743628706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5aDv4/p4YZ4hvd0+24OMdNG2SUNxl+JoR75kjs+xoo=;
        b=CPK7gkgc+f4hyOU2PV8WsHh/gu+GNpawVdWqtPG7DJWOoellKf6QjUNau965TFyrVe
         laM4n2uGYWuXk/esPKm1jideNxOH+371EQWfHSTMGgyMqKCGkkd4c/Txyq4QefQrUl3p
         GGbR6YlvInK4sMFvWW6tNPPnsNhC3wvnCxgtWyQolsuW52uUwWhwI+lZIpHc6IlIus6z
         SKmDvR0xNFurYv6fi28AqIvgJBdyiPsEDckhX3cIHDJe3p0mx86FVEL0znt2f6zEVyIA
         XkSL0skqsinMWpXxmSnut94Cqf3c6Lzu+IwWLRfeKCyYEy1XLp+nbDBU+NNhu4ABvz9X
         KV+w==
X-Forwarded-Encrypted: i=1; AJvYcCV2H85DGlDBvPu2iFDPp9FpooW5iHmoMJVzYuVycMDnYeUmgb5+lPYpxZRJnqEpHBzXlm87uN5g@vger.kernel.org, AJvYcCWW8vOlgvWzWPbmkmrC8BqF4TvSf+2K6w9Dq8/m0ALXMjN2CIQBXEcIPNLVIKj+5HsPPqQXmyg8ZfJKzOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHYWDLNuXF29WXLxOsAbldTScgwCbNn7l+qTkbu2f+9OJJP8Z
	BX7qjhQ6X6wQL69WcNh++yAIJ1pZtvG+mcv2Ic0hNmHRfbqT5Z0=
X-Gm-Gg: ASbGncsFu1lwXBmm8oDGQxvzBE132MZJRm7FcmJBsz1xlHnxojFhTplypA75jMHkRFL
	3HYIyJgQl2hT4yZm7VG9aUOTJOIktdNUTlUp41u66uZxOaIw60IUU56GVB08FAHTBWiM4cAzSWC
	wPMsG/Ih/32qE3HBaL0ExYEBuAWFZjkq+IHUbFI2ZsrkeIZ4q/yH6NyYhQUjhJEPNUz+yXyUv/1
	PSZSiIHMGE2ytCZHIHhf9WKqcScdXYMeAr2Jh/kp2P7RauPs8cE1LijvqoHjwzwBvqRvz0LA3XR
	ur1J6AbvQwoyw9QEG1P+vIBOirwXSXV8698+MmFxfW2eZ56Zj8E4fBZCTyW2btd23Ajm/1ZpBfK
	CnC3Dlq8mx0qQ2oUQ3gSKI0OJ3tPnfpE=
X-Google-Smtp-Source: AGHT+IE5XCCVhPuBcalvEhMCh/Qrz+4i7AieIwvdyBLJ0b5CDmGEn9c22Xv5qXdYHR7I8Um+eZ+FYA==
X-Received: by 2002:a05:600c:4f44:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-43d85065900mr8185345e9.19.1743023906123;
        Wed, 26 Mar 2025 14:18:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a21.dip0.t-ipconnect.de. [91.5.122.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e834a5sm15499865e9.13.2025.03.26.14.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 14:18:25 -0700 (PDT)
Message-ID: <5d15f324-a848-42e4-a008-ad4b466ff841@googlemail.com>
Date: Wed, 26 Mar 2025 22:18:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/115] 6.12.21-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154546.724728617@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250326154546.724728617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.03.2025 um 16:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 115 patches in this series, all will be posted as a response
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

