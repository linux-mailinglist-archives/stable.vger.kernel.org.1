Return-Path: <stable+bounces-128381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71060A7C8DF
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6727A527F
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55B91DE3C4;
	Sat,  5 Apr 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAgStYaL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391031917D0;
	Sat,  5 Apr 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743852214; cv=none; b=GAqPUCQVp9/HrFfkeGzxSoiSsdZTU5uUF5Zl66c6W24YaW319zIMFaPyKs52M6D0xoTp1Hr4tuwaaDcYpwg9tDJwOYSAItyAB7VjwktFCLGHgXp9Sm28NDL39NIzIci1x3vkcAeqDLvIXsMlIH278n+6kuxigeApvv5uGm/h/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743852214; c=relaxed/simple;
	bh=rvZzu3PV7+Qq1z6KqEyz1RML+pcT4FXcKYFqf+mxudw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQnytXgZQDg1kaLEL971ZijfGTEAN34gy47p86YxRt79nR/xi82bTFRjjW0n8+EdRH4o+J5vjc9/cAana2hwza4HCOrIwABc/vlud8AqkzN0x4koWxgb6/NBacyUZglsmeEQIksBMEc+cQj15NOL0cyTno0Udnf2Z7SEZR7cAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAgStYaL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so2669563b3a.3;
        Sat, 05 Apr 2025 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743852212; x=1744457012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZX20hU9jsDEvNi8QMGzQFtvjq3DSEQK4C5TXMmOIUs=;
        b=WAgStYaLrQmYO7ceAbYFYPX9cr9kMd7L1fi7b7NETOxuyie/NcYRugsr+YTFhlm2ZZ
         MkrEPKxDEFYDOJH034RefJF77IqvjUMbVU3+0LoGHOiYesVIjoAEPhm6GSkoYo08UzJZ
         waWlvYKcquc+Wu1yqHm4VS0LWOEqeZt03C84Yc4zgoX+hjvJAyzmjxbiPUlA5fVbhEjM
         SlYM8+/GzEaxINXrWRMRfRrGL3U2Azz9TUuyzuQitbUEv/tuGilscvkH5kyEguyAcTox
         8AEsg5wiQctE1o5Jr17g5o4NAz9ZLOdtz6zbUyi2onsRe1XPc6OZKfFIZ3jvjI0SqFAv
         PMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743852212; x=1744457012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZX20hU9jsDEvNi8QMGzQFtvjq3DSEQK4C5TXMmOIUs=;
        b=Ysl6tyQnZz1zGfbL9ePt1x8GIhaLVKD32ea3IY46wSp16yD7uTH70RF0CgChTC4fuS
         jEWvG7wGp8/Ct91JceufPLIpNLBcCMhqaDFwW3WQn1DWqmY42QtS0yos73IboUcQJZ1m
         GBbuXy7/AKd8YbPL1sUReMbCeG3rie9zM8pL7gkPz3y+Bb3WEWe69QgMfykcY+UBBx4q
         VpA4r2H1BHdvERvRvNBe14N7LeIJPn46eyolOcVwnFtk/Y8XvVqVPYJ4JzX/W5A2e0T4
         Wp4QtjFjeGHwud5kMBWRvBbb3/Ps6sDuUHT4TJwhoyKQRZg+RPK6IdpIF3+myYj8kk91
         POrg==
X-Forwarded-Encrypted: i=1; AJvYcCUoLtvT1pZ5+wThcqoCiaN4M09oScEisTHUG9H0YkXasPHY9V6J0/54KZmN4/7V57U1drs8HmJIzKAhXN5c@vger.kernel.org, AJvYcCX5xYxCLFkZHppaKyckCnEBoWeTzV38gqGR1z+ohUTC0nzMJmgQkBB46uOSEIur0aU9kXMcBw9G@vger.kernel.org, AJvYcCXdBWtTaOpFpzP7VhGmH/Q7GJ6i9XWHzPZC7yMknOveOtMTcGsgWuAmcgnqcMDyTZlpcHpw4LETw837370=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vtVq0gZyYjDx1jTeaPM391rmvVE29nWnghK0hCNfa5NkXZIp
	wBoliXmX4PGpiVt5JiTf4ajue6n+pkWpAxgGrhkSarAOveNKnwri
X-Gm-Gg: ASbGncvOjy4CL4NgDZtyQPm7zoE50OZtWlTM7VvhJ2N2splWDEV6GTPUjDaI1vROrdc
	RcZNJBos24NX2GGY1+2ZuVHxdcTauKNdEjbSWmc9YZtpeHPBoFafDtL/KmIaFge0FGEC2BljR6M
	dFePJn87zHbVDp2VhM5EMs5y2D4aTIuhVLf0ky5hZmzOTr3J+uqONJj2xse7iGSF8p/2dyg7fik
	U9pEgh21Ql4mZRm0rJETwbQSYzGPWzBe6OoEO6Bpe+wsbaB0+42wMdkYAUvIj5SdI/L5q/Uuv2v
	lClqKo2/hOXemtf0BQYKe8Gmk2Kj7uIOx8lisJK2m7CF4GCTKe4Y7mBrf27X96+TtoaHDjjnsSq
	mw6dZQhcP0odmEHrQ/PkGADnh/6rYM9w=
X-Google-Smtp-Source: AGHT+IHTCLHBH921U9jgvr7Q+b2IjSfmOh/lM1Ct6P/k/BHbW31WYiU2NAXxIwif55l65eP3+wzArw==
X-Received: by 2002:a05:6a00:44c7:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-739e7120149mr7511611b3a.15.1743852212232;
        Sat, 05 Apr 2025 04:23:32 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee7absm5178968b3a.58.2025.04.05.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:23:31 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat,  5 Apr 2025 20:23:07 +0900
Message-Id: <20250405112307.485386-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025040553-video-declared-7d54@gregkh>
References: <2025040553-video-declared-7d54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, thanks for the comments!

On Sat, 5 Apr 2025 08:35:44 +0100, Greg KH wrote:
>On Sat, Apr 05, 2025 at 01:43:38PM +0900, Ryo Takakura wrote:
>> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
>> The register is also accessed from write() callback.
>> 
>> If console were printing and startup()/shutdown() callback
>> gets called, its access to the register could be overwritten.
>> 
>> Add port->lock to startup()/shutdown() callbacks to make sure
>> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
>> write() callback.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Cc: stable@vger.kernel.org
>
>What commit id does this fix?

I believe the issue existed ever since the driver was added by commit 
45c054d0815b ("tty: serial: add driver for the SiFive UART").

>Why does patch 1/2 need to go to stable, but patch 2/2 does not?  Please

The patch 2/2 has nothing to do with existing issue and its only the 
patch 1/2 that needs to go to stable as discussed [0].

>do not mix changes like this in the same series, otherwise we have to
>split them up manually when we apply them to the different branches,
>right?

I see, I'll keep this in mind.
Let me resend the two separately with 'Fixes:' tag for the patch 1/2. 

Sincerely,
Ryo Takakura

>thanks,
>
>greg k-h

[0] https://lore.kernel.org/lkml/84sen2fo4b.fsf@jogness.linutronix.de/

