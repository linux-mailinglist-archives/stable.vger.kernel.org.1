Return-Path: <stable+bounces-185904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF0BE23E8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AC31893002
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F80214A79;
	Thu, 16 Oct 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jWwWirqE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB530C623
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604981; cv=none; b=MflEP6FTvO5r+yIFnJSakwX10Gwn77R9iic5mJNdBwxbg3GK686eJ2xTIOdqo2niwVa1vloj+HdUa+Uc0zBM9deIDLZVUwc8gv8v/ecr9AWp3hX+UiY4/V1u0a0Eb+mQVB3ZjSgr57Qu8z5MULFQL2EtAS8Eid7XMiX8SGJjKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604981; c=relaxed/simple;
	bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F40HxQxU8zWiJJhSQo1RFh1FLiYyGhOFFxAmK/13OQHsFspXNVwb1thV5aWP65KdaKKwqiunwu09Qx0zNZKGktL6GOshludqTN7Uha5uZopYI2d+G7C6dSlqcAUT65CSHc3R3nyb+sw5VmyfGpClH7T7piq3GwCDtfyRGQb8lsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jWwWirqE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7836853a0d6so1212187b3.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760604979; x=1761209779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=jWwWirqE3QEI6lWNFj/7+5RR2L5bxPNe1ud4s2AtPOvfbbS5A6CkYZWza+a6RCNDFH
         93N+UCon8hBkdIT6saX1iUKgu3f4apc66BBsMJq/MIDKs+TdSz4mspMFfmD0JPfF4+dL
         WnZU7tbGwhhLhy49RvQbWKJHTunb7Bcd09N4LO8G4o9y8BrlG8LpynOcAKIJRSqy+ib5
         B61j9QvIGyN7LziizwQQnQVdkf52qyXXiMoUmSOJBiqUAozR9vzOVz6Eo0RvDqg1gyrP
         QMgnxkv5gBxS7x1BkCnik6MN54stZ0EhLzw870phdeFDMvYuqfNrK6URwWRZtpHIPkSd
         DbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604979; x=1761209779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTJ5BDmS1jbavXTN8W5DVTEeJJq886cvTMsOxekHMXs=;
        b=qGy/xm7etAqjwYOa7wNAO7pAgGbUgPURK3QcK40xpJ+2OxdRYFuDC+Wen3Op3B4wk1
         8Ytnrj/qijZR2xV9LLdZl2sN/6e3l5I13LanViv0x9eGD+4Fp2SLG7h/cV+MvUyoC0PB
         ystAQnX6KLxdt5m2mBUx63jWSP1c4NqaBcmaXqNEGho+KU3erFyyuVTOJdPq6p/F66cZ
         Pljjty74KEnlSo4G7UwPKoDItD5E1ghzyy1PuRt9fr2Qud84oA3o/0WDchE46M/kSifF
         khrfXB7+8zlzqrPt+d6ufHwRuIcDchHnKzY8SePwqOienTHBNN5NYZOXbAcaTkeqDnrh
         lpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWtU6aEAUye4dCodyVw/0bdjQ/ienAaMVlEcUsiGIM7iHjpDvpIVGj72YITrINYa8KwcnJPfoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgOAxCnFTyuPdEXx+xlL9Q7GpiPzp3dnydY0ZlAIYJhe15Gcd
	ffIAZwuGa1pkMI/BGlJgpiRNyH6dU+0bl9St8owdDNFVN5CwddjdPERlJpvCKT7afdK3YsMb1nk
	eRgxtM+VJ2uh4G6rWZiFjrrO92D5PKGyoA2ocdZ8PMA==
X-Gm-Gg: ASbGnctYf/yi/fFjVRkOHbBAXhPTIXcCHy/bIvwEGN7KVdiIS4uJspzouD/BOADqxb3
	YhbFkoo870OOqmT0EcroHRuPsWTjsPhWBcxU800OGhiIP725rMKwObXSknAenXTnHoJrB2jqJQ/
	KW677DbaGQQYs8qIphgCzqxTCRNK1QNx1AHKeRsh9SquZyxGL9DJCgOCoX5Wi55h0tA/R+HsaPR
	QOE1XphutATAXwm0zJ6f/3f4S89kuwJFGE15etH2Bat9K87VmKjQ4WweQ1+tINk1yAl
X-Google-Smtp-Source: AGHT+IGxqTGy5wHmODLi1UF6gIFjWY6sKPakop2EXbRVgjjq12zyCIQCyGdiYtedanfT5A77kDydHAWRiH5qffLKEn8=
X-Received: by 2002:a05:690e:1686:b0:63e:c3a:ea77 with SMTP id
 956f58d0204a3-63e0c3af55dmr1343586d50.14.1760604978793; Thu, 16 Oct 2025
 01:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Thu, 16 Oct 2025 16:55:42 +0800
X-Gm-Features: AS18NWB1MKGKlQ42nxBswbDuR0UxKYudldovqI8s1wflRtIJVP8mzsQzwaKGcuo
Message-ID: <CAMZfGtWhgHoYU4c2Yz5w6XCXJ0oSoJbm0_kW=YvjFENv+pDj3Q@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: always disable IRQ during THRE test
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial@vger.kernel.org, linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:05=E2=80=AFPM Peng Zhang <zhangpeng.00@bytedance.=
com> wrote:
>
> commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> has been set up") moved IRQ setup before the THRE test, so the interrupt
> handler can run during the test and race with its IIR reads. This can
> produce wrong THRE test results and cause spurious registration of the
> serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> short duration of the test and re-enable it afterwards to avoid the race.
>
> Cc: stable@vger.kernel.org
> Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has=
 been set up")
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

