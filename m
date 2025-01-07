Return-Path: <stable+bounces-107896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92749A04AB1
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E2F3A6292
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166471F868B;
	Tue,  7 Jan 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApAeMSWM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4381F5403
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280502; cv=none; b=Nag5dQq2EIhHEoBBx6aVljbESdLrd3+Yxkla/ZIxjeG4MGHQs9LOPRN4vndwRPYjDRsYiEXGah+slIvh/ZSKMn5PuXnK/0cT6dB6zD1jeiJPmYS5VmipwcFaQOfw6FBfQtbGDR1Cz7zIO4Ji6wjdYS/iNQfxvXMW5d6TrAgmRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280502; c=relaxed/simple;
	bh=s20fIlw9p2A8MPpe7e1vf1OBRFsKifSYci/GqL1Eyhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGBZ2XGGFyBVW+PEfVKiORqRxRldQAOB+ZVSfjTryt59mi6pPB1+Zp/e8b6CyNvikmwrAz6YgbE0YpjW6KpEgBMWkza8iduZMk/951Lxid3f/mmBxxq8qBQbn9yhzowoxjqpZdvfJHo1gwo5ZxECy9+b3SivAtLbKHAuMSKDeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ApAeMSWM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2167141dfa1so2658805ad.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736280497; x=1736885297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+J3uEvrodRrvpIjWWGDgko7jtoYydXF7C2qPRbL5eTY=;
        b=ApAeMSWM6XnlVDKRWubk9k4yx2jI6/PrZXI79PUb4hYY9C9OfuIicjjZhmHCv+Zq+g
         Ixwdh56bkSDXgXhx7PTx2YP4W6M0GotkvP2w9c2aWgVvLjidPsPVqyF0STewevwyKZWo
         ZieDni9/yxDwrtkqCMvM+PVMo2sSQG3odyRC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280497; x=1736885297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+J3uEvrodRrvpIjWWGDgko7jtoYydXF7C2qPRbL5eTY=;
        b=h+FUTFrXw3tmBUy2J9Vk0ishP3UKCD+izlmtiuoRyAV6QBCJWKjLgAyiU5p8t8m8MM
         cJ9+p0wqb6KGGI9/1d5Zfn5MPPV+y59vlTrLc6CM0b1xAfA43ttE2dL11LsHX9axlJJp
         wFndsI/TlaPVL52Dv61zuwDkZZcL60PNpwJQGiXfqFn0MI8O2Mofi2TkQtUUY7a0jOgb
         0IjUbg9QSETiImiC/5WqsVyXMIat+PzsstvrTH/iqJ2Psz1ul4cC9EWym8VsusKfZ/e+
         83DO+2mqulvlZXEFF897X5N+d/uA+lzeYmHx9OgHB2xr6MmGnFcBFXoMYK5FNaQ7UtlZ
         TFAg==
X-Forwarded-Encrypted: i=1; AJvYcCUC56kCoy4fSQEajkfUKqj4ma2116c5vuzTtq+kmJoMDO6XXF7f095S5CjNMBuQGKmZYkXoLcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtJvUzlc7d/w1AhuVlhKlFbMSq8F9j3GJRXkMq/DAmgKvUlRH
	Ei1Lt+VZftrecgtGGe+bIF7okMMTBrgvl1gLoUi9r+J8EXjsdUDMJ7mhTgAZ6g==
X-Gm-Gg: ASbGncuWm4Rnj2ww6OFd4836wQAQRiSyPjoE8ZulPneCORQsSG1DwntqG1fAv3soOev
	VgR//BNk/7Kh3WrkWQVH1CdjrsWs8Z/ZZhK+nmifAomjS0yHOWuELJnjexK0aGWpIUEY3InoKvn
	wEtwc35DJXUQWoiTCA+DXWmi9jOStbYE3M9cGjAC2YQ4o86XxNVhPUNBZIMwOpzxkwWPaZ98Zcx
	vWSPAuI1C5nD0b3dGtKJPtbF3vQc4ZWNRMlaQtacw3SXAo6wivyvI8Qc7NEIAKZmLWsin6dLhjA
X-Google-Smtp-Source: AGHT+IERsInGKvMTJwDEekT7zUQ/SqNr1OWxECv7WnReZ50o5l0ZIy479qmOPxldyGbLGh45fTS6jg==
X-Received: by 2002:a17:902:da85:b0:216:4676:dfb5 with SMTP id d9443c01a7336-21a83c721c1mr6200665ad.21.1736280496985;
        Tue, 07 Jan 2025 12:08:16 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2961:4bbc:5703:5820])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d47sm314263425ad.55.2025.01.07.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:08:16 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Roxana Bradescu <roxabee@google.com>,
	Julius Werner <jwerner@chromium.org>,
	bjorn.andersson@oss.qualcomm.com,
	Trilok Soni <quic_tsoni@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Scott Bauer <sbauer@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: cputype: Add MIDR_CORTEX_A76AE
Date: Tue,  7 Jan 2025 12:06:01 -0800
Message-ID: <20250107120555.v4.4.I151f3b7ee323bcc3082179b8c60c3cd03308aa94@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250107200715.422172-1-dianders@chromium.org>
References: <20250107200715.422172-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From the TRM, MIDR_CORTEX_A76AE has a partnum of 0xDOE and an
implementor of 0x41 (ARM). Add the values.


Cc: stable@vger.kernel.org # dependency of the next fix in the series
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- New

 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..a345628fce51 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -158,6 +159,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
-- 
2.47.1.613.gc27f4b7a9f-goog


