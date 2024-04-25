Return-Path: <stable+bounces-41426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E758B21C2
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611801C209CE
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BCC1494BD;
	Thu, 25 Apr 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGqmQGrA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74F133408
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048768; cv=none; b=Lyfj8YTqggt7XhHqwSOOq2anQC+Bjvanr5ABHq1DjB0ZxXWIiWa3T8OptcsPJpnr15/o9zcjgpebqGuOMEYdnVX1P9tHSfyBG+eswYZUiYC2ruVgNrgCxed8fxbPemcItP+Ri8PTFY7D/cJhwkBVFZT+YBIRqdR8HzNwZ40HOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048768; c=relaxed/simple;
	bh=kkDuINCQYhQ6FbdcqoW3as2fTSOHoDDS1HYme8W0NPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sZRn5me2GsAAJxsP0MT1BpIBzP9pOCxhqpbl1rQS2tq5LIBbt9HJUcPmgdXEM8Wp9iO0FvIH272QO7rWbqoW3mlOl6lidVpgkQMb2oRJ7ppkZsvnOSEI/gLKMFg6hL1ZQA8e7q6TB6SNH69fS7396STeY7q5X/9aiyvnLBGW29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGqmQGrA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7eb89aa9176so290392241.3
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714048765; x=1714653565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zYuNQHZgONJaBv+1xJH2KfHQ0fX0UBccuZb/VjBvZRI=;
        b=SGqmQGrAQEFc424iPdbb7JcTzJ9gQJTgi6zH4OhE6Kw9hnoxvOVga8YwL5W4e1XFyG
         StunPoJjo564Q27sMC5G2YYGpp+cbm+An4mHdLDsfY0auqmays/uwslzVoQe9Acefws6
         iKoaQLerXkSHI6XLL/9r0fXxatli04jIwL+eWakNizRhyrZ88FoqzNeKzpszTImBvLYU
         KOwtXLEqjXeEiZUBetLn3r9g7uAxDSsJ6XPkhDPQr8R5NxQ+2cUyv5AjJIDGxMQl9Kqf
         AcspfqzAR6FzO++J0hn0vEFP2B6QRN3CP0ebCzhCQdmTXSt8l9eK3TABIB9w0XCXwchn
         9AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714048765; x=1714653565;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYuNQHZgONJaBv+1xJH2KfHQ0fX0UBccuZb/VjBvZRI=;
        b=ORTSBFw5T44HcKcUPrCPmeiQZKPjiRAuyNuElVeO6PRzQcN2P0rX5KE3W9dg8CHYmF
         Gray0zvAI5ZwFsmkCs9PHfG+ScFJtBLK4ZdU/Jlfg+mzckrSHNJmULk2C3W+GNT6PdTx
         X0ieczd+8cMIrLbuubBmablI7o0Vcqu6wcH89b7gD6P2ocQ/haY0wAZGXL9CtgoJRa3s
         0/noLEfd/qmvlDMRU5vpATPICTQfduFM3CozQjIrOyJVIa3G5t3QeMNxkFFByapZ3LGw
         gG/cdDMNU/dyXidkobEvYC126+3O0kmv4zKFQJzKxIf0TMDt34npzwOUT3fRh/QnBuQF
         hxpg==
X-Gm-Message-State: AOJu0Yz6YYSAsY5YxDcl88kKzYHIr+5B1R2eylX/zAbzQS4vcO1k3bPj
	zJen0F8JZPJ7HUnwQ7yQSoCKkAa1cJaQ5/iQfWSEzM6KwIVxBzs7XrvLRuh+fkY+Syfq/ajpTwK
	Bg3Zgxyx/bkv3XHz2fIaS6vTkab3Zay6Rrm2Ui7mh6ztZ+OZKvuY=
X-Google-Smtp-Source: AGHT+IF2zJY8viJj0WPf0ZMzG+lSNpwCUuLfp31AS8h547e/ZspBmAWTT4v3GrZr6yL1RxHPIvLy+kuLdlul9fGmHPU=
X-Received: by 2002:a05:6122:328e:b0:4c9:98f8:83db with SMTP id
 cj14-20020a056122328e00b004c998f883dbmr6978370vkb.5.1714048765077; Thu, 25
 Apr 2024 05:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Apr 2024 18:09:13 +0530
Message-ID: <CA+G9fYv5fV74VfJnt55E8YaNWzu8KJG2bhw0ddJhM-mPVUpUpw@mail.gmail.com>
Subject: stable-rc: 5.10: arm64: ring_buffer.c:1479:21: error: implicit
 declaration of function 'try_cmpxchg'
To: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The arm64 and arm builds are failing on stable-rc linux.5.10.y branch
due to following build warnings / errors.

Anders, build bisected and found first commit as,

first bad commit: [9bf29b51d2bc21abdb8bd36382c1c324a1c54ca7]
ring-buffer: Only update pages_touched when a new page is touched

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
kernel/trace/ring_buffer.c: In function 'rb_tail_page_update':
kernel/trace/ring_buffer.c:1479:21: error: implicit declaration of
function 'try_cmpxchg'; did you mean 'xa_cmpxchg'?
[-Werror=implicit-function-declaration]
 1479 |                 if (try_cmpxchg(&cpu_buffer->tail_page,
&tail_page, next_page))
      |                     ^~~~~~~~~~~
      |                     xa_cmpxchg
cc1: some warnings being treated as errors

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFu97bCGW3ZYMbPsIpFyxEwBx/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFuBOMDouq6VfImqR2Iq30FQe/config
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.215-73-g5feded50ee59/testrun/23639019/suite/build/test/gcc-12-lkftconfig-debug-kmemleak/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.215-73-g5feded50ee59/testrun/23639019/suite/build/test/gcc-12-lkftconfig-debug-kmemleak/history/

Meta data:
git_repo:
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
git_sha :
5feded50ee597a37f4778545a879337c2f72490d
git_short_log :
5feded50ee59 ("Linux 5.10.216-rc1")
arch: arm64
toolchain: gcc-12

Steps to reproduce:
---
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFuBOMDouq6VfImqR2Iq30FQe/tuxmake_reproducer.sh
--
Linaro LKFT
https://lkft.linaro.org

