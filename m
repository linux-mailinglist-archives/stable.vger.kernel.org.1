Return-Path: <stable+bounces-184008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E9BCDAF9
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB514541A62
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2E2F746C;
	Fri, 10 Oct 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiROp3PP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3F2F60CD
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108582; cv=none; b=dRMl3Mabl1Hp3pxy2lsvmFxLCbb4f4NQY2m1At9MY/h6iK6uC6LUgM1O3haC9V6QpOuQvBQ11umP2pXQR6Wuq4c/EPrXEB1gRFsog9vpgfzBuCOmnfUNPiqoGxNFg4Lwy1hlRDAqakz1Cyddhs3XSgp/ISEDUjfcijDezAn1hGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108582; c=relaxed/simple;
	bh=UHFjEVHBo1yIOaVlRsqK18HPUDEo7fXT8pgeeEEdaXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sd+BXDCMOmli6sOiowjdxUXaIKBvxtAbIqx2Vsz9IfPNyyAu12mnBk3YbWz7i8tgAemMp/DKeU4dAABJ9LH9SVvrzK8bbIO60Hy0HYD1ceynEPyFWT5W7ZJxI1KYyZ8vwhd4gN9dZi8lAaq2I/Q9G71S9HrgM499bqj+CR/hiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiROp3PP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7835321bc98so2228654b3a.2
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108580; x=1760713380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elZCS9zUDdalSz9uVOKCoOd4+j5ifaZJHKjwRqdAu9k=;
        b=UiROp3PP13YG7bgCW6IxIzbr5baWsZomFwoTJOi3pCx27e/TBEhpoliOhlYot0en9k
         O1gyHbVsRk5xLL2fEIfFt4mkiw7LD+8BNPpbVS401O2En/tuMRw7UJ1IqFmlafnrCUMk
         W1069ZjRwbPfmDe07ZFGOVQlrWczibnBgSQwjPfYKh41Zs4LQizqLl/MyZ9g7tly1Dso
         iDOC5uXKSbEE0D6OaIVQmv6MNBZ3vZRx4aRQd7u8JXL0vEXsvv3J91VA8jWscZI/eb5F
         lNffj4UCgk/N+HTy+H4s8pNiKE3kqmq+sPyybIANE4w1SgK+6CNQB6zPewHLZqqgsz0S
         SPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108580; x=1760713380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elZCS9zUDdalSz9uVOKCoOd4+j5ifaZJHKjwRqdAu9k=;
        b=H+XGf5how9nQu6+9ggcINraaFV1xv/lsELxBn5cICX1UZT2/G8HS/8GIt+JhffCoRg
         /9HOrorndETlwGM0OuI1HevZFoEQP6WKCGs0IZIOUh04oSBc0C/QGzALpB5YXYyLTu33
         gQ8/FGFhBFMN8OwI15nbjZBHaROBdxsT5UG53h0hZ/tmCaz3IdeMxvq6JcYiXN5uwvVM
         EtqItJgX3tYkx4pWVgXehwjkUpxBE8P9vRx7YQ6arm3pAOP/MTEOBm5dB0w7T8pxMPgu
         aQWoaAlQlCBLVstk6RnJtSAYmUW3h7DIR/zD4K7IRsDNQNTWt6kK0RhfAW8glg/Iug3s
         +D1Q==
X-Gm-Message-State: AOJu0YxlJ9UEvUbRQ6tlZpbnQYMMF6KLucqSeLXA/mMhg5fTM4js4tr0
	E6XHTaNmER+tD79mfdLZG1bYaFomPHbBHwKhWnuogNwZX7uzf34uq2PrrjhLhQ/fC+QkcQ==
X-Gm-Gg: ASbGnctBq5FURKIpu2qcvS0v8iNw0cdxoe+eChU0VxX5LYPFgDViNyy9uv+48EaecAT
	Vb70AUrsS0fMD9WGm695LjHDQEwGytN6pyHv2t8R2LTZUiPqXpeXqqntcAx9PiIBjepuzAsloya
	VFU3ZBT79JrNHTndtxsK+NILGHsZl2wBJbHrSIw3uD8x6KuqlhMz9EiuPc7+RrhYv4medcIotBm
	Fkhbw47b1V8W5T53Jzk0IlPQrpPV8ATSxvCQpdIEddsySqlq5yojj4vgccJrZZIUMEPqRn1zCBn
	jPKLaO0TOifGyZESBnIBnUpaxPQrOUhpMHxJ/v2mij6RWKcuyleClaUveSRD+87pPBRtqXky6Sl
	dtDKf5Dy5TaHUjAx/9OU0qIyHOA9g/+gel9oLTyW/l0JFc5mR1gahiHTdOSZjVI1rAAVC
X-Google-Smtp-Source: AGHT+IEiheifxj1cVZ8u0uGr35LMFjwn1oypAqpQX6zfZ7PxZ09jYE7B7OTz14SyZcJabP5tV0n5Rg==
X-Received: by 2002:a05:6a00:2e19:b0:78c:984b:7a92 with SMTP id d2e1a72fcca58-79385ddca48mr14271231b3a.12.1760108578879;
        Fri, 10 Oct 2025 08:02:58 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:02:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org
Subject: [PATCH 6.1.y 00/12] timers: Provide timer_shutdown[_sync]()
Date: Sat, 11 Oct 2025 00:02:40 +0900
Message-Id: <20251010150252.1115788-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
useful feature that addresses various bugs caused by attempts to rearm
shutdown timers.

https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/

However, this patch series was not fully backported to versions prior to
6.2, requiring separate patches for older kernels if these bugs were
encountered.

The biggest problem with this is that even if these bugs were discovered
and patched in the upstream kernel, if the maintainer or author didn't
create a separate backport patch for versions prior to 6.2, the bugs would
remain untouched in older kernels.

Therefore, to reduce the hassle of having to write a separate patch, we
should backport the remaining unbackported commits from the
"timers: Provide timer_shutdown[_sync]()" patch series to versions prior
to 6.2.

---
 Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
 Documentation/core-api/local_ops.rst                        |   2 +-
 Documentation/kernel-hacking/locking.rst                    |  17 ++++---
 Documentation/timers/hrtimers.rst                           |   2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 +++--
 Documentation/translations/zh_CN/core-api/local_ops.rst     |   2 +-
 arch/arm/mach-spear/time.c                                  |   8 +--
 drivers/bluetooth/hci_qca.c                                 |  10 +++-
 drivers/clocksource/arm_arch_timer.c                        |  12 ++---
 drivers/clocksource/timer-sp804.c                           |   6 +--
 include/linux/timer.h                                       |   2 +
 kernel/time/timer.c                                         | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 12 files changed, 299 insertions(+), 89 deletions(-)

