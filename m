Return-Path: <stable+bounces-178803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B2B48026
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 23:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AA77A2C0A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411A20F08E;
	Sun,  7 Sep 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HobQ7bLw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B71202C30;
	Sun,  7 Sep 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279343; cv=none; b=j5FbikJ4TCdBHFLj4pVDOEWdnFWx+LtLGS+aex2jR3/3Ik7R91pwqdt+Eh5P4MUqgEVpWfU04fNWcC4IDpPUY12H9QsT7amchJpwxDvhsbffKqBCgL1fe2Xf3Qzo+Ml7RWo+IRZR07hCNj4V5YFF/oOqIHm1OLxs653EaEqBvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279343; c=relaxed/simple;
	bh=979tW4muEaHsThLbREw9EahK7v4GBzSlkTFqjEkX5yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3S4H8PjIZZT54uwf4M6+5nU8PsweNPEf/Z5m6QSfHhLpl1xlEGAEFFIArQtAcMeBpNl1+mkN2KbuJZqW3fyq41l8H38uKsp/JyBnIsOdQ4ohlcG+/+cLktqoqb4vDx5YelEcLbo1Dn5l6d0CwHBAy6WVEQ1UqsYofC+T/ckJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HobQ7bLw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e8005bso3424535a91.3;
        Sun, 07 Sep 2025 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757279341; x=1757884141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+XcqeXctgHrSpZdbfjrY35DRNMeHAmTDIMFfLDkzow=;
        b=HobQ7bLwx3glk+98cLpFhQqmUZQ0OfpPkJ5Fq8Hi3zYLzPcwdsB2//mneMBZdiK76l
         OsRtWG4UWxPgDQuSJtVRHOGDpHIR6mut+9ymNE1Mxs0Ja+ojIJgfHPUNnmkDDIIjdyPA
         ZIaHxxa1ESAER02ZNF05LjFpQhc74ulkprBgIro0ubRjLpthw3ioc3/7kvpzNMlo8r8G
         JcGEc+0foPXV1+pHGpUY+6mX/inFZ7fGMlsmWyEgGnF4Nm7kaTV2/azbRRMuDZGOrQQm
         7++9ARIYmLZaJg8ZI2F4G+s4wZH+I7eg/USdbrs9rfbfecq0siN9OqTjjDKKg/EKo03U
         mfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757279341; x=1757884141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+XcqeXctgHrSpZdbfjrY35DRNMeHAmTDIMFfLDkzow=;
        b=G3d0LGiaAWYoqIdecIhJnbN3LG49qKwcNSj1ZT1LVHeMFcAJrDSJNnzzZw194xOAnG
         ibqJA4t9+zMp1r6KrMT316WSQSW2W9jnORatpxDo4yX8ZUYrCu0CWgfR2794ZbazJt9J
         HPEUQikUL3b8QkFjv9j3dF3fjigD8APWhH5TJCn/UoAOHEfB8cy1FnWh9Yl4Sd940JmH
         h08PUvi6rRwD4SeZkfhuCOE6rJMuEbpmCwYETB4xs0bva30k4J0WkjUwTDVO3di+0BDY
         epyGrzT0zApfyzQEgWG7QBUIn81p76QYT5FXGUbhu9TAgqrfk2UOA02ViKTpyQN8DAc7
         eAMg==
X-Forwarded-Encrypted: i=1; AJvYcCX5qYy4fz0uC+nC77sEFqTMJsTXQKOkJaz6T3iorM/4G6XGaTB0otMdyLujTOOETQy4vKTR2jGyi/Ospao=@vger.kernel.org, AJvYcCXiBqR5pcdS1O2vOV4jjj0CySpJH/psQEYcPNt8tXWiJWeZWG/IZlfduYHSNGNMDVCzhFme1BjV@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8Ksj/8ULsEQr3SgxkfqG0/PP1KjDmo/himyATTuPHgYHwOD7
	rN8Dkf5faEnJVm+Rzp0hwpukhusZBfInDiQlL4UzTyzl8A4nhpSLxVTEE77sbduRd8E=
