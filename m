Return-Path: <stable+bounces-158660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BDAE9691
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F135A5A2B
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 07:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE5238C36;
	Thu, 26 Jun 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UO2yXuDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AB1411EB
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921437; cv=none; b=iRYtnv6HzFsng4Tr3SPlKBENe2MlJQZogOlsJg98M2Pz7+t72QOyMcWXRq1rlXi0xEYeHjVSwiVcfW3zzCb/EmfWKIxc5svif1gsc6YtbPimM8A/U80khCu/PQmnmr1XCBv2pokQci9XTmZFg/MZGFpmpJQcVHi5n6vHmLFHylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921437; c=relaxed/simple;
	bh=9C/yPC65dyt5L285Ad0r8Enf6n6g55IaUv+DoEN+0PI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AKeGI3i3MiC3KPy0CjH1a5AHYcYZA2WgzM0m4+iN4YQdYfL10HLwomTksUjoXJz5DAFhUMm0sLmSXqFnBKMcwDhTW5JdRPxK8/wOdLKJYb3SUUsX6eZDeJwh3WadiHHPjIsRVZbIlUQMSHKjjb9qqra1V82J2E0O5/loInxnQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UO2yXuDg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3137c20213cso736320a91.3
        for <stable@vger.kernel.org>; Thu, 26 Jun 2025 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750921435; x=1751526235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9C/yPC65dyt5L285Ad0r8Enf6n6g55IaUv+DoEN+0PI=;
        b=UO2yXuDgntwHQ6MR8cvQeo7Q9IirTmfpF4LlGbTd9hES9M+eDcsJ7d0WzpG5bAFYkR
         c/7gVPNjpgZfWvXbUkiprXq5V+JUcPLbX7jde260tH2YizxHrd0iTNUiqSZALXk4E+Pd
         F2fIRvrGM56c9U6H+Dycyt8YoTk/o5hFvAurBZ0vz7xZGSFCH+SbJf5bd8DHZFPxahtQ
         uqw+PCoTjHvMAGTdJD/T5/GECwChBPNjJZCk60zK2Z/tLLJjsb1D/rUdclEmq8LeG2Ih
         7okva+6XM2mKiKKU6JQi4Llg+KB95AlRwXL0+Z/0vqLLkX3zb3T/fqjXGNPUyBnUBvP6
         5D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750921435; x=1751526235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9C/yPC65dyt5L285Ad0r8Enf6n6g55IaUv+DoEN+0PI=;
        b=MfI07fxLa9Ho5kuYDkdmby2x65/NGvBGMT3LjB30PzOL+E+If32LTcmUBadV3xBYpA
         nP613XW6qOg1FiQgrHfXjfIRieXxLfOImRY7n1GJEYrKQN0A0S4+BTpWbaix2iZgc/ve
         1ceIvyo4c6ROvSd+29Cljn4meuCrFH9vDarlV0YnVxjw/7A1tdKt416HzDqsj6jzX4mY
         vNiL/sYMV6zeYuo7B/BBSc+HmBdmdGY5SCpPWdufIEoYbyoETAadLsMHGuBx4JeTX4FU
         RyB2IiKY75DMOl96/bwKKa8x/UiizhPkyxW28s02AWgWfPxW24cuVyJpkDd0onzG4R/U
         qQiw==
X-Forwarded-Encrypted: i=1; AJvYcCX+D8vsA9BrqoJtQMJhUDuWofbf2mT8LYeuksG0vPYJRj4WsfnboeLfT1/Chr3VX4FFjWZSx0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwg/ZEbH1PB75XiIMbIGmbWbzA0uDYER3CutlFtK78RAn1YPfO
	jNWHUBC5IjdfXQt5Lg7UcogoBXJR+LHogndqrd8jCwGcuCGxu1qLLXgp8ez6U6UuslJdvcyx5mH
	cvmrF8kzVzzhCwun+Ymd5d5Kiwxw+Q7h1zqd+UfOuvg==
X-Gm-Gg: ASbGncthgxBP2HnQDRpDCkbb4sqiRJ8vd3UumllGYRYYITIiDxuCYNpedQqpnWopegI
	tl3ZUPwKTes8FoDiHnk4v3P62u5l5l9nOovY/Ayag0hqjhYBYc8EtDG2CXjBkG0qee1UYUtUp76
	6k7kHIjRfOIP1YfOFsSS7Y1L3cDuGxsN+HjW+lO0wKplTtURUtjmzGUVUJwNNfDAEtjd3oMcMKL
	pfZ
