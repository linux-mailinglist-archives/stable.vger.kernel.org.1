Return-Path: <stable+bounces-20149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D78854482
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005C31C21416
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEECA1171E;
	Wed, 14 Feb 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CISgWuk1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18760BA29
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901332; cv=none; b=legB/5V4nO7+ofAC2/bwxp9MLn6MDi4vYxl6LP7Qz29m87N9VHyxdLpkGR2V8LkYGOYijqlhO+rRcd58seoJJcCJvmG/HZ9n8g5CEPQQK9Qwi8EIcfNdlAa3R6CQsPKS+IK5r/EOq3wilHPWx3zmK39V0WMsdR0O8mXAHmr8CX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901332; c=relaxed/simple;
	bh=MfcAXUCHb2E1/+tWEyK5zhlte6BwjTT4yiXkFWjcBoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I56D1rujwBrWi7ELRLhkAWmaTS1aLTwERv74b+CCcWUkZ7/cqFVw33T1Mie9z3EKzGWKhMPjmTbDD6ovd71vyVggLteMYCNQGiU01vOVboF9oyyjoPcM3a4LPqRU7/GVMdvdNbR0ofP9S9AOUxgXiMh+GstnPLMfU2XmlwUnfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CISgWuk1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso431544b3a.1
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 01:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707901330; x=1708506130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPRsJ6g4sGjHYOROeqaGh/pr9ekDnpVi90clFxCUkAg=;
        b=CISgWuk1/rbOKV2EdoWpaODq3ELivfPw1Mg9iVc+qnhrS7ZA8KHhT3VeIUjwiFVILe
         kuhok7KbFPm8UmUvGpMq8G01o4Y9zfFFNqv2WbXguBozSTjIf2zK+JnBfIEF0rTasyBL
         FfICzQRZOWIqMJlJixXaDGpXDMs+/+n+izwL8XMtLaOnvetvqIbwd3dwRn0/awzvJ0ki
         BrN2W3LO3gE6V6OZS84OAMDmkQC4fINJ7A03Emf3yqmUjkt9e4z9NEA91HdyCUJG4Sng
         vWfRWJMTGU693hHSX8rc/RJFhxbN97c5Uat2ZnkjDPab+VeAy8fRHs2dJHB35OeeD6ih
         7k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901330; x=1708506130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPRsJ6g4sGjHYOROeqaGh/pr9ekDnpVi90clFxCUkAg=;
        b=fu8lLM4DJXsu3NRhXjJ2M0aDLitggIo+lebu90Y4bEFqfGN6XmKNhtJBsjZ/cdnMpD
         0hyOD05+/Z7+n1XVZkdeZVfJLpK0UOwbR8mxHWF5N3cMZ4+QmsQb55C9zgOrmGcfH4Vc
         +gnjMjpwth+tBu1vdzA8T/utHvfhkivbZ/HrEXD7Lau/ff6uGlUtalrKAOzPs5/+5d5/
         GD2iiekA/4pSvi4YhK2ltg+oStqzvAZsHqiIAySq9oBz9DwYEPWPtaHSfWufyZEhHqTK
         5waDXwVEFQ16/VHdFVrE0ixgo9xkMH0NomZfJvXfcAyTk8n662ppl9G8/KDJtoPrsGgs
         zlYg==
X-Forwarded-Encrypted: i=1; AJvYcCXz/tjRWa4n/qUXD3muOHn9H0jwXNSmlJ5vNdYz94Noml7mf/YwAMMbPSByKzKHC/pPLqyfkjizKiejdBCOxB5gKRMEcIwg
X-Gm-Message-State: AOJu0YwxpMzi0wxEBACJZsSUIu/TSDZN548psUJs3wUPrOT3posJ+8wB
	e/wDlGg2bxslPJGyy9xOtmwt2wI0U7wI8ceJhIjgY20G+K9d+RO+aKT6o41bp+8=
X-Google-Smtp-Source: AGHT+IHy/Pj3hWoJS2WkBJmfY13iMBvhueyDKJ5A/yQfFVGdLE2c2qKte/Hxj8onksRoyE5sotknkQ==
X-Received: by 2002:a05:6a20:d487:b0:19e:4c37:8737 with SMTP id im7-20020a056a20d48700b0019e4c378737mr2014592pzb.5.1707901330438;
        Wed, 14 Feb 2024 01:02:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBa/niUfhaptGFm9lpsC7zFdtIR2IEOBXSB0tdcyp6YZbUOgFtfbI/clENDxQCc8TCx8cnV0UJM0uPePynqx9jmQ7hY4b5ASPHIgiC4ZfxONgs2/Bri+S7wIUid9Bd0gcGYFrdshm5ssWW0rX7DOV8ZmKL6m+ulTzguKOnSdLt5I/uYehmsE75yEXVwh5SFONe5K6zDtg+cMtGVcnmC/zs52MkLQukmDPBDfZPnewiiQR2bVV8CVafM5Yknt5+zeqr1cvS7wKO
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id m25-20020a638c19000000b005d7994a08dcsm2476681pgd.36.2024.02.14.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:02:10 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v3 2/2] riscv: Save/restore envcfg CSR during CPU suspend
Date: Wed, 14 Feb 2024 01:01:57 -0800
Message-ID: <20240214090206.195754-3-samuel.holland@sifive.com>
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

The value of the [ms]envcfg CSR is lost when entering a nonretentive
idle state, so the CSR must be rewritten when resuming the CPU.

The [ms]envcfg CSR was added in version 1.12 of the privileged ISA, and
is used by extensions other than Zicboz. However, the kernel currenly
has no way to determine the privileged ISA version. Since Zicboz is the
only in-kernel user of this CSR so far, use it as a proxy for
determining if the CSR is implemented.

Cc: <stable@vger.kernel.org> # v6.7+
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Check for Zicboz instead of the privileged ISA version

Changes in v2:
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

 arch/riscv/include/asm/suspend.h | 1 +
 arch/riscv/kernel/suspend.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 02f87867389a..491296a335d0 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -14,6 +14,7 @@ struct suspend_context {
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
 	unsigned long scratch;
+	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 239509367e42..28166006688e 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -15,6 +15,8 @@
 void suspend_save_csrs(struct suspend_context *context)
 {
 	context->scratch = csr_read(CSR_SCRATCH);
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
+		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
@@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, context->scratch);
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
+		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
-- 
2.43.0