X-Gm-Gg: ASbGncsjOeAH5qA98J2cnTnMn+jOb09Z3l5kg9CYkR1hHlwDIUZoIZTgBTn8eDUWB12
	bqvcTk0nrRInKt6Gos+9HWIw5WcdVjWpnlM41HjiqMRdWELXQHmvpCpWRPtbcxsHc/OJKJQAj5G
	ni6zLDsP4jTE4e3q7P//hHTZn7SWDtSLBTJuDWZj5F3Bpyz0DjgkUOUgTbBal5L847HPnCl8Dsr
	7rkEdKBglvUE2jJ9DDDN/Eq/0yVtvOt2XuIGwYKGOlktICR8TqQXFRX4ptJaSzo/kRPHXbdDRqd
	89jANA5Ktc5HR11A6PvJeDso6mm5iI25IboNBwwT8scpl83AAtNsWnRUeuQ18Js0rE5bjws4oKZ
	HVXGVJlTifOsBc/T61wQfpT5wIXyuqhE3UMlwHva6fzXd6LKWeD/DbUtPnsj8lij+aQE5WfSblO
	Q=
X-Google-Smtp-Source: AGHT+IFG7MF1IfPkdtAuFovSgo7+co7waZ4T1YFBNP0xQm4JDsl0GWnqWncqLsD04bz1b83PhGwrew==
X-Received: by 2002:a17:90b:1b11:b0:325:211b:da6e with SMTP id 98e67ed59e1d1-32d43f94256mr7552325a91.32.1757279340621;
        Sun, 07 Sep 2025 14:09:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d8d0a3386sm204302a91.18.2025.09.07.14.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 14:08:59 -0700 (PDT)
Message-ID: <82edb13f-134e-4aaf-ae5d-6b9f80b02e68@gmail.com>
Date: Sun, 7 Sep 2025 14:08:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195600.953058118@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.299 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.299-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Looks like we have a minor regression introduced in the 5.4.297 cycle 
that I will be solving separately:

