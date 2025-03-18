Return-Path: <stable+bounces-124846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C97A67B29
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B303A6AC2
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AE20B80A;
	Tue, 18 Mar 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pnVp/em6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECCF1A2658
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319670; cv=none; b=n2qs/gUCxWgwjA9l4H95klU9UXL4loaOHJf9ODOyoAyChBq+8B293vgkuYUAXF5Jrze9EDhAjeiN05l4TtyPxnJpOfE97LLkKrNGDRmUL2oQOZ+Nv0NGElqGEB+T3154u+13YeVbnnMCPD7Mym05HJLmnKzNBX97tJO1q0CCzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319670; c=relaxed/simple;
	bh=cY8zJalzlYDRu4TCSrTTeFntZqu4qHy6eKeTT5/JURk=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=cUWEFZipyKsAjmd3Ot+BJn/ZOlhg/vUrLpRJLIwYvL4o1OfCpaPMR3yKd8kjsuqt2c1qIyXxUv5fNOGzqti9prA3UApB+TgaLvj1joWS+P5C3BwRYTY0vaKfda5TwtgR1E2OzHySJ9hYPxFry4gV6vh2nQAg4l8WUn2k9Rf5QyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pnVp/em6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso4570133276.2
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742319666; x=1742924466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr9VlUSuwj2cvREtuodkvAWZfzyLV8sJeXtl00sfed0=;
        b=pnVp/em6p9PQ4rGB0PGTgJPm7PXiY7dBHBVRmfvrlyF4eMDuYG601x40Ee2R39zkHz
         1LBQXSxDUvbv9+BUyGUeDbQkO8xZM8XFDtIvYuf1HyxcWpjIa24Jy/qswRNe0EQAwvQ/
         gcxCPOi5rjnDO9UmKxn39e8qJlUnlWntYc4MvsFAlCPMX9+XFnWQJYR9TgZ65FSqv6Ep
         oeR2da9Nbnx8/xIioyVf9JG2zsC6mXb+HqzM5kVyg5TJI6yDNfuFtIF5JwgBCgEakW02
         phNPJU0bieEkx/VG0IZPkgkYVXH4rBy2JSZILetk8WP8OBxHiuhGLW2GYjxvbEq1bFN3
         1C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319666; x=1742924466;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr9VlUSuwj2cvREtuodkvAWZfzyLV8sJeXtl00sfed0=;
        b=cQoPlTyxtv8wrd133Q9tlAL1ZRktpkdnjWfpbAbLF4hU1celNEtP2MmvS1hNy/mfHO
         Df7ZXvY4IMIb3eXz6wWhEg+YY8AuUlRkanvbYqjkebtnYk42dynll7cRNVoAZxabMahs
         gk+uyc2uxOaQYOCxKNBFaQG9IC6ROF9LBlIKUHeRlvfrptsR1xpdAw5Aot9x56p4QKKK
         sIE/V7gqscaQphtMeq25fG+wWAtvMJDVEbIBncVUE0WmetwdarsT1U3DSiPYT8ZF6CVg
         du48Mo3sKa7JMveQlrxaLoa7cw3CKbZCwEYZGxD0YOMMOTjNCpHGobuJHLOdGYMCrNJp
         LrCA==
X-Forwarded-Encrypted: i=1; AJvYcCWlhFY5XRm0x97rTNONjoPX0aQoxqZmuGnQwOiD5r1sUbxG7JNdBXQN2gZSONczMvGwRGeqSSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8B5h79DFB5WD6f4zbjo5aT3u4vW8CRw05zJ7XLFtu7mBkNVO
	sG8D9rBItIo3CT587uWJ+/KjPAvIOEt1Xymqul630UhHXlZDC1unEVMS9IcbAP0MzxSFa4r17z+
	apqsRu+E+R/i3HsOJy0M40PJQX16Kso68O9U7tw==
X-Gm-Gg: ASbGnctbxPwHsMQ5AayxA5Qr+xgK9eV3MN4XUDRsvAsqA9Xlj/C9Oh4u5qQJ+52mCqO
	jqigOPf21IEzroSRWPW4TwPEKoFd2OLJQEPFw0zJTYy35YibzYZuvutgzKWhGI8mXNXRtkN6Oxs
	zbFXmXIysavhp8yY5/zmbC4R6nJvM6F+y6/qCzaKpfrq8sFf3e3tiURGj0/uo=
X-Google-Smtp-Source: AGHT+IHAvgFSLCeKiG4GS16PKXNq2KcLKgR1T+3ZNJr0mbRXwyJqEXnrH3ZlxHS1+S6S+PGEW1OcvgSG0BBuSk2TJhs=
X-Received: by 2002:a05:6902:2786:b0:e5d:c2c9:c11e with SMTP id
 3f1490d57ef6-e64af141c4emr6076248276.15.1742319665867; Tue, 18 Mar 2025
 10:41:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 13:41:05 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 13:41:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 13:41:05 -0400
X-Gm-Features: AQ5f1JrLCHCgFXFzekvTy-M2owmoNcV0_6LhIjktQM-SGcpzkB6ESlFIqMVSwwg
Message-ID: <CACo-S-3BZGKvH+Oe-xhM==HpvR_-jr8EtRuz8CaKGqup4m_a7A@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.13.y: (build) format specifies type
 'unsigned long' but the argument has type 's...
To: kernelci-results@groups.io
Cc: tales.aparecida@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.13.y:

---
 format specifies type 'unsigned long' but the argument has type
'size_t' (aka 'unsigned int') [-Werror,-Wformat] in
drivers/gpu/drm/xe/xe_guc_ct.o (drivers/gpu/drm/xe/xe_guc_ct.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:654a7499ce48b09c6748b92c5ad90055057a67a1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c025445840beab62deab3af5afa8429f63e8f186


Log excerpt:
=====================================================
drivers/gpu/drm/xe/xe_guc_ct.c:1703:43: error: format specifies type
'unsigned long' but the argument has type 'size_t' (aka 'unsigned
int') [-Werror,-Wformat]
 1703 |                         drm_printf(p, "[CTB].length: 0x%lx\n",
snapshot->ctb_size);
      |                                                        ~~~
^~~~~~~~~~~~~~~~~~
      |                                                        %zx
1 error generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67d98d1028b1441c081c5d19


#kernelci issue maestro:654a7499ce48b09c6748b92c5ad90055057a67a1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

