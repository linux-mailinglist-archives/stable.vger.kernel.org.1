Return-Path: <stable+bounces-98180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE89E2F42
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9905FB2E1F8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C21F7081;
	Tue,  3 Dec 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KBz/qKwZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39C1DDA3D;
	Tue,  3 Dec 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263781; cv=none; b=NnDzjd8chBGhSmX1k3Vh8zYYOR5cRr0l5gkBtm0qnsNbwY611KWW7jo2rM1fETedfl8eM8PG65rSeRH2IXEaS1JUnf74xZq6iDRIvtyw7oV3kCtkTAhPbv30vaTORxk5tgq/ZpDLgHKVWLPM1qiWJNKQq41a6SPp13UdHzjmWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263781; c=relaxed/simple;
	bh=+OI97RttOwWbVb6vhDaP2/G9TkHStlnAitmerH4Rprc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgY0DmwOupmocH/SBYy+PiJ1L8UqSpJLHntdYZbhkQ7EhZDR80LlFBLV1NL1PwRzIKNv8J01w4drRd9du+XBeizw6F1AH2qqRgKHjW48fzLOwkq5sIZT8VV7kb6XhN9gJxJxSU88zdVszeyz4ncMr0axr73zS+PHLfXJTCLSKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KBz/qKwZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385ea29eee1so2416077f8f.3;
        Tue, 03 Dec 2024 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733263778; x=1733868578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wq7RlqBqYTJgNcVGikdgd/6+YugmYFoD+v+g89HEvfY=;
        b=KBz/qKwZ3gK7tFo4NeI1KU5d6KcBOm96xug+nXAVfcJ4jUuWyvH3wo6JQbJHJDxkG+
         vgoTSsphPbg4sBAxBx6rRSGH7qFZW8mB/ozwGuxQJYnpIwaHCJ8/nhFbZnFuE7fvs1IE
         LUuFjljmpd2Of8HuVvUZQE0gl4sD0Bds4Mgido62SUj8kNmriS0pBjL/olYuqGUi7WIC
         8IiOg0LKgYqPhqna4XPELSeNwctHbfpPP/KLGk+bkCxMLhHJqlNrmw0oBq1ePG5ZRNQl
         VIhs+V2mI4JCVki0VCboCZnhXGs2WmG8lXe2rlRITL4rPIWbbu1h0S76qj7C8nY/l89h
         3vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263778; x=1733868578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wq7RlqBqYTJgNcVGikdgd/6+YugmYFoD+v+g89HEvfY=;
        b=duCpd2EnQDZ2t7pjFRSmrvBqPUdvxcbBiwjpEDypxHnEpgULun4Lwl/T64yIr1w2je
         vDWaVxTCPn5ujjVMVIvve6PoAFz49ZLMYFcplYb0r+5jMk6ImEqOmwXR0obtpwmTlX9q
         CyZCZwp9VQA/03UYia0DzkkuqfhS5NVvGOGsUxd5262HrSiuk80KhijITefdQMFMKGbf
         fqe3Ui5t5G1zwoqvrG+aw1eTtt1HEa3T9NNEe1tokTqzV1KPVK9va5H0Qnz8qV0yp8nZ
         kgytjrP2LTV2w3n/uMkl7lrvoBBSv0U2omPSR+XoTaORDOfscZ8k9R0L8xGmtmkLHUWB
         LL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnCFm4hiVQadvqBwQkns0QUnybiMAlgOx/v2I61rMKoOu72I1JVslUndwOxehlWrBfXzwXCXVagyyEhpU=@vger.kernel.org, AJvYcCWqYo7h/EHGpgtvkpTiY26rSWuq4OfL7cQhpw+dVRaH2pQ4WpgwTPdO3XXUoI5/Zzc66dzfMP9M@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsweabxx1nBXVGlnSmanarAcnbD+qNKoSkLyGhEE7vszpn425
	f8kErrYX8RFf1vkRlCFTbvATUCsXGqX6ARmel7w+Ni1Lec+srgM=
X-Gm-Gg: ASbGncsOEU6BID3Edl4TKGH4nNDCkLMjpggZlugmt6Lz/Bm9BGBU8lUKRpOyxrMYY65
	oAp6XRSf/PczvFuvwG9kInc1rfao8qpHASUaI2ryrEuWRoWcp7qtgKgHYmTp8eVw3ONLEs+GoR5
	X1GToxR6p7IvpJvfWFZR2u0jL+s1vnIBBJIrz8pJfx72xvM3QNu64xfyX3xowYx78xt+iKlgYwi
	qsNbG5XNJ8OXyVbOBanVQximSOlLYFhpXQze+qnfaKJekhHsV3bSkhVm6uQuGmIID54iTpjNCja
	SUXsjM6YFwrTO3p09Dh9UiGRlmM=
X-Google-Smtp-Source: AGHT+IFJgvZy0ng1MDxsWS2X4TUhHyqqMOIIIsx8jSXLNYBrh3HO5W77s7kYQIniZGNfqY1bA7ScPA==
X-Received: by 2002:a05:6000:4025:b0:385:f573:1f78 with SMTP id ffacd0b85a97d-385fd40ab50mr3841152f8f.24.1733263778334;
        Tue, 03 Dec 2024 14:09:38 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac059.dip0.t-ipconnect.de. [91.42.192.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm1426565e9.35.2024.12.03.14.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 14:09:36 -0800 (PST)
Message-ID: <04de8963-2d60-492b-afd7-4a271dae95ea@googlemail.com>
Date: Tue, 3 Dec 2024 23:09:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241203143955.605130076@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2024 um 15:32 schrieb Greg Kroah-Hartman:
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
> 
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
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

