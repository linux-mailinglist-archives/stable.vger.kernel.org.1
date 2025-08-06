Return-Path: <stable+bounces-166711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFECB1C8D3
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064C218C470E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509F292912;
	Wed,  6 Aug 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf6thGFV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AA28DB4C;
	Wed,  6 Aug 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494485; cv=none; b=sj7hPJSi/zLOn6qzQOLtlyXs19Fo/8ltrsIuuYMug1cvYaYHt/rSUHkX70q/j80T3K0/Us6R2CAWw/tH+i3N8DDa1sIzfbuvXo5qqR9FmMS2xxHVMWEuuWSykUaCc3pZTA9W1PNXhjsLFgnaVYro+MadRt9ZeM6hhSCPs2wKlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494485; c=relaxed/simple;
	bh=l+BjPJugvSX1xnYBlRpydXaOEpnLR9ZZrGzevonqp/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CU56+WseVeiQbSNTjXEs0NyCCNsn8RHo2U2Rg+aId0rGgh3xOxIRaK7LGd2zkuJuPK1VRSGtm7MsxGfhY7K4bnAySIeO9NU+EMuxyo3LRMzbGnBinuO3qH+xTvUWl4nRfv1cWBhJsFnW33wRBovOhJwyAruNHNH+66DaubCj3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf6thGFV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bc61152d8so86726b3a.2;
        Wed, 06 Aug 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754494484; x=1755099284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8FWAmyygJI9ykU3sqCpkELXQA+zPUabO2nOc+Pr1Qc=;
        b=jf6thGFVBifiZUJSAEomMO+PzWyNB7+bv1iXfgiYQ0thdET1AIKB53KIkfZ3VEO4t0
         pJDLTZX/v6bFJiwNKSNxzgwcF6+t6oVCy18WXphInTNX7jKCJ+4pjwdZ8gu0oxzc3s68
         Mr+UGxgGqaaoxkfM/Vit2KOk1uM2toWbn3KlhvPlPCgC9dQaDRQ9Z9NJUYU1DiCAQBcU
         PXkY6+T88CCWq/3q7yj1zbJKOKc4J7YRXykSznJtbTpqVe6VQmIaa2zU2QFn84b7ndFD
         53eJ80Vd34GNFRWv9JdhwPHGazBlNuwzWU4zmRsE0bu6cUsb0432sGa0GTDdY2A4CXg4
         X1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494484; x=1755099284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8FWAmyygJI9ykU3sqCpkELXQA+zPUabO2nOc+Pr1Qc=;
        b=ezIz6kA/i7Nu8S3Hxax2pu2Q5jEVncA00VCvNFYbehsT7eqFElS9r25P8Q4xvQkclA
         TgOXxpjo0UzIwH0MmbSlYeKMqfAmITxKmxlnLt24abNjvFtjqfVExGWKqCoa4/EZF/dQ
         wouUFDtj/NRxEED5pNSHO2u8fMFuikOL2vsDRH5PO5I1BOTewRE7NCvJJM/+NN/vbSLZ
         xvbosr/ATWa/6p7vnnbDPIVFuPRlAPGDKM0kq2PI7SQoEccd5o6/33ttlEUHzxY1O8v/
         U1AA3IFvkR+C4p8LfzKYoexoRoKpnZQo7/ZsEMjfPGH2lqGqUOaVJhqDxPtuAWFXAaoG
         274g==
X-Forwarded-Encrypted: i=1; AJvYcCUGaDRJwkzKtZ7DPMUk9IHVJ+1aHSiTFNAdJIoWRV+b7nK0GrS9uy0fP7VNh6x6C2Bwn+QpgqZo@vger.kernel.org, AJvYcCV5kBiE4VgjEONnzAE5xPE51U8oHlgXwCy3qJ1Xlq99vFxFZ9i8R//n+oqI4nlZZU10e2WgDIOc1zURTQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYc72FUpl8qeIsyhOCxpRieb6lqDQK8Ikd18vbTURouF5GgTJ
	cG3diC8Xfwkpn4L/xWGIvPv6zVnd0gstPVPuyMbpRsgo79y9363kj1W+kKWFTHFpVbM=
X-Gm-Gg: ASbGncusFdU133LfyJHlomPB8rJSiv4DJuqf2x229zcOOlIqCcstNP23GSfhm+pQEb1
	PPrdEgb0UXrTioykcnj0Iq6qoBPqn5qSF59aA6OeF56BUO6DfHvwkCAHHUd3k9rUScQNl+gJoOF
	nA7b3BxeQ92KWu3ZHHlkCplAQMPyTaM4VIcoUVgjWFBBTruAJOC/MqU/ozgWn0oQh8Mzhs9HiWu
	rSRYN4D8ROLveJEmH3Mwe4hczRL4S2lS7XQ5Sj/D2sEHp+AdOkRVmY2aElORyaXmuOnPqoqcP5m
	pku+er5+1cmhkC8gcH/30yMtTeb1v5e1UdKwFuPPwAoojJch5CjbgQQq7s0vvwWy3rHbOo7pGZJ
	7zm+pZGuBatr3ZZUJDizwKtU6o7ieVpO1vnRnABb6
X-Google-Smtp-Source: AGHT+IE1mEFPS1/GYteQGs7cvs/+9c5s9KgpQScsfzp5Wld/S4EMQoGCuFw6NzbPwLhiL7WdxjTiFw==
X-Received: by 2002:a17:903:2445:b0:240:99e6:6bc3 with SMTP id d9443c01a7336-2429ee8b919mr47219875ad.20.1754494483441;
        Wed, 06 Aug 2025 08:34:43 -0700 (PDT)
Received: from archlinux ([205.254.163.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d28asm161899175ad.142.2025.08.06.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:34:43 -0700 (PDT)
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
Subject: [PATCH v5] x86/cpu/intel: Fix the constant_tsc model check for Pentium 4
Date: Wed,  6 Aug 2025 21:04:33 +0530
Message-ID: <20250806153433.9070-1-suchitkarunakaran@gmail.com>
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


