Return-Path: <stable+bounces-111744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE2A23559
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874347A1D95
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F8194A7C;
	Thu, 30 Jan 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eq6hiR9R"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F81547C9
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270059; cv=none; b=Okiq8pMkIQ4NgwYeFIL1OdFO6Qzy4016+ki1pARFUN/y+BZhh261YmjU9fKuxvkgyBtUmxO+47vzG9/M93oyTMAZy5assp5DW1we8Nu91wWbr3GCPR2C9wDHyqijdEMB6KrD/o38j7FcjYMEd1kMLqMdyliWnPu53zRVypxGRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270059; c=relaxed/simple;
	bh=rl3sttZTHNOF3X6Qf1CPbYHH1e5zy7KHI2Vo5o42HG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjFHNQFZ1ri595lB8TvLg/hL4VO4NQMlE00aeDUAEhcfS+Wo91ompXq73kkC4utE1fgDUvaKE4czzxGvdtNX8hMD1tlKhAnuDiYwfdgQhQTPuFJwfUd8dSRfMmUKtiGvyiW+FBHGsFBA/PoqoPXa3/zrrhc0H3Un+PEJdqDFlcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eq6hiR9R; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738270041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AxR+YjSVLIjvz2qqmkKbLhZZFVeBOAUSc90bIfkXWtM=;
	b=Eq6hiR9Rj6pWjWkJuwOYI5S5vtJoQ3y3bMWA7y26c5hGAo5FSJknV1UoyevWkL8569TiuB
	redLf9W1vYnoNlzkT7VIMRpYXeN8/sPY+OqyhmTV+8iq3TtYBl4OfOnO3RmSDhBrKYODp9
	XdXIz/qg0YLcyi6cp0z6FtYxKf35d2s=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	stable@vger.kernel.org,
	Moritz Fischer <moritzf@google.com>,
	Pedro Martelletto <martelletto@google.com>,
	Jon Masters <jonmasters@google.com>
Subject: [PATCH] arm64: Move storage of idreg overrides into mmuoff section
Date: Thu, 30 Jan 2025 12:46:15 -0800
Message-Id: <20250130204614.64621-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are a few places where the idreg overrides are read w/ the MMU
off, for example the VHE and hVHE checks in __finalise_el2. And while
the infrastructure gets this _mostly_ right (i.e. does the appropriate
cache maintenance), the placement of the data itself is problematic and
could share a cache line with something else.

Depending on how unforgiving an implementation's handling of mismatched
attributes is, this could lead to data corruption. In one observed case,
the system_cpucaps shared a line with arm64_sw_feature_override and the
cpucaps got nuked after entering the hyp stub...

Even though only a few overrides are read without the MMU on, just throw
the whole lot into the mmuoff section and be done with it.

Cc: stable@vger.kernel.org # v5.15+
Tested-by: Moritz Fischer <moritzf@google.com>
Tested-by: Pedro Martelletto <martelletto@google.com>
Reported-by: Jon Masters <jonmasters@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kernel/cpufeature.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d41128e37701..92506d9f90db 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -755,17 +755,20 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 #define ARM64_FTR_REG(id, table)		\
 	__ARM64_FTR_REG_OVERRIDE(#id, id, table, &no_override)
 
-struct arm64_ftr_override id_aa64mmfr0_override;
-struct arm64_ftr_override id_aa64mmfr1_override;
-struct arm64_ftr_override id_aa64mmfr2_override;
-struct arm64_ftr_override id_aa64pfr0_override;
-struct arm64_ftr_override id_aa64pfr1_override;
-struct arm64_ftr_override id_aa64zfr0_override;
-struct arm64_ftr_override id_aa64smfr0_override;
-struct arm64_ftr_override id_aa64isar1_override;
-struct arm64_ftr_override id_aa64isar2_override;
-
-struct arm64_ftr_override arm64_sw_feature_override;
+#define DEFINE_FTR_OVERRIDE(name)					\
+	struct arm64_ftr_override __section(".mmuoff.data.read") name
+
+DEFINE_FTR_OVERRIDE(id_aa64mmfr0_override);
+DEFINE_FTR_OVERRIDE(id_aa64mmfr1_override);
+DEFINE_FTR_OVERRIDE(id_aa64mmfr2_override);
+DEFINE_FTR_OVERRIDE(id_aa64pfr0_override);
+DEFINE_FTR_OVERRIDE(id_aa64pfr1_override);
+DEFINE_FTR_OVERRIDE(id_aa64zfr0_override);
+DEFINE_FTR_OVERRIDE(id_aa64smfr0_override);
+DEFINE_FTR_OVERRIDE(id_aa64isar1_override);
+DEFINE_FTR_OVERRIDE(id_aa64isar2_override);
+
+DEFINE_FTR_OVERRIDE(arm64_sw_feature_override);
 
 static const struct __ftr_reg_entry {
 	u32			sys_id;

base-commit: 1dd3393696efba1598aa7692939bba99d0cffae3
-- 
2.39.5


