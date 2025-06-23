Return-Path: <stable+bounces-156154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6475AE4CE8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA73B1B7B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17D2C158F;
	Mon, 23 Jun 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="go75nq8+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90ED242D68;
	Mon, 23 Jun 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703822; cv=none; b=D1jH60rex2RpekMnWIvTAqhRt3Pd76uf3xskmPXZKLs7QkPgSM9uxoGDw6A+ImjIAOjx5sLaPZ6KEH/RhAKMHaruDfAHhCuQ4adchl656kUX082BE3+XDwKdQIoj1CRrnwRm7is75qrzIpk8BMGG92NbrjoeljbKWIezvGWK1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703822; c=relaxed/simple;
	bh=p1JnzbMj9qvo2T71XFSTCX9c6KzObdJcXfLfpLwDNfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgxnfyyPQ3YuqDoz7764tzMJFMRYhKHMo2L/UpuCMt2rhN8Oux95B/qwsaQUynEjvgZjpugwTQxKeNVhZxg0vg07JweEWaGgbt0abh7N1l2u+QCa1p8XjtQtrWWv8sn3NCqKGxpMYtVSXcgnJpmzpww/rcEEbisIviwJOG3kjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=go75nq8+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so3098647f8f.3;
        Mon, 23 Jun 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750703819; x=1751308619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2QVEwAUEUpg/DctJJXdhkEzwh3keBNJPXvALEQFRCo=;
        b=go75nq8+0BtpMdx4rS0I3M4lw9kRU1aQzprcL7Co3UmJHWFPl0C2dH9D11/7kIuSbl
         q6XAZ3t2DiPzswlEzLspteC++uceJRtbCGKsUkkmWerTIvPevExVbHaGHtVzAZXS/4xr
         pimsy8Mmxf1Z23FvhptNCY7BqQDL3O9MnjDdtPuiXuQ76uHDxh2zLy94m17tZY1rTXhE
         b+fcu53esVaW9uk9irbuXrtbIYY2a16WeSaJuGxLavk+rBfdV4r4kWzJc49Gj06faH/y
         XsXLtuNZNeNfesn/VfnspHNzxY5rk5Qaejo4gxeGuWLrkCEmuK+SkDJhADDxRoX/m+g0
         id0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750703819; x=1751308619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2QVEwAUEUpg/DctJJXdhkEzwh3keBNJPXvALEQFRCo=;
        b=JDHGf69rvUuv30VYLdhefFhsOAeMROX36mHWXMh3lo78a1pUhcXr5De2xBEyssgMR3
         ntwoBxNu3PNzAlS4b5sNIQjuNVEG68IeZ7aO7yYBUPeQEaU+cfW9TRk7A0PXKBvzbgSS
         GwWPaDPhrK8Zb6UAceRIN7r4VuH+F8zBcv05BDaIV2YtX++r9FFNq73V4LY5J/0I3d3X
         owsQxE/Nwsmitd+eqDSbK6eq6t9JTaEd4AhsXlL4diRHDvBr0DlaQbctKuquBkRG7ZPc
         9mxdCXq6E+jZEkseBfNLPA5QPIGqxbttkv3umBtQJ22mZhaBZm4PyOWWAKAqWrdH4PEw
         /qvg==
X-Forwarded-Encrypted: i=1; AJvYcCUUBNzb0XWvlNpgQbZKU0/Z2xNBI6BZdimoNcRgFW6yj0YPBBHE8ic3duLgB/ekY574vZIKW2Yi52EUWCs=@vger.kernel.org, AJvYcCVanbuXFdtpR7AAOlldaK7xeG09zmum/MPbErVOtrioKf3BGNj2PZwHZVktsnyfykjx6vqvslc0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rW30nUALWYyiXy+SCVXqhLeh1mryKU8pOVjOKuIdQhkQZX/G
	RiOTk99Tqw0ZJaDoM+Z2SVyFsF5A2eZTiTkZE8gnaufJ2Kub4ZdoaME=
X-Gm-Gg: ASbGncvnUtKQdHkk0l8KfdJuk0tx3FvOv2gaEds8c9LcdDxCGPUAQ9alN8CvQj2XmWr
	z7eiVlfdzKMA8cTzTnw5hGcmNsrzMpzeHFZWdc1gOFpx5Cb3Hc4K897G3QqtREm6B+p1O8xAl5B
	yyUiAVjRTWQLNcmLGIi7M3uJ1dixZLaC3RCj5bIA4G9husTRKCCE9xTyu5ieSv3BeKHwbmZHRrj
	4D6yu0JwqKZkDiRH33Iofa116wyKYFRvJVcmYVbZ/1u3jaQdQ1PRSj9w78ec2xMWzLh/pEmfC6Y
	Z15v8RoWnd1U/dWNuJnAMTKegczBMcawxrL1UmtKwAaKlZSAVXeCWlMgap0GVGS63c9QHESsSrA
	PcYe5AmdDSyVGwNTCdu4Uf5znPDf0/T9tkt4DIgLzzBHFuLiNAs8=
X-Google-Smtp-Source: AGHT+IERhtKyxwid8CVkClCk2R48go9/o5PMynbVEIQLznd3rozQuFuUsZ8RW8sAARaqnOMP4lEq3w==
X-Received: by 2002:a05:6000:2a8a:b0:3a6:e6c3:6d95 with SMTP id ffacd0b85a97d-3a6e6c36e16mr689550f8f.41.1750703818752;
        Mon, 23 Jun 2025 11:36:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac778.dip0.t-ipconnect.de. [91.42.199.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8edbsm152221325e9.24.2025.06.23.11.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:36:58 -0700 (PDT)
Message-ID: <bf8af6cc-ec02-4560-89be-b8fcf4455aa1@googlemail.com>
Date: Mon, 23 Jun 2025 20:36:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/290] 6.6.95-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130626.910356556@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.06.2025 um 15:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 290 patches in this series, all will be posted as a response
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

