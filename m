Return-Path: <stable+bounces-169847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C5B28B2F
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 08:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954F01C875F9
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787F21A447;
	Sat, 16 Aug 2025 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsqMZVMM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE593176F0;
	Sat, 16 Aug 2025 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327103; cv=none; b=LtRI2YJupQoVJI7drHxTrrU37F1PbWBo5cxfxnvxYv/YHZsMynvrW6YcpXPLowvj2zCtJD4DIJEiQUX4UCPXLmCdVmBLumG+TaGKm5qMwFgX05VyovxME3uvP9jgJDRSV7jwyhQjbBQCNygWewYkO6L5gEpyl5DS0dQSdgDpyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327103; c=relaxed/simple;
	bh=I1I/6P6R/jJHDP7d/EmBJ02o3OhrJmNh1erLpSB768s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1Y7hdWWAe8taSYuTnjUbusYqfReO777Et/PyolP56LINWxc2VfWZT2GaiTkeiQLgyoobO7BVryn2+vHQJJtefCNvJKhfW+jSi1tm0DOmevRbV4webvefQ+e71+OTMubIh97bxYDh6PlRFGSQRgsiOxsrfNkeN5rqP7bPLcVutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsqMZVMM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e434a0118so1249290b3a.0;
        Fri, 15 Aug 2025 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755327101; x=1755931901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39WcNe2AXItXXp9jrDQpd1B8VQX1N+yULMm80zOpn5Q=;
        b=EsqMZVMML1Eh2ZNNHqqyPAoQbm1Mnz/OkEaquoslcXl4b4dRySbnuleHE4IBx2JOKJ
         rON9LKpTCC+RoAzkHTUSNSKa+qb7F/GN2uk5+3KPB7Ms3TupgoZtuurLivFUNLjlV/jg
         aBcWDubxHHmDu0fdnErgBQ0iv5EktVU98lpi21n+5GfvpU2PZSdnHkOG34lrCMv9v2xv
         8Jz874zMwVxiJ+8RazV6QhZVNdXCLveAMHXawcxMRqXUF1GblUesCk8RUAz4J9RlH3ta
         kAwCB79kF7Z/XriL9Mvdfy7Yuomf5OB4xCiV/Bozb2i2czvtBGBMs/xa+qppCIgeJCZt
         4gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327101; x=1755931901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39WcNe2AXItXXp9jrDQpd1B8VQX1N+yULMm80zOpn5Q=;
        b=KlfRJyKmhLXRDZozsxKwmbCS3jv15uxBSD6pAFK3sBXU5IxBjRcidHHJa3RyvBvQqL
         Lps6CNsqoFqRp682PHgaR4qTE2o9Yyj++QQQOriUN/Y62C+/Nqws9ZN6ka1Iis0jKCAP
         zXH373xCPKhJY891GCYBewf0SoZotABR+cgRwHL3BgmxLyjjlQ3LagvTfu4APlXzFMp4
         8tsEaNzRm7p2InVEdiD/nKEgJNqmE7kh4DSuqGZvizStM4EL76JsTDHdVWMgXUnkIac2
         Vd/ICyteXMEaHSi0L47iPwZgZ0QOh0WFZLY67Z1VVh3I5sq/71Hb45U+kD+Boy9c+UHl
         5Urw==
X-Forwarded-Encrypted: i=1; AJvYcCWndd9aMntFmX8Th7QW1j692JYdBbkyhh3YoM1j0zBfnUClpNMHz/xT8HzNttc8CKMRgE+sIWiRS9M8P5s=@vger.kernel.org, AJvYcCX3tN57IhjxX7eNOkqiTrLhSKREiB0r9EjaxWOPMEhoOqQ4tJDCzwh0LEWX2Wwz3wRUlCKllaiA@vger.kernel.org
X-Gm-Message-State: AOJu0YypuAUpTCFEJfk1jMNbGNNajiFTjgeppz9ov3y/ZJFCvj7gOQSm
	A8rr+i10dfdR3h4Q1mr9nMYIByBw812jUZco/LcSRxyL/SxrBctWVxvl
X-Gm-Gg: ASbGncuNzZB4kVPgXahCQxUXchH7A8WUQ/8/hy0311kHuMCltBuTRhGRf+Gm9uHzkeQ
	k/shFwKL2OHTiDhahaYBliwMNgaHQxaIfwq3BZhdybwgCNFqq48Pmh9P8eJt+7n0Qg++Yw8JDla
	n8vzy369nKQjijUyZFFr1DS+rsmv+RR41lhKezKt7rXEZK6RmyhwWsXTZd/pVu1QJsM/UzUPi4Y
	VwpKPi9F0Ey8RIZT+1d8PGhBxsvnOvns/tQGE8ETRL/wb15xem/x1u1EuhQu8HzP8PkKNKWJqQa
	HYcDvjL4dbtmZ8fSD53BUyzqmyAlrC0WedB6x1fkDCFQ60bB4biHQ4lEIeIXpd20ZipMFuVeEee
	l/QClt6ZFi62XjEbqwqUI+MRJzNEMr+c=
X-Google-Smtp-Source: AGHT+IGUsLmuiPcI2giCI2IF6qVd6KgQXhFiqbI/NN3EugFt3xJ2EVq0iMIu3K9bJKvvdzrEtNpDKw==
X-Received: by 2002:a05:6a00:3493:b0:76b:fd9d:8524 with SMTP id d2e1a72fcca58-76e446d626cmr6485065b3a.2.1755327100857;
        Fri, 15 Aug 2025 23:51:40 -0700 (PDT)
Received: from archlinux ([2401:4900:67c2:7988:186:bdc:a8e7:4149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e455b5f9asm2512433b3a.107.2025.08.15.23.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 23:51:40 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	darwi@linutronix.de,
	sohil.mehta@intel.com,
	peterz@infradead.org,
	ravi.bangoria@amd.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 RESEND] x86/cpu/intel: Fix the constant_tsc model check for Pentium 4
Date: Sat, 16 Aug 2025 12:21:26 +0530
Message-ID: <20250816065126.5000-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
a constant TSC. This was correctly captured until commit fadb6f569b10
("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").

In that commit, an error was introduced while selecting the last P4
model (0x06) as the upper bound. Model 0x06 was transposed to
INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
simple typo, probably just copying and pasting the wrong P4 model.

Fix the constant TSC logic to cover all later P4 models. End at
INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.

Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
Cc: <stable@vger.kernel.org> # v6.15
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
Changes since v4:
- Updated the patch based on review suggestions

Changes since v3:
- Refined changelog

Changes since v2:
- Improved commit message

Changes since v1:
- Fixed incorrect logic

 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..98ae4c37c93e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
 		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
-- 
2.50.1


