Return-Path: <stable+bounces-56915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93B9253E3
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C736B1F255F5
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0813440A;
	Wed,  3 Jul 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b="lKAU4BMf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777304965F
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989117; cv=none; b=fYlcmorhk0mIrXKeNw7SMTaXj/4GKXmk25S50ADcYHNZ2YZxD4HxjYXGPOLtDioUvtACMfSvA4laC1IOry9QgLAp1/krEsmXnF6oE6CG8D8PxRRIOL3hAgbxu/cxX4qBTWRNE6lQ4UN7mMUVEjwO9Gyi9/88ZSn51fPtDJkHfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989117; c=relaxed/simple;
	bh=HOW/lQWRUIc7FWyhXic28qmTL1KJ+uCJ8pZQSUHfiyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDRWNidVvO8SejfPwgkY8Y9H/Zu7kx0rrv3S99LUEdEMT/uBxCllp11N52qtlqUw9QqaiPMf9xx/wPbRLvB/hBRqpIJPw1qFxZI4ZUsIcEafcw6zfOEjOQTC8iUvalVX5/0zFftiMKr8ZN+1oxYF2B0rGnpaFzSwY+5VcIutmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b=lKAU4BMf; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d566d5eda9so2232905b6e.0
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1719989112; x=1720593912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5J4ADRk7D+11TLpLEN1TYzNIFMfFCzUMHNjAgN/k+zM=;
        b=lKAU4BMfbAe0qxUY8KTAXuNH5Qh0wQw8a5XQ+1Uco1SUksCI9E6oO+qlGpzYczRim/
         ec4GDHFtU5pyNJPYl7SDllVQtu6zqIxm1zbQV2w9ltSrTdduYcijHxIDRAyx6JhJawXs
         IHojPQtAwAUejCe/cXUZ2XauNXtRht/lEAdc4k63t/khd5dFZOUOFuzS5lwhzl5gucHd
         KmDHyoB0io723XtFobYVk8njJd2ju2GiAbnQq9WIUx/JLBz5CaUa5Ro0XwLGH2oyUy++
         Flw4ueMQhs59ZhCfMgZNm1sIfBeYYPcZaaR5v55Gum7E56EeEvb41eykbSM/E+dDohhB
         W9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719989112; x=1720593912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J4ADRk7D+11TLpLEN1TYzNIFMfFCzUMHNjAgN/k+zM=;
        b=rK1ZMNdVD9ZOXdxCFn1q92+IVHdNLhuKmDxn/7vTSglkqES1u2R7HXUFYaiW+EU2fr
         uD/8V8kwnRs7L2altracteqG0Sd2j7vsnhe19mDazZtLlpXm8+FWUa6LcWxCHmBA0iYo
         23pbKsMX2R9Ucyds35yvNBAhaq0bXp+N+S1RydbSLfU2XeJfnOYxqnS7XqCywKXNk1CU
         8MZOxMqzxXQPwPDH9pbl/Dwh2w7fmjV/fNmBmuHqrpWulX6uYOrm92AnEz64XnZUAY+h
         eDEHrhlYZ6Tr62p6aHYK/4uTC7EVwfZEci5w4Y4ZHPIBBY4N+MLK8zSi5zw95WtPtXwa
         nGLw==
X-Forwarded-Encrypted: i=1; AJvYcCVYKhBBXHOHSAog2jnXdota1j5dVagA2SbQ67YTXHnf30Ch/fIVD60kBUmH9e5z1UNVMkmCmE1EGCTTo63MEWDVHTufqAYV
X-Gm-Message-State: AOJu0Yw7VHi4XjNdD3cidDFrlYIAXCEYw5xPLt47eZ8JTs9OX9jKGpsO
	g0SHdn18O9oG5iK2TyqmULwIimY/rRNof5yd7OS2g9G3zrO165KdVSc9AfXt2hw=
X-Google-Smtp-Source: AGHT+IF2I90yAYvAiJm3WaMT8wMepKHclm7yHSVey+ikNh+Ehd5cKcb+Hq7+IhSBo2k3Q39f/lSqxA==
X-Received: by 2002:a05:6808:1493:b0:3d2:2585:bc5d with SMTP id 5614622812f47-3d6b4de2f3cmr15227720b6e.45.1719989112457;
        Tue, 02 Jul 2024 23:45:12 -0700 (PDT)
