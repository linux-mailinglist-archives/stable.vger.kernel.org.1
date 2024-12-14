Return-Path: <stable+bounces-104162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3AA9F1B87
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BC5162444
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B613FFC;
	Sat, 14 Dec 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZhzuWgi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66075DDCD
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137591; cv=none; b=GBFpi+mG8PTQfM2EkmXmDtIJdKzWfUNiHMS0cjLrba5oh70X5wVGDclthlbaZntYV+8qnp2S+IB9VGiXoe5P25LUbUqiHLpX01ngaALHCXyKbZewvC4qQKhSTl2NzeeNGXvHznGToANW4YmTGRNNEha1CzfHTqK1BJTlb41Ivug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137591; c=relaxed/simple;
	bh=9VcI1y4DrqTHAqxzGhnqIkcAzN8r48f8mRzXZKwipic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocTWnStrzb3frzG1bbQtwAbcFwSubzT++DKH2wQeVGqr+743rxcSXLcCPEMVR0FPDI50aucohLkfKFWRB50iEDBmhD2QtV/j6U4C79rVbK6A3Wu7gx4qV5jKhdinemejkhGMumx2XAz8tPMhjg/ioqRRPiw2G6/dEMI8ABJ/kJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XZhzuWgi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1951699a91.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137589; x=1734742389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCYhLJZhR58ewaFrjgMGyGbHfnpNdzHm23IqgQZ/0wM=;
        b=XZhzuWgiWcMoHTc1oBI2ureLcOzeudbOg7Sl9c9eMJx03AbZgEc9ZyLe08aNBR/CRn
         gEUDvPZJ19Gx63EvcNB4tMIB5kZHkMfz6CO8+J0Ss3LsRL8cr6oFwiJ2dbXpFTHi7enT
         tGwu9cOXFQmAHinwhGahaSsENDbxIrwXf1/q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137589; x=1734742389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCYhLJZhR58ewaFrjgMGyGbHfnpNdzHm23IqgQZ/0wM=;
        b=tIWB/zflDgGwoDqlx/vFkWAiYbqRQ1hnNWSL52EKPkZvZAdgSyeyAyxDKaWv8YLKUX
         KZcvEq3KUd59+vLQueBX61nXGvMkONG8yxYF7BeNyYghjGG/WL0j1UTDc//gOppWPupR
         BD/bFLLvz5RLsw83ne/q8Oz8SgKzEnm1tK9g+SNjPKC9Ctrf7tAnkR5HSBT8LKSrc4D8
         NWWmX2aTF1JuX3FN6vdg7IqtTh+gIRM3Qm/lk2yc0gWEYCoM9SY3QC2I1ShitidASd4k
         Ycq9krpkHYiJ6DzW7LS2xaor8mDnwUZOTa4KFavhnMLo2yC1vmsmMJItrwwx0xVO5j3e
         4VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQI+5F58oh01iWrsdW/KvWsekQU7bR2tJks9ccA3+meUGvR3FaK7DveihiyYR2TKM1L+i6fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7DGeWop9/2sVpDjQESZ0y+8/JgMegZYRJ4PPQYLHpO/eJ/24
	Sj2O0cnPuIy01dwTMfBdapMKQoiX+6M1xaaTk8pUqpz2q6raTOlsS1Jz6+C4nQ==
X-Gm-Gg: ASbGnctOgHug67Zv44zR2YjjHcXDwwzn7IMz94JdPFNlkbaU8kLArNmb78iKzTsN9QS
	fT75DQKuDvhfOM1bkQ0N+0m+0UMZzWJVEXpAb69lvXK1MGhHntfksguzkEkuAVyV8Vc9SZBofgY
	K56rUIiLoKWQjwOxYjTRdYO/0YT1ddNOC2848jnh1z/WJAtRLXSsLmZ2lWbi4XBtFRE0dLA7XRR
	8xGRQ1aJW0uH0s56/jGiXR0kfIyX86e28gY6I+2q3VfKWkH0SlA/pwaZCBjkQih5A7mPqZ/EY2S
X-Google-Smtp-Source: AGHT+IGyZAYcBNhvS6uotk+yKNrfDXGIRBKVBPzRwnHoQvCbP1TZ1iFVgP8Qo1WHFe4yMk8mfH9X9g==
X-Received: by 2002:a17:90b:4d08:b0:2ee:ab10:c187 with SMTP id 98e67ed59e1d1-2f28fd6b5f3mr6479214a91.18.1734137588765;
        Fri, 13 Dec 2024 16:53:08 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:08 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Roxana Bradescu <roxabee@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	bjorn.andersson@oss.qualcomm.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
