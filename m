Return-Path: <stable+bounces-86538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F79A125E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBAF4B2194C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D32139D1;
	Wed, 16 Oct 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cE18XdTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE691925AB
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106132; cv=none; b=bfKYrVW9SnfjTXz9FWMCt7XZ9WGmwc40XEe+VC1aiXveewKqBtYKrqYo9rN65keh2ZjkN2Fny2ZBY7vYJEuEoKAGc5G4W6YFJET7Y3U3mQy8viQnoYMXFuUDhk+F6hlDjQSjWG2bG2yXLkAY6nZlIOFVCfSUo5GGGla681Pei88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106132; c=relaxed/simple;
	bh=AizIWYo3Rp6fcvTw//kensRTmFu4AwbeNi936ktT/FA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pZaDQWv+wyKhawdsKBGLzlVC/tZdbq+/AehFONb4k41CFPKGN73XhDH3XeNY64dKVbM3VYEiEmn1rHDrPk7muutK1aq9010Zu/aZ/Kaeza6uH7YhOiySr8TJr8gEdNwqG3Go+NZbxF4oanrjuIi9v4Gvrr4P5pjG1LyIiWJedeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cE18XdTE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53a0c160b94so209295e87.2
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729106129; x=1729710929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnUOdLnFJmyzeKaHzf9E/7YlAq92nC9210MUbTkGRcs=;
        b=cE18XdTEsZaKltk/E4kSPZDBAoNYwJTjayB+7cvZKi3XydZQKcjdgve1f6Iyi0TMIj
         +tmFpdcD3FzRVFcqsmyfnbfLzLTODTGZDLxnDRdesOddyrpYNQ6/mir/ojp9Qv2X03y8
         dUIybYM2sN3cx+h7BlhdW/ybf3W0T+/OrCr5kJr7bkTqIfqe+zPw1QaaeC3WhIZGK6rQ
         t6T5sniVTtaN8ast42mhL9lweIDfJEgTWvhykAP39XiijQ48z5dNOUPnscBoJGLNCa+N
         Qt6CzV4fpmtgoGgIHnQFxIss6fNBtmFVGbuKhSVz+ywWMcsa1949iZWlrLgXmZQsk6Ds
         yzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106129; x=1729710929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnUOdLnFJmyzeKaHzf9E/7YlAq92nC9210MUbTkGRcs=;
        b=mlHhG7h5QSytlpRl9euUQdM7XzwYKhZviA6wZbqvWd2m/753XqqwlCIpw65iSU5xpI
         69REgfgziIs5XsGD2Hd+skZld58ZY8I2FmDgyDhVs4tC3PdpJINkf4Rmx4zUJHqG/K14
         VeqHcK6qHEuLxBinam9iZcdMMdyE0DoI7q0bD4QJYcVTCwm9GMLsrOW9MY6XraO9XA/8
         rROjQddjhAF0y4PriUcAdYLhiScZzWfeS2acrAWhqEIkUYXBEquYu2kBKscYeGTL6wj6
         8myTZI62SOXF6oRGXVam0v2uJsC2i8jiVVENGCq8Ozvr6/0HcuKmO8s5D+CxBhA2g1mI
         zssg==
X-Forwarded-Encrypted: i=1; AJvYcCVcfP+C2voG2VC3ilJ1zBfix3Nd1sBK6ST6LEujlq1ipUUF5+FbVzIh3EHQsPyXOr4HBG5x6KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywia9mRXYJSs6V7ZYwMXsNNsRTSDNP2wMXDZZpSgwb0syTMJc1R
	1gGqnPPIA4f45XYnn63iG8w7qUybdOmRiYcCKXt+knnkkfhyxCsNmGIe2ZsvWVooHt9LiDJL66c
	y
X-Google-Smtp-Source: AGHT+IHyCp88Lyyn8NVup2Cdcy7bSgWgZ9pAZqaIufBQaS5qEjeH2wgORBRi5ULiWKpPBEy1cbB6lA==
X-Received: by 2002:a05:6512:1095:b0:536:a52d:f94b with SMTP id 2adb3069b0e04-539e54d828fmr9034506e87.8.1729106127388;
        Wed, 16 Oct 2024 12:15:27 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013cffsm531184e87.278.2024.10.16.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:15:26 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] Fix KASAN crash when using KASAN_VMALLOC
Date: Wed, 16 Oct 2024 21:15:20 +0200
Message-Id: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgQEGcC/4WNTQ6CMBBGr0Jm7RhaqD+svIdhMZQCE6E1U9NoC
 He3cgGX7yXf+1aITthFaIoVxCWOHHwGfSjATuRHh9xnBl3qWpXKIMmCD4rkMS00z8GiFYoTDrb
 rjarVqTZnyOunuIHfe/neZp44voJ89qOkfvZ/Myksse86XZmrtnSpbjN7knAMMkK7bdsXO32L7
 78AAAA=
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


