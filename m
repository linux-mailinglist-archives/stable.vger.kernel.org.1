Return-Path: <stable+bounces-171928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12AB2E879
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A055E10EA
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46F2D9786;
	Wed, 20 Aug 2025 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcpFt2N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6A286D4E;
	Wed, 20 Aug 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731668; cv=none; b=rGvyaFSg9qePfGU9UV4PilyBiTuofUhIjeeqLWN868fQLzZInEP70knChYP8pjnYJS+pJqe+7C6OJm8/pwVH9nZd4cPrvpG+KKk5KaFPOCgtg6+KmthlYgKYeO0KeQJBipJM9pnX0kHREsssDunCoVLHR+BzBaTWVfAZz1VDHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731668; c=relaxed/simple;
	bh=PIL6xm/7vGenGtn3AXVWgyrRZCu371nEigq24oJZOkc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mt2kf8Bv6ynhV8eW8Wb2drQCjji6e99E9HUGJDrAHvGeO+R/jQhciSiuO3htVnc4N9y+GHeOH9utMZo0Fr0GgPeJvukwn4UsFO5q7Iw4fA++bZv+mGq1DxxIv1OKBPCZDtbZS3JlGTUpMYpxDwzgVcmtjaU/7bR5q8Zl7xBloNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrcpFt2N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c380aa198eso168213f8f.0;
        Wed, 20 Aug 2025 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755731665; x=1756336465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIL6xm/7vGenGtn3AXVWgyrRZCu371nEigq24oJZOkc=;
        b=VrcpFt2NI3pZbiZ6wYWecM9npQjkPUWki6CCxt0gCx5mc3E8id0vqfTigyVgmQ3b3E
         Sz06hihtVeQCIWv6IHCwEbnzUz3qFdxrnw18SWbhP8qGlULkkbz+3+4JJS0r++Etckgt
         UTuY6o8/fqKRhcK024w6djqRoJIurML/vEPuLywtAhUJ/G4lZWSKGxEuTEAk7d1XDKeB
         jKC5qflQhL/6YVRJsktH8M38mJU9cvvZGluGZ7mMILuIaH8BQ6w1Hy0sWZeISo5lyJft
         OSvBJLJAh/D4jLZfSU8rpe2HElEquEJbhebgJnif6VsyShOxnQ01c2ClZbTUGOhvPoED
         9wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731665; x=1756336465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIL6xm/7vGenGtn3AXVWgyrRZCu371nEigq24oJZOkc=;
        b=s9XuoDrC6MssP5pxwclj7xnrZiXJB4dwCIfAIdJFsTAmg2jZSqfQN8+AaNr8dYrj/z
         1E8czW4iBl3OTQDdFPzjz5sA2mDhuaZGL1XcgxfG9wE2sJLAVe/fuRflJ9P0f8sP0eEG
         QKRLCDS/OtK/N+2iDTmjENn21vWB1ZtX/ZrOfI4ykI3NvtLItfI+aQQAk36nIzBSDVQm
         +VengsfqLX+LsrWbb/VOKZp++QdeQjYzr+oQwYPUXhw/87wORzPLts1OtTC18O4y08Yo
         IaGBHLx24Hp+hqk5yftiSezfdShu77PPCKD4dHmsKtqv7+InDrwbdOzyqrZvFEfIo2ja
         bZzw==
X-Forwarded-Encrypted: i=1; AJvYcCVFqgI4Vk79l+LGktWwdbuM3jMA6A1l/m+uxKitDk/bVbx5IhMOrGQEN8+26E7hIZmD1OhksH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlpXh3ExnyoIwPr2Sm7ohvV8sclOjW97+jsC0BngoGku0KF5P
	CQM0Jzu5RHfRGa1fR0ejqcxb7iJfUS3VUrKtXTys872vDnBAeIawD4MBxO4NPdB7ifAcQpgge8y
	5q7oQOaVMt3iYBajwkoTHh53xU1yM3OACkccjrPbK+XroZo8=
