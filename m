Return-Path: <stable+bounces-188965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD4BFB643
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222B819C692D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAD3126DF;
	Wed, 22 Oct 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CBNflJgz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547C314D2A
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128625; cv=none; b=iN0RQcGVREIsg3QG7CkrYl+c/sMBTMgNHaPWkd381pwusip6OPxp3OcH7WJ1VDmJ3NzynxELftWCy7RZvsfijyVIdmP0t6tPflqsuTtnQ8fjnkxkBBMzlGWHt6phKQJt3Pzr0UmVaJiqPmHWNh0oP+DgCsML2WalRQohzy7t/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128625; c=relaxed/simple;
	bh=YMRyZre+kBbFoPiHrqjDWIN+c5UsSggZobEPZ5cklR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG9EDnoaA27Pj+KYwyANp6na6PGpacYOSuncpQI2VKf0SPED4LONGWKPeocScI1TQgSNySc7pKMIHTwjuAYFsGGCdxI6Gq8x62OrI4EqVENoYX0Pq5MWbcWZKjMdtuUtPRl428z3Fjv0K5OaPhUcmMQYYsPtbsns+79z2aNsGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CBNflJgz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-421851bcb25so3982906f8f.2
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761128622; x=1761733422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14Z/Egm0ib+pyI7E20I7AQcOKcoL8J1lei7NXkr+nVY=;
        b=CBNflJgz6IF8ioY3RtZRqC/RQrVpIyON73Nk6TpSC3y0xnv10Gyf3/dq+Z5HPzdxDm
         2esW8vZevm2hJ3K/0bcfWk8BuCvD6ZAKvtv0qIr2TtO9jxL/6j2fJhgyDdbEg/GtJw2D
         +dupHc+FdB2nn9uVEfCROBvT1QDUhBsK+SUhj3qIxywVMU8VOwfFVp4rrLrLQND1sGIG
         2asgeAnk03tpisYi6NS94j/rShIB1OiA7qIRKb/6I3hw2gh2EM5woJ5m1zqnLdiD8IDM
         M4FoTZpSxA+Am5/AbjMUqU3bScOu9DvFm2j9xA2ze9qXhc4pO280YkdVy9Dbs7Ta2jRB
         n+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128622; x=1761733422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14Z/Egm0ib+pyI7E20I7AQcOKcoL8J1lei7NXkr+nVY=;
        b=tuaHwOF3KLMq3vZ9BPLty4SXvvN6hUoTkhAovURaX3PFHruHuSpgEqRncuyGBjIH8P
         xpv5/4yRIpKdXM7G8VImPMLW3YNEAs4Thp6ZyNpICeTtFWAXZbQuAtyn2eHoROIxLS+L
         rx7SJoQwhgutJcuG7YV4MdvhgE4XGbxO3K4x23o3dLZhfWu14h5O1YjHUMsX5sQPv7Sf
         U+n95oXKycKJNEB0R6kof0HIkSbWzSS7sh36sRaG3/R0mOTRtpSk5230Ozt+rgjnAgqS
         tNsylESXOWrHNvi8c4Vn3Tq137LlrQC/7hUPrTv5M/VcEnEtb4uglokHu5dtGcyV72Nl
         +uVg==
X-Forwarded-Encrypted: i=1; AJvYcCWMZ3C6YmYpwRb0kHvxK9L8sMsVVQFTP50EOvqEK48HkyJjj9YQmhbSBc9SF6AJnCJZ4XVFtQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW64+Z6Qn7a86fUO+qLy8usNGLC5OtSvaDz30pOUQ9/i1Hgv3K
	fqN0VKJ19emqKlyYH4NLwfykkxVaCdxaChMa+vxc5QuTNqMHrtPYwwk=
X-Gm-Gg: ASbGncugkohN52XDHqkBqVU1Z+YAE4p/ekmaZeHl0y6YE7CJKMXQUVetXEthPtOPXC8
	Z1NB2dxg0JIS4fZsggAC/Q1JGX/m3znawYBlEkU3eYJp0kEoit9TI7VnjWw1IUZgTDd1mhXkdG1
	P6vNXc87P4NtyH0cjhGT0d3CXryNzCC5BfBGzM03BsJmoi9HO99V7cDUYoGwsNZ/EbSg858ZgiB
	Bjms4Cr9Y6f953s8xMNjhs94HFlCXOHsowLLERW4QqPdGHLGDSTob42HToqvDp+pJwxX1NBgeO4
	9zQGSCjeKcrCBlDWix5Zh/+nGuGbpuMVgExZkDxvF5h3Z6e33TWXoutBGVFuNNyzjTw+nLW8G6W
	065RXHfMqpRDUgDdiwVTMoQcW+dFlHoAPLsl8LZp08S23nBvYewVTKSuUgDtlfAZNbVOwC6CEmZ
	AGU59Epy7sThYtQJundx+KsXsJLS8bYLusnMeThg7trB3dJLm9Q0k=
X-Google-Smtp-Source: AGHT+IHC3YeUejmKrYXNkUxhYAL7YEasRTosBZae2wnCLum1tuqcSZ/3cUYt2n/DhFVyS/dLVqcNaA==
X-Received: by 2002:a5d:5c89:0:b0:427:241:cb86 with SMTP id ffacd0b85a97d-42704d1461bmr10607226f8f.7.1761128622241;
        Wed, 22 Oct 2025 03:23:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42855c2fb92sm2193439f8f.46.2025.10.22.03.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:23:41 -0700 (PDT)
Message-ID: <36369902-7be0-4517-833b-71a69ed870c1@googlemail.com>
Date: Wed, 22 Oct 2025 12:23:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022060141.370358070@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 10:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No more screen problems, no dmesg oddities or 
regressions found.

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