X-Google-Smtp-Source: AGHT+IGB3/XrVvwCiSKGcdM/uKLZZR2BBjt/EJ8TFkLwSBLUw9n1kq4/A/cuTaHIdw+LRFJ+QBCRjPhK4cZiYm51gdc=
X-Received: by 2002:a17:90b:53c5:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-315f2675bbbmr9154353a91.17.1750921435517; Thu, 26 Jun 2025
 00:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 12:33:43 +0530
X-Gm-Features: Ac12FXzrp0QOBUWJ7tIxkv-cgchxT19rQvDD483_utcFbw2DHpKfR-GbfFmMvSU
Message-ID: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
Subject: stable-rc: 5.4 and 5.10: fanotify01.c:339: TFAIL: fanotify_mark(fd_notify,
 0x00000001, 0x00000008, -100, ".") expected EXDEV: ENODEV (19)
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, chrubis <chrubis@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regression in the LTP syscalls/fanotify01 test on the Linux stable-rc 5.4
and 5.10 kernel after upgrading to LTP version 20250530.

 - The test passed with LTP version 20250130
 - The test fails with LTP version 20250530

Regressions found on stable-rc 5.4 and 5.10 LTP syscalls fanotify01.c
fanotify_mark expected EXDEV: ENODEV (19)

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Test regression: stable-rc 5.4 and 5.10

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

fanotify01.c:339: TFAIL: fanotify_mark(fd_notify, 0x00000001,
0x00000008, -100, ".") expected EXDEV: ENODEV (19)

The test expected fanotify_mark() to fail with EXDEV, but received
ENODEV instead. This indicates a potential mismatch between updated
LTP test expectations and the behavior of the 5.4 kernel=E2=80=99s fanotify
implementation.

Test log,
--

fanotify01.c:94: TINFO: Test #3: inode mark events (FAN_REPORT_FID)
fanotify01.c:301: TPASS: got event: mask=3D31 pid=3D2364 fd=3D-1
...
fanotify01.c:301: TPASS: got event: mask=3D8 pid=3D2364 fd=3D-1
fanotify01.c:339: TFAIL: fanotify_mark(fd_notify, 0x00000001,
0x00000008, -100, ".") expected EXDEV: ENODEV (19)
fanotify01.c:94: TINFO: Test #4: mount mark events (FAN_REPORT_FID)
fanotify01.c:301: TPASS: got event: mask=3D31 pid=3D2364 fd=3D-1
...
fanotify01.c:301: TPASS: got event: mask=3D8 pid=3D2364 fd=3D-1
fanotify01.c:339: TFAIL: fanotify_mark(fd_notify, 0x00000001,
0x00000008, -100, ".") expected EXDEV: ENODEV (19)
fanotify01.c:94: TINFO: Test #5: filesystem mark events (FAN_REPORT_FID)
fanotify01.c:301: TPASS: got event: mask=3D31 pid=3D2364 fd=3D-1
...
fanotify01.c:301: TPASS: got event: mask=3D8 pid=3D2364 fd=3D-1
fanotify01.c:339: TFAIL: fanotify_mark(fd_notify, 0x00000001,
0x00000008, -100, ".") expected EXDEV: ENODEV (19)


## Test logs
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.4.y/v5.4.294-22=
3-g7ff2d32362e4/ltp-syscalls/fanotify01/
* Build detail 2:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.238-=
353-g9dc843c66f6f/ltp-syscalls/fanotify01/
* Test log: https://qa-reports.linaro.org/api/testruns/28859312/log_file/
* Issue: https://regressions.linaro.org/-/known-issues/6609/
* Test LAVA job 1:
https://lkft.validation.linaro.org/scheduler/job/8329278#L28572
* Test LAVA job 2:
https://lkft.validation.linaro.org/scheduler/job/8326518#L28491
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yxHGv=
VkVpcbKqPahSKRnlITnVS/
* Build config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yxHGvVkVpcbKqPahSKR=
nlITnVS/bzImage


--
Linaro LKFT
https://lkft.linaro.org

