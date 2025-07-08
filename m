Return-Path: <stable+bounces-161328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509EAFD5D4
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F2C5830F9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBED2E7170;
	Tue,  8 Jul 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="24xFTLhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C62E6D03
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997551; cv=none; b=dc+Uhx5VeIhacc+tDnnEzl4P8kUxljEhsB9ZrQ+6+o1nV3L78O7jiKH7cOxHiG8a1GC3g08RuAUJ9hnnaOZKUsbnUJ0mJHopsxnyzm7dT3fMBxerxrmCnpQbRB86nvqY7EeQsg0jVSn4H0WBB3utbbrE83/8pkvPUz1mNa/XlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997551; c=relaxed/simple;
	bh=z6zCXSdWaqo/yFc98YMQU1j3enDa55bjqzc2L1pQXlo=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=sJb5BS0M5yQD+aWWITYGpzYgBc1PoXRnQu9UzwCUhErHZmHGguXRJCjpIUOpv2Cpmv28iS/NlB3msDgG1zwjkv78SUr56gNqwzuUVZMXh1TZ5AoZPb2P4rNoCSqF9KV/jOOJtYWbU0R0d2p5matGjkfLyqoeTInLcCam5POqpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=24xFTLhZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-712be7e034cso41078487b3.0
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997549; x=1752602349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpluEhLI/t93zqxg3ZqOBakRHmNZJcMqoqP5WiD9hyY=;
        b=24xFTLhZk6kWiUdF8k+9tUJlB78XakwPBC6EMsiEKTRKtURZFZ2JbFx/rEhSfD2DA0
         Y6OgOgflxOr9pb036dPrLoZ0/DXSstVmigeo31c2GfaOh6bic1RXKGEtVmN1OrVpJrTA
         73WahcIy1iEQ6aehY+FBZwTp9lyU0X/UtxqhXVHf8rCH8HNiT1tV5RYWkixVJWfJADZ2
         Ns2YPPaibuuIDmaun1Byc8J2XAN/7oSPGQjY4PA3zpbF1W6mxZldPLpk/n2xzUnJ2OhG
         1e/H31rwPVhgxm/TQUT+ouATZLL6K76mv/JWD/y1ayA9HLEHmSbN+HZjBKIt/j595Vif
         cCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997549; x=1752602349;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpluEhLI/t93zqxg3ZqOBakRHmNZJcMqoqP5WiD9hyY=;
        b=usydqe2ZIfWyveWN6BryoR5S8RlJ+I5MIS8T/vpabG+pJApsc/4ZzDeWVKBpAHZAwq
         OnqWM4gf0X8BxCbHAFu7X2t1W0FqwkDmJxJY8yzhMqu13U6omT2aag/KpgNjaw7WDqfe
         yMOAUyowyKFFP0pZjqswdGeozLChT6Pw1Hq46BHOI3ZGnV5L9W/y9+ILbFQPcobnCelz
         sGe4IYhKCwlyHEu6vEetO9Ej67UXFl5BrNLZSMeq53+s+lv8LP2+4DM7tugIwRuO2fef
         RBlUWGhqwJ86tyU/navHI7O3i6N8Ltv780+qReMUwdMZDAQrT9QvznCW43qJX5gahap4
         96DA==
X-Forwarded-Encrypted: i=1; AJvYcCW37Ar+IR4kOeJnjG6y71rRudEA4FCikOKYck7by3PLCpuQDjjtIpoNLRutL2pEeLSW7bdTuZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKexemmkLMvlLc8TiXVaQaCsD/lo9xPTc/r1RnCxnl9k0Qast
	aXN6mVEGcezwwfqLMp7bgoLE1xD6ATf4dSsfAbaLn1H/dBB65AnOAsG772PpC17vCVpAHSHVkLv
	O+Ifu2prqYiq5bPjYnq0zuID66zfHUfEgstMsR4MOqg==
X-Gm-Gg: ASbGncuh6P4HWHRkFr7PQ1Dn4tjQcycfnrffvv7U03TccCoRCHY4Sr5t0LxhUUSa5H2
	zS0XuB1skT85h+HmS03Q9nxuBKkASOrUkzHLTGDy1BYJjaNUZzIobGeddSfVwosshUVAt7GD7Q/
	2lTkOSzKzHIr/hyk2mDh2/0BSPXNMokwr4i2yN8OkAEg==
X-Google-Smtp-Source: AGHT+IG+4HWjLu+0O1LFhU9JnRv9X/8QQrRk1DV6BPaDmP1/LVQnnzBq41MYBWvSi3CsEchZkrxK+CsDpJ8TcLsVnq8=
X-Received: by 2002:a05:690c:708f:b0:70d:fe74:1800 with SMTP id
 00721157ae682-71668d2297emr248634117b3.15.1751997549114; Tue, 08 Jul 2025
 10:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:06 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:06 -0700
X-Gm-Features: Ac12FXyaUW3BGkmwTlhPiXguDdGywMVpOERrBFBwjmzoqbIkX3UQ9ebEsi3mP7M
Message-ID: <CACo-S-0gewXY9fgrQHo5tmU4XkqUwqyCK=Y90M5M8Sd2DtmXiw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) undefined reference to
 `cpu_show_tsa' in drivers/base/cpu (drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 undefined reference to `cpu_show_tsa' in drivers/base/cpu
(drivers/base/cpu.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:320f186cf70d8d6a8155682d995d1860d2ef3445
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  16a0c0f862e842e4269c2142fabfece05c2380b1



Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: drivers/base/cpu.o: in function `.LANCHOR2':
cpu.c:(.data+0xb0): undefined reference to `cpu_show_tsa'

=====================================================


# Builds where the incident occurred:

## vexpress_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d4a0d34612746bbb52003


#kernelci issue maestro:320f186cf70d8d6a8155682d995d1860d2ef3445

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

