Return-Path: <stable+bounces-161425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F85AFE68F
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDDA18940FF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36328DB66;
	Wed,  9 Jul 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaJ7VSmq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3A25A328
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058627; cv=none; b=o+fChLaZLxYHRGKpBNRCpXFDpDBT0fqunqIuZyMWCSPHWftgZUUC3UaWBz/dD8Oi4Ix6ObJ8XR1ZAUmM9MQbno72/UDt/wL4HZtDjUfIgJuNGCb4DCJU21RXbypbakfV3bExNNupZAx/SdhtDyPHUjZ7qiLXppTMvVV7zwEv260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058627; c=relaxed/simple;
	bh=dLZQA4g4l3IkyOO4qanx0WXyNBgnxKd6OEhOrizi5C8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O22xYWWDPOhk9CQzlZqxki7txgrdT7VbTnw8XleW/sJR9BetF4i4EvL/GQV59yDSF9gG87VBUR53RO4TdeqvWI/gA4bQh8LgCJ0vI2I7SQJGzYo1GAo4JB3ITEy7ns6yJj3ueO9+xADp8ucsrcqFZMvZL7aruq+ZNQykC1Of5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaJ7VSmq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so4737919a91.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752058625; x=1752663425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9Fo/6q6G7ngEaiAx4m1CQV8r87Lr8o8jqTCjkiXksc=;
        b=ZaJ7VSmqQW8Umg5b9ZfM1sXEQNJuuvDhCgo7icBQVh/F1uxGO9+l740GL1FFiPS42v
         7Y/0jCpPbXlbP4ZWtfNypRLdm4+ugbvhYJjYVRJyLNKArWdkjRIhImaS5k8NCau4lynI
         GzS7IxbRfpAO3xAPw94DkIcZ8kva7Nzs6DIVIcY0tjdQvKFBpggeJ6NQmU7/GcRLM9MM
         NFga5FY1aT9p+CThcZYnorWmm+M8Pm/vUVVEVXpHjkGHdbpGHRCKIU2VnLV7S5iWeADe
         c01r7bk2INo7nEBLdW6Zx74kpw6UKCmdhS07Sgkuanq0sJkXFnXwN5282JnzVTxFqnMK
         PZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058625; x=1752663425;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9Fo/6q6G7ngEaiAx4m1CQV8r87Lr8o8jqTCjkiXksc=;
        b=c7xxY6f9E9YabV+VjHRcqE6yBSBed+haswVagKddWqeWBY7QhuIzoLFP0Dogloiq1d
         sg2kA7ZzYqNgjk/RVB49srmc8/b2mEGRO7LbcJ7MxMd02/SiQNoTU7mtnxru2R/jrkRJ
         L+fHMQRvL62wyfufYOb8xtJic+mOgvg4Kgz1XIkw1pUBBsjW/BNFOCFHyJY74na+CbAA
         Mc/ZVbbSMATArx6CElawQS7TdBoBKsAFQCOcREXbZ8jGySmJjZK+EaQB+Pzx4LmL9GvL
         Mn+v2vlq6QVe2FuqhgvcS/xkSAFfZdZpt0uHCOiSO07osB41KdfmNNc5kuFw2S3hKAMz
         1PAg==
X-Forwarded-Encrypted: i=1; AJvYcCUUo3wi2kV/RUOb6tCZJ4EOZ5ALWZHew/waVJkck+ntxBqH45fc6+pCcg6P1uTXDOP3TWBqQjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvJKlWuy7xYEVt8TWjFf/+bHmeYidVTK9OCg5nyQWEeIjuJxa
	xpFldrUtEIWDDOcuAaFAnB/zT48oNREg21wRyeubfMu9SZUAIwcVEYP4zI9zud2dOrVv8lWutLl
	MTQB6nMMRGOnMLX6GaCH9jrDxl0ir0MYLi5U3HLzfIoU0BQbhqhVGpX8=
X-Gm-Gg: ASbGncs2YT+9FTgkomshbzWMZ2zkq56vB8lBZhrqFIS70sG8UgQ6jnTCJsYI9C36iR/
	1yuI4g9Bg5IN904Rw6z0d/oD974TzmoDXbpUqK85/Ort7485gkq5WPGJUBjEWmB7zO7sasCg55I
	Kz72FwNt4k62kv5kGXpB6hlIlh+R3tZeTc/juu8IAWgk8gEXhX6bJt9k02q20GOAaI2B2p+hqHG
	BMa
