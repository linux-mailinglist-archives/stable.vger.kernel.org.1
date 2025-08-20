Return-Path: <stable+bounces-171907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290AB2DF84
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E04161868
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1A274FD9;
	Wed, 20 Aug 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4Cjct5L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE035334E
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700575; cv=none; b=L4Y+6VrnfhYwbBln/JjF91e0OlLW900KPOgOBCti/IMyCfjTRp27IYbe4vrg5stVW5B8x8BQuIChi/BYMxTOwq/24OBvoFGR+uHKHcSDEVNPV7G283vqmH57rgeXRyyE8io2b1MIgbcgHWIsPSzC+rcEYFMw/pG1f9LHwKmAacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700575; c=relaxed/simple;
	bh=4hBT+buiES17wXgKl6UMMYEyTZ1Pb3414IbE2VoRNAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E07/m2N1+N2FImxyHHyJ/gu+B42uRCLkbUcZICMOo4b8ggB69stTSXPVLwJYnSBj2/jUUMK7+Td5wHtcyGhp7cOs5D8DpksoomIvmYX9LbVR0CxIFIOnR9D+Q0oq6JdKEqouEPKGcPPPf40JQzIJ7jAuRxvZRRcbKZf5Cy6AcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p4Cjct5L; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323267adb81so7688242a91.1
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755700573; x=1756305373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbJBv/3H5428xs4cdRW4AQdn6v112iL6mkHWnmkXwqE=;
        b=p4Cjct5LhB4EUlPnUfP8b3AkQuBnjPt+kueRO4zAd0gPuVH8DVQ1UsKTMjstqAH/Bs
         jpYFde9ogpjlIuSsm51B/6eWVW03CylSZFtY5Jei8qVBwtFqS7Txigc2CcbWwhCksZT5
         nxlS/NOWYvudZYj2eJrghI2fMODCd4bVmfQxQ6apOH7QRtmFdA7AZkT5tpOyIZQC+eCp
         UgRj2OACeuZcbhBCD057ETTIJfFgoT1PJ//khN2flKO8Dhiud6349cK3JCHoeVl6pvaQ
         PbZhyVoUIbF1pLwk6kvsvHURylSX5oNork6YnIM3nJulEqfsidUP9Dp0ZE2HfXwtsujY
         zQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755700573; x=1756305373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbJBv/3H5428xs4cdRW4AQdn6v112iL6mkHWnmkXwqE=;
        b=tTcdC+qJ+viQ3MzWQl89h7BpxQCkg2OC2Ah0WrKn4HixiaXuC48JqCv5y/UyS+iNqg
         +ZIAmP7hwvYYojx4EsaRK6ge6TjXm8bnFlxpLgcGEUa4jnWDbGMf1+Dn0Lpc4D8WA405
         8poyy5mLGl/xw/jS+2mb9+IQzr9Kyv0NApeZMkAK0rWdaxkdc5fkcZj+dAi9bbIw72oS
         E+DUmHg3ut4qpJ8F0qBlHYHipnZ1RVRfESO5gKHCOqZYBRJsLVZNW33crqYXwqcDp3PD
         95gGvC9isJUeYgOoYt/n7w8LVJKl7GaOa9Kmn39+eEZwKNGJyjuj6GBkMzuv1DQNYija
         uevw==
X-Gm-Message-State: AOJu0Yy6xYFIig0kn1L63dHBXzcq5URE29Bm9AbblyR3HKtyegT0eDRY
	sdMwg4mWzRAOgcet+Xb/8hq5jru2YZMJ+5MuuH+Kl2aXBPLnI3ojrcm45XxYHa7UDUVHhR8MfAb
	IXsXzDe8p31lH9TZ1A1Bp0ZnmO3yi1lWeIXpUaigDGA==
X-Gm-Gg: ASbGnctZLzF9AE2gwunlPlIL7zJLncDy+gsGpElw9u7ZxZ5vuzBGvzaW3mozUGM1dr/
	cnb+aZp7IQwKfNnBwMPN+ihxF5RodiRb6tHjN03v8c60MhKZgCdqjTZ0HQcShtq8oONeJ7AwOKE
	8SwytibhSl7OPIeLIURikCG1RChEzpgeou1hI5rsAXw3ys4LKKRy+aoCzPRvlK4CkncdGMZQ9oW
	tmTswqrNhPP9Bbn1GJtLitbq/5ykva4GAFyUrs=
