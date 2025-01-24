Return-Path: <stable+bounces-110380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6863AA1B6D2
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 14:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A44D3ACA8F
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130071CD15;
	Fri, 24 Jan 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT4kMRIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53679C0;
	Fri, 24 Jan 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737725546; cv=none; b=fV309kPZQrh82pO/RFuJd50R/sEoKE80ov45xBSwfz11Mp9O6LFWkkrO1sOqxidZT6xfvMXklwKnvTX8IRAt1DK80JOMxxJayfk1y+eqWbJspzKHBtH2RwKGWRcYiGYa06I2KSQ4sGdm/9SjMTJdlVnQ4fZYt28LhnIeieJJwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737725546; c=relaxed/simple;
	bh=4FYKS1XlVwqucqi8Ae86v922xxqNnKi/Xn6F3uH2Au4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hFTqO14In+IeTLsngMq90Dh7dH0jj14QHG0tckmThOl9X75XWiBF9PESrSAEKUzFFQcaQtP4n1NxiJxGNgKRXXNPYMR6ewDq/irD+RdbWUx+epyE+DbchOl6lhBx5vY72jYHkfJGjKxEPLuaDGagRd4ymskdtOBmHihzItTRocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT4kMRIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D74AC4CED2;
	Fri, 24 Jan 2025 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737725546;
	bh=4FYKS1XlVwqucqi8Ae86v922xxqNnKi/Xn6F3uH2Au4=;
	h=From:Date:Subject:To:Cc:From;
	b=YT4kMRIEv1K+OGMSzKsd+ozMsCWl3l17jt8GJUD5d4QQy2tPe+KpT2qPfc3rVLlAO
	 JHgl1+91c3DGyoWkst9mkaf87pbNPSCR+bUOn+PcvIJ+6Twpp3prL79cZuS/rRLbAa
	 VgSnM08qglYLxxHDKdt6FjwJhrdPuBPzXdS0WUmNfodMzSuZ3Btp6SByNPN81NXkEe
	 DFOQguABK4X9IsD+T/AAmmE9ePQN2VgL1Hp2kSlnC3sAT8deWCv0d8hUXfT+wdPVGa
	 VS2TATyTzxG4IZUiHkKkLB8N55rF1lmBpQcllJONoloacSLIrCkvoOpRZDslkH8NEm
	 l4UD3e5CckBBQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 24 Jan 2025 06:31:57 -0700
Subject: [PATCH] arm64: Handle .ARM.attributes section in linker scripts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEyWk2cC/x3NUQrCMBCE4auUfXah2VgRryI+rOmoizWWTRSh9
 O5GHz9+mFmowA2FDt1CjrcVe+aGsOko3TRfwTY2k/Qy9EEiqz92W25pnPADa61u51dFYcs8Wb7
 DuSS3ufJeFJAhhqiJ2uTsuNjnf3c8resXRmbOKX4AAAA=
X-Change-ID: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=nathan@kernel.org;
 h=from:subject:message-id; bh=4FYKS1XlVwqucqi8Ae86v922xxqNnKi/Xn6F3uH2Au4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmTp2UUnHHdyyih3ld3Yd2N7+9Uf998JhNXWCS8LiSxW
 mff93D1jlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRlYoM/wO2xW/7VvbYmnd2
 cGXZqtoyM9t0NS2+tsMbmSRMDtuHWDH8T1ofeP6h7vr7YvO5PzM7vZnekLK22tjE9038zMxVS2R
 W8wAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent LLVM commit [1] started generating an .ARM.attributes section
similar to the one that exists for 32-bit, which results in orphan
section warnings (or errors if CONFIG_WERROR is enabled) from the linker
because it is not handled in the arm64 linker scripts.

  ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'

  ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'

Add this new section to the necessary linker scripts to resolve the warnings.

Cc: stable@vger.kernel.org
Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/kernel/vdso/vdso.lds.S | 1 +
 arch/arm64/kernel/vmlinux.lds.S   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 4ec32e86a8da..f8418a3a2758 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -75,6 +75,7 @@ SECTIONS
 
 	DWARF_DEBUG
 	ELF_DETAILS
+	.ARM.attributes 0 : { *(.ARM.attributes) }
 
 	/DISCARD/	: {
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f84c71f04d9e..c94942e9eb46 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -335,6 +335,7 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
+	.ARM.attributes 0 : { *(.ARM.attributes) }
 
 	HEAD_SYMBOLS
 

---
base-commit: 1dd3393696efba1598aa7692939bba99d0cffae3
change-id: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


