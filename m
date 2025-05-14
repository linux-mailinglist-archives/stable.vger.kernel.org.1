Return-Path: <stable+bounces-144455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73034AB790E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A468C546C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB2221F35;
	Wed, 14 May 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVSWe5Ok"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18221B9D9
	for <stable@vger.kernel.org>; Wed, 14 May 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261724; cv=none; b=jIQpil9/vovn22Lvyz16UnZZSt5DNhtF9YQY+rb0OtK4iuF8kzydZjiszdexCEStRsp+zx/gSpjjtCos9SjrrFMCSeRnIEXJJrQp9UIAXNt+N/ae4721kVjE4jsQ6tXO2b83bpeO0BW+9MbYJnq7i1eI6pcGLQsyxqCi+NMV+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261724; c=relaxed/simple;
	bh=ikg7uKNlFxdtInhouVVjlX/eWNb/Iocaf0FOoIsWq04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLdtBm0v6S1NfZoo47OWcoFJAqBlpaRDHO6UagnKPuH1JP4TqyfumttaInK8m/eIivQIX4IdVmRGApkAqjRov/xZL6r7f2zsUp0HKm9HyqhPaUc3TUoXYCDKzsoC1aH80gOqxMmhHqp2SiUcEVmgmB8iXdCFIbr67iX3pcsMR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVSWe5Ok; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54fbd1ba65dso263939e87.0
        for <stable@vger.kernel.org>; Wed, 14 May 2025 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747261721; x=1747866521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikg7uKNlFxdtInhouVVjlX/eWNb/Iocaf0FOoIsWq04=;
        b=lVSWe5OkMpmjEy0mhYsTTltJfu0oaUtd//WBacEWg7ZSevmG1HqR+FdcNn9YT9vPPP
         5BOQetKQV+LeMQyoORqCJLjIDoBhtLFxdkpRtvP6xuq/keEFldb/aNQSDSQarbtL20oA
         9dxkgEIkGIs7oz4WTcdcE+EIWN6n5FVzOztRQDX1NtiShFJqDH/QHP/K9v+3sYM3HLvA
         O/qrQoBcK3YMD+2Rom5Bn32xjkSG8UNQ4CVXaPPzh6EzrdL6WoTY2p1jtmoRe/gu4B92
         y1+EI5RcIydRYBiulEyJJL9tkHHrNjv+sYHTwG4Th9rf/GG7zGWo0Y9boJoH1zQr8mUV
         yZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747261721; x=1747866521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikg7uKNlFxdtInhouVVjlX/eWNb/Iocaf0FOoIsWq04=;
        b=ptEb9aVCf5mFhR/2OhOHwCb6lTp+Dp2WubdPHRRYkwbuMlq2YSL+oLaGwv8zdcrWFJ
         APWLFlNoBjLOnQUiHtzOXM0tV5slPcsfbkqxl8ygZpab5+hkg/oOHDq2Vjq3K187LcTj
         6UvOb7F1QctHEv7Xq6985VRqU0NLKffLghRrTQ99M0gc0Ovn2kbdJA0X1TwQycyMxpv0
         vmH1M4U00iXTxulk4Q3LeaEwOtt561hpfrqhvcYbQb5IVpmoaFErJZm+Wn80ieF0JPwx
         JbHfs94hohSPZnEs5UR+9O/bqYkBqgHAOFStiJNSisI87ce9zwFHKdsdv17XR/yFNKz4
         E3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeKtivXeNMZF33CPltS44H2KCtjR4F8SWrzMV3m0sJICYl6pBYw+EJII2uOSb5+CCmhyPwJRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydy6U0WtYn9Pb/Ti5iP3D7t5lqa6KdU+7sEAhrBED1HNu321Nl
	ar+QjJrQ8Ily0B26iXlyH6ZAPHRoH//AXmKoOr1K+ZTWG0yNLtIrpF0DDNHw09VKlLOCqacxKdn
	A40ww8uS5LSkTqrA3TSMsu3PBGo6Ee9ZqByyhSQ==
X-Gm-Gg: ASbGncvC5/Xlpc0yDWrAnPyFBaJhWOjqceOPwyc6BgPu44sfqV8LTEI2k4BBiMh1u+k
	q0T94xyB2X4f4GhNX2Wq6hs3B32E4dN4xXW/vYUr1kvG/Sai1azBbSgpqEvaA1HKaQ3bme/PBPY
	n1dnr5mGFcVD5IDIw2ZlbwWk5GlY1TlyR+J52ihYkiMbI=
X-Google-Smtp-Source: AGHT+IE1Vp4rlvI75qMKlDEVkN1t9zzD3BxyByO5SW27Vl1zUjiPYHzMEgLHLW0x21yYIa1dbtvC8PDJZuRwP2Kenrw=
X-Received: by 2002:a05:6512:450c:b0:550:d534:2b10 with SMTP id
 2adb3069b0e04-550dd12aeeemr60274e87.35.1747261720610; Wed, 14 May 2025
 15:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514-pinctrl-a37xx-fixes-v2-0-07e9ac1ab737@gmail.com>
In-Reply-To: <20250514-pinctrl-a37xx-fixes-v2-0-07e9ac1ab737@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 May 2025 00:28:29 +0200
X-Gm-Features: AX0GCFsW1KstBI2jcV_icDkbitXFWIRxmcRnuAcWr-VFZ0eu8OVxn2v41gFG6Ok
Message-ID: <CACRpkdb2Njam8GGuN5yeR+DYvi0xe11xbARaoDepoGk=gAK6GA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] pinctrl: armada-37xx: a couple of small fixes
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:18=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:

> The series contains several small patches to fix various
> issues in the pinctrl driver for Armada 3700.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Patches applied by applying to a separate immutable branch
and merging into my "devel" branch: we were clashing a bit
with Bartosz rewrites so I had to help git a bit.

Pushed to the autobuilders, check the result!

Yours,
Linus Walleij

