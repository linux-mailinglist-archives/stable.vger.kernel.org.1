Return-Path: <stable+bounces-20148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D103854481
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 10:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FCBB2769D
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FE79F4;
	Wed, 14 Feb 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vu3CK0nb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23379E1
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901332; cv=none; b=BC5VwHFOeJOHDFnqc9/r4oJKhD/XR+BtytqxwwmlvL+ES5ZpXJMDnT40/aJUqlCKB+/zfQehePW11fGFBXzSCiDHon+i3ZNxZ9dIxLPRu5x2RfpCo8F3lmOhgLQVZObpOmi3Juc0dgD58CskOuz29/zjlDmYOhjQjN1smHRc49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901332; c=relaxed/simple;
	bh=whB7Ohz/aZw41jDLmsNbB2EZqD6VWqw1GxgDMy7wNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE/Az+vbh7XxLDucc/meFu76GZhB74+U6Kr4fSw/LXKQ6lsYi7KocH0iTqZKlO7YxxMobvlOxCAZReFxXO/GuitA9fVZ4BCH8i2IRDFu7FNZ7abNen82mVrNeVp9t1MveT1uclV2V8vZndBCRGwqev4TEgjOB2zEd9Nk2Ls/Ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vu3CK0nb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e09a890341so2430545b3a.3
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707901329; x=1708506129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=Vu3CK0nbeZvAPFO8TBI187ZZSnXKk7NZyQOjaKzW17lmGlge1A3wFJ+niufluvOIfo
         suRI5Bh4QxSL+yPaJ3PhNTH4xyB5ANsob4+9cXUFJGvhvYmsmz+KnR4l92mX8/seUfAn
         u8BbKc2d7FfTxNJrssFZA1OmXrA/T/Fhf+Fi8l93+YnyUMA06HQj502xrg978mj2Yrl8
         yhiS7riKONRBPnZjnlZ4Yna6fz/rM3IrngSUtM1vNkq1plu/57/9dH3XbL3PLZOT/PCV
         jB0AQ2YWUg8KDPDKmetsLNCBNyqnX59dCWTpm7OsumSqifx64E8t7Gj2W4Hf24yOrD8K
         fFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901329; x=1708506129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=O+WAl2y8VCCtZ2+8+IgIRqcDU9WwhW4dKfLRymuhm7DkxjOvHT1mGn6gqSQbI9RGge
         4/WO0JviiJZsXC0t/EcsOr7LkqhyIE8sz4Vf7d2HHL9C21K6Fr5/UXcHHjDTJ5la7gwk
         t3M5+BIlrA6J5WL7za5a7DrKhBCxA9sqje8uYLDLrzJN4KT17h7q2FncKy9taEeJRl9S
         1xMSMe0i4hxqwTyN4DXEaM4mIa7pAycuvI4a8Pgy2nfaYbmQRawT0OI6xcJ+NHNN1Uga
         108VGJm1eCouqrZ48hJG4gJpTY5tVq9dx/O8nEFxninvc3PEkh0d97qz0bCcq/GrHWOZ
         GyXg==
X-Forwarded-Encrypted: i=1; AJvYcCUNCh7KkyApIcDqg5bmvkvCkew8EqRM5sx/G4TquZnuH84bCWDJKtsnJE2L0XUUDPIgUQxfurnUbWXWO1wFSv/foNtCmTPE
X-Gm-Message-State: AOJu0YwJD7M4BLwPw0+LJbGrHY5tjEzvW0WtAMordUaXaK7SwoUqFD79
	LVtwGRXnKSIpIamWv4KNSyazBKZfK9I54mx97rs89TmH8eecewqhT5Xyr5nzIl0=
X-Google-Smtp-Source: AGHT+IFsjTuVAsJab6ip88ByI9QyNPkKm0np9TXh01qjGS2E4T32B1s1GFubfCKk7kV11vqAbji1+g==
X-Received: by 2002:a05:6a21:3a44:b0:19e:4f38:d8b8 with SMTP id zu4-20020a056a213a4400b0019e4f38d8b8mr2502137pzb.49.1707901329240;
        Wed, 14 Feb 2024 01:02:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7j4Fc4POZ09+xXH83jfYc+PuXbyH/VpOIAqmnBvkJ7GqY+HqUjeaxss0dPHCrRc2j31VDWX26D00yKHkfrVrh/CtH4mEa+eXidreRJPQVQm1CHNxDFHSujA1O2DtcTmfQJnAyb7E4fgp4iJkddZeH14jt0tzjkqeMTpNzqbiEa+Ttjq1fIS3GLjWb/svp7lzGE6D9Zk/QFtwED28vrb5ty1QHbbn+rGhZxsay3cXFF5d9pj9rukcYm/6vj7pH010lIbqQV9ff
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id m25-20020a638c19000000b005d7994a08dcsm2476681pgd.36.2024.02.14.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:02:08 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v3 1/2] riscv: Fix enabling cbo.zero when running in M-mode
Date: Wed, 14 Feb 2024 01:01:56 -0800
Message-ID: <20240214090206.195754-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214090206.195754-1-samuel.holland@sifive.com>
References: <20240214090206.195754-1-samuel.holland@sifive.com>
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


