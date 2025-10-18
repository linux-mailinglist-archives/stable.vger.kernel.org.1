Return-Path: <stable+bounces-187798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B0BEC590
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138D14081AF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CE24336D;
	Sat, 18 Oct 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oC0JFe3r"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758819E81F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755222; cv=none; b=pjXblvEwVQzkFE6YE4o1g2ZY+O8O+puaLNBpS+goUnzFrLKhs0j98oddjBmdmB2etxmHPuFTYD4N0nWmA39TuIvJSjqKrFB7RNO/Ve2GuZrD4mIub36sSnq6NhPRu7Y/eU3FBN9FmSDKAHeJf8G4uhrNp75IypzAXXXIXkvc94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755222; c=relaxed/simple;
	bh=zd6tQBowptX4m4Mw6QRX5estg4n4hoBoi1Dfssm20GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUdLoyQ4pmOoNFm+TaeEYhOCI0dpUeRcoz8+R/vA2tp5gqN447dL19CidpI5TrT4aaMf5cUrGpo9JPeYZN1mGhu69d6/6npy7san5FEjFPp/pvcWYKzj8+3D6RfEpZtZwEV0YyeSY8pmH8a18n59KEtK3PtOnxbanrw4W7KaSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oC0JFe3r; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c103928ffso37924106d6.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760755219; x=1761360019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Dus8AFvubYCo2Iz75kl/mYsJ0os8tXO5WjEduobHi4=;
        b=oC0JFe3rGSMj9T1J0hmVSZSKMAV23Aa7KGoZH+aTeTEifjJQRMBmF3OB9OQxDZ8nGv
         7qcx2LqrXBdrO1YFi6wpmlvGnaEL3lzmInYdN+GEkb286mTyxbvBr5/Da5jF48OYdCOa
         qnHckrOEGVEBdbdBFeIFqVdl0MRS4TCwbp2Q3UAV1/CW1haELZ/Ng1aTKdyu1sRySrTp
         c45MCuLH2CLKYR7NLSCHm++U8zWZNIpCEP37BL7PDlnQxWWpiDV7dWBBbx4SFoofVT5o
         GS2u0uAron3BfutQ7LwQ/pwgp5V8csWxcAEZoGnQulLMqRtgEamdX8Z9pOwIh/r9VPuO
         67AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760755219; x=1761360019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Dus8AFvubYCo2Iz75kl/mYsJ0os8tXO5WjEduobHi4=;
        b=t1UnqOoWF43sb+akIGS4pqxmKDrm/f4nqY1WxP/Z/PHyPSi/yoj+7Wvi+Im8uI3EFd
         LnVvSDIPCjFDuJWVXfO3wIlef7sLkyJOz1iqlsRO74J8smceD18txsC8AWgq+0YpULRS
         aTu2flRS1LPznH3XzQYG2Fcbrlc/5FVP+68ej4TsZfccVw3fWdUD/qCIKBqm6S6N083E
         iEoKzuwNuwDz9BPu78BXfqeSIuK2O9efkNA5FcfYFGeEP2khBuOcg+yZ38KvoQbWejCy
         dUdw5SA+KIFFubtsCjm6P5PSWuHVP98EEWZMMUGC+i6RpU9hj0klhnXf65YzxOMLu/L7
         pEfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXf5q6ss+PkDhB4U5RzoHnyzOFYweeKzzaT/QKQBVPh7F/RAiANQ0X3a52QwY9xcyNQUQfP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQMelXF8W0CZVLvZZ7SIORKQg93yGmSJU6oAjlPGNq20oOmbg
	pIC8ejja65BRyWu+VRp30rG1UNxy0EceoqpOGmwkt0joSuu5d5TNVjPUK9kt9CUB3QI=
X-Gm-Gg: ASbGncs6kBCx4dqNGviUcGb20OmnJshTpWkQdp+yasjN8fw/RKHZwy0id2LBBp6Aib4
	u7DYIU6Ar8fFqrrzlGa5EPx85worxPotFJAyFYuXP58CgiIZ8ixC9gK5U4ggGRPsb0jT0sgleVZ
	C4NVSjQe0wZyeZtlWzUY3Xt+cjExyJIq77Kl30h3bbjdwCw5/AOtMuRLMu1DQpNeG0neZERwxE2
	dXyG4B5inPCQfhLpy445Oola38PyS5lFeGKquobifpJierR+9+NS2wc+29UlwX0dcggSmQom7N6
	kdfI/evY4/s8DIehPm4gYQ/DO6l85B1QcA6aHJIgeuXyoFCWHPsgkpBPThhyLp5v4QE7zm1Bsar
	J9jN8FhjvdEIC7OKOVLLMtWiEPe06mtDMew+l6pl6py76N7QKCINW1wcMCCa4cJSkR7rWt/sLuu
	2Aan1xx9zbe3ON6UVsUzt6QIHbTdFYDZOGBJSaxXXFklaMdzItbRqlSoKGvS35KyvI
X-Google-Smtp-Source: AGHT+IHa5CVoc9R4UCxsuyKubgfsAJamI5eRYeedq2Gpyju8Cu94PfvkOYi04haInndEP2HJ/gEVdA==
X-Received: by 2002:a05:6214:5985:b0:87c:2111:ad4e with SMTP id 6a1803df08f44-87c2111b136mr72178006d6.8.1760755219062;
        Fri, 17 Oct 2025 19:40:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fcd39sm9355186d6.6.2025.10.17.19.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 19:40:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peterz@infradead.org,
	mario.limonciello@amd.com,
	riel@surriel.com,
	yazen.ghannam@amd.com,
	me@mixaill.net,
	kai.huang@intel.com,
	sandipan.das@amd.com,
	darwi@linutronix.de,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
Date: Fri, 17 Oct 2025 22:40:10 -0400
Message-ID: <20251018024010.4112396-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under unknown conditions, Zen5 chips running rdseed can produce
(val=0,CF=1) over 10% of the time (when rdseed is successful).
CF=1 indicates success, while val=0 is typically only produced
when rdseed fails (CF=0).

This suggests there is a bug which causes rdseed to silently fail.

This was reproduced reliably by launching 2-threads per available
core, 1-thread per for hamming on RDSEED, and 1-thread per core
collectively eating and hammering on ~90% of memory.

This was observed on more than 1 Zen5 model, so it should be disabled
for all of Zen5 until/unless a comprehensive blacklist can be built.

Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/kernel/cpu/amd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5398db4dedb4..1af30518d3e7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1037,6 +1037,10 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
+	/* Disable RDSEED on AMD Turin because of an error. */
+	clear_cpu_cap(c, X86_FEATURE_RDSEED);
+	msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+	pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
-- 
2.51.0


