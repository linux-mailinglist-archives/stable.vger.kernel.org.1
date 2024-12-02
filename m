Return-Path: <stable+bounces-96020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEA9E02D7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551B216CC47
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FC1FF5E9;
	Mon,  2 Dec 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvpIv9M1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB91D8A14
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144681; cv=none; b=uZSqhxwncakaA/e7+F3nqTyTlp+MTmYl12ZTJWOLkCevba2aDTywDMOJ14MYmSmSjOp5Hkr4oTg6sHb1iTcl1VCGWy1/2univoaSC9G7OJEe3RrHxnr06RiwdJeDxwy/ri8w+6xisKdBs/CqNPH7VeQHeK/n332XMqB0P1oeLCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144681; c=relaxed/simple;
	bh=5SzFAbmrIuuLhnpIScNVjFggB919kj6AcIhcCvny7Hw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mEoX4tUsbdMhMLfkSUVhS87f4yQStAzkzb3y+xcjdjonWfaVPgr5uJOPBAYkw2AYqWv42wRKxFJ6NUqUPU+W+4ciG5IGKhVL1HyeAzyp1sLmOdq3DPWd6wWMPWcupTOQ5nu92clilrtsvZBYQS13oagXchzLnd+cWggLf/4YVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XvpIv9M1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea5e405870so1541639b6e.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733144678; x=1733749478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4cBhcu5tPxZOdOqB/un0ZYBCIoqhbKvCypSo+LJw7AU=;
        b=XvpIv9M1qyDvoLvzEqRc3+OnKOfI2sF1gDthr+0ZIkosproaLUYf7++/p0xK3XXAEW
         6Im6z9fPcAfrZarZmn1vuD4EBTJW87BnXqESmgyI7Xq7nWzH5D4aaGC+RgQfxduV83VZ
         SGKciQXfR+egGY/HmnMI729ZdnDHtCtfG9VPY2C0eiAyBiLAjVti85oqUitxJ0SVCjLT
         tMovPcccguQqBoT5J1CpjVKATKz/oEhxSlilA+DXT+6X6v9bR/4mluSSSKXJzGEhV9Qt
         0BY5tMrILdUmjhh0dtBgTqOc5v8nz8RTdR7ppBWysrU595+wddBm2npjFAHiQ31AlgrJ
         gGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144678; x=1733749478;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cBhcu5tPxZOdOqB/un0ZYBCIoqhbKvCypSo+LJw7AU=;
        b=dzkW2bea6SbaVQtZ0qXrYjhO0K7FlizGFVpvwH20W9Rr5XzM2ogpGiBeprxSsJi2Mx
         0HC1o+cM3/kXNQrEwlHd+tJNaAzBo2CyGr8cKUKJL4eannx379tXNq0drXNBuZgOZ49P
         bFVGRcrqT/1cVPhtz6bP/bnZdEDIrvzVO9GuN1w6GwbNqB/9ZKlWb1DnC3BxEIksE7Rm
         uDVwbHD6KGE7bJQkYe87OJrEsh0yaJNPPeHua3vvoFGTbxWb1fHKUNjh8OYHcaFgdS0v
         /PCbpmVEoLmTyLJ3FnN33ocMpg0GHFtoHhTZITTuv5OfqIgl2/Es6SZGKAh2ilcBxc3U
         xaDw==
X-Gm-Message-State: AOJu0Yz3ibWUVWfe4Hbv7TwZinYo53njGGtbmBzntrI+fC/hzabXYn+8
	JdtIgqULpyVYBk2dCy6UlMQTPdquuNyTdn7uq4afKSN3tNcWtnno2sH3fjYjsq6e0M7CK+/HIDP
	26UGLeUrasx1HUPA3b0qkIiDF4H9YdnVpcJ55PYhnEPQCXetUd28=
X-Gm-Gg: ASbGncuUPPnXQccQ+PaaotM0bK0hrYvjC9j8HpCKQoV/paleCbCLj6paA962N+R3cg5
	Yjcsu8Mzx7Sf+CbByA/9ytfznoDLc1Ppl
X-Google-Smtp-Source: AGHT+IEOmtFOZwTN+vKAJuSyZjG158JDX7sBPe506LACLmXQ+1Wnw+DpEiOcyzCcmFHfKXbuwV7o3I2ncAMo1jTS/nc=
X-Received: by 2002:a05:6808:1986:b0:3e6:24ec:d6f5 with SMTP id
 5614622812f47-3ea6db8eeadmr19782665b6e.1.1733144678574; Mon, 02 Dec 2024
 05:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Dec 2024 18:34:27 +0530
Message-ID: <CA+G9fYuMnDvMK-4PRmyOk+KKFONrPPwRtFpnAVtUPrmQhcbOfw@mail.gmail.com>
Subject: stable-rc-queue-6.6: Error: arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5
 Label or path bsc not found
To: linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

The arm build failed with gcc-13 on the Linux stable-rc queue 6.6 due to
following build warning / errors.

arm
* arm, build
  - build/gcc-13-defconfig-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------
Error: arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5 Label or
path bsc not found
FATAL ERROR: Syntax error parsing input tree

Links:
---
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.63-470-ge24527f04ed4/testrun/26165097/suite/build/test/gcc-13-defconfig-lkftconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.63-452-g90b0e9ad2d25/testrun/26154074/suite/build/test/gcc-13-defconfig-lkftconfig/history/

Steps to reproduce:
------------
- tuxmake \
        --runtime podman \
        --target-arch arm \
        --toolchain gcc-13 \
        --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pezSPMVBtcveKsnXdZEqo0TOjy/config

metadata:
----
  git describe: v6.6.63-452-g90b0e9ad2d25
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 90b0e9ad2d25b129a24f464eb4fc0c64b19291fb
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pcDuIKSwfb0J48oc9AheBNQtsu/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pcDuIKSwfb0J48oc9AheBNQtsu/
  toolchain: gcc-13
  config: gcc-13-defconfig-lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

