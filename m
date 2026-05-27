Return-Path: <stable+bounces-254606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBKOD0kEF2qz0wcAu9opvQ
	(envelope-from <stable+bounces-254606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:48:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BD5E62B1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3666E304E298
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BBE400E19;
	Wed, 27 May 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dG5zVd8F"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E37419B
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893126; cv=none; b=S42y7iL4pX05Vo/VLytmIXOg8rPLFJ0FDNvxfqB85rnhK9vGwsi+2RHbjFWmZLz3pEdBYztJWkOq0fgSI7bYbCTQriTNnsb5C35oaQDxCoI7ttaOX7zklVUR/aq4F8RYLlrsRX51+ZZt4RQOHMP3t33KQZYnekB20jVYZ+vOC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893126; c=relaxed/simple;
	bh=XX8GMsC96hadNSsbDV9d/4MKMd/HlvPjqoVR74Gpw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soxS3WwodaZpdQyv7Vghap9Wd+hHLGz7PVc0rTZsY41kpHKQenzdYVVzXtzVUYZTiCAqj7lnKEB1aF/MuFuFnBybWkAE8Jupbun7iA1iCm2A13NNHUCYu3AbvvJ4PSIv8MhXp4Tg8wPtditT7ZskrddX9mv1wq+tb4FCkJn72gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dG5zVd8F; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779893125;
	bh=8ZVMgWzTv1EuKhyLQdS7LYffrWhyz9g/6oHzSX4cx/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dG5zVd8FBZgi6FvsVoGua4AH9l7zxjEuyX504artV99LQlmZctesbHB+zOjcHv9Qg
	 MQRFMOktaDuvlhav8bQjEGf0A4Ja3teT4zC6nnCP9sFQA0RkxKJHwLllCzVfjCb+6v
	 91ux/eApsNtOjNLlAOhBTyLjy+EVxNc3AO6/ulls=
Received: from stargazer (unknown [IPv6:2409:8a4c:e1b:e231:5a6e:b99e:242d:222b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C27FC65A96;
	Wed, 27 May 2026 10:45:21 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y 5/8] drm/amd/display: Move FPU Guards From DML To DC - Part 3
Date: Wed, 27 May 2026 22:44:25 +0800
Message-ID: <20260527144428.1095001-6-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254606-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[xry111.site:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: E55BD5E62B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[ Upstream commit 32c1c35b6d8bd8b7ea9ab3d1454b56b605f17dd1 ]

[Why]
FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
can manipulates floats. To do this properly, the FPU guards must be used
in a file that is not compiled as a FPU unit. If the guards are used in
a file that is a FPU unit, other sections in the file that aren't guarded
may be end up being compiled to use FPU operations.

[How]
Added DC_FP_START and DC_FP_END to DC functions that call DML functions
using FPU.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile              | 1 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c | 1 +
 .../gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c | 4 +---
 .../gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c        | 6 +++++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index a094cfa78260..145ff97ed560 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -85,6 +85,7 @@ AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
 
+
 DML21 := src/dml2_top/dml2_top_interfaces.o
 DML21 += src/dml2_top/dml2_top_soc15.o
 DML21 += src/dml2_core/dml2_core_dcn4.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 1a98578f223c..7398f8b69adb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -38,6 +38,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
 	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming)));
+
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index d5885bbd14c4..f3abfdbe6805 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 //
-// Copyright 2024 Advanced Micro Devices, Inc.
+// Copyright 2026 Advanced Micro Devices, Inc.
 
 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -377,5 +377,3 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 	}
 }
-
-
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
index 2972c6eed21a..e5d9a456645f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 //
-// Copyright 2024 Advanced Micro Devices, Inc.
+// Copyright 2026 Advanced Micro Devices, Inc.
 
 #ifndef _DML21_WRAPPER_FPU_H_
 #define _DML21_WRAPPER_FPU_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index 9215e38343ba..f4d45875d0be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -13,6 +13,10 @@
 
 #include "dc_fpu.h"
 
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !DC_RUN_WITH_PREEMPTION_ENABLED
+
 struct dml2_context *dml2_allocate_memory(void)
 {
 	struct dml2_context *dml2;
@@ -20,7 +24,6 @@ struct dml2_context *dml2_allocate_memory(void)
 	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 = vzalloc(sizeof(struct dml2_context)));
 	return dml2;
 }
-
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2,
 	enum dc_validate_mode validate_mode)
 {
@@ -84,6 +87,7 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
+
 }
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
-- 
2.54.0


