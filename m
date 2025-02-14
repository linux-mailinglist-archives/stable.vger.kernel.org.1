Return-Path: <stable+bounces-116351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0DA35332
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 01:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FA83A4F1B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BDC8C7;
	Fri, 14 Feb 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BAa5G0IU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382851FC3;
	Fri, 14 Feb 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494076; cv=none; b=QCLfoieJz1o2fZkRKZoCIYchKXTI7K2ZBUouDx5WE/6Hmo96d+7tqhZstNqD+p0pPz6QgFN1JmplSQXCarnQdL5D0KCzZNlvqP22zXiEt0zUjjhZdxra8+ZF08pl6LtFQVhN+5mgXIaXHUNBSGYFtcMFTDhPRuJO52yi12HxmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494076; c=relaxed/simple;
	bh=t8P3tZaQxu3mQlHu1ICaIX21HqUXbzlMLNshFSmQ/Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7vl/agGL71rC09tWWk5apsT1+NDCgxcjQbcXHY6bacOjZ6ECAXi+UQNTjnt6YkzVG54CCeAlZgkiJxc8fYgkQoghxN2TVsWaoNzGQvKf0DdDv7z/agU54S9/ittrXEsE9TnrvGflbk+GRRvD2T0+jCQCws4d9BYCGe76ymT2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BAa5G0IU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1020389f8f.0;
        Thu, 13 Feb 2025 16:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739494073; x=1740098873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=terIPvdWa1fSylHgnwuIdhWYMuV0yExm2ENY3Z+tYgI=;
        b=BAa5G0IU5objHvyS0n1uLMSFoiOjKB0RZIyh9GoJO9INRIGgXzOGo74TMMPgep3/GU
         YhpIMLH6KmC1+33j39sT/REZTLf9Kw12ZekVhm9iJIjJAtYlOgxgXEVSxYRdr9l9IlUK
         NRQyTMUeVmo7ZXHoe8nwkmKaWcCmhYAtkUOzJABzYTEZSoqwpgMLBrtv7g9gJz9y6rYY
         PdpohVPS0mGvOG71TlFsOEy2Xy2EmQTwfqxllab6BfxWYQfG2TuMdQ81WxeGB7+kxXr6
         7v8+uTGpPfaIhuZtuOTH5OWOhPJAEgCBsOxCUTG1F5SnzmYmMl9koV3T6HeR9mVC00n/
         C3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494073; x=1740098873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=terIPvdWa1fSylHgnwuIdhWYMuV0yExm2ENY3Z+tYgI=;
        b=TJcLA9KQuYnT7qscqKNK9OVz/Ek3vRXDrkZ48JAOheerqIrLiB/5iC6wtyLDma0TKD
         /BYSzZ1pMW4YhNwKmLLl7ucX5hxMx3F2w252oWS279jsL4cVhnOoqTVNQp6S3Atw2iSs
         FWTDfIkXvE6GRDG/KL5yJhmlJvRd07pZPAISH6eClXdLbKL0ovR9TjO2NvasjniDjCAe
         olvzR9vGzcdT37Yzih5MZLBXV8IRNg8h42ZomsEA7wcvDolHT0g3G4eEQ0AYiIOsxtQw
         1UB3EKWBKF2aJL2pOFFgGfcYM+/Bl5DNFtzp0RkFuSIJRzpmRYEFq34AjavFFthcAKgq
         11Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUprdNjoB0hj5dq/AA4ibGGUfavLfqXSemQsgoMsbq1HYU0meVZ1IuC06+O+1rSEWogJllH7Qj1@vger.kernel.org, AJvYcCWNFPzaTLrsmIIMzWrOfqo/gEwNI8KhoCg2Qx/tS1Y3LWanWN5P8VzJ5Qiq5RzryLrfhDYF5gMgqpgqWak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeE4jRoVpXk/GmFuiMzSGm+/4yywuGlnRUSB/DXfya2CFU2qb
	2Nvss04r5npZt2Z7dcXmVr+tPlJb1iQV+yK2McpCb/WdiSZnJ8Y=
X-Gm-Gg: ASbGncuGayl9TMUzLFYXtuqL9JK1uQQ9W/OCxwaP+qZh1f9yDI5mNsRkZtzBBaRQ70k
	H7aO2D31rLXQPJyrp+7PzZbAGttK84C1MlMOe/Kl8cR7Lk02+0z5QdIXodaGuhe3lN3EAobohe7
	vbjUmeqAmwHWo13miQ9JaoIGne7Y1VQYxqdusIi6m0RXdLBXEuyqy/OpKb46b6v78kRvLXaY5kd
	MMrFYJNGTnySb9KBQQ3y0R3EOdT6GfQEjglJL4Lt+OPB4QJTTiGLl2w8vjPVJdG04cTF1sxYeFI
	RimZ6SzpNF/yOjttJ557Hq+XAFqW5hGK+0CM5riFl6gXhx2qD5dQWUwhtNA8QuRzvtmi
X-Google-Smtp-Source: AGHT+IEv3hJWqhg4cLIRV0joUfQfZVf2QbqCq9tySua4HLVAtEybpZVVKs0jk8uNSOvxRlm1HNaTzg==
X-Received: by 2002:a05:6000:1a8e:b0:38f:2a84:7542 with SMTP id ffacd0b85a97d-38f2a847693mr2946055f8f.28.1739494073222;
        Thu, 13 Feb 2025 16:47:53 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4779.dip0.t-ipconnect.de. [91.43.71.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913eb6sm3226913f8f.51.2025.02.13.16.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 16:47:51 -0800 (PST)
Message-ID: <7ce031ee-c9e0-4e52-8151-265dd3ef1637@googlemail.com>
Date: Fri, 14 Feb 2025 01:47:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/273] 6.6.78-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142407.354217048@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 15:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.78 release.
> There are 273 patches in this series, all will be posted as a response
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

