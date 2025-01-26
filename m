Return-Path: <stable+bounces-110534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3DA1C9C8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DE16723A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04711F78F0;
	Sun, 26 Jan 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r57ZkTfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856B1F78E7;
	Sun, 26 Jan 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903282; cv=none; b=ZI/upkaUEQ5JBm39gRM/c5a4mcl2LM4UnJficUFpubT88RRTeGJJH46iwh+o3poZwyixFQ06QCc+uHPc8+upe35hnwgD0iDNEOEgrlnnPTdPgPTUp3OiJ8cSgkJyVP/ETEl3Tx2GFseufPMTxMojxv3STJQ26AuQUfz8kOJDzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903282; c=relaxed/simple;
	bh=lUa6hxzSEHrVv1Pb4M3DcXtPzy5jghDECoP62giwwcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuMJWJrN0jLgBsDx2SvqLaBhXBQM4M+bJPdBUbzlS/hRZoAlAkaA4gj5bDNsm8Ow+DAOiNxNGvVIFHysgkTeMRDA/A7/NsyyJ2MUx4VSRN+rH1LDHy65DVtB38BAUq0poepB+PeeII8v5YpF1v+KN/J55p92vjCaC1rhmqNl8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r57ZkTfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9859BC4CEE2;
	Sun, 26 Jan 2025 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903282;
	bh=lUa6hxzSEHrVv1Pb4M3DcXtPzy5jghDECoP62giwwcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r57ZkTfaS5R71AcfN+CONsN+ab8tMvA5nkaXRkreIvd10L5aGuAX3FqmmNajkd6x3
	 3IiA6lWxDOmvIo4+8vjOS/SB6EnQI8ZHsWP6AOHH3pYWZesOOxZuvhKc0BBHBSLd09
	 NyCoCQECZ3Ko6YgDK+EewwGJXj98Xd+O759oipcAwiQC6Kfhs4tGqybBEQJkUc6tC8
	 gGb+Cn+VMEqHEuc0t3iJATEIv7KKaD8rQg20C92t5CzYwQGyN71K0mZnVOpIi/JCEm
	 Ldkjky+GvfKoTDdQ9iSE4ZWxqLEDdfPDlRI4tfo9Ac3lq6+VkWQyom20kTcbg0YWlW
	 LE9XmhKx/VDfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 32/34] drm/amd/display: Increase sanitizer frame larger than limit when compile testing with clang
Date: Sun, 26 Jan 2025 09:53:08 -0500
Message-Id: <20250126145310.926311-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit e4479aecf6581af81bc0908575447878d2a07e01 ]

Commit 24909d9ec7c3 ("drm/amd/display: Overwriting dualDPP UBF values
before usage") added a new warning in dml2/display_mode_core.c when
building allmodconfig with clang:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6268:13: error: stack frame size (3128) exceeds limit (3072) in 'dml_prefetch_check' [-Werror,-Wframe-larger-than]
   6268 | static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
        |             ^

Commit be4e3509314a ("drm/amd/display: DML21 Reintegration For Various
Fixes") introduced one in dml2_core/dml2_core_dcn4_calcs.c with the same
configuration:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:7236:13: error: stack frame size (3256) exceeds limit (3072) in 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
   7236 | static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
        |             ^

In the case of the first warning, the stack usage was already at the
limit at the parent change, so the offending change was rather
innocuous. In the case of the second warning, there was a rather
dramatic increase in stack usage compared to the parent:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:7032:13: error: stack frame size (2696) exceeds limit (2048) in 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
   7032 | static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
        |             ^

This is an unfortunate interaction between an issue with stack slot
reuse in LLVM that gets exacerbated by sanitization (which gets enabled
with all{mod,yes}config) and function calls using a much higher number
of parameters than is typical in the kernel, necessitating passing most
of these values on the stack.

While it is possible that there should be source code changes to address
these warnings, this code is difficult to modify for various reasons, as
has been noted in other changes that have occurred for similar reasons,
such as commit 6740ec97bcdb ("drm/amd/display: Increase frame warning
limit with KASAN or KCSAN in dml2").

Increase the frame larger than limit when compile testing with clang and
the sanitizers enabled to avoid this breakage in all{mod,yes}config, as
they are commonly used and valuable testing targets. While it is not the
best to hide this issue, it is not really relevant when compile testing,
as the sanitizers are commonly stressful on optimizations and they are
only truly useful at runtime, which COMPILE_TEST states will not occur
with the current build.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412121748.chuX4sap-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index c4378e620cbf9..986a69c5bd4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -29,7 +29,11 @@ dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
+frame_warn_flag := -Wframe-larger-than=4096
+else
 frame_warn_flag := -Wframe-larger-than=3072
+endif
 else
 frame_warn_flag := -Wframe-larger-than=2048
 endif
-- 
2.39.5


