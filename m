Return-Path: <stable+bounces-86388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618E99FA40
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D3B28480B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE620515F;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xo5IX/qx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FBC20402B
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028254; cv=none; b=aLyCg3WJDTc/bc9pqZbgWyoLWL/oFRkq5XhUCl/1dtXWezub4V4Ik2BaWk5lAchcyMAVU3oRvKV/b9UX90aHYJmuOiT4ltJf68VWTTp2o9Htk7VB/IP42W+c9reNlNovKpQvceP7QQ1zhDBD4CgWwpt3GeSjMr94+jdwcPauugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028254; c=relaxed/simple;
	bh=xhvCp4mAYg+RttCEWM8nrBcCcRu+QmsxtiZPprbDDRY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OP6Pi51iIT6Ey2qMsGwlu9EMSFei4+XMLQzpZpbBk29oHan5dqLP6UhU+5fuI8QFlzdP104IL7G6+FukjO96e/H84rzgaNVkAulqTRNiWur6hJkxZfWsPBnGLLK9aeil4M1oZ0QmG2fI5qBPYLHxAvtDXXFpQhgzl2rBrNACZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xo5IX/qx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e7e73740so2942772e87.3
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729028251; x=1729633051; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1N4AEo67AJDxg5isYDTUU408W1MiStgBZrCEl+upAQ=;
        b=Xo5IX/qxmofdt9B0T/ixkhiUw+slhmd8ODgCljCbkY8t5weXQzy/XOkkG0VBIHwPnv
         ijtsKeEPc1ZZMScocdHIPhrRNmv5XgG+xlxoMZBPD+UBJ7vYYOxcKxxiJji4Khz3LIWG
         uRAdSNFb6ERFGYKmf2fF+70PSmNasKHb90oMuu9iBWMGuHL9GK+FI8qbkegdfIYL3chW
         hsvjh3kEwfegsf+qXw5aw6fCM3lH2egZ6/DdnEoPN4pZh69/p1DWHUDAxuKx8RhOvJAN
         35sN7yt4WQsQo0KaucvBvEgK4Hpp02Wp3UIJPpZQV6PsjQM+5o2EeaunhGMrC9MuMjMo
         SxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028251; x=1729633051;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1N4AEo67AJDxg5isYDTUU408W1MiStgBZrCEl+upAQ=;
        b=DwytFjTEDvFyVO9gjOKaZfDRelhyYPhG1YcC3lFENwo67y5hCl8E/6VAs2oN3sJ80g
         ztek0K1eQuB5nC/EFXmj7+KyJ2VMXtzq+RevNEqfEyMDFmM/EoDueqaJeXrryltcTj5q
         vjbljQkF382Qyh95yzl5qsKYLK8zwcRWhfFfpOJ2zTxJ1owMnmFupy8YHkWsq7bm/mHW
         xTemzmUlAylwYt71ZeYA2MD7u61v3fEHaOhHusJ7w27ZnWAMBhrJ35bu22SHBSA5yK3n
         jW33sMTxYKP1JrqSXfU8oybdAyZdywU5ZmeCqFV+SFBeXjnbq/Tbex99FipuNoGhKye9
         85WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWto4abcV6Fbjc+SVvPuzViwiZHFcnviQ9krFcIeB+YGBw2xb05c4aa8D9OOnTlYHk+sOLbIto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKKmzc24cJTQNfimrE1ow20IxsE5toLGoVEb1gDGRH/SUVJxj
	nDX6ddStEJOWfv2AoG4C0m+z73XmJGmuhX9S/3VjCkNZhv1vMXGJf+WUpSuXTSU=
X-Google-Smtp-Source: AGHT+IHrmYVh2s1M1vR8j11JDmsNmTewokj7TjNFd15E6BqGO2sG9UYvH4yAw5v0dpTqUPBHFsORUQ==
X-Received: by 2002:a05:6512:3d23:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-539da3c58f6mr8166447e87.13.1729028250720;
        Tue, 15 Oct 2024 14:37:30 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff39a7sm258959e87.164.2024.10.15.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:37:30 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] Fix KASAN crash when using KASAN_VMALLOC
Date: Tue, 15 Oct 2024 23:37:13 +0200
Message-Id: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIngDmcC/x3MQQqDQAxA0atI1gaMzLTQqxQXcYwaqmNJQATx7
 g4u3+L/E1xMxeFTnWCyq+uWC6iuIM2cJ0EdiqFt2kANRWRb8cfOGfeVl2VLmIx9xjH1Q6RArxD
 fUOq/yajHc/5213UDvZs472kAAAA=
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0

This problem reported by Clement LE GOFFIC manifest when
using CONFIG_KASAN_IN_VMALLOC and VMAP_STACK:
https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/

After some analysis it seems we are missing to sync the
VMALLOC shadow memory in top level PGD to all CPUs.

Add some code to perform this sync, and the bug appears
to go away.

As suggested by Ard, also perform a dummy read from the
shadow memory of the new VMAP_STACK in the low level
assembly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      ARM: ioremap: Flush PGDs for VMALLOC shadow
      ARM: entry: Do a dummy read from VMAP shadow

 arch/arm/kernel/entry-armv.S | 8 ++++++++
 arch/arm/mm/ioremap.c        | 7 +++++++
 2 files changed, 15 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241015-arm-kasan-vmalloc-crash-fcbd51416457

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