X-Gm-Gg: ASbGncvsjFBrMASXmW63JViUKsITgpl1AsgZiNd7BG/dNogWB/Zq8zwU6OMT59Ll0MB
	aYX4EGPAXsvAUa56V7rM1hO6Om9RlxcFLqw1yBgVknGcE0F1DaIuLeYDJuzQu1LwKajrf3KAQEO
	UzS2XJe/q8hobIP/mYNwULPRwxvSn1R4E2n/g9CpC9ZEKYQfauTr0zT+sp0i0TEyxzlph08MGIW
	VsyzFQfLcWGn6+N6g6ndbE=
X-Google-Smtp-Source: AGHT+IF7xL/J5qeGU7qUUnHMyy+vQH5Tt2oPV3P8wpyhba8q4+IEiSNutYzfYaQSwQ/uCj8lCOLnITp6KN356O7nlYQ=
X-Received: by 2002:a05:6000:2911:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3c49736a0f9mr356214f8f.44.1755731664163; Wed, 20 Aug 2025
 16:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5Za15YWs5a2Q?= <miaogongzi0227@gmail.com>
Date: Thu, 21 Aug 2025 07:14:12 +0800
X-Gm-Features: Ac12FXx0gBLh0T8RlKB41soMuTeq_ifB1SJzNYMK84XGbBhFyPuTKVJTzH5GSIM
Message-ID: <CACBcRwK8wUbJ_S=z4QQg_CGfVWQaMd6HktdNCRkfG22Ypgg63w@mail.gmail.com>
Subject: [REGRESSION] IPv6 RA default router advertisement fails after kernel
 6.12.42 updates
To: stable@vger.kernel.org, netdev@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, regressions@lists.linux.dev, 
	edumazet@google.com, kuba@kernel.org, sashal@kernel.org, 
	yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While testing Linux kernel 6.12.42 on OpenWrt, we observed a
regression in IPv6 Router Advertisement (RA) handling for the default
router.

Affected commits

The following commits appear related and may have introduced the issue:

ipv6: fix possible infinite loop in fib6_info_uses_dev()=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3Ddb65739d406c72776fbdbbc334be827ef05880d2

ipv6: prevent infinite loop in rt6_nlmsg_size()=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3Dcd8d8bbd9ced4cc5d06d858f67d4aa87745e8f38

ipv6: annotate data-races around rt->fib6_nsiblings=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3D0c58f74f8aa991c2a63bb58ff743e1ff3d584b62

Problem description=EF=BC=9A

In Linux kernel 6.12.42, IPv6 FIB multipath and concurrent access
handling was made stricter (READ_ONCE / WRITE_ONCE + RCU retry).

The RA =E2=80=9CAutomatic=E2=80=9D mode relies on checking whether a local =
default route exists.

With the stricter FIB handling, this check can fail in multipath scenarios.

As a result, RA does not advertise a default route, and IPv6 clients
on LAN fail to receive the default gateway.

Steps to reproduce

Run OpenWrt with kernel 6.12.42 (or 6.12.43) on a router with br-lan bridge=
.

Configure IPv6 RA in Automatic default router mode.

Observe that no default route is advertised to clients (though
prefixes may still be delivered).


Expected behavior

Router Advertisement should continue to advertise the default route as
in kernel 6.12.41 and earlier.

Client IPv6 connectivity should not break.

Actual behavior

RA fails to advertise a default route in Automatic mode.

Clients do not install a default IPv6 route =E2=86=92 connectivity fails.

Temporary workaround

Change RA default router mode from Automatic =E2=86=92 Always / Use availab=
le
prefixes in OpenWrt.

This bypasses the dependency on local default route check and restores
correct RA behavior.

Additional notes

This appears to be an unintended side effect of the stricter FIB
handling changes introduced in 6.12.42. Please advise if this has
already been reported or if I should prepare a minimal reproducer
outside OpenWrt.

Thanks,
[GitHub: mgz0227]

