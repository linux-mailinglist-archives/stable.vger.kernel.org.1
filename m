Return-Path: <stable+bounces-77407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A41985CE8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8720A287893
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FFE18A6DF;
	Wed, 25 Sep 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc9XFgKm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930B1D619A;
	Wed, 25 Sep 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265657; cv=none; b=PdfWSIlU1MIuehl+OIS4knifxdF9el05FXRdYrDf8bfXh0LGi0A0eBQuMzVc4HEIEfzCatilgEtyi9zVn3+8aFO6F5kFku0K2SIq3/fqUqtwMCsF4rQm51+X34C/M3Ay6PW0uVALJ/e/mrfv2hr+9pLhnpU8W4/r/FqtOJNUTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265657; c=relaxed/simple;
	bh=c5m3Bnbl5dphbPfrSx66MXOe3qY4VE3SBmFhPptmC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyMXXzDxn50EkR4ZDmjCtlebqeYwZEOzdImtGpOPrkuf4wNU2jZoBh5cdbAJ3XjGr7V9klNn4+qqiA9zYckWJ3kw7fmfsYMUiOxpEl7DbgFGc5QXXbBH2M5SZPACQUGebjkDAMnoJyVxHoCPOX0XSv2746GB44tq+BRKFfOM9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc9XFgKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E40AC4CEC3;
	Wed, 25 Sep 2024 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265657;
	bh=c5m3Bnbl5dphbPfrSx66MXOe3qY4VE3SBmFhPptmC+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pc9XFgKmbEJ9b2TE23dK8Hxz08ERO/2fnzqHatLMi01Jua2z7lRmB9xnXE+2dFWpM
	 Hi/l6QZ7LZvjkHoSo4uY4cNBfLSjXWQS8fwJZzDfOjW1LUKv679LUs9Fyq5Kkn2Rfr
	 HI+YuMqA+dyXC5P1kWh4zLgx7uyjo6DQf7mjHY0tweIgxYwyMu40tmjzMVvKMn8kBu
	 OBZX9qZzIukESGqIuyn9kbJ8B2UeVn+gVnHbQATjUWsgnBdoGrPY7+pMcR7m2WCrQ5
	 QReeB8qGeGPLIA8zfKLVTShxwjwDYP8FVop/I+F3bXHKEnVMb5QUv5WfE+hGd7yXGH
	 FnqmE/QOIbVCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Shanavas . K . S" <shanavasks@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	vegard.nossum@oracle.com,
	tony.luck@intel.com,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH AUTOSEL 6.10 062/197] x86/bugs: Add missing NO_SSB flag
Date: Wed, 25 Sep 2024 07:51:21 -0400
Message-ID: <20240925115823.1303019-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Daniel Sneddon <daniel.sneddon@linux.intel.com>

[ Upstream commit 23e12b54acf621f4f03381dca91cc5f1334f21fd ]

The Moorefield and Lightning Mountain Atom processors are
missing the NO_SSB flag in the vulnerabilities whitelist.
This will cause unaffected parts to incorrectly be reported
as vulnerable. Add the missing flag.

These parts are currently out of service and were verified
internally with archived documentation that they need the
NO_SSB flag.

Closes: https://lore.kernel.org/lkml/CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com/
Reported-by: Shanavas.K.S <shanavasks@gmail.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240829192437.4074196-1-daniel.sneddon@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158c..be307c9ef263d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1165,8 +1165,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-- 
2.43.0


