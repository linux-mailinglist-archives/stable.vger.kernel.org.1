Return-Path: <stable+bounces-121339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33DA55DCD
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 03:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC333B3C46
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17A185920;
	Fri,  7 Mar 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y00GW0tU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1213C9A3;
	Fri,  7 Mar 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315403; cv=none; b=fQBujGeA0Sv3YV/ozyttvD/PikoAydPeR66RZbzR9llo2YUucDUZNoyo6mTWBXu6rE3rpKEtux1lpHW417wuJ+BKtFnXz1QvUBO61+wF67do9u6BgVFTYCHyE5Eb0AZnXIpmRB8SfeKa4fkMSWnjf3OsPru26c5ZIMEk5Nuv/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315403; c=relaxed/simple;
	bh=lu1RNpPtTTMW8hPrwHoqzvYwwBZs4o04id7aariJlpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1REJF/3AZAmsUYRJcLxNALnuA2hEzwFHj/kQtiNDq6kCM7ytI0995ijiP8NJcbSKEJM3A1tI1OwOuDGJN9RL7a4VBLtH8cot1qPqMgzq6Fbp8luG+CQfPV5BIvFf1cuHFVub3rN5vkqMiPT7MhzlkPOlOsysyxjhr7JphY8nlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Y00GW0tU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390ec449556so1601412f8f.1;
        Thu, 06 Mar 2025 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741315400; x=1741920200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21l7JhXFBnRN90S1P9ZzisrlFHAVFiQS1Uh0soZKZtw=;
        b=Y00GW0tUykGbvqh+bA0xVlRDybZOVoRzB4vrOkGmvXCuMsAr1c4DPB6S6x77h3oY8n
         nQF8MSI2tprC3B5r1qvXEyTdwK2rTK4cDPQ0HQF2VVp6EPlXCvBYCh1SUrTSoME+38cO
         sMVCYQ/1ueA9H2Exe9IYIPMqjAnvjtu3rtbRqVX1C8IGLl6kdEnbNX2fqsjTc1OxDHpl
         zz1/qmesNqY8xoLzA4N/OCeOQkSNkK/2Q9XsdifgFOqPS1++JTPjcBzWX/BXmO5sM9JX
         lnQpwOh/o7q5FlGgH7qyn5nReFsDxyUtff8s/Yk/XpV+rwUXRGTbWp55ru3QlbhupXOP
         l4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315400; x=1741920200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21l7JhXFBnRN90S1P9ZzisrlFHAVFiQS1Uh0soZKZtw=;
        b=Po7H5Hf6cUuIaO+vst6MUb1UZWRqY3RAWYKILJ+xBfBDvXPnsoekzQ2mUeGM6ekq8E
         z0h+mqDJ/vsqXuPNBS0ulMt3LMdbZh4T3L55utJ0QmD4zaVjqHK4Uu1ZyKU6W6R368SK
         sQ5NhepONCJrf0yHrht3MSjw511Enazs6K6XlOnofK0jWwbg7LWpdWQEH99MUi+wmnWD
         M8Qr8javkq2dXiRhxy1ywiyiyThosAhCGCSX+BZoTqjEnlGrOkmcIozb5pdB05jAUbkZ
         LjKWvyWt8L42XPNIscVWmdcgz7eytv4uZJNx5k0r6w3Nb1WezMEsdnIM6iEQZdzDYlJ+
         vt7A==
X-Forwarded-Encrypted: i=1; AJvYcCUWs9dh7FXls3iBrQjj3ZhpjRGbOL1wVXx/Xbh3SVZQn5Q8ErDBPCyOVj5vqLR+sDfvK99ore6/fhPfcBM=@vger.kernel.org, AJvYcCXgoMm7tr5ZZh+SF1MuyRhLS6DK5jIZMgq7jgWicSLPD4FnFvORlM+7oTVFZGj5B/IhtDUqahG2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcl7rQtrfocOlqjCueXcOmm9Z0x78jEjXNEDx51Vli9e8HYpzo
	YS1Cz+Iebr8MBCDr/oA0zw2IZ68p0tPftXBoB4u8seM9B2UV9Yc=
X-Gm-Gg: ASbGncu5d3g9PaccWvBmPPKYrw0PY+Jvf0qRnAuZlOj0Lo0UViJoIOEeGgoET+AbpVr
	ZY+jY6YmzweFLPg9o1eu0ne1KpW4x5eJGMVs0o4CcBe9rrWOR324AfgwhKO6YVE22NrQpztZKes
	M802grwNMvp2FEinRiENwzwc++8nxro3UNfrnPimx6CslDg7mqpLNgYdUUGUBNxfndHx1kY+zrb
	8/EfSR/yBJa8WfJvP2lzujsYjvzP/INWu5wKGK/wQyqbEdTuS1+cuuhgoZcPcf3NKhny9OUKjWa
	vB4ydMIDKvpn4/tdKJFDtRLgPlwB9lIiD6uJ4gFyaIstiGtmwZ/Gq7T1L8yhkIczL24d/VtKZ/d
	sdg+Y72UA9btrlfj9Bc4Z
X-Google-Smtp-Source: AGHT+IG9eA+HEVAdvrRkowX3CKCIOamcUeu8hO48HnBvAUkscRzOTUfZ/2WqBVl6lxgKs3RZoZThBg==
X-Received: by 2002:a05:6000:2cb:b0:391:306f:57de with SMTP id ffacd0b85a97d-39132db1ac3mr1248059f8f.45.1741315399899;
        Thu, 06 Mar 2025 18:43:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4f54.dip0.t-ipconnect.de. [91.43.79.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm3863532f8f.19.2025.03.06.18.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 18:43:18 -0800 (PST)
Message-ID: <c941f071-3453-4b0c-a2e8-19c54962c9ac@googlemail.com>
Date: Fri, 7 Mar 2025 03:43:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151412.957725234@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.03.2025 um 16:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 147 patches in this series, all will be posted as a response
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

