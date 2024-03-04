Return-Path: <stable+bounces-25839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F270F86FAB7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB5C28537E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640612E54;
	Mon,  4 Mar 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4qz1iO+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACE8F7A
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537208; cv=none; b=Cx0qWpbcW+gC7oqS5cHPt9gcOQQesbvuN1KMtqPHc0dMc8PV7xn/8mjOZLmaHNHJpQIef8vBxVjohQW/9RagJtw68nbWb3zFhvTeYXUPNFnM7+tynRIANiY4UaagMsyPnLz6JwuwYmJeR29v7aRzjQ0Arz7abcf10d1Z80vSCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537208; c=relaxed/simple;
	bh=n6Qh2FCao+/0jUCZw32HbvM9SMqzGExMn/+rLP7vTMs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n7jTJcytDoizlU6Dkon0vzKle9Yelzmj7M5s3jqPDIDk1aRF4phdTNx/q6ooELSfZBhqU4ClTO3OquUXdUL84yysjHd8JkzXntDaX3uaAdlQuID1Ag/mXr+y9RHnBaI3nlKYgiR7dx+o8Kuez+48jIypPcTdAYEKkcoMD/m/mW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4qz1iO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A798C433C7;
	Mon,  4 Mar 2024 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537207;
	bh=n6Qh2FCao+/0jUCZw32HbvM9SMqzGExMn/+rLP7vTMs=;
	h=Subject:To:Cc:From:Date:From;
	b=X4qz1iO+g6gEKZVjs91uOPbp3TsmkYLtBpttq8hipkZ/r0gHneFkCozQTSjA7kDCY
	 Bliy5iz2Ud6NnRpMiXMX4FpNHMwHOBZOO5v2vfCLuc4GlrCWIFMLqd6R1p6GGpJttw
	 JJALV77O+7i2aXXwKK8mA3rm9LF54Da89V2P/AVM=
Subject: FAILED: patch "[PATCH] riscv: Add a custom ISA extension for the [ms]envcfg CSR" failed to apply to 6.7-stable tree
To: samuel.holland@sifive.com,ajones@ventanamicro.com,conor.dooley@microchip.com,palmer@rivosinc.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:26:45 +0100
Message-ID: <2024030445-rants-grading-f698@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 4774848fef6041716a4883217eb75f6b10eb183b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030445-rants-grading-f698@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

4774848fef60 ("riscv: Add a custom ISA extension for the [ms]envcfg CSR")
aec3353963b8 ("riscv: add ISA extension parsing for vector crypto")
0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
e45f463a9b01 ("riscv: add ISA extension parsing for Zbc")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4774848fef6041716a4883217eb75f6b10eb183b Mon Sep 17 00:00:00 2001
From: Samuel Holland <samuel.holland@sifive.com>
Date: Tue, 27 Feb 2024 22:55:34 -0800
Subject: [PATCH] riscv: Add a custom ISA extension for the [ms]envcfg CSR

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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20240228065559.3434837-3-samuel.holland@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

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


