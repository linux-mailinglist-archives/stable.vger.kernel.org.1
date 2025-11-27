Return-Path: <stable+bounces-197509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9261AC8F6C5
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459294EAFC2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9933769A;
	Thu, 27 Nov 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="FHeG+t6N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF121B9DA
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259147; cv=none; b=D2XLYAHzaI/V1I0HIUx2BxDhj0n25w11S1k8Kmnm03+0ZhpQHPXHJJ0bHGejb+omMj9lzF8132uwf/3UiEnJVhXVfeiTPJ7arAIU9kXNU8lyytyhi09EvA1BK+Knc4TLVK/XAhtQNVu5aUGFHClOhu/8+2b5mhYdTfoEhOSX0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259147; c=relaxed/simple;
	bh=9ZzKcKIgZ9n6Eo23EJ8Prora+F9A0YM3L2CXsxAKcds=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=uzOYX7LZogGnJXXa3KQsHjiDI1DMmwdplBhSai88ZMaqA8h7IMcyKEqypLHG33x4OhkZtitp05TwREFRW9Pi8qmaaDF9TcaSC0wpT7sYl9zL51SqWT63n4RPFuzykv3RHrdVtQpEnqVkrsvGAzwO7Rri77ut1l/BFjQ4mlvlCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=FHeG+t6N; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aace33b75bso949053b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764259145; x=1764863945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJHmsqXzEO1WhzD9aktbA8nnXS+LjHgPh9TLG0CUyNo=;
        b=FHeG+t6NDy/489qxiHKcEBovCMghtm+YycYnQooyRoheYqMXKBPMEcX+TS5HAFKoaf
         pLyE+1gpbzjZio7/Js4j2Jc42F+RUx5g4I6pMMJU0jX5XY3Gc1WNCcLMicFvfxAXTuGG
         3/WKuzX/mWC/xi4yK2krk3J9BpFYzDsArjBg09iI+BkLB3lwAgdeDzoeTbkJ6YJ572Yl
         4wKzkNOhaM57EgycpIuQrbjWHN+1QzG3fGNTXjwHA/j60/GWkPZuBLB2HIIlh8PHWwnK
         MAHHQjcNYvN875/aCdBw5KB6cvOYUx/6yxchgthkBDQ542zLa5Mph/DxBaUKGkdbHcMN
         SZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259145; x=1764863945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJHmsqXzEO1WhzD9aktbA8nnXS+LjHgPh9TLG0CUyNo=;
        b=jkMHRt08CXr8aabKJGQig48NpRGxfxwLFMMg6ab+2F6I0/K/vsUv6v2TnRKEs4MbDD
         FAmXdiHHn2Nk4aEoTfgHXitGJZVPiJgXCQFi8LdpP7HKT5zbS90V3hCjSAqA7AZJcM4c
         OyyOl8kpMnN/BAVeiIqxNKyaE8fECI7Y/KUcNo2Oi0BRMnxQWhUKsXAVfB05sduVUVcY
         0Ws1sJQg/S6aVfWWnZY+6oJsKtWK5rO2HutrBaGuNwO87G6x5qbYUSvdp154fo4JKynE
         TiW3NHcHa8VrZDcii5Uo1g50D5QkezkxeeHMoM+41oXO82uWkWAJFobCn2TwRM+uobMu
         mPHA==
X-Forwarded-Encrypted: i=1; AJvYcCX6xM6+wjYSyMJeOW22uxJ9WK+6ccWEenYZZZcTqqIQEd5uegTwWC74f9Cpa4HxPKwh0eY9An8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwItv9OjqgSeLirqt8P8R7+1c31QhGAc34pWxpQEwgndZp2/bd1
	+zAlAIaUQ+uLyWBNEhNuyeSTPPYQBT3nNVz8im0QIdloXNaCU7HsdHtLxK2r4gS9Jgf5LB951Z+
	EZ2af
X-Gm-Gg: ASbGncvP/Z53Ab8xC1vg9B8yTpcg1WE5/juOpNQYslNkMNKX0ypwfnUpT8ywiFZ67CD
	WSnhN4P2bOHM/cjEdteadL+2tEVXr0cp93AcRkulPv9dy0hfPdF5y0jWCyt15JdSFlkTEejfcf+
	oI1kiPS0tmWE00gtSWYlGSLk8sqlXyhW+LoGahwYNFLHLzgf8+LgAX7vQbkcl6OI8f6WiAl17hU
	yHUe9eESsvsvy6m7Pj9kY24gnO2BQOFeFrlnWUeQuJSfrKNCvfCzWPwj0SWSrTaq7v4CfeXcxOP
	vFtfpwzvxkw3SL3oTlmXp0fH5QGFmWDDnKChm5aKop0m00JEDQnB+Xoje2UwZqIV/VSnjyMcYkW
	d1KhqOUo+06ucEnPwxNPtnBn8WfdMOh9sSH5qN0U87WQd+wGwlWTqTiIfiPL11JvBJSRSKWBgJ3
	V1nlCZWyH/isV4Bmo=
X-Google-Smtp-Source: AGHT+IFYeXpPQkoR0TI1wvui1aWw/ijHUTEJA+OXVRgB6TCQ3g4Dqq3qPqWd13aV+kyIgccNR8uGLg==
X-Received: by 2002:a05:7022:6181:b0:11a:2c18:cb89 with SMTP id a92af1059eb24-11c9d860d64mr16161603c88.35.1764259145026;
        Thu, 27 Nov 2025 07:59:05 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm8605109c88.2.2025.11.27.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) GCC does not allow
 variable
 declarations in for loop initializers ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 27 Nov 2025 15:59:04 -0000
Message-ID: <176425914379.933.3008623423965283783@1ece3ece63ba>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 GCC does not allow variable declarations in for loop initializers before C99 [-Werror,-Wgcc-compat] in mm/mempool.o (mm/mempool.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5387ce1530c340d198d1f318d34f9904675295a1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0001989708674740432a288983eddc1fdad1073b


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/mempool.c:68:8: error: GCC does not allow variable declarations in for loop initializers before C99 [-Werror,-Wgcc-compat]
   68 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
mm/mempool.c:101:8: error: GCC does not allow variable declarations in for loop initializers before C99 [-Werror,-Wgcc-compat]
  101 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
  CC      kernel/irq/spurious.o
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69286d2ef5b8743b1f65f3ee/.config
- dashboard: https://d.kernelci.org/build/maestro:69286d2ef5b8743b1f65f3ee

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69286d6ff5b8743b1f65f41f/.config
- dashboard: https://d.kernelci.org/build/maestro:69286d6ff5b8743b1f65f41f


#kernelci issue maestro:5387ce1530c340d198d1f318d34f9904675295a1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

