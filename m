Return-Path: <stable+bounces-197602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9BC927F8
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EE4E348FD9
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037B2882D0;
	Fri, 28 Nov 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdIvhtzO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E283FCF
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345950; cv=none; b=dIWCWo8tXpIlVIh4X1UBDmFbonnhb2ma5x0q4Z1MlXWtrw/Yd08M8gw/eJn6Jq8rZdzv8aLMOertZTljM7yB9nMjXAH/LkJe1DeXTar1S/P9rzmS4nzurzfjSmASk+m18RLEDLixcHbCAyxxk1okbZjlC+bn1wvKXIujHqntINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345950; c=relaxed/simple;
	bh=7R/V3fLA5ZUpQU7ZkDgrTUeowxcERJCp6oWcWnZd8YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLni3EvcP2dqu6zSOMpuqt17mOlXQYur1ojaHE42pJ/Ms/bNtwvnfw93M41OYQhKn6cPqWh7i+jd1PA5ZWhZ3gFsPzGCch6qlQTiUt5S99jYdHjtYr3OtpaF1Wu3qk/X6yhszQ82//NhgY9E0YtS8euycnKY+5Uqr9ft0PB03tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdIvhtzO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298039e00c2so28675835ad.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345947; x=1764950747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jr0436cSAe7dIJCuJ52U9qMmv3xepyLVevZMH0j277U=;
        b=HdIvhtzOBvQ5EY6cqn4AipFgpqL552YJbs3JhicLIGEAFAC7S3KIJyUuUUOV+7E6k2
         T42z3ruF9j09Ve0d6/G15lGLACv7LbwDADBSIvG7X9+BQFVCitZ9ZAgesw9AZx0FNWws
         k1g+K6wt4Gynv3QWnesk5RImQY7oMI+l6z06S/GIJkpp+9VeTQqnPbvIcDUWfZJ5Mm3M
         2nbAg2ZUnuqcOPRFok42nrhJNbyimDgGcXepdfVidSboxfb+kegEDTqe38fYVQlFGvvZ
         1wGOlxHZvbJULLFg29t8Kw9Cp3JguVNAEr/FYJb41EG27G4nkNDsOpvqAbSVAf2kPyGV
         R5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345947; x=1764950747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr0436cSAe7dIJCuJ52U9qMmv3xepyLVevZMH0j277U=;
        b=U1ob52iRqqfywV6su3pXSoqxy/qvqiNy1d1SJkpK2bAsTsk34uTCmefIjlBF6LPxDh
         199HnuHBEIOp7gnrgfafOvTHoZVbVt/THlegGJHr7lyJRVOevZ7+mf5APC2lAupdMWWc
         axlbZxOQUaat04vJyXngboQDnCI9FTSDZtXbAXJVm9CYK7kA4GlBFQOhXa043c7nimgG
         0dBGVlttws+fGhRziEF5MFS0FU+gk2Ls627S1VKBL61eGgFK+ci9eAWcu01nE64MmXEn
         PxWPq5zcvOv4QQ8OBZ8RgvyXlZ+6bKb6+26fdcqPTq6Kao1M7mJLQXqPEfxEsMzKsv0n
         d+CA==
X-Gm-Message-State: AOJu0YyCRDhh+cWPAgPMxk/6vrmbT4nVHn0UmDxZRA6T4i+uFGKGmCJU
	Vt45EWhyvI6K9rrXZHslhVwur5dFmKvY3TsbzmbrcH3yVA2Q+DzBLq5qLdWUJpOorcCakA==
X-Gm-Gg: ASbGncsEwdxzpiPRZpwtiQy8OasSxzksYppi9ybSrrR6BtNsdW8i1KJVt8t7xCFL/nr
	vWrStCan+zeCfjdhD83O5lQhy3tWZY7WJ+QCfbBGQtaOxtp8XSD4sOQ2OQW0m+9x34Q98m4vMb/
	qwdVIQPtVxnt1ifaj1my7l/C9J92mIFbgxmC/leICWS4uhO9Cl6PHZEqv9t613bo01X06SwPt2y
	1CPtLbsEfnMjUyFg9bujnGe+UaoMlGzGAADGevcRkMGH/aGZocoO7a2ppAkTIjbG67cNDj+MExW
	j/mXijzgcMHAsCSmmYT4qn9VggrR40vHhoEnQ3brvoonUBR+0plpsBskEXaxC9W97LC/2VbYIDG
	i/Dxkc3Vzio5nk/4PxH7lvIyfQjeM4a3QiE9fDpT1QdIjjTJZddDPBGL99GuEBlw/82XZ+RIksz
	vmoXiWAm0VWtlZ62AlDyBVFXeTD2+8j7y3vzAGOQ==
X-Google-Smtp-Source: AGHT+IEbRdUXnl5aQOE+Qq55lmPGygxKdzplNnm4FsxdZSNypxAVuwWstG2sn4JYjVv8VNlcsFkFkQ==
X-Received: by 2002:a17:903:11c3:b0:297:e3f5:4a20 with SMTP id d9443c01a7336-29b6bee38ecmr348858315ad.26.1764345946851;
        Fri, 28 Nov 2025 08:05:46 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:05:45 -0800 (PST)
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
	viresh.kumar@linaro.org,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH 5.15.y 00/14] timers: Provide timer_shutdown[_sync]()
Date: Sat, 29 Nov 2025 01:05:25 +0900
Message-Id: <20251128160539.358938-1-aha310510@gmail.com>
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
 Documentation/kernel-hacking/locking.rst                    |  17 +++++++-----
 Documentation/timers/hrtimers.rst                           |   2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 +++++-----
 Documentation/translations/zh_CN/core-api/local_ops.rst     |   2 +-
 arch/arm/mach-spear/time.c                                  |   8 +++---
 drivers/bluetooth/hci_qca.c                                 |  10 +++++--
 drivers/char/tpm/tpm-dev-common.c                           |   4 +--
 drivers/clocksource/arm_arch_timer.c                        |  12 ++++-----
 drivers/clocksource/timer-sp804.c                           |   6 ++---
 drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +--
 drivers/staging/wlan-ng/prism2usb.c                         |   6 ++---
 include/linux/timer.h                                       |  17 ++++++++++--
 kernel/time/timer.c                                         | 315 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 net/sunrpc/xprt.c                                           |   2 +-
 16 files changed, 322 insertions(+), 101 deletions(-)

