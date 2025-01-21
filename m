Return-Path: <stable+bounces-109633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DDA18132
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B026D3A03BC
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5881F3D36;
	Tue, 21 Jan 2025 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoIg50v9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9481ACA
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473739; cv=none; b=pD12bV4fBuOvaWYOvHYKTPgwlCwuDamU7lPLKKLbeZh1NYsHvQKPvg4Svk8iKIjJH2BScM1G1vYtsAg6vteO5F7FlfJEWrdFCBAD8XAVm9obs3ObYYHdEu+IKsjnc5cd+YFRRuLojqk3axsBWPSnnABKNeezXGoZlkPRvaHzxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473739; c=relaxed/simple;
	bh=kxvQch4lmnNeMJ7lVAwLF224MK80vY1EAPZUny6Y1q8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WNjgPhp1gxH30JviD3OyM5EeRPdD/fxIsAIM9KbA3qq2W83gj19rHaFsI6W8JVv3Vj/DFp5lTDiuMDJC7WoWJwIZLU/2qaNbjBrbVCRXMmZCw0JaqYCi4B+lda49XZ6PxPtqPnMJ4KeaIUEIjtkQT7bVIdUHQH7KQGyKksKtMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoIg50v9; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso2856311241.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737473737; x=1738078537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDTSWVQGdCD9tMFkWYVGThW71xYvYXe5j1cL43vjuxg=;
        b=XoIg50v9QfpxZHOdE6D5rmaVXL9WXwjTD1wDEgehmFtjJacgjbVB/6axPIxbkpNUHZ
         ZPGtKv+Qd07FQpbcpKusDl8FKhrlpQ0AKHk/gYt7J/0bK7+oCDviLRvk/NdjwtyNktE1
         pajciiz+ZiANe+0Qk+RVXFl/lDAfiB+QmuQc1K11H2NexdAnT2GYVcFBoC1ikUf9qijC
         bm5k7qX4lAUc/W+XkJuV6j+PdWQ7ep/oLlzDkuhECArbZyOiV5nWg1TaFvUUj914rYyF
         SeNpCHvyFaeZbOjw29W//Iwkp97pq9mKPfDALpEa0GWW7VE4fPafSRVhbI2GBdW5O/TS
         VQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473737; x=1738078537;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDTSWVQGdCD9tMFkWYVGThW71xYvYXe5j1cL43vjuxg=;
        b=ebPXKlUMD6ADni2oENZB6a2MQ73QHKlCHnhq3fNw1QOPYerwFTAaAl5n/GkQF1RCmO
         lnf2fp/6P/7bA0mGME6wo7Z4dfvNAqB64xOW3qBlKdTAY8/VB71PY1elkKrZHG9z5WXr
         hih9ywjqZyjVkfC8c/5GEf9M3Bfsove+qxAhZxR1yIFxezWZRA4p1r5skL/ty96Hc2kR
         mQ1uCEGN8yHWa5QX6bD9sO1wWuoaXYzJaqiFNwpFK2N/tyKtq9sOTbNprA61E2TVLk/Z
         Hm5dGf58bGBa8+SQ1CapMBCU6j6upeyJvQEND/iaKNsGBg30kN9ot4KMOhXJE9tOd3pm
         +hIA==
X-Forwarded-Encrypted: i=1; AJvYcCWN2THZ46yeLs2EKdLYBgMZH7IDmzn+UCIQqU0QFb7HiaxNidHyt02044WUlSvhr5cV50W8Dl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugSnroiQSChRQ9HD4mnDZT5QkY1wxzpe+8At323Tmj41D423n
	rCtX/GLkjTBc7g+qo5iTVxkt/qj05g51N2Io17eouvqMQQG7ziGSL2n0TXm4ODz+prLgYkV8kqM
	VgwX5MWUE1tiBRSkxDuiTnjBfdgQQW/3kW6WjqQ==
X-Gm-Gg: ASbGnctmxg6PvDdaOHkfjqNbTed3FkF478Pu4qKoFBti6g5WFYHRReiNmdi5H3avLvi
	Ugq+t7jnKY09U92eNnCvVY9DN7X9tYHkeXuuhVLZ18Ei0PdEJfKm1jSb6bBEiKjI/WIR43kbdfb
	bNHQxEB9wT
X-Google-Smtp-Source: AGHT+IEkXmzNocUJjw2I/AAezkt1FSv+OwF1eUGF2IDRW82+rqI8Qcvyt/2HQ3OrGqF20lvsYWgENdia/aObxjeuw1M=
X-Received: by 2002:a05:6122:1998:b0:518:9582:dba2 with SMTP id
 71dfb90a1353d-51d5b3b51demr12190423e0c.10.1737473736912; Tue, 21 Jan 2025
 07:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 Jan 2025 21:05:25 +0530
X-Gm-Features: AbW1kvZPuiJxn7spmuQ_i4Aalk2ph3gdDDRTPhIq6UtdNT9EHblhbEuFqNTDoRc
Message-ID: <CA+G9fYvsRbxV7u5xX=5mThTmrd-1pfOYjJZxp1yUUqJfCdom+g@mail.gmail.com>
Subject: stable-rc: queues: v5.10.233: drivers/of/address.c:272:23: error:
 implicit declaration of function 'pci_register_io_range'
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed with tinyconfig builds
on stable-rc queues 5.10.

Build error:
---------
kernel/sched/fair.c:8653:13: warning: 'update_nohz_stats' defined but
not used [-Wunused-function]
 8653 | static bool update_nohz_stats(struct rq *rq)
      |             ^~~~~~~~~~~~~~~~~
drivers/of/address.c: In function 'of_pci_range_to_resource':
  272 |                 err = pci_register_io_range(&np->fwnode,
range->cpu_addr,drivers/of/address.c:272:23: error: implicit
declaration of function 'pci_register_io_range'; did you mean
'pci_register_driver'? [-Werror=implicit-function-declaration]
      |                       ^~~~~~~~~~~~~~~~~~~~~
      |                       pci_register_driver
cc1: some warnings being treated as errors

Anders bisected this and found,
# first bad commit:
  [00ec41adffcf855c3812cec7b265f43c60752f63]
  of: address: Use IS_ENABLED() for !CONFIG_PCI

arm, arm64, mips, powerpc and riscv:
  build:
   * clang-19-tinyconfig
   * clang-nightly-tinyconfig
   * gcc-12-tinyconfig
   * gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Build regression:
gcc-compiler-drivers_of_address_c-error-implicit-declaration-of-function-pci_register_io_range-did-you-mean-pci_register_driver

metadata:
----
  build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.10/build/v5.10.233-115-gdf787b08d487/testrun/26848040/suite/build/test/gcc-12-tinyconfig/log
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2rwDemGhjGUiyKwSFMekoPRvmIv/config
  kernel tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git describe: v5.10.233-115-gdf787b08d487
  architectures: arm, arm64, mips, powerpc, riscv
  history: https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.10/build/v5.10.233-115-gdf787b08d487/testrun/26847981/suite/build/test/gcc-12-tinyconfig/history/

steps to reproduce:
--------
- tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

