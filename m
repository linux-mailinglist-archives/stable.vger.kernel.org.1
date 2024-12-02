Return-Path: <stable+bounces-96151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585989E0B41
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2132826D0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA171DACA1;
	Mon,  2 Dec 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRwO00mB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBF1DD866
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165005; cv=none; b=dJ8WkAUCwBnrY0lGV9h62vJQLa2gfOQusd3EDxNOH07WTQd/EKP6EozkCzFsPDul8XoQw3BQE055OKdAKnXhNBikNPyGtFPpfZGX8YYUDAwXxiteos3Av+gqP7fh8smPESg66zkACn3ejI+xdOdbci0tALI1sSuwjjSfdoeQE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165005; c=relaxed/simple;
	bh=I6X+25HwarITYfnmWvypF7d0Hyw8TJMkjS5mLztaUow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kcV3tC/mnDFnvDQt4vGkVHSbBLTkrEu7X8RSlAVA8t4DJldE34VMrmErEHS47L2Zw244qKXcVZNWV5DecbF9QiWty0k7TodlrVc2wttqJwmUR6NkYarj/LoC/Ghh1b8zJ7KgtrphOxrLTRKhBUUx7kW99K4XKYibViYG5vzxJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRwO00mB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85b8d1fd1bbso834470241.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733165002; x=1733769802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Se8T5+LK18s+wDSD1Sg761iFvt2oWO3ZqKqGkylKq4=;
        b=vRwO00mBVaQsZa7xkk9s+4adtMazWhEeR6wUdCQpB9KImqOqrvKi+Kzf5ooFxaE1jT
         g8Gn9gHP9ypqTtsFwO01ySW75w9R69tVzD/miVcUloPC1U1PPQpv6kWKEXdf3vmgh3u/
         X2R+BrEiadYCDDC2GR+um4g/rWu12d8oCpxunK2oXuqtQS9G4W6/ijD1RUBnGQFvXkfF
         MS41wOcL5yKiywxzB3dkDs+q7IrcGJ96ofA+d1aT1ijwSXMj0hBf5yvlLF7fI+c2wPw+
         9rqYFfW1eXJRla9ubo0oaFypYA887CFJJXVqI4qPEkQeDYaMSmYhi5ikLIUolHMi/CvY
         +RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733165002; x=1733769802;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Se8T5+LK18s+wDSD1Sg761iFvt2oWO3ZqKqGkylKq4=;
        b=jnIRFPHCUB0Zxyn7bv/lTFiWFwNgvBDVkvkRe5diMb1VmPh0jy/4EjvL32spDxorqI
         IlYRY1mQogk6vaFmH58P6SsFfjkFVHa2fG9nEkJQJERCIcJOD/utW7Y1DYMF0QcA005m
         DEIr6n492WgdHgxbdEfYRUStSKEh3OW636aiaBrLBG5lvlwoXQ2LtG5nCNu/5oxOba8T
         cS9HR9EPijSdkFYbcxMQOTfSsEx23KvJep0jOUQlroUvQbCrNa3YptSAVhHu3LYeBa1m
         Co9MiwqmhIy6XlaLmPeUG4RYRx47lMCRCs5ornaMTU9KH5QILmQJ7eK87JlTvzpAcjM2
         tzXA==
X-Gm-Message-State: AOJu0Ywb3VSJcSH6UO1fPtDIqMkhmtUJHidfM+PvHONEIY9Fy2fGJ6ri
	8BU0opLQ2HYkgYjkMPWL6XFOS9AzJOfcyS4ar4AiscaZdrSY7XkPK+7xn5NYQxR2ZYqDkbMhUfl
	yIglKKE3nWZ8FkiaRUdzG7NkL6pwkpTI//WlPKBMRj0lyQ3ht5Bc=
X-Gm-Gg: ASbGncvELyAbs1HhWUnC38ShxQo4A1l7VtXi8YxrwYM27b5C8fUEGrjWKPOJT8JuKRF
	VNIjEJO9C1BSiNjAtK0d8D+zx6sDLSaNg
X-Google-Smtp-Source: AGHT+IHs7hkrXZMkSka2KzYCMq2Db0uhY/f+zEXDn3gxFJFY3CqXCi3w1hz4Fk/YoO+opKa+72vNn7Buyj4pv8VOTe0=
X-Received: by 2002:a05:6122:2a41:b0:510:185:5d9c with SMTP id
 71dfb90a1353d-51556a3e2b4mr30501129e0c.11.1733165002577; Mon, 02 Dec 2024
 10:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 3 Dec 2024 00:13:11 +0530
Message-ID: <CA+G9fYtQ+8vKa1F1kmjBCH0kDR2PkPRVgDuqCg_X6kKeaYjuyA@mail.gmail.com>
Subject: stable-rc: queue: v5.15: drivers/clocksource/timer-ti-dm-systimer.c:691:39:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before '__free'
To: linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: javier.carrasco.cruz@gmail.com, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm queues build gcc-12 defconfig-lkftconfig failed on the
Linux stable-rc queue 5.15 for the arm architectures.

arm
* arm, build
 - build/gcc-12-defconfig-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------
drivers/clocksource/timer-ti-dm-systimer.c: In function
'dmtimer_percpu_quirk_init':
drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: expected
'=', ',', ';', 'asm' or '__attribute__' before '__free'
  691 |         struct device_node *arm_timer __free(device_node) =
      |                                       ^~~~~~
drivers/clocksource/timer-ti-dm-systimer.c:691:39: error: implicit
declaration of function '__free'; did you mean 'kfree'?
[-Werror=implicit-function-declaration]
  691 |         struct device_node *arm_timer __free(device_node) =
      |                                       ^~~~~~
      |                                       kfree
drivers/clocksource/timer-ti-dm-systimer.c:691:46: error:
'device_node' undeclared (first use in this function)
  691 |         struct device_node *arm_timer __free(device_node) =
      |                                              ^~~~~~~~~~~
drivers/clocksource/timer-ti-dm-systimer.c:691:46: note: each
undeclared identifier is reported only once for each function it
appears in
drivers/clocksource/timer-ti-dm-systimer.c:694:36: error: 'arm_timer'
undeclared (first use in this function); did you mean 'add_timer'?
  694 |         if (of_device_is_available(arm_timer)) {
      |                                    ^~~~~~~~~
      |                                    add_timer
cc1: some warnings being treated as errors

Links:
---
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166355/suite/build/test/gcc-12-defconfig-lkftconfig/log
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166355/suite/build/test/gcc-12-defconfig-lkftconfig/history/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.15/build/v5.15.173-312-gc83ccef4e8ee/testrun/26166355/suite/build/test/gcc-12-defconfig-lkftconfig/details/

Steps to reproduce:
------------
- tuxmake \
        --runtime podman \
        --target-arch arm \
        --toolchain gcc-12 \
        --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrBARu3w5Sf8rdEqEy3SJ2mX/config

metadata:
----
  git describe: v5.15.173-312-gc83ccef4e8ee
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: c83ccef4e8ee73e988561f85f18d2d73c7626ad0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrBARu3w5Sf8rdEqEy3SJ2mX/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pfZrBARu3w5Sf8rdEqEy3SJ2mX/
  toolchain: gcc-12
  config: gcc-12-defconfig-lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

