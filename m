Return-Path: <stable+bounces-145692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F666ABE238
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D24166DAC
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124326F440;
	Tue, 20 May 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WmHxRIq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DE25B1D3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763948; cv=none; b=ovnd9nRU4yuCYH1AhpXOTy+xXf9E4p0dLfCnWhjODLgo941W95TiZZIyogTxUMx71WrdPItuyEmP4vaY2th4QGikz4a1fdyNuLkTDT9TnARUNbqlKjJb9cIXpVw5GD0jX3xpJeTx/hGg3N3nLxSpv0x7fmh2oB+aF/wN88AdKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763948; c=relaxed/simple;
	bh=wgCii30GjMhHtimkrAbU+0WoC0n4tKxapYyiGSdvmCU=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=jPIPKN1h3fXFKtcFn2dfrJIZngLPlMBjG08/oiIyjnQEo8LquJqAjOfz/PhvV6zJjXytJMl6KK1wz8RdbIDl0IOVPgJNOJbLPapw6fHOE6aF5FdJ8RxaAYzJkkKn0UKhvw/sg5i0+MXVFs5OPAzVMNKFfXNT+ndRvMIxw3h5BSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=WmHxRIq0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7b5f81594fso5228755276.3
        for <stable@vger.kernel.org>; Tue, 20 May 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747763945; x=1748368745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRHMeyoRQuvZcuFjHmKImLHycMNfAUuBZnd3kj1lMdQ=;
        b=WmHxRIq0RBsY+x6ph5PWVsAReN6+bXGuA8FqfnqTWG7rXy83bTonWLrunm+kmTQ8jU
         UWtccYvMOPa6WfPkv+QTY61oOD9yovqHlxp+ZUJjGVRR3PNkjOe/qEgcQOvf3VjWz4Qz
         UB4jqhJ8TH+0k/P1MTcyS6fVHLo++zK9us6dVhxOfV8PdNIhT6tF2Fn8vgvJyw68drnV
         IVVGbPVqBxYEffY4Jgqbu7JT07XLlfpa/KkqVA2xYbxd15Biuln8AlbT1xRSjnyYFkhT
         y/ULt5ZBGN4WzaD00KVntpI5IqrJ7/nsDzK+kO2BYRnZ3NH++zv8s5rliVRdChZJ7ER0
         nLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763945; x=1748368745;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRHMeyoRQuvZcuFjHmKImLHycMNfAUuBZnd3kj1lMdQ=;
        b=Y/3Hin5mlFKjRWd1fPPHN8dOEDHvpEQVe6YIqm8XsNQj1HWZwP9140aTbV9IUHmEWQ
         FmrpVfUGYyc9HdPsrRemYtUFs82tMY9NMxPJRliTjxcs+B3mr/KoJuHsQX9Y1Kxzw+9Q
         ln5OlsN6mk7A+HPjhxDlfU6icvqZx1SsiOnuLqE3R+FrEUWJtIS9pR1jYazC3QbI/1xd
         AR+v8tuXMao9ET4kQZke3NUi+iWeBw5EZ1yzWeyaPlUXFZVG21cMmlvPkb4o+7Wp9tmk
         t/1jbGji3qSjaie2nfNXKG7ZcBWld7r+uZNMd7aKa8Ob6Bm/1Djdf2iC7ANAbFaigupJ
         OQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Uv6nvAAogiTMwtyTqZi+0SqW/n8v06JbNulHNMkFyQPZCuyCfDKif3O6Hae+sPXkxqOri6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4fenzpMCxto5sZHVMFFviPbQibBP65KyQDgau+JXFX0Nxi3t
	Kkm5kWZ2lpPTbZXHatoEs4w3Ce+LVO1/WZjZDH0bfhC4cjkr0UL4X5F8yh5DB5hIsspCLVcdSAh
	R20aTxqfZzUIotEKCFPn33qtie+YM+KfMl56CAJfjTbGXXcV96IJ3TJk=
X-Gm-Gg: ASbGnctJkL4E6Tn7Z8+SDpWnulkazuUaw5kV3DwbUMFg6m/ae+kl9CAwGRRFMADNBP2
	uqQEwT0+0Caad62Yk6vhhhdZ+niYHekQxETcvZr+jR1j1LlD3pRjflV63Yx7WdQJnwJPLX9NXnY
	IBV2LJQL11qXdoMmukbIaP7z3tZUBsupo=
X-Google-Smtp-Source: AGHT+IFH2wtGcfNqVKIJXhQhAf1dD2aOLn55OdfSPdiGQkAFZk97SyFslUWHrhuvLS0QOgNMmklBn6ICKAhkheRkiwc=
X-Received: by 2002:a05:6902:2847:b0:e78:f20c:9b85 with SMTP id
 3f1490d57ef6-e7b6a318329mr24905610276.38.1747763945125; Tue, 20 May 2025
 10:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 13:59:04 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 13:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 20 May 2025 13:59:04 -0400
X-Gm-Features: AX0GCFs1B56PG56cGl8AvFKOTldwOqfHKNuV5JWtTnyXxhTVLnP1MwT0yfotiAs
Message-ID: <CACo-S-3fJyZaG8AK9TLqojd72F0y9HyH56Qa+LC2Q2Qibq93Xg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) ld.lld: error: undefined
 symbol: cpu_wants_rethunk_at in vmlinux (...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 ld.lld: error: undefined symbol: cpu_wants_rethunk_at in vmlinux
(Makefile:1234) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:029b000b9c1bb21b6d1cadf1eadd7d1b2b5f42bd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ba6ee53cdfadb92bab1c005dfb67a4397a8a7219


Log excerpt:
=====================================================
.lds
ld.lld: error: undefined symbol: cpu_wants_rethunk_at
>>> referenced by static_call.c
>>>               kernel/static_call.o:(__static_call_transform) in archive arch/x86/built-in.a

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:682c81a1fef071f536c2ecc7


#kernelci issue maestro:029b000b9c1bb21b6d1cadf1eadd7d1b2b5f42bd

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

