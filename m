Return-Path: <stable+bounces-145914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D808ABFB8F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14D25007B8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681F22B8D1;
	Wed, 21 May 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lCWnMDoe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7B1DB92C;
	Wed, 21 May 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846110; cv=none; b=WMfqBXzAiTu+wfTotP6qaN+9I/QZMMhU1f8rtGgJCDtWZ66lEBS8iXEmzViywLBoM5saY7PjjXoOk+BsX7AF2bxtVZiiHJOBpG1ws/rcNH82bgW4nhhl9d5htz3DCuZ22Y+EQrqVoHlJkgOsQ81hvu05y3rl1iL7M6qGtdLpk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846110; c=relaxed/simple;
	bh=b7xXyi+01O5AFpi8W80L9Y1cFNIs1LdnBBXdAsf/Ba4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLhERwHdw0zvzsulle+/W7rc+fuxIrPR4HeP5YdQcDkEf0JCXakmDEXPMpaH6LKg3/LF+PhD7WU5sB3l+OT24FzOzApFie97MXzg5/ShOqPDOUpgayP53cIplZDK+vcH2H6B6KZy591oFRci8pRB9Vhnc+IdNKpeg43eb52lheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lCWnMDoe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso54047275e9.2;
        Wed, 21 May 2025 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747846107; x=1748450907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R21FvzuR5H03XLkhE7ZezmCTwEQzFxDVoCgSjcClEyI=;
        b=lCWnMDoekrVLTw4euLB6GvrQIyczVbLA+8t67tiwp0JBlu3eTbJcfe3Qj2UxVoOH1b
         zrSj9XejTcOzo/e8OgTwCb0SaXdslEFdnEoI7V2e9WYNZCH07N4zg2aVd6GRyvQE2SOy
         V1V+YZQKtHblRDpneotnMe5bIdmZOqs8TGERWO7oxQIeGgu5bbU9zPlqxR3sEZSShhrg
         mgql1t+TesDipv8FD6WpqvjOci52o6+CaeZOWGzIlN6jCFCsp/UEerSVWAp81ejwMDaX
         ZEAaF5FbTu9QkbDkUinMv932qDzv+CYsEk8sYNrZ9V5mDDVwgBsbGgwWVAa78e5F4up0
         bPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846107; x=1748450907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R21FvzuR5H03XLkhE7ZezmCTwEQzFxDVoCgSjcClEyI=;
        b=k0spzDVa3KOCrAKXozJZQMJzyZxDdZTNuP4ob8NgrPnI5ExCz9+ovi1sGMsK5J4Tgb
         nE0oqAEsrsM/DzQKyMbeHsnYauRK4FRX/OnvmnEl7KtPruBembULoV3v6s++c01fQg6G
         1/25sKOsrJhfgMhseTmkEuoqlEFUUPQKPLQIcMtEzdByBdHg3lqSoR1evcaK5BkzixrK
         ejT6fkJtuIbLAkVgg4aaKHvGR7+m1cmgCRv/iEGVnQUkdc2DfyIiITnisn50qCGRx+vi
         xwj6KgGg5YlgDVBZSheiq9VFezT7jexfWc42Zu/179r3rlKHZpQEA+ZdpZgxVh7JygEd
         4Gww==
X-Forwarded-Encrypted: i=1; AJvYcCVPqsYrqUxX7suP1BHYorS9+rR/f5u9d4s6uYq9WRztKebAqArpMYKTm/bzAZlveyfUCSDRxgkR@vger.kernel.org, AJvYcCWpSZbldXv8vqMlSAhjQ77LYPeZMo+9L9/0Z++FqRk8+wW7oKcBOp0+9Mo2Wrvqenm9si+XV3H3P5ascik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhClxgT/cY5G96fNcJByb6onsdhuadKIGoHAGPvlvuJA6iQB3M
	HAgSFuNRb5Jk33+lBDq/lmxOl6ab9+C1CUUqbLtOxDP3DQnGhNnpm3c=
X-Gm-Gg: ASbGncv3R9acAV++++O8L8ky7GUsrND/AaCfGmm8HuRIxruKaz19H8YsEQbbxYBeyNB
	tUFXT48pr+FErnGNZhFoSZX4hseK6rhi45vElV9nvCy5KjX4YVtBhgjdckAkdtiLUhE7xZopv5M
	IB8Ixg/PDNNGVYZP/xL6YPEyoLsW2SZo/kcAsW595hOTIDhdG/AgZzH/5XhNi9mYcm7gWHunUq+
	n0NBJcliwxmbQqldeEynCVcQDGrKfPvGtSUxoNt5BYrpoLTIokFn5FxwK9gAzVWUMBz4JbhMsqG
	qOStZ/qATH8wsr1mJNhhrMVbXVXMCMw96wcSFnzCxU4exEhmoYGBEdLtbhRmVqvOFNSwsDQbP2V
	NHII9Bt6YsbVkW0XeWXhTFiZEqJk=
X-Google-Smtp-Source: AGHT+IGIu3gbuINcDndwdP4p4mOyqy+li64ELdayYdyjK95FwdHBw8FjbzsVCoxES8ZbmatD0+A9XA==
X-Received: by 2002:a05:600c:3c85:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-442fd6790f4mr190944295e9.32.1747846107250;
        Wed, 21 May 2025 09:48:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac604.dip0.t-ipconnect.de. [91.42.198.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1825193sm80172405e9.5.2025.05.21.09.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 09:48:26 -0700 (PDT)
Message-ID: <741506d2-6447-4580-adac-962d9e45842d@googlemail.com>
Date: Wed, 21 May 2025 18:48:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.036375422@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.05.2025 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
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

