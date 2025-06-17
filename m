Return-Path: <stable+bounces-152839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE4ADCCA1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C253B3B50BE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F442E2650;
	Tue, 17 Jun 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFpJ1kjM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F22E2641;
	Tue, 17 Jun 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165510; cv=none; b=keSK4dWo3/uoL8KIp5+6fDzhLjaT8eEBJch9x+US33nLEbY062cIObXOyKT4Xd8tUNppULAUfIOPXScGPsYYhO3Yc6vCAzUn692cmkgIfVTsWtq7eVlhdKAgxll75/0C+fHR3zspEM4lDSw53/HIGCGq8tzDdUapDM2CJVMkW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165510; c=relaxed/simple;
	bh=xUevxqP7qeHQyrqc8eeur3FyUDeFXsqRS6sO3KTeE1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNWdlsg4zOEIMtqiGt9aBbT6/shQ4P9Km8O4V44cliw+ZARfeFybys0i1ud7hzgDAnQvi8UxwNe86tGcF11gRgirlTGnRXqdhbcEE79tZjuF/wZkx6cyv1r/mRYwYm3dXq3rXImV6DkaUydoWiNrOFU1Hh+z4JVao86JtqGdtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFpJ1kjM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso2760078e87.0;
        Tue, 17 Jun 2025 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165507; x=1750770307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ7rt4e14DyPGgHQFy3EQy+5G7wFsrLkDEYIps9brIY=;
        b=mFpJ1kjMUtq7TTL3NIxllOppRvClAn2qAeHE0EOYP4PuE/JeLxUyfI+P16t6AmDEaT
         bD9GhHgbpuPQz0l2XSGq9GOQUL00V0/XCExL0kJiCuIoSrHTE9ccDigfR8WrcIDhsMwb
         IA7/q3vlA8Ppo2LkcgWRl4H/SPwNwWoP3pHjGsNsFYuM/hp6eodu2rLLhxZ8W5byzILD
         Uwlly9uXTtg5yK1QHTff8lr09M1ZhISPhVXh+lXBoYkTCwApBW25yR4KcBUIX+YR+JuK
         4x1yXJSVl/hYinXCgXjiPlhUKQ40o31NS8lBFrcYPsegVZN0nW95cRjDBe+8Uzy9ztrZ
         tgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165507; x=1750770307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQ7rt4e14DyPGgHQFy3EQy+5G7wFsrLkDEYIps9brIY=;
        b=Kh9k5XSCbKONoCGMFgChv5LiA5/qPMu2sPtP+JEg5QeBNdtn0hPRwVJW0+abWHfPcs
         eWONetTkNZiKoTXtd+wtbjE35SgiE0iUnO8G1R5089obmZiQ2nSr9JyIxYOp1u9eE1B9
         7x9aoit/iqpZ+wiDbrLvZGINtm5ur+wWp1rwibATAZnquBe27rYY/OxMa3HA5XaBHGUq
         FDZLnanbS42bYvW5kpXHfAqeCyzDH1pvNrM0eY8kq7lpqUOHc6l5QDEj6ZCyxyQxbBC/
         akiW+NSPa4gcpvDtbFecFRxvAWqWDrmBqlFaccJmktWQiHMHap+4UqD+22QqNKvZChj4
         BDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8NvdvMGt1ChVgl0cjtCzt1eG367C6N/0Lb/WHAQsKvz/KlhYC9IvIBow7Q06OQwZjXerhYUvj@vger.kernel.org, AJvYcCXwm7vroIx8qCsBeScma4DrB61d5g/FLr9Z8jcQUzKPHZAa19aOA33u3utlQPBZNciKUgvHfkAvH0/DvW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQm9l4BcThJyvX+PcMwP6Pv3tBKQNUkwMiH1Hvg0yebshE5HG
	4bpQv2VqEw+76Cf7Zrt9nQMzm8mqmGKbD4lY660xqXI67wDwrv+tfu+b
X-Gm-Gg: ASbGncu5+MzBxwhmOJF7MEslvMO+wQD+xH271OJQHzmce9gMY5XQXGzMLB/MUw5RSjS
	GUNssieKfzx+fk3bYyuXIuI/d3/BSF6C+VLKn9JzcYm8+PmYqwDUcYqy7YQEODE3IWciT8pkkOb
	fdFjAzJL11sMqSEfGNTmdqhwbwFYB9UIutSANtdTGNbqqzH5bKkRSDxiOBJicmVdM7uwRLDO86f
	9saz+GIzr5bcl2XlTfe8QS4f935Ag0ZcFMWVkc6vqgUQ/hHmfK1YmpTVeW4Du+FJmXKv9AlmOJm
	K5SikhQyge35TVbWFa0tSOCcvVQi1Zx2nE+pe47y2pmYUP/Vblag+vpF62/8uuOn+AfCA01+ZKA
	VAV8cTb5RO+oQFihqYQ==
X-Google-Smtp-Source: AGHT+IHHo3gWM8jne4M/ik8SRuW9s/CXCSDuf5VVjjbmz065W7Ty2nNpgRR2fJksE2eb2m1Q59uOcg==
X-Received: by 2002:a05:6512:15a2:b0:553:2ef3:f73d with SMTP id 2adb3069b0e04-553b6e8851amr3027873e87.14.1750165506269;
        Tue, 17 Jun 2025 06:05:06 -0700 (PDT)
Received: from localhost.localdomain (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f91ddsm1900394e87.250.2025.06.17.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:05:05 -0700 (PDT)
From: Klara Modin <klarasmodin@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor.dooley@microchip.com,
	valentina.fernandezalanis@microchip.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: export boot_cpu_hartid
Date: Tue, 17 Jun 2025 14:58:47 +0200
Message-ID: <20250617125847.23829-1-klarasmodin@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mailbox controller driver for the Microchip Inter-processor
Communication can be built as a module. It uses cpuid_to_hartid_map and
commit 4783ce32b080 ("riscv: export __cpuid_to_hartid_map") enables that
to work for SMP. However, cpuid_to_hartid_map uses boot_cpu_hartid on
non-SMP kernels and this driver can be useful in such configurations[1].

Export boot_cpu_hartid so the driver can be built as a module on non-SMP
kernels as well.

Link: https://lore.kernel.org/lkml/20250617-confess-reimburse-876101e099cb@spud/ [1]
Cc: stable@vger.kernel.org
Fixes: e4b1d67e7141 ("mailbox: add Microchip IPC support")
Signed-off-by: Klara Modin <klarasmodin@gmail.com>
---
 arch/riscv/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f7c9a1caa83e..14888e5ea19a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -50,6 +50,7 @@ atomic_t hart_lottery __section(".sdata")
 #endif
 ;
 unsigned long boot_cpu_hartid;
+EXPORT_SYMBOL_GPL(boot_cpu_hartid);
 
 /*
  * Place kernel memory regions on the resource tree so that
-- 
2.49.0


