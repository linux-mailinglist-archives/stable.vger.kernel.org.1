Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD14D6FAADB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEHLHV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjEHLGv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5933D7D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A631562A82
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7EC433EF;
        Mon,  8 May 2023 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543959;
        bh=+EQLDVqzIt5FoDrH2KzsXY2W7NDxek1Eoy+ySahyZB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFjpVHC0K3fa+H+lP5myKXd3Ziz2azmKGTpGcdNo6oZQKwPB1okvpZbggAAG55Zm1
         d28MsaLW4590mxapXpP+Hj5dS4itX7wsQwLsTSZh+89ZZIfUDYWPsCAROd3US2S7BX
         9mZMW7Dz887yzcIC3Miu6IW50ycdwQNNjAGJyx6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [PATCH 6.3 257/694] drm/i915/pxp: limit drm-errors or warning on firmware API failures
Date:   Mon,  8 May 2023 11:41:32 +0200
Message-Id: <20230508094440.637897569@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Previn <alan.previn.teres.alexis@intel.com>

[ Upstream commit 69e6dd149212cdd681201352a79e6634665004e8 ]

MESA driver is creating protected context on every driver handle
creation to query caps bits for app. So when running CI tests,
they are observing hundreds of drm_errors when enabling PXP
in .config but using SOC fusing or BIOS configuration that cannot
support PXP sessions.

The fixes tag referenced below was to resolve a related issue
where we wanted to silence error messages, but that case was due
to outdated IFWI (firmware) that definitely needed an upgrade and
was, at that point, considered a one-off case as opposed to today's
realization that default CI was enabling PXP in kernel config for
all testing.

So with this patch, let's strike a balance between issues that is
critical but are root-caused from HW/platform gaps (louder drm-warn
but just ONCE) vs other cases where it could also come from session
state machine (which cannot be a WARN_ONCE since it can be triggered
due to runtime operation events).

Let's use helpers for these so as more functions are added in future
features / HW (or as FW designers continue to bless upstreaming of
the error codes and meanings), we only need to update the helpers.

NOTE: Don't completely remove FW errors (via drm_debug) or else cusomer
apps that really needs to know that content protection failed won't
be aware of it.

v2: - Add fixes tag (Trvtko)
v3: - Break multi-line drm_dbg strings into separate drm_dbg (Daniele)
    - Fix couple of typecasting nits (Daniele)
v4: - Unsuccessful PXP FW cmd due to platform configuration shouldn't
      use drm_WARN_once (Tvrtko), Switched to use drm_info_once.
v5: - Added "reported-and-tested" by Eero.

Reported-and-tested-by: Eero Tamminen <eero.t.tamminen@intel.com>
Fixes: b762787bf767 ("drm/i915/pxp: Use drm_dbg if arb session failed due to fw version")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230323184156.4140659-1-alan.previn.teres.alexis@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../i915/pxp/intel_pxp_cmd_interface_cmn.h    |  3 +
 drivers/gpu/drm/i915/pxp/intel_pxp_session.c  |  2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_tee.c      | 77 +++++++++++++++----
 3 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_cmd_interface_cmn.h b/drivers/gpu/drm/i915/pxp/intel_pxp_cmd_interface_cmn.h
index ae9b151b7cb77..6f6541d5e49a6 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_cmd_interface_cmn.h
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_cmd_interface_cmn.h
@@ -18,6 +18,9 @@
 enum pxp_status {
 	PXP_STATUS_SUCCESS = 0x0,
 	PXP_STATUS_ERROR_API_VERSION = 0x1002,
+	PXP_STATUS_NOT_READY = 0x100e,
+	PXP_STATUS_PLATFCONFIG_KF1_NOVERIF = 0x101a,
+	PXP_STATUS_PLATFCONFIG_KF1_BAD = 0x101f,
 	PXP_STATUS_OP_NOT_PERMITTED = 0x4013
 };
 
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
index 74ed7e16e4811..48fa46091984b 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
@@ -74,7 +74,7 @@ static int pxp_create_arb_session(struct intel_pxp *pxp)
 
 	ret = pxp_wait_for_session_state(pxp, ARB_SESSION, true);
 	if (ret) {
-		drm_err(&gt->i915->drm, "arb session failed to go in play\n");
+		drm_dbg(&gt->i915->drm, "arb session failed to go in play\n");
 		return ret;
 	}
 	drm_dbg(&gt->i915->drm, "PXP ARB session is alive\n");
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
index 99bc8b1770162..e9322ec1e0027 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
@@ -19,6 +19,37 @@
 #include "intel_pxp_tee.h"
 #include "intel_pxp_types.h"
 
