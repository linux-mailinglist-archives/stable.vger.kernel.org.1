Return-Path: <stable+bounces-165183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F618B15819
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A701E543694
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75A1DE2BC;
	Wed, 30 Jul 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFfWEaYN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E381199BC;
	Wed, 30 Jul 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849589; cv=none; b=hPBEuaLUuM/+sn74Tm2EAvAOJ37ZCC/X9cpgKsUY2VJE7HWyNSPpBJxU+5M5IQCNSCbEmtG48/J5ljbKn+FuGghU4aiZDu2+C8/5XH8OUjYBdM+mmTtyVchcz+Sl4fqvm2TdtUSu+pGKJTcCd9iUb8/j2ljJ0JpDc6oISOLXk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849589; c=relaxed/simple;
	bh=//VizQTrkMZKkTiVcA5DAPQBw4oGz3v0bgb0dgqHP/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLYUExNA0HvFiDzDATMV82sMyezfbfPxuj6V8eWWRuyEtTBHZdN4gCWRM7lgdQrsNXXzeNwuxEaVck1hd1l8OWT8YiPr5Kl2kF/1850h+f0lbVCR8SDYFsdinucelUBHNce6MvwzswV+dsrNCXRTWSlUUvsWEwXUX4MjMNVvUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFfWEaYN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b350704f506so449648a12.0;
        Tue, 29 Jul 2025 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753849587; x=1754454387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2V9USrBXsSBMCZmUVcYrTmHrRQnQ4b5hPFo+KGIp4o=;
        b=kFfWEaYNjOFFLKFHdhUnwe9+mw4cQW/OGHJrY3X0e+XGpyE2V7v0FiLYtcUa7cSe90
         46iuyfIHvxcpbY49+vt23xHToU7W/e5U0vae7E3ekT302SqpgR9kG2Vsjvwozb3aiit0
         GC+v/4wIAWRdAbWzxSHAvGvZvze6cD0VB2XO6xthKXB1/hK+kqs+Mm+RR4qY1aOHbEcc
         rRFqk49WlCiqYvsnGIji8+O7wYda8APgsyoXDhj7fhhtBUPqVSDdsTGJh9UNMf6COpq1
         7zXgXp9FQnA45PlMKopvMcAIw+kzKGqIBJzKpeRMBRYAXlfMeJXuSHYf+ngz4TCtehWu
         DR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753849587; x=1754454387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2V9USrBXsSBMCZmUVcYrTmHrRQnQ4b5hPFo+KGIp4o=;
        b=mejx2/Z+la6nc3WguqaeUUA+vHj2w4l0tR59Cd6ZuKtOCEcPOE3fSk/yzTfS2S1BpI
         GG0SZnAF7eDVnbHfUjKinkUet/0Od5IAHhWLvT2C2f0wFW0OrsAymVTHTIL7yhxBUcm2
         NMO8CGW6aInNPh6CMH/jFhJFbRE0lXmgFftA0+YeIMbOxwoh0bomfQ/BtLeUZB8TMpy4
         A38GqWlbyO2S7xnDjFjgMk4X9SqSIUOwQysUHcyUfXn7Q51oCpHonKTmelMIhRyQnCRz
         bhMbP+PPYpQYqtv0UPeUh6TT2QtVS60Deu0zEGRyVaSFOfcqNaG4zqP/ZUzjDUlwO7k/
         0g/g==
X-Forwarded-Encrypted: i=1; AJvYcCUWi31yrAXWEFNvKkTPXB5ncnm8ArA+A+Tlefq6ZmwRB8Km3Sv7Y93/Tv2im+NgVWt4S2lPYSIoa8O/Gk4=@vger.kernel.org, AJvYcCUwOHZr/TTGvFEdyUdY1pukr8MZ1vKLo7qvTuVktqghCxZ/q/Nycv7UjY7UHOcAX6mjhkn2v69L@vger.kernel.org
X-Gm-Message-State: AOJu0YxBL64chKtFYUb8CJfmk3l4IWfnuV1avrEy4TtrQB92YY2kakHE
	NgycdIr26vNQJ5aNiHvrVFOKnlPAqAcb7u/LbowliNwAFZJ+s5YFnh1D
X-Gm-Gg: ASbGncvGA6/x8j7UlsppfugC7PSnbnYEcGg8l1t7PRMV3B0Nq3alsrL6veqs1U0J6TY
	AzR4Tmd3Ym1Fr8vtO3rXXJ6lR4ydOv7sJpndOJUFd4UgLM6nIkpyEVf5wHwdqaDFZ3fQ+sXPPe+
	heuVH5xD5MB58WUnZ0MGfoMP4t8VcYyT2BeSJUwEYgXc1GIavLM/HGXcoi/NJl/RS10Vb7b16Oc
	HMljRSF6cGbD/L+cTrCN/ra4PU0M5KG82jQMDQTLe5JOE8DVF3CVJrtbv153IidCMQFyMw3ovYX
	a6VDe47lCVvcR5U7z+6k4txOPkewMLsFhyHA7sIv9YVetRjmB8lizwZwY7fnVqHrTtIgfsolJiv
	aWO5/i48t2S8lSDvoztPld1ddf5z+aA==
X-Google-Smtp-Source: AGHT+IGuv6wRtmjN8iZHw6frGooIYv84EAacrIywVuTREWybq2JpFF/vHKdmzkeZcnWiVJkvvOmwEA==
X-Received: by 2002:a17:902:f544:b0:234:986c:66cf with SMTP id d9443c01a7336-24096884323mr31485585ad.16.1753849587064;
        Tue, 29 Jul 2025 21:26:27 -0700 (PDT)
Received: from archlinux ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24058bbb554sm38795635ad.50.2025.07.29.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:26:26 -0700 (PDT)
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
Subject: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for Pentium 4s
Date: Wed, 30 Jul 2025 09:56:17 +0530
Message-ID: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
wrong. Since INTEL_P4_PRESCOTT is numerically greater than
INTEL_P4_WILLAMETTE, the logic always results in false and never sets
X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
The error was introduced while replacing the x86_model check with a VFM
one. The original check was as follows:
        if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
                (c->x86 == 0x6 && c->x86_model >= 0x0e))
                set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
Cedarmill (model 6) which is the last model released in Family 15.

Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")

Cc: <stable@vger.kernel.org> # v6.15

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

---

Changes since v2:
- Improve commit message

Changes since v1:
- Fix incorrect logic

 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..6f5bd5dbc249 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
 		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
-- 
2.50.1


