Return-Path: <stable+bounces-87557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07E9A69A6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A0E2839C4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893D1FB3D8;
	Mon, 21 Oct 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="athffiqp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F91F7091
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515787; cv=none; b=ZOey9BReqbTDzTsoPolT4HFMee9WRevobmd4NLqU4naaFJjNHzyubEIJIJtlY4bLXVy2yX0l/SZjhv1DBPQVw30r9tLJcnkAJxR4Kriam9jn1jsasuaSRdipjsfl6BDUrx9Jmd3Uz0IkoCQ9QsIFHvstqhhYRsX7wB/pEjHnToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515787; c=relaxed/simple;
	bh=BKs99kGKGIBL0L+PjSWTZs1uIZtDYzztkFhXrQ8dx10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HhjYAcT1uD3SUR41Zd7ei0F8gfZt5dOCoNijuj9FNWKg7Sfcm/9qmW4HofyKDq+ZSPJohVTAd7u8tTHbcfsNT0I+Y49NCOWps+C7T/JcJEbWy5/kI3hkR2BIyrBNzG7BVrFpDGeBSEuixeSBmaUtiukWajF1mfNYjD+bXZiGHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=athffiqp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so32497491fa.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515783; x=1730120583; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBVj7hwiJkBfNNbqJ1p90uIKA5IyeuTojXmRSNi2iDM=;
        b=athffiqpY9DbLHRfA8bbGzEONtCbUb7/ydkkb0koMvW/S38ugCwiafHGsO2aOcozmK
         PpDYxnGJMZ91S6vOywOoIOgtFRS+8Fue4K5tjHzH4jOdqdPNbLTKuHLSB399Q+zktzUM
         BzUz2gAI5+ZcEevpfsjjYFqt13FFqdh3+/pei7NIh5z3JG1/M3C4zRpV3PH3GeKZxTlf
         Xto/ORUR9A5p/2g9ijY2Lzcj3yc+/qwGmbxIU/mUKLcQKfQ4xydogNey7V5aEfoD1hCI
         1IYwIrBnd2ttH7er/VvWEcIg4fgSHS+xPRc7batDspG0ac1UYKp2BC45K+Oah4BfUVDb
         ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515783; x=1730120583;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBVj7hwiJkBfNNbqJ1p90uIKA5IyeuTojXmRSNi2iDM=;
        b=rcRxz3HeEmmypPdpW4CdGNao+fwkHrP6ngvZy2YWGrDuFAfN9gOogTLCR8Rvym0A5i
         IgKgay/BaQxTi6MV7fA3VZA/+nxBX1bbsdxsytygUCwoPfU/U0RvS2xG3OGmSLMjeE38
         QrxYvsaPunZelyjyt83H7BZwbzEepbswMizpcw/3r8HMjyYWJ9nw96L0jBQB5esSOuoh
         i0W03RFL3dM7PRac8rjvU3vpCFAKZkH3PN4fx08+ny1DBOR2J3TVpYn45Ok9Be22POLI
         IVu8AM1+Va60qO9prcWsId74H1cTM8UqC1/ws/dQYQKTmZoNnC9EleWMnG9BEzdY9vOQ
         Vdqw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3VO2VdADyn2+7fC07hxVXoReOk+0LtWOWGosSoL3gRDu13CcMZEfg0+xVcE8HtGVD6kgWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YPuKlkP2dnB+2JeHvT0jISOmvm38/P3OA42eDPQ3eVqkt4MP
	pKYH0iJ0FnjZR74O3hfSWfixF1rkvE0OiEOPebfn3Jh4k9HEY8T6zTkABUnh2yY=
X-Google-Smtp-Source: AGHT+IG8laNr07uMgyvCGL35sCAnuBEi+eOF50gkS3gF675d/DHfKwi5UOYoiwlWGy+RShs73rP5eA==
X-Received: by 2002:a2e:998c:0:b0:2fa:bf53:1dad with SMTP id 38308e7fff4ca-2fb83200a44mr42548261fa.31.1729515782691;
        Mon, 21 Oct 2024 06:03:02 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24d51sm4808351fa.130.2024.10.21.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:03:02 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/3] Fix KASAN crash when using KASAN_VMALLOC
Date: Mon, 21 Oct 2024 15:02:57 +0200
Message-Id: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFRFmcC/4XOTQ6CMBAF4KuQrq3pP+jKexgXQ1ugEahpTaMh3
 N3CCmOIyzfJfO9NKNrgbETnYkLBJhedH3MQhwLpDsbWYmdyRowwQQmVGMKA7xBhxGmAvvca6wC
 xw42ujaSCKiFLlL8fwTbutcrXW86di08f3mtRosv1v5koJtjUNePyxDRU/NK7EYI/+tCiBU1sC
 6l9iGWIgGSNIZWytvmB+BYq9yG+LGLAhTayVup70TzPH1eO/RxRAQAA
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, Melon Liu <melon1335@163.com>, 
 Kees Cook <kees@kernel.org>, 
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
Changes in v4:
- Since Kasan is not using header stubs, it is necessary to avoid
  kasan_*() calls using ifdef when compiling without KASAN.
- Lift a line aligning the end of vmalloc from Melon Liu's
  very similar patch so we have feature parity, credit Melon
  as co-developer.
- Include the atomic_read_acquire() patch in the series due
  to context requirements.
- Verify that the after the patch the kernel still builds and boots
  without Kasan.
- Link to v3: https://lore.kernel.org/r/20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org

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
Linus Walleij (3):
      ARM: ioremap: Sync PGDs for VMALLOC shadow
      ARM: entry: Do a dummy read from VMAP shadow
      mm: Pair atomic_set_release() with _read_acquire()

 arch/arm/kernel/entry-armv.S |  8 ++++++++
 arch/arm/mm/ioremap.c        | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241015-arm-kasan-vmalloc-crash-fcbd51416457

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


