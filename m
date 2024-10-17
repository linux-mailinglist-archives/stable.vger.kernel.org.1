Return-Path: <stable+bounces-86681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8A9A2CFB
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7085284388
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29C21BB0C;
	Thu, 17 Oct 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NiExsrTU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49F21B43F
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191638; cv=none; b=gnTYAymEGDkx4LyeIvfJY86KAkVg9IGzzNKpadWzYDHi71lsqtwCKIx8vGbZFNh/TFyv2WW/YzcBDnzTA4lTN4TST9pT3zHr71FlYwEXJEiEsg9rYvg9E3R4FUzhtp8wvE7LqbfecO/JSzd1G88vOPw/4z2m7lB5gXtXykh76aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191638; c=relaxed/simple;
	bh=viB41ymerrNs1V8lxnas3H8vFE72zXnqdr82GJQKPN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hoJWcufKc7689EGDFNto+ON3lWQYVJKYUP0yBu7j/6a83TKqZaGb/6J4auEZnlE98YRLWa5MYHsD2jCmVx0BEk1TJJb5YcNq1kd8hTKlOxpN1YFDExJms3efCaSNNVVZFItg5AZJOq3d6Z3U+DCNBooC2e0HnRpmiidqFiQqfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NiExsrTU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea784aea63so794243a12.3
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729191632; x=1729796432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxSczehEe035W5CU04y0FkOvPuUKpp9p7Yd16WBzeN8=;
        b=NiExsrTUSaSmLTC3RwkQdRUJwJEVF8FDhgvsZp8pc3X2ejGoBUEw1udTPBWIy4MSgC
         b4Ogb8HjcpjJxcpF37yHxR57uG+aOHlWxYRsGHVwU/SdKlUmRZMmylDqbRQrUyQMJ+vM
         hJQv5TA5flUwK3gWaXtlfOU0G5XLV2PUMaSNmlSTsr7xIKGbKcfBwsaDrWE2l2ITo5rW
         MrWDhZwEsZC4Y/L65XxqS0OvupgCwwq6Hgd1JFVJKbw6upGxe2tFSxj2Un4twKCjrupA
         zM/YYoABK1dzSks6pZCtIgYYxIF9ELDjfXFySYVHZ3Mv4MyxlE9SfiaLJD0ojAP4r8o0
         H1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191632; x=1729796432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxSczehEe035W5CU04y0FkOvPuUKpp9p7Yd16WBzeN8=;
        b=Xznn8+I3HiJZNSgkCh7nvMIqe9+YNEdEdIYBXl44/jsx8CxRnMeoeu7ZeIlMXnhyEP
         rnLEj0kZbhXpWJET0JSXoZU2/L291slPQmGHeiWM8xEvV5ll8OGAJ5+HGeV4aLijAaye
         X2S6O4RcmD/UuP24ZatazJjc0HRnBbgEyLxT94XiEosEEXrOKatewWzcshmYB8deWGIK
         z+3W7ufsIrfUfG0ObzRQ6FLUl5VQ4IpHimtNe+E8L4OXWOq0Y6cpB9iioonzEK7bP4Vx
         Rek4LEa3Z241yDSYbYzqJpgn/rSrVykqlK31RK7vOheB9xSZmgFinibQWrJWVe/nBMBR
         xQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzy2xE90qoFFQjI5NmlcuWbIJvhw7EJ0a68U8Rbu7xkFVOKKfpXpiW+6bLR6d1Tig2/KAzyWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpHkijH+kesbpaHNd0/d4egamojvbmpG8b5T+3R248aUKpPtl
	sqcUxawa1PaVhz4A6Tm2lbFFU4pBX9Q/D8xlY/g33E3ulAASUja60gPiUiyp9dw=
