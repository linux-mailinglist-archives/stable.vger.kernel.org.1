Return-Path: <stable+bounces-86611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E079A22DC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86C81F23E45
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D421DD0C0;
	Thu, 17 Oct 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFzm2S8g"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F391DD875
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169954; cv=none; b=ufccd4rClRJOkiDOmnHJ4zPWxekLTjVh7bOePOXPQWDWkeKtTOB6++nKGv5nRBGpBvqzSLzRGYdXZ0IFGOvcznsracCnmM5FTAQpa3pxvmoov/Y5rfwKHUk15eLTwYZ7LvJ9NLJe1TpwWSEZhwB2q+uNgLpVURKa2aT9Fx8uKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169954; c=relaxed/simple;
	bh=xHB0xa/mWPjxibRzelHDgpKKccLJO1kv6SqOAznSZQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N6xuC8CNscWgcFmyxmMN7qm7OMldzOvRzF6//k5JYxSgt0SEcXOIyo3zGBZ9kCj44utLC8o2f/DkAquA11JQRBktaHlhiqt+A2PdSoMzOgQzkMJAucsHlpyY2CV/XkLJyivd2zENLzKluNUPGWOEnsr4Ba+RIY0C187KK5AA7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FFzm2S8g; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fbbadf83so1155110e87.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729169949; x=1729774749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnpP3oSO+pNE9T1R4DyYSvsrG5uVU7YmtdEeT5HWRtg=;
        b=FFzm2S8gwx9+sDERmNJOJkqn8x2+Gf9kqn8J4uPYZt6LK0RVOxrlxh+3qQ08VYEShW
         ERB4S6zymg6b1dEYLC5+n/nrqBjeGS+Rl/FQ3bcNkLbLe3j2GazAD5WPP3xJotb2exOQ
         ebTanxJwvBChfpWEJ08FPobII65hsHmlJNIs57hGLSt6rsWpHeJatapXOs3H26qVYIAr
         +yVJYR+7N3xZ1fwQJ4fnpV3htBRyvkxIGjtYlZKm5bx2VfUCHLyfDkJnN2gW9apZHMDA
         vKHTT6d8UwE/waLM5c35zMQRj9nq2uUDoZaoilh6tZB3Eekt+FIZMwmbjx+nCpegJMcd
         b/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169949; x=1729774749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnpP3oSO+pNE9T1R4DyYSvsrG5uVU7YmtdEeT5HWRtg=;
        b=D4ATSBygVeYdhu1hYpNmwQQPMg79C4a4yQrZtnFKEHQXMsVq8rLuu2B4cRJF/61lbh
         M6GjVgf9vsNZFxag0oDkx2nSc5MyjoJG+s+Y4SsjOYtbYAYvvOWMz/bNIH1vjml19R1l
         EwxDxyARCmewhDx/t8Gbvz63EnBmXiATCXZzOBhNSGrxJho6yfOq8heI0jyVLV7g0F1w
         ACCazaGv1Clnms72HJdXyjJzkAKBBcRYNLNCaLfRqzeq7xaNN5/caheYznbCUB72V8tg
         /LaIJ3Bt6lvt+vQupKOduaQ+Vrj9bmqvfoPQMETtjuXai+xnaIKJoGUVtKbnRO5zYLR0
         msuA==
X-Forwarded-Encrypted: i=1; AJvYcCXS6Q6B1voOWvVS0VLJbubF/xTsfOj+KkNURrfuayMfszBXwefQHoAmu+zBUeH6MjP7VW3I3gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8SNFGTe5fW1fSVBV3XZC6KAS44pdkRqV+RfY8QY5meWK1ZIy
	pqKOq4cukKnWfz6SXPkn0fNkvqslE6bjSNDnsl0iO+Q6pNroK2+HL49wkJpOpIs=
X-Google-Smtp-Source: AGHT+IEnJVfMeUhY9wGBPKaQBeiAR/UT76Ac9B78KnBxmjeq9yJIEH2UaMvxN5sYtbJPnm7CkirEAg==
X-Received: by 2002:a05:6512:39c5:b0:539:ebd6:a951 with SMTP id 2adb3069b0e04-539ebd6ac7cmr8909564e87.61.1729169948204;
        Thu, 17 Oct 2024 05:59:08 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013c21sm763349e87.270.2024.10.17.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:59:07 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] Fix KASAN crash when using KASAN_VMALLOC
Date: Thu, 17 Oct 2024 14:59:04 +0200
Message-Id: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgKEWcC/4XNQQ6CMBCF4auQrh3TForoynsYF0NboBFaMzWNh
 nB3CytdGJf/S+abmUVLzkZ2KmZGNrnogs9R7gqmB/S9BWdyM8llJbhQgDTBDSN6SBOOY9CgCeM
 AnW6NEpWoK3Vg+fpOtnPPTb5ccw8uPgK9tkdJrOt/MwngYNpWluooNTbleXQeKewD9WxFk/yE6
 t+QzBBHJTvDm9ra7gtaluUNkuh2oggBAAA=
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
Changes in v3:
- Collect Mark Rutlands ACK on patch 1
- Change the simplified assembly add r2, ip, lsr #n to the canonical
  add r2, r2, ip, lsr #n in patch 2.
- Link to v2: https://lore.kernel.org/r/20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org

Changes in v2:
- Implement the two helper functions suggested by Russell
  making the KASAN PGD copying less messy.
- Link to v1: https://lore.kernel.org/r/20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org

---
Linus Walleij (2):
      ARM: ioremap: Sync PGDs for VMALLOC shadow
      ARM: entry: Do a dummy read from VMAP shadow

 arch/arm/kernel/entry-armv.S |  8 ++++++++
 arch/arm/mm/ioremap.c        | 25 +++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241015-arm-kasan-vmalloc-crash-fcbd51416457

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


