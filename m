Return-Path: <stable+bounces-233477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H2gJZZU1GnztAcAu9opvQ
	(envelope-from <stable+bounces-233477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459B3A8835
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E3903026CAD
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA301E0DD8;
	Tue,  7 Apr 2026 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBljbSm3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5F2B9A4;
	Tue,  7 Apr 2026 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522961; cv=none; b=bTT7eEpfqXmjW+eDl3oOMdwvRjN/7JIUumBbopPqckY3E5x4O3LTL9ck1dWw0syhoA93qQQ6ROa+pTqKv6uBV9su91lhqVmmwbqC9wi5IZPp8K3wbf3JT4IoRESIi+YhSnpoCtwPnsZT6Efah1flB3p05UxJD/hVhucEmbMN8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522961; c=relaxed/simple;
	bh=XmGhm0tvIfgLvqP5Iv0OjVZ+bxUm/Xf/rXubccaqgrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GxZmfl2aLJzvqHrFujR9hXSqrsi+KYPD5BUICaLGxw/35Jnj/9aSZWOfJ9GmrAIv9t1jahnQ2WIBUfr2v03899zMJbKm/sTtSBI1FsDymP/NMSR740uEm1WkZitKwn9U2prnNBOJn+9zDDDWqc+6sHIctNWmeyG/rrpJn5uHrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBljbSm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB7C4CEF7;
	Tue,  7 Apr 2026 00:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775522961;
	bh=XmGhm0tvIfgLvqP5Iv0OjVZ+bxUm/Xf/rXubccaqgrU=;
	h=From:Date:Subject:To:Cc:From;
	b=hBljbSm381tbmlVVp5EDa8lJAHQsAoxLbpIlGJx4q7dyBbPg1sibAS7GMTnXWkySa
	 faT7UXPZVb830/6oehZ0YS559Vt+1upYFg3REq56FWH8BAn4xqQskuk3SmIXCWhNdi
	 pgGduUHlmfQR5D+w5TwJb3VyFt7LIIxCXQKaq5QrO/O8FI8oU6S7EQNyOG8TsE1Hpd
	 e7xkVZOd0Eq/R8CF6UyZT2wH7wajJPxw3swlOSMUa5DI+ZANPoAQWuhos3yzG6DNYT
	 wGhuCbEE/HKcSBSoJyfOdq12NYEoinab8AwIjVZVk6FwZfbqc9ZEala355lIGPuWis
	 XuNn/6MB5Gxqw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 06 Apr 2026 17:49:08 -0700
Subject: [PATCH linux-5.10.y] drm/amd/display: Do not add '-mhard-float' to
 calcs, dsc, and dcn30 FP files for clang
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-5-10-clang-amdgpu-hard-float-errors-v1-1-09c4c045f848@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBAAv2L23DVgFEy/0nigsCgNVbNIY2P8e
 2l7nEwyc0AiDpTgWh3A9AopLHMBeanATmYeCYMrDI1olGiFwg6lQBuLQvN045pxMuzQx8VsSMw
 LJ2xb02svjdaqh1JamXzYf5cbxDDnHbtaivoNw9+mfH+Q3b4jOM8PQm084JUAAAA=
X-Change-ID: 20260406-5-10-clang-amdgpu-hard-float-errors-44a87f1a7768
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5282; i=nathan@kernel.org;
 h=from:subject:message-id; bh=XmGhm0tvIfgLvqP5Iv0OjVZ+bxUm/Xf/rXubccaqgrU=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlXQvrnlm9w/vXBc6KnDH+K4p1wbZ4VsSvzjiekvRB6c
 8dCLZOno5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyEI4KRYf27DVsTHj/TfnTn
 V83qr8dX2zGe3HOO5Z/mzibRVzcarqkxMvR9LDgUKWffMrmh4MaVSSmzneYEbmTJm1C2/NkftYM
 78tgA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233477-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1459B3A8835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is for linux-5.10.y only. It is functionally equivalent to
upstream commit 7db038d9790e ("drm/amd/display: Do not add
'-mhard-float' to dml_ccflags for clang"), which was created after all
files that require '-mhard-float' were moved under the dml folder. In
linux-5.10.y, which does not contain upstream commits

  b4bab46400a0 ("drm/amd/display: move calcs folder into DML")
  27e01f10d183 ("drm/amd/display: move FPU associated DSC code to DML folder")
  40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")

clang-21 or newer errors with

  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calc_math.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calc_auto.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/rc_calc.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
  clang: error: unsupported option '-mhard-float' for target 'x86_64-pc-linux-gnu'
  make[6]: *** [scripts/Makefile.build:286: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.o] Error 1

Apply a functionally equivalent change to prevent adding '-mhard-float'
with clang for these files.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2156
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Hi stable folks,

The ChromeOS folks raised an issue due to build failures in linux-5.10.y
when building with clang-21 or newer:

  https://github.com/ClangBuiltLinux/linux/issues/2156

I thought I previously addressed this in all stable trees:

  https://lore.kernel.org/20250604233141.GA2374479@ax162/

But our build coverage in 5.10 missed these files because allmodconfig
enables KCOV, which was incompatible with these files until upstream
commit 3876a8b5e241 ("drm/amd/display: Enable building new display
engine with KCOV enabled").

This change addresses the remaining errors in a functionally equivalent
manner as my original upstream commit 7db038d9790e ("drm/amd/display: Do
not add '-mhard-float' to dml_ccflags for clang"), similar to what I did
before in 5.10 commit 0c3939b00253 ("drm/amd/display: Do not add
'-mhard-float' to dcn2{1,0}_resource.o for clang"). There is technically
an upstream change that addresses the dcn30 error but it was done after
aarch64 support was dropped from the new display engine code, so I
preferred to do this to minimize potential regressions.

If there are any issues, please let me know.
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 4 ++--
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index cb7c37ef8735..1b3e3926b706 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -26,7 +26,8 @@
 #
 
 ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
+calcs_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
+calcs_ccflags := $(calcs_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index a71c0f298380..52d5826b2970 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := $(if $(CONFIG_CC_IS_GCC),-mhard-float) -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := $(if $(CONFIG_CC_IS_GCC),-mhard-float) -msse
 endif
 
 ifdef CONFIG_PPC64
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 6207809f293b..4fc6d9c32d16 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the 'dsc' sub-component of DAL.
 
 ifdef CONFIG_X86
-dsc_ccflags := -mhard-float -msse
+dsc_ccflags-$(CONFIG_CC_IS_GCC) := -mhard-float
+dsc_ccflags := $(dsc_ccflags-y) -msse
 endif
 
 ifdef CONFIG_PPC64

---
base-commit: aed5c3b77cd53ba74f66767b03bfb9177662af4b
change-id: 20260406-5-10-clang-amdgpu-hard-float-errors-44a87f1a7768

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