X-Google-Smtp-Source: AGHT+IFNutTatG/c0rc0vRQ+X24GyL7MQHT1E2ARrKA24bioV6zHc00zDGjx6jgWIb+1kHtiOYdpe+/tvUNZzqekbvU=
X-Received: by 2002:a17:90b:588b:b0:311:c1ec:7cfd with SMTP id
 98e67ed59e1d1-31c2fdbc418mr3139958a91.26.1752058624706; Wed, 09 Jul 2025
 03:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Jul 2025 16:26:53 +0530
X-Gm-Features: Ac12FXwAAHVDnWkwkMUFj6GSNlLP5G09Mrz4q7yC_iE3b_PCPAjUcbl2ua7X09Q
Message-ID: <CA+G9fYtK2TLbpo-NE-KUXEp0y8+5zXNVRFkqdMjaGgcNFFG77g@mail.gmail.com>
Subject: v6.16-rc5: ttys: auto login failed Login incorrect
To: linux-serial@vger.kernel.or, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-stable <stable@vger.kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, Aidan Stewart <astewart@tektelic.com>, 
	Jakub Lewalski <jakub.lewalski@nokia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Fabio Estevam <festevam@gmail.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Approximately 20% of devices are experiencing intermittent boot failures
with this kernel version. The issue appears to be related to auto login
failures, where an incorrect password is being detected on the serial
console during the login process.

This intermittent regression is noticed on stable-rc 6.15.5-rc2 and
Linux mainline master v6.16-rc5. This regressions is only specific
to the devices not on the qemu's.

Test environments:
 - dragonboard-410c
 - dragonboard-845c
 - e850-96
 - juno-r2
 - rk3399-rock-pi-4b
 - x86

Regression Analysis:
- New regression? Yes
- Reproducibility? 20% only

Test regression: 6.15.5-rc2 v6.16-rc5 auto login failed Login incorrect

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## log in problem

runner-ns46nmmj-project-40964107-concurrent-0 login: #
Password:
Login incorrect
runner-ns46nmmj-project-40964107-concurrent-0 login:

## Investigation
The following three patches were reverted and the system was re-tested.
The previously reported issues are no longer observed after applying the
reverts.

serial: imx: Restore original RXTL for console to fix data loss
    commit f23c52aafb1675ab1d1f46914556d8e29cbbf7b3 upstream.

serial: core: restore of_node information in sysfs
    commit d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279 upstream.

tty: serial: uartlite: register uart driver in init
    [ Upstream commit 6bd697b5fc39fd24e2aa418c7b7d14469f550a93 ]

Reference bug report lore link,
 - https://lore.kernel.org/stable/CA+G9fYvidpyHTQ179dAJ4TSdhthC-Mtjuks5iQjMf+ovfPQbTg@mail.gmail.com/

## Test links
* log 1: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb/testrun/29021685/suite/boot/test/clang-20-lkftconfig/log
* log 2: https://qa-reports.linaro.org/api/testruns/29021720/log_file/
* log 3: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.16-rc5/testrun/29043240/suite/boot/test/clang-20-lkftconfig-no-kselftest-frag/log
* Boot test: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.4-264-gf6977c36decb/boot/clang-20-lkftconfig/
* LAVA jobs 1: https://lkft.validation.linaro.org/scheduler/job/8344153#L1186
* LAVA jobs 2: https://lkft.validation.linaro.org/scheduler/job/8343870#L1266


## Build
* kernel: 6.15.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f6977c36decb0875e78bdb8599749bce1e84c753
* git describe: v6.15.4-264-gf6977c36decb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.4-264-gf6977c36decb

## Test Regressions (compared to v6.15.3-590-gd93bc5feded1)
* dragonboard-410c, boot
  - clang-20-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-13-lkftconfig-debug

* dragonboard-845c, boot
  - clang-20-lkftconfig
  - korg-clang-20-lkftconfig-lto-thing

* dragonboard-845c-compat, boot
  - gcc-13-lkftconfig-compat

* e850-96, boot
  - gcc-13-lkftconfig-no-kselftest-frag

* juno-r2, boot
  - clang-20-lkftconfig
  - gcc-13-lkftconfig-debug
  - gcc-13-lkftconfig-kselftest

* rk3399-rock-pi-4b, boot
  - clang-20-lkftconfig

* x86, boot
  - clang-20-lkftconfig
  - clang-20-lkftconfig-no-kselftest-frag
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-defconfig-preempt_rt
  - gcc-13-lkftconfig-no-kselftest-frag


--
Linaro LKFT
https://lkft.linaro.org

