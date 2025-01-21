Return-Path: <stable+bounces-110071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA9A1877A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1788163318
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A3188CAE;
	Tue, 21 Jan 2025 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqAGPrcd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C1B85C5;
	Tue, 21 Jan 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495969; cv=none; b=owxSdjskde/UTSuBuYhP6Cm4jXjVgr5mQoxItPi0NND4NELQWgqORazZ45DDLR67T4+uTpLNmfRBFPlm06gQbtrYoHj91sOEA8+Ni0PWjKxX2pmO12PyJQrOqaYYbn/D0xXLBpxTEWeYnOcWodp+LJUmFKRYuazgHDJbppSets0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495969; c=relaxed/simple;
	bh=3LLeiStxYToysVZyPL2LSNz3jjzOoMVel3ZLJ3xROgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brvig7E/9cGGG0bvA+Vrl/oKwkN2Yb6JzXJYaOGbpYBTb65ZOzy/kel6jQooC112vwr6vEX09/H/NA9XKY2LYG3ckJ0LvxE2NWucgoMcfnu5twwXl7bs0ZxRQQxwqaiVm/cn3OqLtlhjAzhUOsPcf3jLAZiEwwujzGwxE6qqy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqAGPrcd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso12246394a12.3;
        Tue, 21 Jan 2025 13:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495965; x=1738100765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlApovyX2yhqXs8BBrOWcgKw+xYbJfOZcDpmZ0IuRIE=;
        b=dqAGPrcd+dakSyyBTl5jGMOplk3DUvtpqWW3lCxbrD5Q/IioJULcTxHnRM6Lv8HDuO
         9BWIQj4whq7+iRkw1YDNIWm2rODGBB6AgUuMWqXXYmIvvUa03oJIDqj3fVFiQ1HE9rLn
         MC5nMDbpMy5Z1121e/7FxXcN9wesAAJLRfiCl8Kux6GRv7pyipSrbkBjOAb7PWveGStX
         u5Q0lLLebiRPZ/QDeh2/cBbovirTovuHCzSP6Y6+lpC1kf+agdkUNG/KzW+wlCqWXHzB
         iDHGNYyY4zWQGEKVow3q0OIyXnkdvOjNOdZvvjs5iKmtc4J3QMC35WHQX6cgGlArvkdL
         W2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495965; x=1738100765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlApovyX2yhqXs8BBrOWcgKw+xYbJfOZcDpmZ0IuRIE=;
        b=VKthlGNATFtSaTw+qd/dHeiKOKYMwYturAgwmxpgGR5JTySCFdkmoEjiCXJR2DYnn2
         /A4Rjh+fztjBdiEB1IoA8ZFWvpjYBcAcN6WiIun9g/vXqAX7V476AkIBS3OBMSl/kK8l
         CadnVSSRv5ozpn1ymEizHgPEfXV2XENbDIc+3NlocZ6lr6SXx2+QjKgiHc8tE6podw/y
         VYvQng3CSbSCP7g9/sPFrMG0rEPxt1hSxHYOh3X0JPATY8OgBBXc4gNU/RIZJwKDVejm
         7LpDPTPZtP08UhuDV6ljfvts9btX+tQb1sMWePZFlq4qb06uP6IVUPPsoVoh1937L2sj
         iKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXowP8bF8LpCFEzEK6p87t4eIG+ggdoRFDUZRhbvMvUN3Gl8kGzKU+RyuEDUTrZ/DccU8zRPGphVBFO/Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMf4Tl92zW03IHbtmUIjJx+XgcrmmwsUzK+wCJYT7d5v4gjTz
	5CJBxBbDniYp65oco8Yw1QQu8dJ0CqV869LalNQHYGttQwbd85DG
X-Gm-Gg: ASbGncvQRWMrR75GQu3V+NuZT2ZQigIO/r/+yijj6rkGQIg1M3+y/utknrXJud7y4Z6
	dc1qTZeanVCfMO3fHWL5wVNLNdqnz5B39PUsiYyIfx+7PA16RHskryJ+xEt8mRqRwcE5jRTsAsN
	UzYmLOuiqlUvU6Tc0BPBaf1JOaXuFfdGB5NZwQ6mk5rasSHx4v2WttIMEOA9bKrlQH2lERwpUSa
	8fjEHuL12PZ2vxAFDHq9Gmfi5cWs5roD0yT04eunHjKc15iJ2KfssXGnCT7Q69IxsbN4VxcQh87
	uNrByum63qzBUg+SJEuTB510mqc=
