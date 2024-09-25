Return-Path: <stable+bounces-77611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F6985F1E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F681C25C51
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2821D2D2;
	Wed, 25 Sep 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlX1NPrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4521D2CA;
	Wed, 25 Sep 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266471; cv=none; b=lud04RP1vz+JX2p3m1GDS++Q2uw4jLkA+lwWcKtZnUJMT9Un3hVwc4IZ6B9zw5dZ4ILSVZxo9dT7rTobSIKvbakrL0l9BA4rEEp2oUJrb5TTX9n2y12KFVPbDOBF50otg0kD16DyR3bESAHibrdRK+ulzumTL04aexM60enXr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266471; c=relaxed/simple;
	bh=xUwHKg/aHeA4wtXK+NtOrCDg65Gr22zZMZETxZxnKfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUincd2/uKuPnwM0XybRZXXBeDdXqMXrwaL7wHO5Z0vw3DtKSOGCbr813EcS3KPjwNNbwhShUHYQPybpU5YEAepR9A02BVUFus43wNzC+/PCV6rK6gioM6POB15r9FhVklIWzccacSOJVj0tMkHl8mHHNE4S62qaCw84NJ0O+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlX1NPrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3988C4CEC3;
	Wed, 25 Sep 2024 12:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266471;
	bh=xUwHKg/aHeA4wtXK+NtOrCDg65Gr22zZMZETxZxnKfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlX1NPrIg5+BnJ+Os2U7PJe+WizuojDwXJml2SH2lqEgrGzbChHitStogfhIxM9TL
	 d9h3xlgUEfYgCcqBdNrjyQ4VT//aMDbpCVWLEOqlsX8HIYIb5Qxn/25g+yVnK1e/gH
	 D1RQqD1nuMMKPXy8VQnuEVr5K8f6bPj6R/jo6657Fp8BYZo82ZRZXBmkdP9o6ETOug
	 XCcnPOZaMnDpDUNefRhequ7DlzdeYjWXw4ClD4TawLGWL6BCnx998e6i+RFSws1XKn
	 SJ/w+P+WGnnxz+IHwD9n30GQLhQujavbF+BuKtgdb/iSBVBcs3WIQpt+8nh0kMbeut
	 3FwOOMl/ERsUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 064/139] tools/x86/kcpuid: Protect against faulty "max subleaf" values
Date: Wed, 25 Sep 2024 08:08:04 -0400
Message-ID: <20240925121137.1307574-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: "Ahmed S. Darwish" <darwi@linutronix.de>

[ Upstream commit cf96ab1a966b87b09fdd9e8cc8357d2d00776a3a ]

Protect against the kcpuid code parsing faulty max subleaf numbers
through a min() expression.  Thus, ensuring that max_subleaf will always
be ≤ MAX_SUBLEAF_NUM.

Use "u32" for the subleaf numbers since kcpuid is compiled with -Wextra,
which includes signed/unsigned comparisons warnings.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-5-darwi@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/arch/x86/kcpuid/kcpuid.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 24b7d017ec2c1..b7965dfff33a9 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -7,7 +7,8 @@
 #include <string.h>
 #include <getopt.h>
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#define min(a, b)	(((a) < (b)) ? (a) : (b))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -207,12 +208,9 @@ static void raw_dump_range(struct cpuid_range *range)
 #define MAX_SUBLEAF_NUM		32
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
-	u32 max_func, idx_func;
-	int subleaf;
+	u32 max_func, idx_func, subleaf, max_subleaf;
+	u32 eax, ebx, ecx, edx, f = input_eax;
 	struct cpuid_range *range;
-	u32 eax, ebx, ecx, edx;
-	u32 f = input_eax;
-	int max_subleaf;
 	bool allzero;
 
 	eax = input_eax;
@@ -258,7 +256,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * others have to be tried (0xf)
 		 */
 		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18)
-			max_subleaf = (eax & 0xff) + 1;
+			max_subleaf = min((eax & 0xff) + 1, max_subleaf);
 
 		if (f == 0xb)
 			max_subleaf = 2;
-- 
2.43.0