X-Google-Smtp-Source: AGHT+IGpwyQf2rcH+WzoDhFYXE176SHL014MFUoPQcIpoNd1sTNXjuIoM/j+GeIybPGawXZSP9zyHg==
X-Received: by 2002:a05:6a21:a247:b0:1d9:275b:4ee2 with SMTP id adf61e73a8af0-1d9275b51f0mr2038031637.24.1729191632029;
        Thu, 17 Oct 2024 12:00:32 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7bf9a8sm217766a91.13.2024.10.17.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:00:31 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v10 0/6] RISC-V: Detect and report speed of unaligned
 vector accesses
Date: Thu, 17 Oct 2024 12:00:17 -0700
Message-Id: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJeEWcC/x2MWQqEMBAFryL9baDNLC5XkUEkeWrLEIe0yoB4d
 4OfVVB1kCIKlJrsoIhdVJaQoOA8Izf1YYQRnwRZtk+uLZsZqui20H9lDPDdDrcu0ZRcPQZvq/e
 rdpTiX8Qg//vcfs7zAtvOmnFpAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>, 
 stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=viB41ymerrNs1V8lxnas3H8vFE72zXnqdr82GJQKPN4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pg3JGG12euWlQy9DvKHBQ0nxMz8c6TL5anFe59fH1hW
 V3qk+ttHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzEs5Lhn93O7isqHavDq15P
 rPI4ofHUflJP9NGucKUu2ZP8awIb0hgZJs58KLO8wStM+qeDwZsbfwP9hK+0SMa2r10j367AXnu
 bGQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Adds support for detecting and reporting the speed of unaligned vector
accesses on RISC-V CPUs. Adds vec_misaligned_speed key to the hwprobe
adds Zicclsm to cpufeature and fixes the check for scalar unaligned
emulated all CPUs. The vec_misaligned_speed key keeps the same format
as the scalar unaligned access speed key.

This set does not emulate unaligned vector accesses on CPUs that do not
support them. Only reports if userspace can run them and speed of
unaligned vector accesses if supported.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Changes in V6:
 Added ("RISC-V: Scalar unaligned access emulated on hotplug CPUs")

Changes in V8:
 Dropped Zicclsm
 s/RISCV_HWPROBE_VECTOR_MISALIGNED/RISCV_HWPROBE_MISALIGNED_VECTOR/g
  to match RISCV_HWPROBE_MISALIGNED_SCALAR_*
 Rebased onto palmer/fixes (32d5f7add080a936e28ab4142bfeea6b06999789)

Changes in V9:
 Missed a RISCV_HWPROBE_VECTOR_MISALIGNED...

Changes in V10:
- I sent on behalf of Jesse
- Remove v0 from clobber args in inline asm and leave comment

---
Jesse Taube (6):
      RISC-V: Check scalar unaligned access on all CPUs
      RISC-V: Scalar unaligned access emulated on hotplug CPUs
      RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
      RISC-V: Detect unaligned vector accesses supported
      RISC-V: Report vector unaligned access speed hwprobe
      RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst       |  16 +++
 arch/riscv/Kconfig                         |  58 ++++++++++-
 arch/riscv/include/asm/cpufeature.h        |  10 +-
 arch/riscv/include/asm/entry-common.h      |  11 --
 arch/riscv/include/asm/hwprobe.h           |   2 +-
 arch/riscv/include/asm/vector.h            |   2 +
 arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
 arch/riscv/kernel/Makefile                 |   3 +-
 arch/riscv/kernel/copy-unaligned.h         |   5 +
 arch/riscv/kernel/fpu.S                    |   4 +-
 arch/riscv/kernel/sys_hwprobe.c            |  41 ++++++++
 arch/riscv/kernel/traps_misaligned.c       | 139 +++++++++++++++++++++++--
 arch/riscv/kernel/unaligned_access_speed.c | 156 +++++++++++++++++++++++++++--
 arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++++
 arch/riscv/kernel/vector.c                 |   2 +-
 15 files changed, 474 insertions(+), 38 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240920-jesse_unaligned_vector-7083fd28659c
-- 
- Charlie


