Return-Path: <stable+bounces-19678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBA8527C6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 04:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AF51C227FA
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB2A93D;
	Tue, 13 Feb 2024 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SvBXWl4W"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232E8F5F
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795469; cv=none; b=WDZ+GdFMDkjJj4LHUNaZbgQ68NV65YbHTO570aHuv56VvUzdqtkZtOXgm7SJN/Oygupa/DC0j+PXq4Lz8CpOKyHapFNqiKcrGcPglj5U0Y1SVFxKzdWMUVKBK/fqVZB94wAnUkFrCZPzr/gz8DaDCnUuuUF3OuRG64OfF0IV3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795469; c=relaxed/simple;
	bh=whB7Ohz/aZw41jDLmsNbB2EZqD6VWqw1GxgDMy7wNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYh8Oqlx3dDuKHqa3m+qJnLDP/rwU1gAfOe7SCDg0OHeyHxh/pdJdZ6eVLe9T8ZhJVprO6lmeqeKibURlBKRzafmaL7Ae0jVExY4O03IAEYbEkoJAVFWrOdlNYjjPfXylND/oRjlIBNEENH6pk6yYCcGTXFqINl0KWbwW/5uHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SvBXWl4W; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c02b993a5aso2150436b6e.1
        for <stable@vger.kernel.org>; Mon, 12 Feb 2024 19:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707795467; x=1708400267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=SvBXWl4WKjxR5Y3T4VaBEtbfraAgYkc6DGXqjjJNhrjAo3vODTqocVNk8XZE+89vMe
         25c2j+Zz/fHPAhE+zswA3Y1ecBRLnB6jUSMI9oVZkWa94c+8HlI/EVl1Wi2Pm2QuGsxZ
         bHopgMvFVS5V9F8GrzW7cxpAeIg7gtV0JSluyqf9zp8Pn2ZdTOtkV82nPVhxqe2dzdHY
         STlOTg6tdsJXP2p2tg1ths9t3gbvYM5kv67I3VvNKSrEDYAscoWkPsOwry3OpxiJlXBJ
         EDuvkPQybc7wRsWpUVXZt6XPVWBw+Ot/AoEhToxpkVJjgU+YvMOHW032WbQO5bC1eqGV
         dHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795467; x=1708400267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=dBU5n8eMauplh7YLKZzKC4THOe3YM6UAsOyQS9uMQ/GFxpSMH4TYJ02VORjR+FCm7b
         K9RwUPwqHq1WArd2zdXUqCt6R8mvReyi/UJecOaX4kA7Dc68mQHjJlP8HYb5NieHODMf
         1Pj4d2dINX5BiVtgIWWhdx558BfHSVFAO41tUBTAxxRyo90N5KfXz/FU3SKEUaZ7rUM6
         emW6JOeji8w8lNg72s8fBi9oWBauW8+VdFV+mMMX6W9jYCgfb69as24FJuouIaCxG8EH
         aXV5mjBKtrrNhluQvTGgS3XVo/Pm58C0vx1KZLvMt6XDR+fnqGK4LMoV1tbO7544HIza
         JIuw==
X-Forwarded-Encrypted: i=1; AJvYcCURBF3/WV/s5tXDwjakTi66HrSIcMEZ18hWJOmUgMMj4/KKm0UkYzVkX8J/XGFnTX1F3zl2XFbcZB5qrVJaYMgDRo0+LwkF
X-Gm-Message-State: AOJu0Ywax7DXOJYLkx3/nr9Y9Dgu711FwVPo9G6i/b8+0DMt7r77oVXJ
	CM7b5j4G/C929AgIK/PfR+uD7scVjxY+dpYV7N5UBgmH+2LAc7LMcQkQ8Mz32ko=
X-Google-Smtp-Source: AGHT+IE+bElS9VOEBRZYkJMFWhhPq2JzIWq5hlj3C9o2gaDkJNP1gz6btAf9jVpFKefBHdsEY+u7+g==
X-Received: by 2002:a05:6808:298d:b0:3c0:2a95:d3c6 with SMTP id ex13-20020a056808298d00b003c02a95d3c6mr8180720oib.23.1707795466997;
        Mon, 12 Feb 2024 19:37:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG/9tEvERy1/zBWmZWATN9vy2GlKgAccgGMVroA50EeE7/5k30EBoGfGzSPQVGrAPHngcjrgBYvF+RvNslSmRsSoRygVpR8QgfaonMsrMhR8Acp+tY2Km1utekPImLqFVD+seoCQDmoakBzopdLkYZdAgIlb3PDYm9oavZ06D3knOGVT+4oc8cObDPMQHZZNXQ3vsaHWtRonDxS4SpF6AEPKFEoBLA/OuzoSULbJ3HoFmYvyFM
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6188633pfu.76.2024.02.12.19.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 19:37:46 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v2 1/4] riscv: Fix enabling cbo.zero when running in M-mode
Date: Mon, 12 Feb 2024 19:37:32 -0800
Message-ID: <20240213033744.4069020-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213033744.4069020-1-samuel.holland@sifive.com>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel is running in M-mode, the CBZE bit must be set in the
menvcfg CSR, not in senvcfg.

Cc: <stable@vger.kernel.org>
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 510014051f5d..2468c55933cd 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -424,6 +424,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG	CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -448,6 +449,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG	CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..c5b13f7dd482 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -950,7 +950,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.0


