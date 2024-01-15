Return-Path: <stable+bounces-10855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006F82D47B
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 08:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC90B2095E
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7C3C1D;
	Mon, 15 Jan 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql8FH8rD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75903C0E
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2dab0a6308so48221166b.1
        for <stable@vger.kernel.org>; Sun, 14 Jan 2024 23:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705303158; x=1705907958; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7+vbnLNbTqlgMKIijxmVM5SyYZF1pkUQABJ605S2r0=;
        b=Ql8FH8rDxPnR8BOUfn2kNQxek8XwRq7CRclDNCiLY+ZXa9pooO0sP+1oOeVsBpcBAC
         SoLhvswPlA+jZ75t3M5xe6Ss4Xhuc//jRIBFnE35XtsPy7DmzGIW4rst5hPeI99RsICT
         FqG5Icz/Q/XS+0tGKbea36iBbjuu33xAY0c43m4aA/gmFv0CiTjr7MmM5CVHSPpkEzXR
         SZYu6aucM0XvDk5a5s1assEgvNcvLbeqrIc9zqQovNOQjucL8oOGBCC3PzDpu+uSTVnw
         9RIrTdVJzKcZDaopJIOyEcps+w1i2mwYDUesAfjtvnr/B/R0iRtlBvo3XghmmLCqbbgk
         ws+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303158; x=1705907958;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7+vbnLNbTqlgMKIijxmVM5SyYZF1pkUQABJ605S2r0=;
        b=S+QDuvKMaUMsQ08GGJFATtPi0QFR8lO5k9fx88Ahm0xM4G8HC9hK6d522akUY7KDDP
         SfYPX25TiQsSTZlnmNr91KpmdwzgPSDz1mbNYc5n+Utfn/mQzbCrPX1xQh4JzuRz2/0y
         eVtCPtHWHPQu+Uqzy59r09zc4Bkzb8Chw+H4Zq8FFqdaqUcrMCy71Fwn2UupvHOQKdd7
         8MemUfRgHTR8uOrRDNGnx0tg0w29TOaqa+aEQoyzvb40wgFiZ9AXYln5XEgYZQJnP4Rw
         v3JjD2L1mr8nAYcSuwLw24yHOwgJPCa7eYFRURy8oNh+hJsnufBQ10DIONuMfFVSD178
         hxQg==
X-Gm-Message-State: AOJu0YwAhtO35YgakbTm3JMvtDpDhrX8tJHGdJUxij5DRDmCpbrO9qII
	diFawZh8uKk08KXMGTTG8ENM4p4aPMJ0atnUZE4KhGCC7DpTCEDD
X-Google-Smtp-Source: AGHT+IGNK55g/t/XuLEEkNIaMrrCTjdEqVmVIexwz8x5oZ1MlGnwwGAn5TuNaamDoMri7goPo3bntQ7ES3KrR+NVxYs=
X-Received: by 2002:a17:906:64a:b0:a26:88f4:3fae with SMTP id
 t10-20020a170906064a00b00a2688f43faemr1983860ejb.67.1705303158289; Sun, 14
 Jan 2024 23:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Date: Mon, 15 Jan 2024 12:19:06 +0500
Message-ID: <CAEmTpZHU5JBkQOVWvp4i2f02et2e0v9mTFzhmxhFOE47xPyqYg@mail.gmail.com>
Subject: kernel BUG on network namespace deletion
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kernel 6.6.9-200.fc39.x86_64

The following bash script demonstrates the problem (run under root):

```
#!/bin/bash

set -e -u -x

# Some cleanups
ip netns delete myspace || :
ip link del qweqwe1 || :

# The bug happens only with physical interfaces, not with, say, dummy one
ip link property add dev enp0s20f0u2 altname myname
ip netns add myspace
ip link set enp0s20f0u2 netns myspace

# add dummy interface + set the same altname as in background namespace.
ip link add name qweqwe1 type dummy
ip link property add dev qweqwe1 altname myname

# Trigger the bug. The kernel will try to return ethernet interface
back to root namespace, but it can not, because of conflicting
altnames.
ip netns delete myspace

# now `ip link` will hang forever !!!!!
```

I think, the problem is obvious. Althougn I don't know how to fix.
Remove conflicting altnames for interfaces that returns from killed
namespaces ?

On kernel 6.3.8 (at least) was another bug, that allows dulicate
altnames, and it was fixed mainline somewhere. I have another script
to trigger the bug on these old kernels. I did not bisect.

````
[  494.473906] default_device_exit_net: failed to move enp0s20f0u2 to
init_net: -17
[  494.473926] ------------[ cut here ]------------
[  494.473927] kernel BUG at net/core/dev.c:11520!
[  494.473932] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  494.473935] CPU: 3 PID: 3852 Comm: kworker/u32:17 Not tainted
6.6.9-200.fc39.x86_64 #1
[  494.473938] Workqueue: netns cleanup_net
[  494.473944] RIP: 0010:default_device_exit_batch+0x295/0x2a0
```


-- 
Segmentation fault