X-Google-Smtp-Source: AGHT+IEdMY4xh4BhwPScUhIgPWf9ZcAB/0weEpDIJ55eNjWwG2Sd0rlo1FnkJtUF8wfhxGfuA4mblTlPnIw0NgaRkjk=
X-Received: by 2002:a17:90a:ec88:b0:31a:9004:899d with SMTP id
 98e67ed59e1d1-324e143e583mr4420576a91.18.1755700573433; Wed, 20 Aug 2025
 07:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122844.483737955@linuxfoundation.org>
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 20:06:01 +0530
X-Gm-Features: Ac12FXyUQdvOPLI9LVSLZtfZIlbJBJH9mNkCOuEMZ2eMxjtxG5PAQO0-gm_8dGI
Message-ID: <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As I have reported last week on 6.16.1-rc1 as regression is
still noticed on 6.16.2-rc2.

WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334 start_this_handle

Full test log:
------------[ cut here ]------------
[  153.965287] WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334
start_this_handle+0x4df/0x500
[  153.966304] Modules linked in: tun fuse
[  153.967547] CPU: 0 UID: 0 PID: 7012 Comm: quotacheck Not tainted
6.16.2-rc2 #1 PREEMPT(voluntary)
[  153.968294] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  153.969408] RIP: 0010:start_this_handle+0x4df/0x500
[  153.970243] Code: e9 5b fc ff ff 90 0f 0b 8b 4d a4 65 48 8b 05 a0
27 17 02 48 c7 c7 70 f2 87 ac 8b 55 a0 48 8d b0 c0 07 00 00 e8 a2 09
c7 ff 90 <0f> 0b 90 41 b8 e4 ff ff ff e9 a7 fc ff ff e8 0e c9 e2 00 0f
1f 00
[  153.971734] RSP: 0018:ffffabfb0112bb60 EFLAGS: 00010246
[  153.972336] RAX: 0000000000000049 RBX: ffff93cf8706a800 RCX: 0000000000000000
[  153.973157] RDX: 0000000000000000 RSI: ffffffffaae64a70 RDI: ffffffffaae64a70
[  153.973347] RBP: ffffabfb0112bbd0 R08: 00000000ffffdfff R09: ffffffffacc7c880
[  153.973513] R10: 0000000000000003 R11: ffffffffacc7c880 R12: ffff93cf8706a800
[  153.974263] R13: ffff93cf8044f6c8 R14: 0000000000000000 R15: 0000000000000002
[  153.975058] FS:  00007f245e2d5780(0000) GS:ffff93d04e8ae000(0000)
knlGS:0000000000000000
[  153.975933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.976641] CR2: 00007ff069065690 CR3: 0000000106a0a000 CR4: 00000000000006f0
[  153.977841] Call Trace:
[  153.978279]  <TASK>
[  153.978748]  ? kmem_cache_alloc_noprof+0x119/0x3d0
[  153.979180]  ? __folio_batch_add_and_move+0xb5/0x100
[  153.979691]  jbd2__journal_start+0xfd/0x1f0
[  153.980154]  __ext4_journal_start_sb+0x10d/0x1a0
[  153.980642]  ext4_write_begin+0x17e/0x510
[  153.981132]  generic_perform_write+0x95/0x290
[  153.981569]  ext4_buffered_write_iter+0x6d/0x120
[  153.982014]  ext4_file_write_iter+0xab/0x820
[  153.982315]  ? selinux_file_permission+0x12d/0x1a0
[  153.982754]  ? trace_preempt_on+0x1e/0x70
[  153.983393]  vfs_write+0x2a8/0x4b0
[  153.983886]  ksys_write+0x7b/0xf0
[  153.984248]  __x64_sys_write+0x1d/0x30
[  153.984510]  x64_sys_call+0x2ab/0x20c0
[  153.985107]  do_syscall_64+0xb2/0x2b0
[  153.985513]  entry_SYSCALL_64_after_hwframe+0x77/0x7f


Lore link:
- https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
- https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.16.y/v6.16-1186-gb81166f7d590/log-parser-test/exception-warning-cpu-pid-at-fsjbd2transaction-start_this_handle/

--
Linaro LKFT
https://lkft.linaro.org

