Return-Path: <stable+bounces-217466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH0NIK9El2kiwQIAu9opvQ
	(envelope-from <stable+bounces-217466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:13:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F217D160FEB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C9E3017261
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67634DB4C;
	Thu, 19 Feb 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P76QoBmh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA634D922
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521197; cv=none; b=uvuIIIHrWdF6sJ7eNU+6GaEEEuFKY/2j/gF0IR/P6Vys+/r2aF2VjtsQfc1EY2Md+MmYV8KEaOvkYPGJwxakPhIkgvHWZnyA81HfIOiEjkuzAZ/rBpfvT0RMn5UMnAqnefvcAVKQgH1itIPV1eZ5RRnhjoys5WjMKkKo/tbaiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521197; c=relaxed/simple;
	bh=ovXr+6sxYeMEpCTtHn7L/b6JHB1FSSOMciED12Xosvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okgek5QAzCr8f9cVYQNFqHF1BwVdPR7M5TG2Umf+Zckih5etHdDR2n2vIQBqYzTHJAxKumqsVTlcyND8polEfQav8k3lfRcECxJs3JacxzazE3Z5JFaodM7LaiJi1kdhfauCb2RHennTC+NcUcfKTfO4PasslP4IyxX4NoTEajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P76QoBmh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8249cb73792so1029137b3a.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521195; x=1772125995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jler9eAcfNnsrMpyyoJoP7qdaGNuUrFvk9+cWB5kmEM=;
        b=P76QoBmhO76IXp32j+2gyRFsCKuPbBY6qiVYRPZb2BmZOkqcExVfbd4jptI3rez81E
         PZts4yZNkoBjWKAE6338i+gUE115nMTN4RxdAAhJquRS/IKmxbBnYilzx8W9yVA9plfk
         9vPqx6pJTgdk1dqZd3JDP8g4mO0fXbnc6Cpl3y3E7suDl9BDLi7BavjSLF1162tTzRUX
         Kwi0Maakn/Bxge3b0dXjdMB6awWb7NnMLAMBTSorSuMR7FsDRra+nWx00MdY2wfLlQWb
         XmUwwQRvZEgzSa2C3HXTNtmR1DVR2Ye2WZX4CuFs/UVL2MXgJfzUWcV8+cXW1dhWBp/u
         iGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521195; x=1772125995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jler9eAcfNnsrMpyyoJoP7qdaGNuUrFvk9+cWB5kmEM=;
        b=kDJQPhvP8vZfJbtNpUTn+/Eu9lMXj+l7rXIIa3lIri2vtQxerc9PrjXzhywZKD7AJ+
         S2nWqG4Br0IZOTI1Qa1gvDQItrfleodI37gydb9BkCMcaY2BCXcbaB8dMprGA/4quARz
         8Pg/AqTLF4cXRz4bNlcq/LnWN7bPGjyPHDrg0E5bUtpYftiVnBfFeEjKnGCoYZfA7MGM
         CA92+9ppIrsyvpIB2hXg7SHZ4cV5teqCvuFhkmia1rDMXSfRGSrjxiqgVUoR8Q8kfJHo
         P9NU5oAVF68rcbovM/PGCLRzsS8VzctK0fzNAWyoXCNqPEoWLw0zHWh+DteosPVgNfu4
         2G7Q==
X-Gm-Message-State: AOJu0YywBMlwpB7LGG10UX1XJ7k0LRJSAGTUkVQdLTPu3PHXcAd3oLjr
	O46QmAeFppPOSeAom3d3EaFo24FCllS0nPE9pu9rjc4bPz/EzL1y6NVBxlC36vr0
X-Gm-Gg: AZuq6aJ5N5KYxlsv3NP95UKAl6JuB2K7h7FMXEvWLDTQG3RmYKtcjix/3i/J5mkkdLt
	vW5QMb63ZsMuMVlokPB3fduG5o9y86j5UX1XkdvDknxfT9KkblyxvzJQBZVn0XDfOIq0yMaW5/D
	18xEOPilYfyeAG1Gwe/haQbs+1TT5l0Yc++1dbFeE0X1FN+gq9zrJV5u3cBD6SMKBN5PkSFNxmJ
	A4oH0+PX7f3zqa4h+CIjkLTbOPhlW3cx8Nl/g9AobWdA/7NzvuRYeK/otXxGmDM1sY1rlsH8RQU
	Y/QM6V8L2Cxa52T1oNRPz3IgwYtCbLhqjhobU8R1zi1ufY/Q/I9V5QPJv7IP2w5Tc7vZPheNT6E
	4fsAxvbIeMLKtsD4+WcpvU3Qr0Fx0uzATMjifQ55n0Me4GctX6mwio3CEACOWbvUdxpjPxPj93B
	Vy3N6evY6MxRfLMVPvP1V5Jo5cKk2Pte2RO8faoAUWcgqKAZ8mxw==
X-Received: by 2002:a05:6a21:103:b0:394:5c08:7fb1 with SMTP id adf61e73a8af0-39483aae871mr19808016637.72.1771521195247;
        Thu, 19 Feb 2026 09:13:15 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:14 -0800 (PST)
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
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
Date: Fri, 20 Feb 2026 02:12:55 +0900
Message-Id: <20260219171310.118170-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217466-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F217D160FEB
X-Rspamd-Action: no action

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
 Documentation/kernel-hacking/locking.rst                    |  17 ++---
 Documentation/timers/hrtimers.rst                           |   2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
 arch/arm/mach-spear/time.c                                  |   8 +--
 drivers/bluetooth/hci_qca.c                                 |  10 ++-
 drivers/char/tpm/tpm-dev-common.c                           |   4 +-
 drivers/clocksource/arm_arch_timer.c                        |  12 ++--
 drivers/clocksource/timer-sp804.c                           |   6 +-
 drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
 drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
 include/linux/timer.h                                       |  17 ++++-
 kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 net/sunrpc/xprt.c                                           |   2 +-
 15 files changed, 322 insertions(+), 100 deletions(-)

