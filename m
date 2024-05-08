Return-Path: <stable+bounces-43441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A658BF59C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 07:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E44A2857EE
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B227179AB;
	Wed,  8 May 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcIa/Bhi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E661757D
	for <stable@vger.kernel.org>; Wed,  8 May 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146970; cv=none; b=pAQNapXhiNlF/Ff38zCoefL2kEnZDNA4mOUoXhdDQLpGPx52mH3htxkHid/rus/xmrGInKQSiI9yDBiHidiUOMYdEiGkLXVq4/54xh0R8bth5BN97gKNnYkTkVhHZtooZ9EOOBlDFbINdCXYm9cjQsH1g3DEh6wFraojX9dYjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146970; c=relaxed/simple;
	bh=Dm8oAyDId/BGzFguq4WTwi8cfuw6NO7IL3CwBWqI+YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFo5CDmDFlK7Ivhd5spME3sVFsN0tAsMn78KGO+CtzAZzRrtvjylXMkaLDK0f3HkJPDwNGScfBKfkLjWuHhsF2HshRUfEXXuV40SdyIcv8Bw0uEm83n928ED5HZW/8/cjrgP+ddy9vL8QETIfeUKvvWcf9Cse0E90CsdnevWuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcIa/Bhi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62036051972so43325377b3.1
        for <stable@vger.kernel.org>; Tue, 07 May 2024 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715146968; x=1715751768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8is/8kMXXquytRmRTTojazPRXnlwoDhApNzUo9b3+OQ=;
        b=KcIa/BhiRW5xS3AQueE75g59SNsIUK7uFzmASvX+e254/TVlCrWRvk69o5U56MBJVJ
         +6xNpGUi81LEsfeMlpf6hPyxUdTvREE/rIno9US2AeUv9/8rmuCvX8qkUtO/S4P8x9A7
         gNql39MBxjLtQik8dAb4RLs/g8TlxD2m+dPOYdISqkTDJKRFqa+foXMAvQz00Bh58S6/
         LHt55T6ueY+mS8FEKFflcKay5dgT8SAdfyf0xb9P5MfFn4/7Zh96p49GdgRLyEj69xui
         BSmXw9E1iueHRuA82pmMB9+39RgIgqlXs/LhwyNLzhxGWgRGtzBOCF67qE5Z49dGQA17
         TOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715146968; x=1715751768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8is/8kMXXquytRmRTTojazPRXnlwoDhApNzUo9b3+OQ=;
        b=nWVM4c5YRh7UNTzDuO+G373wKaEdQLWtjAjiKoKP5VVQJPFvTSQO9+6i0ZLyw7XiwT
         xoQCoqv008wXEtEVa7JBkq4grMRR3UwIuYa0qQG48dx8un55M33RfSk+CpHYOgLduJWx
         n+7Ty+aI7rxLvP0LX/66EoigzQQPmUDGumDmq9SAW7TGpYogmYIkYPBgIFlK8nBoo768
         6v50AMB+v9qqjOKXsv2ZZbDnEp40VDVpteGCDwlYcc+LRFA2qOb1/nss2Ips7950hKay
         mkJp0i2zMQkJx9gpq/YnX2y3xd6hQkMKgcw5uRlfE2cy/BcPVEnX134Gs5nrbNg+xaYs
         lasw==
X-Forwarded-Encrypted: i=1; AJvYcCVKlC7UvzhvAuSiyiKJ7dveYv2j8g8r2GXIVaSxfBodg0JE53rJmX4kOKc6VlD3z8iZXtbgCvP6yWHjevSDuHvVwmdfMPA2
X-Gm-Message-State: AOJu0YzUQi5KbY6zjVJGf/U+0zaetNPlKOCp8flTiUp0FiQRqwLSXOPG
	aYf1RPcK0dW/a0UMiwwnlnQ8pXnOAvl9g4n1nTn0TXNEh88xOBouB4GgqBoZIVzQN8eJtLacVCF
	vXf2gyHZrVKeHEtN/egjCtiycNIwz7qMMjetRrg==
X-Google-Smtp-Source: AGHT+IG24D1NQIZ27R3N3aZ27xeVwEEsTRm5xCfdyZ/r6uMBhrpmntSpIHxXqQrXwipOem08bGFWGZKtDUaSlW68z1M=
X-Received: by 2002:a81:7182:0:b0:61b:3356:a679 with SMTP id
 00721157ae682-62085a6fd15mr20951377b3.17.1715146967118; Tue, 07 May 2024
 22:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430082717.65f26140@kernel.org> <20240430160057.557295-1-jtornosm@redhat.com>
In-Reply-To: <20240430160057.557295-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Wed, 8 May 2024 13:42:36 +0800
Message-ID: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	vadim.fedorenko@linux.dev, Sumit Semwal <sumit.semwal@linaro.org>, 
	John Stultz <jstultz@google.com>, Viktor Martensson <vmartensson@google.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Wed, 1 May 2024 at 00:01, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> > v6.8.8 has 56f78615b already. We need another patch, Jose?
>
> Hello Jakub,
>
> I will try to analyze it during the next week (I will be out until then).
>

Not sure if you have checked it already, this commit causes an issue for the
db845c + ACK android15-6.6[1] + AOSP main Android configuration, the
ethernet does not work,
there is no ip address assigned, like:
    db845c:/ # ifconfig eth0
    eth0      Link encap:Ethernet  HWaddr 02:00:89:7a:fb:61  Driver ax88179_178a
              UP BROADCAST MULTICAST  MTU:1500  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 TX bytes:0

    db845c:/ #
if I have this change reverted, then it will work again:
    db845c:/ # ifconfig eth0
    eth0      Link encap:Ethernet  HWaddr 02:00:89:7a:fb:61  Driver ax88179_178a
              inet addr:192.168.1.10  Bcast:192.168.1.255  Mask:255.255.255.0
              inet6 addr: 240e:305:2c88:4700:4b6d:926d:1592:fc5e/64
Scope: Global
              inet6 addr: 240e:305:2c88:4700:edc9:86ec:7c5e:b028/64
Scope: Global
              inet6 addr: fe80::32ce:8a2e:269d:e53f/64 Scope: Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:966 errors:0 dropped:33 overruns:0 frame:0
              TX packets:475 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:51193 TX bytes:39472

    db845c:/ #

One thing to be noted here is that, during the boot, the MAC address
will be reassigned
to make sure each board has its own unique MAC address with the
following commands:
    /vendor/bin/ifconfig eth0 down
    /vendor/bin/ifconfig eth0 hw ether "${ETHADDR}"
    /vendor/bin/ifconfig eth0 up


Could you please help have a check and fix or give some suggestions on
this issue?

[1]: https://android.googlesource.com/kernel/common/+/refs/heads/android15-6.6
-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