X-Google-Smtp-Source: AGHT+IH+P6+VRF0jdFQ/AldfEjibVvDH5rn5neRrkUAq3GzMXJXeBhIzcSVSMSwi5CBdmsm9oN/g5w==
X-Received: by 2002:a17:907:1c25:b0:aa6:7cf3:c6f0 with SMTP id a640c23a62f3a-ab38b10d025mr1717588766b.14.1737495965097;
        Tue, 21 Jan 2025 13:46:05 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60746sm802762266b.4.2025.01.21.13.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:46:03 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0CDB4BE2EE7; Tue, 21 Jan 2025 22:46:03 +0100 (CET)
Date: Tue, 21 Jan 2025 22:46:03 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
Message-ID: <Z5AVm4cQDGjnDet2@eldamar.lan>
References: <20250121174532.991109301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>

Hi Greg,

On Tue, Jan 21, 2025 at 06:50:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.

Built and lightly tested, when booting I'm noticing the following in
dmesg:

[  +0.007932] ------------[ cut here ]------------
[  +0.000003] WARNING: CPU: 1 PID: 0 at kernel/sched/fair.c:5250 place_entity+0x127/0x130
[  +0.000006] Modules linked in: ahci(E) libahci(E) crc32_pclmul(E) xhci_hcd(E) libata(E) psmouse(E) crc32c_intel(E) >
[  +0.000021] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G            E      6.12.11-rc1+ #1
[  +0.000004] Tainted: [E]=UNSIGNED_MODULE
[  +0.000002] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  +0.000002] RIP: 0010:place_entity+0x127/0x130
[  +0.000003] Code: 01 6b 28 c6 43 52 00 5b 5d 41 5c 41 5d 41 5e e9 2f 83 bc 00 b9 02 00 00 00 49 c1 ee 0a 49 39 ce 4>
[  +0.000002] RSP: 0018:ffffbe1f400f8d08 EFLAGS: 00010046
[  +0.000003] RAX: 0000000000000000 RBX: ffff9ed7c0c0f200 RCX: 00000000000000c2
[  +0.000002] RDX: 0000000000000000 RSI: 000000000000001d RDI: 000000000078cfd5
[  +0.000002] RBP: 0000000029d40d60 R08: 00000000a8e83f00 R09: 0000000000000002
[  +0.000002] R10: 00000000006e3ab2 R11: ffff9ed7d4056690 R12: ffff9ed83bd360c0
[  +0.000002] R13: 0000000000000000 R14: 00000000000000c2 R15: 000000000016e360
[  +0.000003] FS:  0000000000000000(0000) GS:ffff9ed83bd00000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007f9f5a7245d8 CR3: 0000000100bfc000 CR4: 0000000000350ef0
[  +0.000003] Call Trace:
[  +0.000003]  <IRQ>
[  +0.000002]  ? place_entity+0x127/0x130
[  +0.000002]  ? __warn.cold+0x93/0xf6
[  +0.000004]  ? place_entity+0x127/0x130
[  +0.000003]  ? report_bug+0xff/0x140
[  +0.000005]  ? handle_bug+0x58/0x90
[  +0.000002]  ? exc_invalid_op+0x17/0x70
[  +0.000003]  ? asm_exc_invalid_op+0x1a/0x20
[  +0.000006]  ? place_entity+0x127/0x130
[  +0.000003]  ? place_entity+0x99/0x130
[  +0.000004]  reweight_entity+0x1af/0x1d0
[  +0.000003]  enqueue_task_fair+0x30c/0x5e0
[  +0.000005]  enqueue_task+0x35/0x150
[  +0.000004]  activate_task+0x3a/0x60
[  +0.000003]  sched_balance_rq+0x7c6/0xee0
[  +0.000008]  sched_balance_domains+0x25b/0x350
[  +0.000005]  handle_softirqs+0xcf/0x280
[  +0.000006]  __irq_exit_rcu+0x8d/0xb0
[  +0.000003]  sysvec_apic_timer_interrupt+0x71/0x90
[  +0.000003]  </IRQ>
[  +0.000002]  <TASK>
[  +0.000002]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  +0.000002] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  +0.000004] Code: 22 d7 e9 b4 01 01 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 0>
[  +0.000002] RSP: 0018:ffffbe1f400bbed8 EFLAGS: 00000202
[  +0.000003] RAX: 0000000000000001 RBX: ffff9ed7c033e600 RCX: ffff9ed7c0647830
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000000017b4
[  +0.000002] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[  +0.000002] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  +0.000001] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  +0.000006]  default_idle+0x9/0x20
[  +0.000003]  default_idle_call+0x29/0x100
[  +0.000002]  do_idle+0x1fe/0x240
[  +0.000005]  cpu_startup_entry+0x29/0x30
[  +0.000003]  start_secondary+0x11e/0x140
[  +0.000004]  common_startup_64+0x13e/0x141
[  +0.000007]  </TASK>
[  +0.000001] ---[ end trace 0000000000000000 ]---

Not yet bisected which change causes it.

Regards,
Salvatore

