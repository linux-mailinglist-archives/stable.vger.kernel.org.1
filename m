Return-Path: <stable+bounces-151936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C0AD130B
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1095B3AA989
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC41547D2;
	Sun,  8 Jun 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iV+Z9B5p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B513CF9C;
	Sun,  8 Jun 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397118; cv=none; b=MFpIy8XYAJtDCn4am/9wyX+tpie/DuMdlZMxL5h9Xu+sp4ZLRADvoOg0rSEpmRo+tntBp29HVXj7BJ1gCDSnh2nrKsw2HfMZ19xHQ2V8iPuQPC/QTYDx19VtMcICAUgtXV1QcV58GN1/n5aG/kQNzca4w7wtS7GRYT/W6fx0Fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397118; c=relaxed/simple;
	bh=m1oUG0x77rJWQXsqAeuZMVS9z9c19VzPu+Q1YtyLFzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMwzLCxDUaFtH5zyWYpFvMz2iiNNsS3M4okVDLYxuZAWRBgw1ozNsNWDjw7pWTsYSxbfPNzjkIUHyuiyTFixFb6NpEpJHpF71Xx7EruUsskfhpq6aVTMn4uR5yMlHnYXK9El4XnrKGzQJKhpTeMiBOBIgjeijwq3T9MWddrsGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iV+Z9B5p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so22989725e9.2;
        Sun, 08 Jun 2025 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749397114; x=1750001914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAPW9CEAQTkA9ZtJQM59eScIy81/xXlC54hdG5dtI+E=;
        b=iV+Z9B5pt1/n7NTQ6pfeVcJC289CH9Q9hk5sdPQt0CS12GLFdNrF/cdFFqRVLjqniW
         UF+cvjyrpMnaahM3vyG2e8o9VUpvHwdNQfm3s1/P/o91+NL1kTBPbhF7SnlUHyPycd2N
         lHZe/33iJNT/qKfmWmOrw3Ow9FufB0CYODYdTP8APCwdLIFzDzruzoykRTlSW40vGISb
         2xU9tPzjUsn+DDFBa4dqqTjlYceJ5wNg+F5+IqqDhEieUA51dvXUPAMzPPvkbB2HC15d
         +34qj+n6WkiN9RlDFvtxOgHxxP0XNg4A+2vpt9aBWts2q7etiD0NqZOP0xI2cYotBCXR
         GjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749397114; x=1750001914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAPW9CEAQTkA9ZtJQM59eScIy81/xXlC54hdG5dtI+E=;
        b=b285yiiRyZ2CyQGTrtDRGYIZTB+68MxO5d7mod0bMdbJxfgOuyW+Lqj6wR1JO1kt66
         okKYvIDPDTF0xK1KVq8i+2eM/rjI8sg5Ki8Eg1dF0vp12Oa6PNyS6KXpcxropeLmdvCw
         QtTCp4ODEM1qb7WSj1Ek4JxMvO3wjBJyjFDzh+anGvkvtssmHxeA8T+fe9P9Nlw9Ycvv
         ZY0tBnacXj0jnRKsLHdHiucvIop0fiP0s4Fo9aJLVsIsMDys5mXllzIb+b2FDPCMZzN+
         H1tUq2C5niwI4vOjOhkqXZ6tsRqoesYEtQir8xXNVOPZA6r2M8N7BSewjJJmyWdQOKa7
         zfRg==
X-Forwarded-Encrypted: i=1; AJvYcCW7C6HU/HYXD1iXrm+XbpTrPKHrIW/1HKSLdDNmfJumPqiRTb+TzaMTMWCBjaxopCcnBg2c+7fFusf0Nrs=@vger.kernel.org, AJvYcCXfZBOgBvmkyQ8+FNHUq/F8jmGE/c2cajz5O6uGq+jHyX2rHDukDOz/kk4y+t4DdszbL+pjgZEC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4prV3NjILDEgxGMOk7o9qrlcjf/gsklx4xH+cbndtMH15rC89
	EEGrMuNI9T/w21q4L3znR5kAG9Aey6vj1TRDJl0yoqkycCiL9lBIu5U=
X-Gm-Gg: ASbGncsQ22/n7z17A5sLEhtZQpEE8IkFtuCDAMIr/b5coqe4urG5Pcyu7McCjmK6BPN
	4GcyQbtiZBXoTTbUtj0KTLWendofP58sJZic/cZSM+fLQ7bMXI6bd32tMWnj6SNoHye/IZk+oUT
	sb4Zsj7nTY48nPmR/NSf6JMw2ZwI+4C4JHbzPXvOboyF4bcviERVEEp2ikFeUjja7tJo24g3ZgG
	WUbt8dwpOuRZioUhghJB9dXhrMOMSCc/RvZrHAaptamRpCdQQY1PE7QctwTYnC+YvgpwmJnnMD4
	HHstt1wFRbhPQs6ujzMObvNxZz++795AGg3aI98LRTAQVl1W4apdr0OxGsfRPsbtoHzPWVd02hu
	RF9ZQlYJhbEbr/0IV+pNw5zxC36iMcDLXL6/qBw==
X-Google-Smtp-Source: AGHT+IE+yeRQhGLyvfPMEYFhMszTng6Bd900060XU6yLxwA8zMJMGepOitYZ4xu2+e6pOdpNKpKBag==
X-Received: by 2002:a5d:58f9:0:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3a53b033bd0mr3601348f8f.28.1749397113741;
        Sun, 08 Jun 2025 08:38:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace02.dip0.t-ipconnect.de. [91.42.206.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532436650sm4642069f8f.65.2025.06.08.08.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 08:38:31 -0700 (PDT)
Message-ID: <d8374546-e88b-412c-9e8f-4a6356430db9@googlemail.com>
Date: Sun, 8 Jun 2025 17:38:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.910797456@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.06.2025 um 12:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
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