Received: from ?IPV6:240d:1a:ea3:6c00:3019:6089:f0ff:7c49? ([240d:1a:ea3:6c00:3019:6089:f0ff:7c49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a96ac5sm9615690b3a.211.2024.07.02.23.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 23:45:11 -0700 (PDT)
Message-ID: <dffd88ff-57c8-40b1-a02e-499d71f2986c@miraclelinux.com>
Date: Wed, 3 Jul 2024 15:45:09 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 1/3] ipv6: annotate some data-races around
 sk->sk_prot
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, hiraku.toyooka@miraclelinux.com,
 Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>
References: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
 <20230417165348.26189-2-kazunori.kobayashi@miraclelinux.com>
 <2024070241-equivocal-dismantle-5dd2@gregkh>
Content-Language: en-US
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
In-Reply-To: <2024070241-equivocal-dismantle-5dd2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/07/02 18:42, Greg KH wrote:
> On Mon, Apr 17, 2023 at 04:53:46PM +0000, Kazunori Kobayashi wrote:
>> From: Eric Dumazet <edumazet@google.com>
>>
>> commit 086d49058cd8471046ae9927524708820f5fd1c7 upstream.
>>
>> IPv6 has this hack changing sk->sk_prot when an IPv6 socket
>> is 'converted' to an IPv4 one with IPV6_ADDRFORM option.
>>
>> This operation is only performed for TCP and UDP, knowing
>> their 'struct proto' for the two network families are populated
>> in the same way, and can not disappear while a reader
>> might use and dereference sk->sk_prot.
>>
>> If we think about it all reads of sk->sk_prot while
>> either socket lock or RTNL is not acquired should be using READ_ONCE().
>>
>> Also note that other layers like MPTCP, XFRM, CHELSIO_TLS also
>> write over sk->sk_prot.
>>
>> BUG: KCSAN: data-race in inet6_recvmsg / ipv6_setsockopt
>>
>> write to 0xffff8881386f7aa8 of 8 bytes by task 26932 on cpu 0:
>>   do_ipv6_setsockopt net/ipv6/ipv6_sockglue.c:492 [inline]
>>   ipv6_setsockopt+0x3758/0x3910 net/ipv6/ipv6_sockglue.c:1019
>>   udpv6_setsockopt+0x85/0x90 net/ipv6/udp.c:1649
>>   sock_common_setsockopt+0x5d/0x70 net/core/sock.c:3489
>>   __sys_setsockopt+0x209/0x2a0 net/socket.c:2180
>>   __do_sys_setsockopt net/socket.c:2191 [inline]
>>   __se_sys_setsockopt net/socket.c:2188 [inline]
>>   __x64_sys_setsockopt+0x62/0x70 net/socket.c:2188
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> read to 0xffff8881386f7aa8 of 8 bytes by task 26911 on cpu 1:
>>   inet6_recvmsg+0x7a/0x210 net/ipv6/af_inet6.c:659
>>   ____sys_recvmsg+0x16c/0x320
>>   ___sys_recvmsg net/socket.c:2674 [inline]
>>   do_recvmmsg+0x3f5/0xae0 net/socket.c:2768
>>   __sys_recvmmsg net/socket.c:2847 [inline]
>>   __do_sys_recvmmsg net/socket.c:2870 [inline]
>>   __se_sys_recvmmsg net/socket.c:2863 [inline]
>>   __x64_sys_recvmmsg+0xde/0x160 net/socket.c:2863
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> value changed: 0xffffffff85e0e980 -> 0xffffffff85e01580
>>
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 1 PID: 26911 Comm: syz-executor.3 Not tainted 5.17.0-rc2-syzkaller-00316-g0457e5153e0e-dirty #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>
>> Reported-by: syzbot <syzkaller@googlegroups.com>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
> This backport didn't apply at all, are you sure you made it against the
> proper tree?
>
> The original commit does seem to apply properly, so I'll go apply that
> one instead...
>
> greg k-h

I assumed the following commit is the latest version for 5.15 stable and 
based the patch on this.
Is there any difference from your expectation?

commit 4878aadf2d1519f3731ae300ce1fef78fc63ee30 (tag: v5.15.161, 
origin/linux-5.15.y, li
nux-5.15.y)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun Jun 16 13:40:01 2024 +0200

     Linux 5.15.161


Regards,

Kazunori

-- 
Kazunori Kobayashi
Cybertrust Japan Co., Ltd.
https://www.cybertrust.co.jp/


