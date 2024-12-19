Return-Path: <stable+bounces-105367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DA9F8665
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7A116CCE8
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F791BD039;
	Thu, 19 Dec 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kVjbQue2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441581D79B8
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641696; cv=none; b=miXZtMc0Rl7QRN1Egy0ugUiEojL2/vQZyFuh8+ohC5hyAWNZqO/JXSOltvlcn/vVzHAZsvMwKYSjgNYr2Wgty9jseDl9wIPRbZvIouXB8MSKlGOqjyQ1ptTyWtw8mAtBA9ytemv1rgbMSLlmVDfd5U9267ZEGQVhrUcud5Dv/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641696; c=relaxed/simple;
	bh=WWGrPOmehKv7Jm3KaVRDb/LfAgSgMERBcW5VTNeD/ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9Jq9ohYrcPI9sdssTC6dMUETPKhbmlHjOBFFKqrGdFjf1VKVN6sG5VfjhT3jHY5RqRHNm/iUHl7Hayw972NWGzhdDCKHdaw/AnumKgFxNoOsUFvvRSIREdHcdpZNZTtiKLG3/zCvm0U6dsguSLg6/9WoV97K7avg5Gkyt2POS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kVjbQue2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216426b0865so11605785ad.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734641693; x=1735246493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s4l03z+TiOWmT76Ozzx8G2m2dVtHZ3dYvzPccSMcPU=;
        b=kVjbQue26sKUnT8SgurDNdwN+nmGaM9/hK70Vcpi30GtdYGWk3AJP226k/05mjB5bg
         QWuJ6/ArlvUPzMAOHml+SWc7VrnIVbbE3b6VN/KPRmuvDDIKZ2EIrc+asCtF8OO+t1n3
         BdUQSctLTAhnb8f4L7WIwsuaINbPUaqT8ZCO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641693; x=1735246493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s4l03z+TiOWmT76Ozzx8G2m2dVtHZ3dYvzPccSMcPU=;
        b=ctQon5hkT+TvtG9cDsYM9CLjl/TeUK2ZqE8bJAjlCRP8Qmj57fEPyQE43ZBPmcgofk
         RiadYCkZCp1gkYIbyP/g8vRZUGY0tNxAH55MPnfBLIu6NTLcYKsHZgtWtiwXgqDc1I82
         sHdmzieDwfU/v6fFi7GJFUwhTLOSo3pfeGL2xCoDigpQQ286n2ZzR2xoziGWvr2Kwtkg
         uDdzKIL2nqTaoiyOImYDpTB7ze32926XTNwRpkjqplYGLgRURxx0MAcw1gqXd16wCnPN
         d5iU+DRmDW/V2NTmzdS55Cidd41A0OFYjJpsykBxu+uezWM5d9lMR3fSXTdKuFfuEYKS
         AYRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFNlrprt0JWw6bysI/Lav48ZeGGM8/dYIP/G3FIdK4jCpDkS0Z4/ge2tVmO4Ypq5hD9vK641k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+M3fEhU05S+3ESk7DdYSTDfPYtKmW7gMNgWWNPHvg68kj/+o
	8eyhDLRqZVYZHenPm+w8FFKeQMk/v8gGCth1NTfLIZL5V2MHejbuFokOnO6C+Q==
X-Gm-Gg: ASbGncvCjPL1RoV+6osji9Y25UkVOopMqoh45UtVYPcbHfpJ8MF4m6Cy+jTslFDd9eV
	dj07jVkAw171vRPfZ5kNSDvVt2ZzNV25t3r61ekEJUgdKgaAHBEFTDmtj6I1J5cpYYZrPnK+DWA
	QFhBOkht5TCjEU3T2B1QAk7PLFKP1a+6WLXRf2q1C7bYsvLFEIDZJnkZL5aXA6r6pRrO0+x7wMw
	9bEr/NxOJz6PvfLfalkuhjlqwiXxRnrxYJbWpmzO9SVxJGXeN2bxt/pOH9i8dilaRwCZj1YCq3e
X-Google-Smtp-Source: AGHT+IEaD6/NCBxxxfKhVW+SQ2XuBT1Btw2c/4loiQPU6dq3AxKc2urxpDuKIcZdFcK3IchhrLacVA==
X-Received: by 2002:a17:90b:134b:b0:2ef:316b:53fe with SMTP id 98e67ed59e1d1-2f452e4d0e5mr545837a91.22.1734641692063;
        Thu, 19 Dec 2024 12:54:52 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:a8a3:6409:6518:340d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644d87sm4126905a91.27.2024.12.19.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:54:51 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Roxana Bradescu <roxabee@google.com>,
	Julius Werner <jwerner@chromium.org>,
	bjorn.andersson@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
Date: Thu, 19 Dec 2024 12:53:23 -0800
Message-ID: <20241219125317.v3.3.I4a9a527e03f663040721c5401c41de587d015c82@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241219205426.2275508-1-dianders@chromium.org>
References: <20241219205426.2275508-1-dianders@chromium.org>
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

Changes in v3:
- New

 arch/arm64/kernel/proton-pack.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 06e04c9e6480..86d67f5a5a72 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -872,6 +872,14 @@ static u8 spectre_bhb_loop_affected(void)
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
@@ -885,6 +893,7 @@ static u8 spectre_bhb_loop_affected(void)
 	};
 	static const struct midr_range spectre_bhb_k24_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 		{},
@@ -899,7 +908,11 @@ static u8 spectre_bhb_loop_affected(void)
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


