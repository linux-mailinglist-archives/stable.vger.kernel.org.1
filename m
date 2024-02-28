Return-Path: <stable+bounces-25332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A286A896
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 07:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397831C2406D
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69C23775;
	Wed, 28 Feb 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fnl/Tedv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB522F11
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103366; cv=none; b=hAiY5w+1e4pv3nCJvNVmIq1rZmlJseI+EfYFb1iQT9N3qGw5QCDSLmKx5KmDoU4RyhIgxvanLEzcFHUBRdlgIlsPXeywDx30e+dZFZNXgDcyxkT9ITLT7dzLnpCEBLBWmywhsjQN2z3wxVIBvnxF2jf8beQB5KnwdYUrn9XtW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103366; c=relaxed/simple;
	bh=xTb1dPQYXT3wKImjGSHyQAkc7DbxWJHBELId/zBPW5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAm7uLtbtqIM19nx7z+fB0+UvBtTg/nyViYVIbqjDtQukH+CTcq2Rmv2DmymH+DTdHs/k6h0Kk7vdGxALLLkMTCj0/F/jZjxCi/+FdWs9YS8qbv7hYqtkZT+YwGy7WsBkTObVh6i8NZfvhstuEDV627xtcYr1J67XyFLKIdaeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fnl/Tedv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21fa872dce3so2890145fac.2
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 22:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709103364; x=1709708164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nifjTiVnKPzVz5Xx9U5qG6fvYEiI7lPtCucGoxbvIpQ=;
        b=fnl/TedvuLO5jBuqUWMTFKeYfTLwox8KspHIhvPDNwfkC4XTzen70LHw6uipOkkTf1
         1B3tY2ZNoeNDEH+KHIg0JabKJbfu/CjD2cAut7PJXKFzYKyy0QXP4MWoLxKUpVhqHfdt
         CWfXcCNLyQDK7lgQIxMuXytytd8VDEuLSuXu2uh/7lI/liZGY18blcizpLBur0587Ki/
         rg36oPMby7JVhVpFtmOQ3zJsOhlE3GmK64gH4ceqS1aJY1sNsxt3gxNo6msfp8qE80tg
         flILJNy7fEM06EuGU1kxUBN1lCbj+ycTgx1nNDZDqVfLQEe6mpy5E+D/SwJhOlSYB1h0
         sLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103364; x=1709708164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nifjTiVnKPzVz5Xx9U5qG6fvYEiI7lPtCucGoxbvIpQ=;
        b=IlH4CfYpqW6sB9hU75yHGWfL96HBRC0f8IuYngVTuSCd9+mTZAqC2s/gBIyT25tOTA
         JzAvxSzzhgEqDbPS1vjn6XVAu98Ye6JV1SlPuCq5hLuvTxEfeYJT9iQAO0vzhz4LRvWr
         sV4VoRFBGbZiBR3HaIXWg/Xm7GMDyic7FfUst6Rz+GVlC/YH13wVCy7j+BTZSSj6LTJQ
         g8A++14JPXT4oAGuK/dcIbjgdTPOF2BK+T+ZSlcvNkBCyo5ehV05mF01dphDo5DPlbqy
         esLeQ6pVrRSEa3bI7UDPKtiUDh9lMseVLEmzpM9Ven/qdgN+akoGkJYxLcvJRTusHzVI
         n0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPjzrMSdQSsAT/lIkwmUsiHrYwqcyoAhFPKDed3yI4Rh1k/DQJJTw260xw5fBlrbfE8R2dXeFyMPPWx7IOpJ3gb44ZTG70
X-Gm-Message-State: AOJu0Yya9eHvbB1ctvPnwtZ5HaVPkK5bmbxs9Oag5olOJGrN5ng8Jlcp
	DV/tK+qdr0EFycNO8WYjwZuSyZaO5xQ88m3T2dFBfy11BIWSMRFBkPJNke3gbp4=
X-Google-Smtp-Source: AGHT+IH4U8aBkFA2SKkKEolatXoRyjbjHcx5laQ73wGPgxVUxDCeFNHOySd/fRV8xKBko/SIfS+RIA==
X-Received: by 2002:a05:6870:e2d3:b0:21f:aa70:4c2b with SMTP id w19-20020a056870e2d300b0021faa704c2bmr13648589oad.12.1709103364136;
        Tue, 27 Feb 2024 22:56:04 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006e5590729aasm1010112pff.89.2024.02.27.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:56:03 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the [ms]envcfg CSR
Date: Tue, 27 Feb 2024 22:55:34 -0800
Message-ID: <20240228065559.3434837-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240228065559.3434837-1-samuel.holland@sifive.com>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
other extensions which may be implemented separately from any particular
version of the privileged ISA (for example, some unrelated errata may
prevent an implementation from claiming conformance with Ss1p12). As a
result, Linux cannot simply use the privileged ISA version to determine
if the CSR is present. It must also check if any of these other
extensions are implemented. It also cannot probe the existence of the
CSR at runtime, because Linux does not require Sstrict, so (in the
absence of additional information) it cannot know if a CSR at that
address is [ms]envcfg or part of some non-conforming vendor extension.

Since there are several standard extensions that imply the existence of
the [ms]envcfg CSR, it becomes unwieldy to check for all of them
wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
extension bit that is implied by the other extensions and denotes that
the CSR exists as defined in the privileged ISA, containing at least one
of the fields common between menvcfg and senvcfg.

This extension does not need to be parsed from the devicetree or ISA
string because it can only be implemented as a subset of some other
standard extension.

Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/riscv/include/asm/hwcap.h |  2 ++
 arch/riscv/kernel/cpufeature.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5340f818746b..1f2d2599c655 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,8 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 
+#define RISCV_ISA_EXT_XLINUXENVCFG	127
+
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c5b13f7dd482..dacffef68ce2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -201,6 +201,16 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+/*
+ * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
+ * privileged ISA, the existence of the CSRs is implied by any extension which
+ * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension for the
+ * existence of the CSR, and treat it as a subset of those other extensions.
+ */
+static const unsigned int riscv_xlinuxenvcfg_exts[] = {
+	RISCV_ISA_EXT_XLINUXENVCFG
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -250,8 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
 	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
-	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
-	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
+	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.43.1