[    5.019301] xhci-hcd 8d00000.xhci_v2: xHCI Host Controller
[    5.024929] xhci-hcd 8d00000.xhci_v2: new USB bus registered, 
assigned bus number 1
[    5.032865] xhci-hcd 8d00000.xhci_v2: hcc params 0x0220fe6d hci 
version 0x110 quirks 0x0000180000010090
[    5.042311] xhci-hcd 8d00000.xhci_v2: irq 39, io mem 0x08d00000
[    5.048316] xhci-hcd 8d00000.xhci_v2: xHCI Host Controller
[    5.053885] xhci-hcd 8d00000.xhci_v2: new USB bus registered, 
assigned bus number 2
[    5.061564] xhci-hcd 8d00000.xhci_v2: Host supports USB 3.0 SuperSpeed
[    5.068404] hub 1-0:1.0: USB hub found
[    5.072180] hub 1-0:1.0: 1 port detected
[    5.076289] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    5.084621] hub 2-0:1.0: USB hub found
[    5.088393] hub 2-0:1.0: config failed, hub doesn't have any ports! 
(err -19)
[    5.095545] ------------[ cut here ]------------
[    5.100182] WARNING: CPU: 0 PID: 41 at kernel/workqueue.c:3052 
__flush_work+0x2e4/0x364
[    5.106281] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.108219] Modules linked in:
[    5.117467] CPU: 0 PID: 41 Comm: kworker/0:1 Not tainted 
5.4.296-1.19pre-gebfa69b7e348 #2
[    5.125654] Hardware name: Broadcom STB (Flattened Device Tree)
[    5.131588] Workqueue: events deferred_probe_work_func
[    5.136732] Backtrace:
[    5.139187] [<c0cccbd8>] (dump_backtrace) from [<c0ccce70>] 
(show_stack+0x20/0x24)
[    5.146766]  r7:00000bec r6:60000013 r5:00000000 r4:c26b3ca0
[    5.152434] [<c0ccce50>] (show_stack) from [<c0cdaf18>] 
(dump_stack+0x94/0xa8)
[    5.159668] [<c0cdae84>] (dump_stack) from [<c0226194>] 
(__warn+0x98/0xec)
[    5.166550]  r7:00000bec r6:c02438cc r5:00000009 r4:c0f51eb0
[    5.172216] [<c02260fc>] (__warn) from [<c0ccd67c>] 
(warn_slowpath_fmt+0x70/0xcc)
[    5.179708]  r7:00000009 r6:00000bec r5:c0f51eb0 r4:00000000
[    5.185373] [<c0ccd610>] (warn_slowpath_fmt) from [<c02438cc>] 
(__flush_work+0x2e4/0x364)
[    5.193561]  r8:00000001 r7:cd316510 r6:cd949c00 r5:cd3164d4 r4:cd3164d4
[    5.200271] [<c02435e8>] (__flush_work) from [<c0244328>] 
(flush_delayed_work+0x3c/0x54)
[    5.208372]  r10:cd316400 r9:cd949c78 r8:00000000 r7:cd316510 
r6:cd949c00 r5:cd316400
[    5.216210]  r4:cd3164d4
[    5.218749] [<c02442ec>] (flush_delayed_work) from [<c0932150>] 
(hub_quiesce+0x94/0xcc)
[    5.226761]  r5:cd316400 r4:00000000
[    5.230341] [<c09320bc>] (hub_quiesce) from [<c09324bc>] 
(hub_disconnect+0x48/0x16c)
[    5.238092]  r7:c2710ab8 r6:cd94a800 r5:cd316400 r4:cd94a820
[    5.243758] [<c0932474>] (hub_disconnect) from [<c0935b14>] 
(hub_probe+0x31c/0xeac)
[    5.251424]  r9:80000080 r8:00000003 r7:cd949c00 r6:cd309380 
r5:cd94a800 r4:cd94a820
[    5.259178] [<c09357f8>] (hub_probe) from [<c093ff2c>] 
(usb_probe_interface+0x104/0x2ec)
[    5.267278]  r10:cd949c00 r9:cd94a800 r8:c268e298 r7:c0e74c64 
r6:cd949c78 r5:00000001
[    5.275117]  r4:cd94a820
[    5.277654] [<c093fe28>] (usb_probe_interface) from [<c07e5d78>] 
(really_probe+0x11c/0x4c8)
[    5.286016]  r10:c26c6f90 r9:c268e298 r8:c270e478 r7:00000000 
r6:00000000 r5:c270e474
[    5.293854]  r4:cd94a820
[    5.296390] [<c07e5c5c>] (really_probe) from [<c07e65ec>] 
(driver_probe_device+0x88/0x1d4)
[    5.304665]  r10:00000000 r9:c268e330 r8:00000000 r7:cd94a820 
r6:ce2999f4 r5:c268e298
[    5.312504]  r4:cd94a820
[    5.315040] [<c07e6564>] (driver_probe_device) from [<c07e696c>] 
(__device_attach_driver+0xbc/0x120)
[    5.324183]  r8:00000000 r7:cd94a820 r6:ce2999f4 r5:c268e298 r4:00000001
[    5.330893] [<c07e68b0>] (__device_attach_driver) from [<c07e3904>] 
(bus_for_each_drv+0x90/0xe0)
[    5.339688]  r7:c270e450 r6:c07e68b0 r5:ce2999f4 r4:00000000
[    5.345354] [<c07e3874>] (bus_for_each_drv) from [<c07e61dc>] 
(__device_attach+0xb8/0x1fc)
[    5.353627]  r6:cd94a864 r5:00000001 r4:cd94a820
[    5.358251] [<c07e6124>] (__device_attach) from [<c07e69ec>] 
(device_initial_probe+0x1c/0x20)
[    5.366785]  r6:c268e348 r5:cd94a820 r4:cd94a820
[    5.371408] [<c07e69d0>] (device_initial_probe) from [<c07e4c94>] 
(bus_probe_device+0x94/0x9c)
[    5.380031] [<c07e4c00>] (bus_probe_device) from [<c07e0e5c>] 
(device_add+0x2c8/0x680)
[    5.387957]  r7:c270e450 r6:cd949c78 r5:00000000 r4:cd94a820
[    5.393624] [<c07e0b94>] (device_add) from [<c093dfe4>] 
(usb_set_configuration+0x49c/0x8a4)
[    5.401985]  r9:c26cd200 r8:cd949c78 r7:cd316250 r6:cd316250 
r5:cd949c00 r4:cd94a800
[    5.409741] [<c093db48>] (usb_set_configuration) from [<c094a820>] 
(generic_probe+0x60/0x9c)
[    5.418189]  r10:c26c6f90 r9:c268eb28 r8:c270e478 r7:cd949c00 
r6:c268eb28 r5:00000001
[    5.426027]  r4:cd949c00
[    5.428563] [<c094a7c0>] (generic_probe) from [<c093f6a8>] 
(usb_probe_device+0x4c/0x9c)
[    5.436575]  r5:c270e474 r4:cd949c78
[    5.440155] [<c093f65c>] (usb_probe_device) from [<c07e5d78>] 
(really_probe+0x11c/0x4c8)
[    5.448254]  r7:00000000 r6:00000000 r5:c270e474 r4:cd949c78
[    5.453921] [<c07e5c5c>] (really_probe) from [<c07e65ec>] 
(driver_probe_device+0x88/0x1d4)
[    5.462195]  r10:ce0fc000 r9:c268e20c r8:00000000 r7:cd949c78 
r6:ce299c24 r5:c268eb28
[    5.470034]  r4:cd949c78
[    5.472571] [<c07e6564>] (driver_probe_device) from [<c07e696c>] 
(__device_attach_driver+0xbc/0x120)
[    5.481715]  r8:00000000 r7:cd949c78 r6:ce299c24 r5:c268eb28 r4:00000001
[    5.488425] [<c07e68b0>] (__device_attach_driver) from [<c07e3904>] 
(bus_for_each_drv+0x90/0xe0)
[    5.497220]  r7:c270e450 r6:c07e68b0 r5:ce299c24 r4:00000000
[    5.502887] [<c07e3874>] (bus_for_each_drv) from [<c07e61dc>] 
(__device_attach+0xb8/0x1fc)
[    5.511160]  r6:cd949cbc r5:00000001 r4:cd949c78
[    5.515784] [<c07e6124>] (__device_attach) from [<c07e69ec>] 
(device_initial_probe+0x1c/0x20)
[    5.524319]  r6:c268e348 r5:cd949c78 r4:cd949c78
[    5.528941] [<c07e69d0>] (device_initial_probe) from [<c07e4c94>] 
(bus_probe_device+0x94/0x9c)
[    5.537564] [<c07e4c00>] (bus_probe_device) from [<c07e0e5c>] 
(device_add+0x2c8/0x680)
[    5.545491]  r7:c270e450 r6:ce307410 r5:00000000 r4:cd949c78
[    5.551157] [<c07e0b94>] (device_add) from [<c09327b8>] 
(usb_new_device+0x1d8/0x400)
[    5.558910]  r9:00000000 r8:ce0fe0c8 r7:ce307410 r6:cd309000 
r5:cd949c78 r4:cd949c00
[    5.566663] [<c09325e0>] (usb_new_device) from [<c0cd6e60>] 
(register_root_hub+0x158/0x1dc)
[    5.575024]  r9:00000000 r8:ce0fe0c8 r7:ce307410 r6:ce0fe000 
r5:00000000 r4:cd949c00
[    5.582778] [<c0cd6d08>] (register_root_hub) from [<c09388c0>] 
(usb_add_hcd+0x5a4/0x680)
[    5.590878]  r7:00000000 r6:ce0fc000 r5:00000027 r4:ce0fe000
[    5.596546] [<c093831c>] (usb_add_hcd) from [<c0971f98>] 
(xhci_plat_probe+0x514/0x644)
[    5.604472]  r9:00000000 r8:ce307410 r7:ce0fc000 r6:ce307400 
r5:ce307508 r4:ce307410
[    5.612227] [<c0971a84>] (xhci_plat_probe) from [<c07e8bbc>] 
(platform_drv_probe+0x58/0xac)
[    5.620588]  r10:c26c6f90 r9:c2690480 r8:c270e478 r7:00000000 
r6:c2690480 r5:ce307410
[    5.628427]  r4:00000000
[    5.630964] [<c07e8b64>] (platform_drv_probe) from [<c07e5d78>] 
(really_probe+0x11c/0x4c8)
[    5.639237]  r7:00000000 r6:00000000 r5:c270e474 r4:ce307410
[    5.644903] [<c07e5c5c>] (really_probe) from [<c07e65ec>] 
(driver_probe_device+0x88/0x1d4)
[    5.653178]  r10:00000000 r9:c26bc3f0 r8:00000000 r7:ce307410 
r6:ce299e84 r5:c2690480
[    5.661016]  r4:ce307410
[    5.663553] [<c07e6564>] (driver_probe_device) from [<c07e696c>] 
(__device_attach_driver+0xbc/0x120)
[    5.672697]  r8:00000000 r7:ce307410 r6:ce299e84 r5:c2690480 r4:00000001
[    5.679406] [<c07e68b0>] (__device_attach_driver) from [<c07e3904>] 
(bus_for_each_drv+0x90/0xe0)
[    5.688202]  r7:c26c6f90 r6:c07e68b0 r5:ce299e84 r4:00000000
[    5.693869] [<c07e3874>] (bus_for_each_drv) from [<c07e61dc>] 
(__device_attach+0xb8/0x1fc)
[    5.702142]  r6:ce307454 r5:00000001 r4:ce307410
[    5.706765] [<c07e6124>] (__device_attach) from [<c07e69ec>] 
(device_initial_probe+0x1c/0x20)
[    5.715300]  r6:c2680428 r5:ce307410 r4:ce307410
[    5.719923] [<c07e69d0>] (device_initial_probe) from [<c07e4c94>] 
(bus_probe_device+0x94/0x9c)
[    5.728546] [<c07e4c00>] (bus_probe_device) from [<c07e51bc>] 
(deferred_probe_work_func+0x84/0xcc)
[    5.737515]  r7:c26c6f90 r6:c26801ac r5:c2680198 r4:ce307410
[    5.743182] [<c07e5138>] (deferred_probe_work_func) from [<c02447ac>] 
(process_one_work+0x208/0x53c)
[    5.752325]  r7:d07a4400 r6:d07a1140 r5:ce0d0e00 r4:c26801c0
[    5.757992] [<c02445a4>] (process_one_work) from [<c0244d20>] 
(worker_thread+0x240/0x5c0)
[    5.766180]  r10:00000008 r9:ce298000 r8:c2603d00 r7:d07a1158 
r6:ce0d0e14 r5:d07a1140
[    5.774018]  r4:ce0d0e00
[    5.776554] [<c0244ae0>] (worker_thread) from [<c024b244>] 
(kthread+0x16c/0x170)
[    5.783960]  r10:ce135e80 r9:c0244ae0 r8:ce0d0e00 r7:ce298000 
r6:00000000 r5:ce225f00
[    5.791798]  r4:ce24c0c0
[    5.794336] [<c024b0d8>] (kthread) from [<c02010d8>] 
(ret_from_fork+0x14/0x3c)
[    5.801567] Exception stack(0xce299fb0 to 0xce299ff8)
[    5.806623] 9fa0:                                     00000000 
00000000 00000000 00000000
[    5.814811] 9fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    5.822998] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.829621]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c024b0d8
[    5.837460]  r4:ce225f00
[    5.840013] ata1.00: ATA-8: WDC WD3200BEKT-00F3T0, 11.01A11, max UDMA/133
[    5.840016] ---[ end trace 268ceb3d3c2e8a73 ]---

-- 
Florian


