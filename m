Return-Path: <stable+bounces-5067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28D80AF94
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6EF28171C
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 22:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E558AC3;
	Fri,  8 Dec 2023 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/5UJK4Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19B10E0
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 14:17:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so6225e9.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 14:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702073872; x=1702678672; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8NS/q6MZlMtVuhwouxtULy+pDCV492DXJLYT6vzHxk=;
        b=g/5UJK4ZdOZUsUXBfSJZIuPaIi2Zb4P2NQ2++VRT06TY6/gyXek/vxqkXmiKgRV0Po
         L4uRwUA4RrJ0I2mJAIcyffIrocSucAvI877u6Voj5Rt5byJIt+zDeBL4MpTkFf83nw84
         U1PIwYgQZAeFn5LJIBED2Vjou5Q/LI2utJ9qcWddvN5uqQMLfoFMSWqB8RNP6TCqsDh1
         1UtluCgaAofRABiUamea6/onsam12H65M7vKaYqhEW8EAdnm7+BA8smkIw+wYYRh/59N
         De/qALiDZl+yAK3z8GdBBR9O4CVE/maeghRdn0yxIoKv2uY6WYCFlySxve2Z9hLyasdm
         jZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073872; x=1702678672;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8NS/q6MZlMtVuhwouxtULy+pDCV492DXJLYT6vzHxk=;
        b=oB8vJgD53KpEnRGG6U9aRWGCLIJzQGlwbJ+s9u6Ccl9gm8h1q7GsfgN4MsnOTNDhQV
         jhlVNGUKzmgIcXaa+i2pZ6mRvJ4bxL87UjXMFumacIkLOFazW5jgQFzQC3XiKBqSoYi0
         G9ft8xhNd5/EwHhpOJMcgtCgQFENw8NmV79KaM37ISOqXDsT8ibaatz5OWORloHliIjN
         xHKgeGEIf5ubJWNo/9MBHqvA3m0prHec9d5NqMWOO1nsI3xgjTG/0g3gygCDDDdEFoCt
         gWtTUJa/7/OVm9HhfZrxaRPmpVYrZZZWmVok2lp5Sy7516P1sLr9Bchevx3Kwb5MPRNY
         NCbg==
X-Gm-Message-State: AOJu0YwzLGJpTj18kYxakR0eCCmKWF6S1kojniLEsHUdyC2pvvDrJkhO
	PfNCKsQ5Mesez7YIMQsAO4pWs/ys7q3mpsw5Z5vyomwvoytXP6Yf8N/PSA==
X-Google-Smtp-Source: AGHT+IEvATgDaKaN1ndd8Lvm9xiiFd0Zapn6U3J69ChczCSE4msgaHrZWbaOjZP0gEbqvHTERAya25iiOwFPuQM4XGM=
X-Received: by 2002:a05:600c:3491:b0:40b:33aa:a2b9 with SMTP id
 a17-20020a05600c349100b0040b33aaa2b9mr111109wmq.4.1702073871892; Fri, 08 Dec
 2023 14:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 8 Dec 2023 14:17:36 -0800
Message-ID: <CANP3RGcj8zskLQLcZTDZUET-LEtvixpp7K25m4c64wQhvg++zA@mail.gmail.com>
Subject: Request for 3 patches.
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It appears that 4.14 (.332) and 4.19 (.301) LTS missed out on:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66b5f1c439843bcbab01cc7f3854ae2742f3d1e3
  net-ipv6-ndisc: add support for RFC7710 RA Captive Portal Identifier

while 4.14, 4.19 and 5.4 (.263) LTS missed out on:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c24a77edc9a7ac9b5fea75407f197fe1469262f4
  ipv6: ndisc: add support for 'PREF64' dns64 prefix identifier
and
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9175d3f38816835b0801bacbf4f6aff1a1672b71
  ipv6: ndisc: RFC-ietf-6man-ra-pref64-09 is now published as RFC8781

Could we get these included?
They're trivial.

Thanks,
- Maciej

