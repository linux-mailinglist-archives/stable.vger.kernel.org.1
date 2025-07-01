Return-Path: <stable+bounces-159136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0753AEF690
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B541BC84F8
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3C272E47;
	Tue,  1 Jul 2025 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="najk3iCg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C8272E5D
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369406; cv=none; b=SoElbLUpCQ96HF+duYKPKIyvhUrxVyuZBOFtgsMy+s+mYoht6LrkdYHk2/2DKcPlqTchx5Lfgj0AOHnJamXDHemmwvQs9sVaQznw1wTwnTsDRUsePZdiERRzd8gNfj2OJJm47I6YIbutbwq8wSjI24hnFXSWxTfKkAia7S7T/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369406; c=relaxed/simple;
	bh=gl4xZyAxbepWznSUGg6LJeMRxN/TwOAl+AaAGUxLjlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKWh4TzoE61fCIxXQpQyZGB2J2pYC4jqLjsWY74XCTpWqgen4z0WQZxIrNjdRMdolCId/qNEjpxhkkEX9+VhYme/vcrHuMxBNXxMKTcUr4kwT2QcD80/nDTnTFiWxoFbj1mtEKdnN1I+1K4/bCrlWaVGCm6tNnYILkYK0PHjZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=najk3iCg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1457085f8f.2
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751369401; x=1751974201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nY2MChASwYPFQeeJZJw/kzZhoLPwcfZ0+qyLebAdBf4=;
        b=najk3iCgQJ8SdQ2HIRRi3qALXHCMvh5Y80gvWfUATsex+SdoClMZWXrLuhPoZjkqow
         4rpghtTLY8vuFOSjcGXmc/6xFWn3gX31N5Bu81quGWvwA48QhMEhvBsYXjcONCQ7NTzk
         AYyZfI30XYFzCkVrgrEkZ9dLCNjIXp4Icleyk2UuaM2Yf3NeHmPIHavx2rosTmhoirH7
         ab6U13sDdpwUShCRAuei0IavBfxMtTxmZwljmJUxQTrzV2UumaPVaNgL0x7vMJEEpdn5
         oPnSDHN1tWMTabL7/9ete9F2t30DyaFThv/JOO5zKujpMJYhRbuIZropCUptge2Z51ck
         CXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751369401; x=1751974201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nY2MChASwYPFQeeJZJw/kzZhoLPwcfZ0+qyLebAdBf4=;
        b=mSgSiThSF1UH30UpsDa2hHFbOrwxUXdlp+K+NqTixrbqp79R5rGrlXvkcN6zToHmi7
         xxrSuH5/TQ1JKDhP/mox6mFCcR4E/Wb/Xy9orManu8AzIBH+c3GWU9HuGvomXPVbwoET
         tIrDhJ2M21vHIvOQxjTVtTqBorAlTuujNKetg2vtu7LxyWchMO8i42QQvTF79Tl3N0BJ
         3S1ReRT9xpUYSXbsvFuR9+fZbicIuaqfYhTwfyL1maj8JnDPJSSMonsP+l5ZEyBNI8Re
         diRX6TGWwM0dc+bPiKLUgZ9jDBfRa8r0JHapr6ZMx4WYftWVVMr6gfJEemWjaBgWotlv
         1YaQ==
X-Gm-Message-State: AOJu0YwgvM6VMdMVg4EICt4GnHL/fXd1AExCDLIw3DrJh7ALlOz7PEBo
	HGGVkCeQXQhtk29k0dP962WHty1kad2N/cAply01P5HwqNDxj5vk443ikX+Axtb/qj2X+mfUQnB
	RWL5CxGwV9RD3pg==
X-Google-Smtp-Source: AGHT+IGFKc3APByuuUCC/SJ/U3h/jsYQ5L0n7CiuMCpjGBt4me8xIhMm+owqe3Jpb+ZT+O252CMSOajCRUIPFA==
X-Received: from wmbhe15.prod.google.com ([2002:a05:600c:540f:b0:442:f45c:c10c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:9c81:0:b0:3a8:6262:e78 with SMTP id ffacd0b85a97d-3a8fe5b1dd8mr9761747f8f.37.1751369401366;
 Tue, 01 Jul 2025 04:30:01 -0700 (PDT)
Date: Tue, 01 Jul 2025 11:29:59 +0000
In-Reply-To: <2025070142-equation-unlighted-9720@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>
 <2025063054-abridge-conclude-3dad@gregkh> <DB0MKNAAHYVK.3V2BN2WP3C7ZI@google.com>
 <2025070142-equation-unlighted-9720@gregkh>
X-Mailer: aerc 0.20.1
Message-ID: <DB0OMYW0QFR0.33PUE4BU0XS5D@google.com>
Subject: Re: [PATCH stable] ipmi:msghandler: Fix potential memory corruption
 in ipmi_create_user()
From: Brendan Jackman <jackmanb@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>, Corey Minyard <minyard@acm.org>, 
	Corey Minyard <cminyard@mvista.com>, <openipmi-developer@lists.sourceforge.net>, 
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Corey Minyard <corey@minyard.net>
Content-Type: text/plain; charset="UTF-8"

On Tue Jul 1, 2025 at 10:14 AM UTC, Greg KH wrote:
> On Tue, Jul 01, 2025 at 09:52:55AM +0000, Brendan Jackman wrote:
>> On Mon Jun 30, 2025 at 6:10 PM UTC, Greg KH wrote:
>> > On Mon, Jun 30, 2025 at 05:09:02PM +0000, Brendan Jackman wrote:
>> >> From: Dan Carpenter <dan.carpenter@linaro.org>
>> >> 
>> >> commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream
>> >> 
>> >> The "intf" list iterator is an invalid pointer if the correct
>> >> "intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
>> >> and invalid pointer will lead to memory corruption.
>> >> 
>> >> We don't really need to call atomic_dec() if we haven't called
>> >> atomic_add_return() so update the if (intf->in_shutdown) path as well.
>> >> 
>> >> Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
>> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> >> Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
>> >> Signed-off-by: Corey Minyard <corey@minyard.net>
>> >> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> >> ---
>> >> I have tested this in 6.12 with Google's platform drivers added to
>> >> reproduce the bug.  The bug causes the panic notifier chain to get
>> >> corrupted leading to a crash. With the fix this goes away.
>> >> 
>> >> Applies to 6.6 too but I haven't tested it there.
>> >
>> > So what kernels are you wanting this to be applied to?
>> 
>> Right, sorry for the ambiguity.  I've just applied the patch to 6.6 and
>> booted QEMU and it worked fine.
>> 
>> I have not reproduced a crash in 6.6 but it's pretty clearly a real bug
>> (it decrements the target of an uninitialized pointer).
>> 
>> So if you're OK with that then please apply to 6.6 and 6.12. Otherwise
>> just 6.12 is fine, I will send another PATCH if I ever hit the issue for
>> real in 6.6.
>
> But why would we skip 6.15.y?  

Ah, sorry. I forgot that existed (I was conflating "longterm" and
"stable" in my mind).

I've just applied this patch to 6.15.y and booted QEMU, seems OK.

Aaand now this made me realise I also forgot 6.1 existed and it also
has the bug. So I've just applied it to 6.1.y and booted that in QEMU
too.

So: 6.15, 6.12, 6.6, and 6.1.