+static bool
+is_fw_err_platform_config(u32 type)
+{
+	switch (type) {
+	case PXP_STATUS_ERROR_API_VERSION:
+	case PXP_STATUS_PLATFCONFIG_KF1_NOVERIF:
+	case PXP_STATUS_PLATFCONFIG_KF1_BAD:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static const char *
+fw_err_to_string(u32 type)
+{
+	switch (type) {
+	case PXP_STATUS_ERROR_API_VERSION:
+		return "ERR_API_VERSION";
+	case PXP_STATUS_NOT_READY:
+		return "ERR_NOT_READY";
+	case PXP_STATUS_PLATFCONFIG_KF1_NOVERIF:
+	case PXP_STATUS_PLATFCONFIG_KF1_BAD:
+		return "ERR_PLATFORM_CONFIG";
+	default:
+		break;
+	}
+	return NULL;
+}
+
 static int intel_pxp_tee_io_message(struct intel_pxp *pxp,
 				    void *msg_in, u32 msg_in_size,
 				    void *msg_out, u32 msg_out_max_size,
@@ -296,15 +327,22 @@ int intel_pxp_tee_cmd_create_arb_session(struct intel_pxp *pxp,
 				       &msg_out, sizeof(msg_out),
 				       NULL);
 
-	if (ret)
-		drm_err(&i915->drm, "Failed to send tee msg ret=[%d]\n", ret);
-	else if (msg_out.header.status == PXP_STATUS_ERROR_API_VERSION)
-		drm_dbg(&i915->drm, "PXP firmware version unsupported, requested: "
-			"CMD-ID-[0x%08x] on API-Ver-[0x%08x]\n",
-			msg_in.header.command_id, msg_in.header.api_version);
-	else if (msg_out.header.status != 0x0)
-		drm_warn(&i915->drm, "PXP firmware failed arb session init request ret=[0x%08x]\n",
-			 msg_out.header.status);
+	if (ret) {
+		drm_err(&i915->drm, "Failed to send tee msg init arb session, ret=[%d]\n", ret);
+	} else if (msg_out.header.status != 0) {
+		if (is_fw_err_platform_config(msg_out.header.status)) {
+			drm_info_once(&i915->drm,
+				      "PXP init-arb-session-%d failed due to BIOS/SOC:0x%08x:%s\n",
+				      arb_session_id, msg_out.header.status,
+				      fw_err_to_string(msg_out.header.status));
+		} else {
+			drm_dbg(&i915->drm, "PXP init-arb-session--%d failed 0x%08x:%st:\n",
+				arb_session_id, msg_out.header.status,
+				fw_err_to_string(msg_out.header.status));
+			drm_dbg(&i915->drm, "     cmd-detail: ID=[0x%08x],API-Ver-[0x%08x]\n",
+				msg_in.header.command_id, msg_in.header.api_version);
+		}
+	}
 
 	return ret;
 }
@@ -336,10 +374,21 @@ void intel_pxp_tee_end_arb_fw_session(struct intel_pxp *pxp, u32 session_id)
 	if ((ret || msg_out.header.status != 0x0) && ++trials < 3)
 		goto try_again;
 
-	if (ret)
-		drm_err(&i915->drm, "Failed to send tee msg for inv-stream-key-%d, ret=[%d]\n",
+	if (ret) {
+		drm_err(&i915->drm, "Failed to send tee msg for inv-stream-key-%u, ret=[%d]\n",
 			session_id, ret);
-	else if (msg_out.header.status != 0x0)
-		drm_warn(&i915->drm, "PXP firmware failed inv-stream-key-%d with status 0x%08x\n",
-			 session_id, msg_out.header.status);
+	} else if (msg_out.header.status != 0) {
+		if (is_fw_err_platform_config(msg_out.header.status)) {
+			drm_info_once(&i915->drm,
+				      "PXP inv-stream-key-%u failed due to BIOS/SOC :0x%08x:%s\n",
+				      session_id, msg_out.header.status,
+				      fw_err_to_string(msg_out.header.status));
+		} else {
+			drm_dbg(&i915->drm, "PXP inv-stream-key-%u failed 0x%08x:%s:\n",
+				session_id, msg_out.header.status,
+				fw_err_to_string(msg_out.header.status));
+			drm_dbg(&i915->drm, "     cmd-detail: ID=[0x%08x],API-Ver-[0x%08x]\n",
+				msg_in.header.command_id, msg_in.header.api_version);
+		}
+	}
 }
-- 
2.39.2



