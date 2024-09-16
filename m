Return-Path: <stable+bounces-76517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7E97A6C6
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AF31C26EFB
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1615B10C;
	Mon, 16 Sep 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i+Z50gHi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E918B1A;
	Mon, 16 Sep 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507702; cv=none; b=e4RXzk2qkYrNWa2plMyYONt0YQxGDhr+Bd70XM2q+VkSFSzfeJ447EC0KwlpkaVBMilQjNaOT+y6msEsnNBCTFZvvnCBasoWz5bO0R57I4EA13uC0Wsiis3OWrHdA+ENwhKQv1Do24hkHH/MbmmHS0MzRO6o1ACSmhuBeS84q4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507702; c=relaxed/simple;
	bh=2HAfSjZ0rksb6UX+rVql7xe64h/WufpvrJQUuwP8Ei0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9UGECNvVL4wTAiKjyeh+dpWObISCpSD/HglW4p5HVxgrqe8Z5PpaTOh1/FztDM4fwZMS3fmFMWa5fYFBWcOCbTc1nfYyXzNH6PYCNf9xGnz55QitUUAULk3r/D0O/q+aLhQVLnOPPBW4TLESnk64txm2uOctgp6CF9w+W20Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i+Z50gHi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-378f90ad32dso692245f8f.0;
        Mon, 16 Sep 2024 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726507699; x=1727112499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqLo/dEBUfpp1Lh4uLJBd7I7zW9+divCoFNdtfvd0Io=;
        b=i+Z50gHi0OoXWurSGDCW2kWELVblGrEd7rbwxswUf3hmTJ/gvAkw3lJTzI3hjNkad6
         LcMzbgotrT5j463naFtVy5z8FFTYjPHM9aUQwLBoQxzyrtFX6CZx01d9Wl9SnLV5XJSn
         joP4am5bXsmDU4VhtuC1HwEmwaW6I3LcSIgLr/ZUFKzHxfbThdXgdwLgI3MwWpexdUdv
         MCeFJcKD68SJf9EQcYgvdWvnP0Vo1CPPUFi0gpNzfDVakepFVRcQu1GYtfbY1v2uV5Po
         hxvDRNmqE+whdLthPJiyHcrYo4BZWhl1+mSDexJ0e31tEhJExCi1WfmKJQ/7eWpUAEtP
         61EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507699; x=1727112499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqLo/dEBUfpp1Lh4uLJBd7I7zW9+divCoFNdtfvd0Io=;
        b=UnDrDzTlzBbvjwfSfc10utmsf3/vH8UJQPPeVtlS1mbQJ/8ZwKyun7CJxejlh7z42c
         xkbBQCQQKSl8e7SVs8Ts9N8r7sgZhI4AlC9SEjsSy3+JvMGEqDn9S1zbHwcgiVUoLdyp
         Rx3+tWIwIuiY1+GwOwZBec1mxV8ztuvq0xn1STLYx19dTcwv2Ci8O2INvu0M42Sg99R5
         5E4BtaVto1UInet5SxLE1/Dd33wUe9lKqBMNKd6P7F3BChJZYDYUcIB2TBG72wMhErWp
         Fos5pQun+LyVp7EL5GkPr2Ez0bDL/ZGeOW55fZztFcGjn7eyhsDYq4oqb9GXJ8lC82B4
         tNhA==
X-Forwarded-Encrypted: i=1; AJvYcCVUGHwhAZNoNDt4cuGkDqWEpqcKPiyv52XD0OARthVsY8nwAyknfbS7de9WwMD7vST4t2PLs3yK8+YuYm4=@vger.kernel.org, AJvYcCWYUPH0wgRRcBIHy9Ht3djZrSlqNwtHeG5OQ1oBTFj5Njud9MRfsov/7/qwgzcHokAPR2n9TXs5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hi+mm2qQDJpBUWEMR6+zuk5NvOz1Ih00+xugHY7HWlzl2a2g
	TqrZypsGDQOf2ftGxV5moxKJOcAemmoK8LapELJ2Rf8BfGGHEGc=
X-Google-Smtp-Source: AGHT+IGPWSlU7J4r4K/9tm5G3UvJ73+6azKqU0ph7RCHLSGhOJB741tGiPQbKbvdefwpIoquatygBA==
X-Received: by 2002:adf:ec07:0:b0:374:c07c:a49 with SMTP id ffacd0b85a97d-378c2d04c73mr9324752f8f.28.1726507698263;
        Mon, 16 Sep 2024 10:28:18 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acc3a.dip0.t-ipconnect.de. [91.42.204.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1948fasm115960175e9.43.2024.09.16.10.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 10:28:17 -0700 (PDT)
Message-ID: <f3a5272d-2105-4e11-bfe9-d04b0626a7ef@googlemail.com>
Date: Mon, 16 Sep 2024 19:28:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114221.021192667@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.09.2024 um 13:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.111 release.
> There are 63 patches in this series, all will be posted as a response
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

