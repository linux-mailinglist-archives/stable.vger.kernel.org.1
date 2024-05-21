Return-Path: <stable+bounces-45519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5158CB0C0
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C6B2826B7
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD73762E0;
	Tue, 21 May 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xmm+FP+I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA071E87C
	for <stable@vger.kernel.org>; Tue, 21 May 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303105; cv=none; b=Po6LcXQc6LhAXjBuB/TCWPwTLGVIsBxNAqNQeynKXNkCH3A5szDdea00sNI6YbIdetx+EiChlrpC66MGAkb3GZevCTMn62EVkzoQIwN4d6bIjDdcPVq7NbbspOdv+Jo3f4BPO0k47AkSDvsyhxboBkefGQ+Fw++Y8ewPfMdP+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303105; c=relaxed/simple;
	bh=90Aufiqznm1fPa2eOmNg2iOfg8Ezkn/sjjhgQJXCuys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KVBJp0mN6tEdAHrxkgR5KP3uo5cFH7wvtel2x3IF8svi8dRwTsovzekDdjFq6oE9pQe076IQKoaddnDni9gVK/oq1rLqapb89Wys82PbOq9y3qWSbGow19BAJH+7t+n5n7aZP0QRyPVKu1rYzfIPHG1hI4Xg6toiBCDu+NJixiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xmm+FP+I; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-65789db0259so5949283a12.0
        for <stable@vger.kernel.org>; Tue, 21 May 2024 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716303103; x=1716907903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kGoT9PyxEwtgM/5afZe8siksPbu26HURTv64xQc5SOs=;
        b=Xmm+FP+IRg3JJTIbOEEb8rozKvWPgzR8HSeWPRwtg9hFCH28h6pkenctnVI5rNYw8e
         erJzQl3XoSCbeQPczS2yYror58msyVkmkeTDtqcPBeiXdpA0XoRVD00y2UY2iyJZyHYN
         wK2BwtCijV6kfcwz5Lz0suPHYEcUgT0u+pA2kkInPXRqjQFCNaLYs3U5dC4s39QYWsbB
         Fuba8ZIsVcBoulLDwU3ckBKGWDBfg7jlX9pIx8Lmwn6+EXHeZFhXKWUnjWsKDieXHYbf
         41NeTbsAsZRIBQFtvXQZSU1Apfy+IHXMT6QYEiL72ZKomjC/G/+KD3rRdTqtGoSk2bND
         x5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303103; x=1716907903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGoT9PyxEwtgM/5afZe8siksPbu26HURTv64xQc5SOs=;
        b=u5s9W98vcCuaseaATxwwRW8/OMqNXzfhCs6tq277yaf9opea4GgUq0FBuGuNKT4NRD
         JV6wvItDQcrInAutVmyCguzjhRVh3uINW7E1cbVdH+93rrIZC8WAcuMtlvprbsFkqouJ
         d5CSz4oF4RHnRqUxuyGslNtn12jiP4LGMG2kJC0iQ5Q9b5Q/gokT6PFJXymrbIXBUvJN
         BAl9Vx0toWn5Zzm1BnAs//aSJyiRAzS8jEgo10ufF2nVbqPnLsqjWjveahc9nNsfDeXu
         apviXS1FjdcIMFFL7xDzIFcHNFOXxaYC4z2Dwovix9KzLQfghPIy4vvEAjAxSgaU7d5P
         yWJw==
X-Forwarded-Encrypted: i=1; AJvYcCUddMPzWxA2Df/HwrgHhLRiH/lzPnnC5/j21LkHKn1TL4m6Oa72PiUeGDG7kNfLm0x2ODMcdWNIaapVYNejXfHhRxsK3wbh
X-Gm-Message-State: AOJu0YxDS7rj/j2bCAKo0rFv9VDZ08+j9isFUZG+ysn4+eWHsJ/tyY3p
	4WGuUpwTymEnpI+6TTRypWhEMbbNSeiS5Pv8zTs8ytvqRqa01ewGpxmjxCGCWtvQCg==
X-Google-Smtp-Source: AGHT+IFGy8cBPN0O/uR94/FNSc4BWHZGPU8P9wMgM4hQOMLL9aP8jYx+Dk+1beqWdZ/Rm6A/aGdurLI=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a17:902:d491:b0:1f3:317:50f3 with SMTP id
 d9443c01a7336-1f303175717mr1476425ad.0.1716303103456; Tue, 21 May 2024
 07:51:43 -0700 (PDT)
Date: Tue, 21 May 2024 14:51:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPC0TGYC/x3M3QpAQBBA4VfRXBvNLrZ4FblgDab8tSMpeXeby
 +/inAeUg7BCnTwQ+BKVfYswaQJ+7raJUYZosGQLKq3BRRm7c1/FKzo02FPliC05ykuI1RF4lPs /NuAyA+37fkYHcClmAAAA
X-Developer-Key: i=ovt@google.com; a=ed25519; pk=HTpF23xI+jZf9amJE+xfTRAPYN+VnG6QbPd+8nM0Fps=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716303101; l=2034;
 i=ovt@google.com; s=20240521; h=from:subject:message-id; bh=cMh2radWNBGWDH4huHkH6mKDKNWKhn9PdKTJLMYtdFs=;
 b=kYbb85O8UWePVi4kvyN79NNub5bpiBQwrq2Ul4k4k+eSGt8ADDCjwakfX4lCXPpr0FojOi/XR siaEsTtqS5OCZyMWCZFoASjh9Ngi9ftpjfFxznSo+nKHNheiWg0QR+T
X-Mailer: b4 0.12.4
Message-ID: <20240521-lse-atomics-6-1-v1-1-7aa6040fc6cd@google.com>
Subject: [PATCH 6.1] arm64: atomics: lse: remove stale dependency on JUMP_LABEL
From: Oleksandr Tymoshenko <ovt@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="utf-8"

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 657eef0a5420a02c02945ed8c87f2ddcbd255772 ]

Currently CONFIG_ARM64_USE_LSE_ATOMICS depends upon CONFIG_JUMP_LABEL,
as the inline atomics were indirected with a static branch.

However, since commit:

  21fb26bfb01ffe0d ("arm64: alternatives: add alternative_has_feature_*()")

... we use an alternative_branch (which is always available) rather than
a static branch, and hence the dependency is unnecessary.

Remove the stale dependency, along with the stale include. This will
allow the use of LSE atomics in kernels built with CONFIG_JUMP_LABEL=n,
and reduces the risk of circular header dependencies via <asm/lse.h>.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221114125424.2998268-1-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 arch/arm64/Kconfig           | 1 -
 arch/arm64/include/asm/lse.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c15f71501c6c..044b98a62f7b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1752,7 +1752,6 @@ config ARM64_LSE_ATOMICS
 
 config ARM64_USE_LSE_ATOMICS
 	bool "Atomic instructions"
-	depends on JUMP_LABEL
 	default y
 	help
 	  As part of the Large System Extensions, ARMv8.1 introduces new
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index c503db8e73b0..f99d74826a7e 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -10,7 +10,6 @@
 
 #include <linux/compiler_types.h>
 #include <linux/export.h>
-#include <linux/jump_label.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/alternative-macros.h>

---
base-commit: 4078fa637fcd80c8487680ec2e4ef7c58308e9aa
change-id: 20240521-lse-atomics-6-1-b0960e206035

Best regards,
-- 
Oleksandr Tymoshenko <ovt@google.com>


