Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120876ADD4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjHAJdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjHAJdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D14EDF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CCC61510
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A1EC433C7;
        Tue,  1 Aug 2023 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882270;
        bh=u+a/YN5RSA6Dxd9P6Tjnv1mbNg9xAQykg2GEYGRJBCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkUFmCUwV8KVES013VBN0vA8S9HU/a5dDIiwtfEt/MhM4kY6/SNYj+cQ174uqwmia
         c0acmUUbRRZ7IWx/m04JMkLRrfZeiNNnU76MSUOTkWoNNEb8hgCREldUbM8TyyO9Ey
         RIVaDKufUP0YF7RtUn7Ywookx7QcvZBOnbpGJigQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Cruise Hung <cruise.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 045/228] drm/amd/display: Update correct DCN314 register header
Date:   Tue,  1 Aug 2023 11:18:23 +0200
Message-ID: <20230801091924.526950181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cruise Hung <cruise.hung@amd.com>

[ Upstream commit 268182606f26434c5d3ebd0e86efcb0418dec487 ]

[Why]
The register header for DCN314 is not correct.

[How]
Update correct DCN314 register header.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Cruise Hung <cruise.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cd2e31a9ab93 ("drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  2 +-
 .../drm/amd/display/dmub/src/dmub_dcn314.c    | 62 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn314.h    | 33 ++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  5 +-
 4 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h

diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 0589ad4778eea..caf095aca8f3f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -22,7 +22,7 @@
 
 DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
-DMUB += dmub_dcn31.o dmub_dcn315.o dmub_dcn316.o
+DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
new file mode 100644
index 0000000000000..48a06dbd9be78
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn314.h"
+
+#include "dcn/dcn_3_1_4_offset.h"
+#include "dcn/dcn_3_1_4_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs_dcn31
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+/* Registers. */
+
+const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
+#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
+	{
+		DMUB_DCN31_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+};
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
new file mode 100644
index 0000000000000..674267a2940e9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN314_H_
+#define _DMUB_DCN314_H_
+
+#include "dmub_dcn31.h"
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
+
+#endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 92c18bfb98b3b..6d76ce327d69f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -32,6 +32,7 @@
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
 #include "dmub_dcn31.h"
+#include "dmub_dcn314.h"
 #include "dmub_dcn315.h"
 #include "dmub_dcn316.h"
 #include "dmub_dcn32.h"
@@ -226,7 +227,9 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN315)
+		if (asic == DMUB_ASIC_DCN314)
+			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+		else if (asic == DMUB_ASIC_DCN315)
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
 		else if (asic == DMUB_ASIC_DCN316)
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-- 
2.39.2