Date: Fri, 13 Dec 2024 16:52:02 -0800
Message-ID: <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241214005248.198803-1-dianders@chromium.org>
References: <20241214005248.198803-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for detecting CPUs that are vulnerable to Spectre BHB was
based on a hardcoded list of CPU IDs that were known to be affected.
Unfortunately, the list mostly only contained the IDs of standard ARM
cores. The IDs for many cores that are minor variants of the standard
ARM cores (like many Qualcomm Kyro CPUs) weren't listed. This led the
code to assume that those variants were not affected.

Flip the code on its head and instead list CPU IDs for cores that are
known to be _not_ affected. Now CPUs will be assumed vulnerable until
added to the list saying that they're safe.

As of right now, the only CPU IDs added to the "unaffected" list are
ARM Cortex A35, A53, and A55. This list was created by looking at
older cores listed in cputype.h that weren't listed in the "affected"
list previously.

Unfortunately, while this solution is better than what we had before,
it's still an imperfect solution. Specifically there are two ways to
mitigate Spectre BHB and one of those ways is parameterized with a "k"
value indicating how many loops are needed to mitigate. If we have an
unknown CPU ID then we've got to guess about how to mitigate it. Since
more cores seem to be mitigated by looping (and because it's unlikely
that the needed FW code will be in place for FW mitigation for unknown
cores), we'll choose looping for unknown CPUs and choose the highest
"k" value of 32.

The downside of our guessing is that some CPUs may now report as
"mitigated" when in reality they should need a firmware mitigation.
We'll choose to put a WARN_ON splat in the logs in this case any time
we had to make a guess since guessing the right mitigation is pretty
awful. Hopefully this will encourage CPU vendors to add their CPU IDs
to the list.


Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 arch/arm64/kernel/proton-pack.c | 46 +++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..39c5573c7527 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -841,13 +841,31 @@ enum bhb_mitigation_bits {
 };
 static unsigned long system_bhb_mitigations;
 
+static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	{},
+};
+
+static const struct midr_range spectre_bhb_safe_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	{},
+};
+
 /*
  * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
  * SCOPE_SYSTEM call will give the right answer.
+ *
+ * NOTE: Unknown CPUs are reported as affected. In order to make this work
+ * and still keep the list short, only handle CPUs where:
+ * - supports_csv2p3() returned false
+ * - supports_clearbhb() returned false.
  */
 u8 spectre_bhb_loop_affected(int scope)
 {
-	u8 k = 0;
+	u8 k;
 	static u8 max_bhb_k;
 
 	if (scope == SCOPE_LOCAL_CPU) {
@@ -886,6 +904,16 @@ u8 spectre_bhb_loop_affected(int scope)
 			k = 11;
 		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
 			k =  8;
+		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_safe_list) ||
+			 is_midr_in_range_list(read_cpuid_id(), spectre_bhb_firmware_mitigated_list))
+			k =  0;
+		else {
+			WARN_ONCE(true,
+				 "Unrecognized CPU %#010x, assuming Spectre BHB vulnerable\n",
+				 read_cpuid_id());
+			/* Hopefully k = 32 handles the worst case for unknown CPUs */
+			k = 32;
+		}
 
 		max_bhb_k = max(max_bhb_k, k);
 	} else {
@@ -916,24 +944,26 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
 	}
 }
 
+/*
+ * NOTE: Unknown CPUs are reported as affected. In order to make this work
+ * and still keep the list short, only handle CPUs where:
+ * - supports_csv2p3() returned false
+ * - supports_clearbhb() returned false.
+ * - spectre_bhb_loop_affected() returned 0.
+ */
 static bool is_spectre_bhb_fw_affected(int scope)
 {
 	static bool system_affected;
 	enum mitigation_state fw_state;
 	bool has_smccc = arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE;
-	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		{},
-	};
 	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-					 spectre_bhb_firmware_mitigated_list);
+						 spectre_bhb_safe_list);
 
 	if (scope != SCOPE_LOCAL_CPU)
 		return system_affected;
 
 	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
+	if (!cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
 		system_affected = true;
 		return true;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog


