Return-Path: <stable+bounces-132027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51029A83675
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495C77B1641
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243E15624D;
	Thu, 10 Apr 2025 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cr6dmU5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DED1C860A;
	Thu, 10 Apr 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251882; cv=none; b=usSiUYddqTvHUE/u/DJYy/bLLum1TYiOLQSpBWBaG4jb6jYPsG7FYiqOoPdCVMWOH9egt4LAmK22FUmM0p1iqMAVxFtPONJU9vSJDgHs2s6zq+x0pSMz6fOvFbdZP6VNVub8ReECbd3ULB06PqAatq1at95uw0kDuHBR6nt6EQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251882; c=relaxed/simple;
	bh=Eo1gt9bKvrZ5+HJR/BHOywwDv1Yl4/abKqF64Ryk0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTTdm76/tkpM9Xw/xNJhzFA+vGNKBQFjEjOwiyBC0kwtPKIsax6oC4RRCpXA2R+bcE3ld8roJ7bMAKYo8iJmoO3rr7bRD8hv+HkMU2tLZ4xM7aZmQ5C3dqIcJlbVkoOjV5pgBzfLvYHEStOJ048l/SqCy33zgb8Ii9FtX/K6zmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cr6dmU5N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so2595775e9.0;
        Wed, 09 Apr 2025 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744251879; x=1744856679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLsoh2OIC00QijQVonaJXsKWz3fOoh+K0IKMEyFAzFw=;
        b=cr6dmU5N5xQXqSG3H1gPUazzj+UJWPI1hMmt2hx4BpJogkll3xFXoMHDKC8n3AlYUp
         uXSj9RosPZuVvnXca09NZVbyLgNaRUa1cp1PsEKCxTW+LW1/poGrBJ7S82ZpXKX7XHry
         c0ALtiPTGaTIdHv8x8nwbrNp/xrEOiiXRZBRTbblyYev5I6I11S1Qu8yZTdIlwixUaCU
         KqHs7RzOMz2FLpP9A4O4Nouucaw9QgJUtDTE51Us5BkV5wWUf7KQex7t+SyOifBRaUv+
         gEmXQ/n6QX6ieg0ybpb7XjpRzQ4X1C5d4Vw4/ltOKDB6I9rzfs7OQ1/xGF9FGmcTNOBQ
         yD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251879; x=1744856679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLsoh2OIC00QijQVonaJXsKWz3fOoh+K0IKMEyFAzFw=;
        b=qhNfT23zq3UrmhxNwlAzCWh5hL/w7FZr0hiHy/G3WPjNy+r2p3GTZq/+Ob+V01FsOq
         oJNzVzcYJHcctQlOlPyOfM/IAbkR5iv3hXV15cmDVqsRQ67Us23s3BFJmQEVb7+i2mzv
         MbQFUX8BUOLRcTotQkGrZkgseAZBFE1UWwU1ei5Nm48Ye/I3aMOP03uY1CPOE2a8xFo9
         XBY+98UFBoaww47acImZG951P+km6yOm8l3VN5MLA7gX7C2NmBFeAhdEOOy5j7V0jNjq
         XtS3zOP/TQwJdubNmY0ULraG/xm5CT2ydLE7BJkkC2KTNKZpzNFZMsoh0UkEouRP6OjL
         KniA==
X-Forwarded-Encrypted: i=1; AJvYcCVxT+KTYBT+D5NC4ke9kZohmbTOQZcpute1LIlO8vCj6Cn78ieNUvfBiATiZGTl6XtyvnlpfDZz40LuFU0=@vger.kernel.org, AJvYcCX65nYErgye456mKAeU1tVDDBcbSOFhX+Oh2ScR7PFVd4Lxa9m+cObZbNiRnkmGRxN1PR2a49Tv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6yK8QwNlZ+JZtzKFMkeLCsHXYk/YYmeW2v6AmAQv5OjrAYJv
	m70A7wzixpkHxYzERUX6W3dFvQ+MgbdJH4gqmwNWaIR0HZ8J1cc=
X-Gm-Gg: ASbGncunCXMr1uQkVLLRI2W7/8/PLDK6orX9JrX/DxsATWFjoT8Dd+kHmmxeTHPxbJw
	cGrNITUjK7sUiVanmxUUjBbDWFiK8w/OGBaq0vGpnfKgGH1JKFdHeYEe7B2gslTu1WHlYtp0wL1
	zVbcKLXBeHza0PH913kNgeAEr3rY5TDCNTnQ9ZNx8egvcRDRLDiIh6CTGFItmcII6t7q9fnehl6
	rDvHtApfKuj6sTgo+brpJqxZwgKyHrm9sX4UarxZmJPEKvLKM4JojgS/omWF0FFStPp1yLHaXfk
	lnlym3FwjCPI+QgSTIW/+EwT8BNCJ33Nb3we5TqEjrhw2gD1MHQPXelHMjfUQiHKYBdUQi+sCLH
	OLd93dopUQqzPOjMR
X-Google-Smtp-Source: AGHT+IGWCWxesOK7jbekbPCv/x0NNcwUVBmp03gM9Ij6w0NKiLZ6YXEuDKJaUpEmxnowZDntDgDmPg==
X-Received: by 2002:a05:600c:1e1e:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43f2d98b7ddmr11478485e9.30.1744251879071;
        Wed, 09 Apr 2025 19:24:39 -0700 (PDT)
Received: from [192.168.1.3] (p5b057414.dip0.t-ipconnect.de. [91.5.116.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20a9f14csm24512175e9.1.2025.04.09.19.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 19:24:38 -0700 (PDT)
Message-ID: <cc67b805-4ed5-416b-ba5f-3b52877a96b6@googlemail.com>
Date: Thu, 10 Apr 2025 04:24:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/269] 6.6.87-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115840.028123334@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250409115840.028123334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.2025 um 14:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 269 patches in this series, all will be posted as a response
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

