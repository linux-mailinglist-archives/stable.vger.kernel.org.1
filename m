Return-Path: <stable+bounces-107897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A4A04AB3
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB951887F66
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A31F8699;
	Tue,  7 Jan 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgCPJ6l+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB61F76D2
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280504; cv=none; b=MxopAiNg0/ddsBM1/MzOzgGN64RXP26ZtZWVqtAqILm6yJtlvazwHwqZehfpoY8zWlR6//CerMh1PNkMQ7M7YULE7PaUGaKLVZrMRO0fq0+bH3hC+EJGaU9pcBhOiAWEsGRODl5F8QP9eEZ7bJQLIGsKjmyT2dGDApVYNmJRpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280504; c=relaxed/simple;
	bh=Duq+INKIqNPUgvYTHZsJkbkyGq8prfurW6VmwQI5pbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6pCt9UgJ40SiN893MEcQIwhF8VlcClYikNgQhgza29TcDMciBCX7Di1Jd9JNL8xWuY/B7flqqzv3AcJVIUN+X9hnpFkosOrsWLGckclciAyEW8zdEsSXshom+Jyn9lJCFZTDc5QauYJVxn2JhQtJoIt/gvyej1LYB5kGIzf/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PgCPJ6l+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21a7ed0155cso16138875ad.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736280499; x=1736885299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfHdG1ANNWPpZE2kjiBnSExD56hP6zWfFTzaWahyQ5I=;
        b=PgCPJ6l+mNt/l80HE6BzyNgX5kWGIe/m4WTXfKM8m5wD2+39y3c61K4xoE0zVtp1Pv
         kUsAIwZWBmVYy1/u9FsCzjpoGtNN6bJ8/WceueyFjrC5I8w8bTDxfoEvkWcmVK7CBcLc
         Wsxsi3arNIqeeKatGBHHXfyQk429zXACrhRpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280499; x=1736885299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfHdG1ANNWPpZE2kjiBnSExD56hP6zWfFTzaWahyQ5I=;
        b=YpOM8vmH5Q6935Ji5lyVf3qpkdLB+z2f6oLUy5JVUNi9eTKUuqQ4M3O4abVz3aT/Ww
         asPhTkmhEhQctMxoM58Le9VvBQNLYKJ6Rst0ifh+ndX3u9FSnDgIRbECvvm4G8rK+Riu
         uEkInArNrw601TCVIK/uVAv184/NQzYYR32I0LLrQG/hcLV+IFHsOLRsCp20gCBVgQM0
         Kz8VvjLSHVaRaARbRH9YTxaM9zIt892tFdK9JsSW+7x49qmb4KpEjuhfvTDVzijnArJ9
         rYsiespfa+RbAk0L+4LeH957TF1O9Hq+7Xro4RsIJ3W/WeKv5Xy1O1KkbYx/ZPYx6h7I
         rJRA==
X-Forwarded-Encrypted: i=1; AJvYcCXQGhRAnz67Pv+3mTVQhGtzgba0ZvC9O5Bp67kPPqbEgNbiRP2Trhb4OXdbqOyWZgHzQaimXJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTHQcAQgdlRp96j6De5/FM6uiHazdYbgT9CnVhRuBJFYCARIM
	knfP42/gH9p5iaBgteXCi40hh9j4RvaJKXsf8c9DpqGfQczq57WadnRuYy6BSw==
X-Gm-Gg: ASbGncsKyiFaQPKTceOXFH6X1pqoaaP8uDMFoSN6RbNlSGK6C/vFzj/UyRE1DI+pp2r
	59I/kE+RFQbtUM7JK/j7BUNLCZLmBhi+PsiJhCPARTJrM1TPBOh9XeF9MCjYSjPMwcPooGObn9q
	5jwVX+2FZWckSFR0JgFENdXfGYMTsMqoxHe/pjxEyAMV3wIZI3EtnMcCosjixPLEgJXkVU5fR2q
	hVVuzZyrtGprwie9V1wqV+f4uuODzIt/dHPVGTNN19Uut3EDOVTDq0mLfF2uso2l6OQQLLOLaJ0
X-Google-Smtp-Source: AGHT+IFu7otqKCCIAbXozs9Yi25BzurouHYPRUn+yFnfSXfUKFQHp3WyFH7S4/kldp390+NNufFNOg==
X-Received: by 2002:a17:902:ccc2:b0:216:4165:c05e with SMTP id d9443c01a7336-21a83f67982mr5749945ad.24.1736280499600;
        Tue, 07 Jan 2025 12:08:19 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2961:4bbc:5703:5820])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d47sm314263425ad.55.2025.01.07.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:08:18 -0800 (PST)
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
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
Date: Tue,  7 Jan 2025 12:06:02 -0800
Message-ID: <20250107120555.v4.5.I4a9a527e03f663040721c5401c41de587d015c82@changeid>
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

When comparing to the ARM list [1], it appears that several ARM cores
were missing from the lists in spectre_bhb_loop_affected(). Add them.

NOTE: for some of these cores it may not matter since other ways of
clearing the BHB may be used (like the CLRBHB instruction or ECBHB),
but it still seems good to have all the info from ARM's whitepaper
included.

[1] https://developer.arm.com/Arm%20Security%20Center/Spectre-BHB


Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- New

 arch/arm64/kernel/proton-pack.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 89405be53d8f..0f51fd10b4b0 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -876,6 +876,14 @@ static u8 spectre_bhb_loop_affected(void)
 {
 	u8 k = 0;
 
+	static const struct midr_range spectre_bhb_k132_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	};
+	static const struct midr_range spectre_bhb_k38_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	};
 	static const struct midr_range spectre_bhb_k32_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
@@ -889,6 +897,7 @@ static u8 spectre_bhb_loop_affected(void)
 	};
 	static const struct midr_range spectre_bhb_k24_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
@@ -904,7 +913,11 @@ static u8 spectre_bhb_loop_affected(void)
 		{},
 	};
 
-	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k132_list))
+		k = 132;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k38_list))
+		k = 38;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
 		k = 32;
 	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
 		k = 24;
-- 
2.47.1.613.gc27f4b7a9f-goog


