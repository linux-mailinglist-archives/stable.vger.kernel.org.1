Return-Path: <stable+bounces-34281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C62893EAB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB8B20D86
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB94596E;
	Mon,  1 Apr 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MMRWwz1h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E941CA8F;
	Mon,  1 Apr 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987593; cv=none; b=nXXR5MH8tWnliWmztcB7127kWJAr3OVUqBVwE9xcYWPC55FAONpT+E5JEeYZHgopXfThL+/wLql2Su8i8dEzG5n3uJlecu83nK1zBezsDsKO3qeaHWcrtO7Ic4JvcbSN3BDt7WZLZBxaLq+7CtiU+PXhM8+4gPZKnKrqYY7TeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987593; c=relaxed/simple;
	bh=yvh6xgcEWYij7aFFUxtgf4z0g3E0+u4KF/WWQTx3GNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jugK5gqEna8Djm77knPHCxw+w6Vml5vUzbhfbnzurN2V9NPzA1dK3JjAiS8P5RnHIQ8ZWuOMaOBccEGYEwojemmJRPERXhxRSe5Ee7jEiv9EYwfdWjLrPCy/QnpXWLnCTElllWDm1LxKUuqNQn7rzzZYIHCQZgpPqHhzEnw20CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MMRWwz1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D9C433F1;
	Mon,  1 Apr 2024 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987593;
	bh=yvh6xgcEWYij7aFFUxtgf4z0g3E0+u4KF/WWQTx3GNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMRWwz1h57Zx7HXcS0KotYSrueLpxnf37PP73C8Nn+b4lY5ijyPN4hK7R0pBWl3sL
	 1LoXZbAta3jSY54TWK4a+864wqnJlHqhY+lEJaUaTjU/aqRvekbWBprk6ohJqBwIK9
	 bDhSWh8cCNuUKi90Itt9owo6fDFfEP9QZ1SBtxCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.8 334/399] drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, mostly
Date: Mon,  1 Apr 2024 17:45:00 +0200
Message-ID: <20240401152559.147359228@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 18846627ef1210dcd55d65342b055ea97a46ffff upstream.

Reinstate commit 88b065943cb5 ("drm/i915/dsi: Do display on
sequence later on icl+"), for the most part. Turns out some
machines (eg. Chuwi Minibook X) really do need that updated order.
It is also the order the Windows driver uses.

However we can't just undo the revert since that would again
break Lenovo 82TQ. After staring at the VBT sequences for both
machines I've concluded that the Lenovo 82TQ sequences look
somewhat broken:
 - INIT_OTP is not present at all
 - what should be in INIT_OTP is found in DISPLAY_ON
 - what should be in DISPLAY_ON is found in BACKLIGHT_ON
   (along with the actual backlight stuff)

The Chuwi Minibook X on the other hand has a full complement
of sequences in its VBT.

So let's try to deal with the broken sequences in the
Lenovo 82TQ VBT by simply swapping the (non-existent)
INIT_OTP sequence with the DISPLAY_ON sequence. Thus we
execute DISPLAY_ON when intending to execute INIT_OTP,
and execute nothing at all when intending to execute
DISPLAY_ON. That should be 100% equivalent to the
revert, for such broken VBTs.

Cc: stable@vger.kernel.org
Fixes: 6992eb815d08 ("Revert "drm/i915/dsi: Do display on sequence later on icl+"")
References: https://gitlab.freedesktop.org/drm/intel/-/issues/10071
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10334
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240305083659.8396-1-ville.syrjala@linux.intel.com
Acked-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 94ae4612ea336bfc3c12b3fc68467c6711a4f39b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/icl_dsi.c    |    3 +-
 drivers/gpu/drm/i915/display/intel_bios.c |   43 +++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1155,7 +1155,6 @@ static void gen11_dsi_powerup_panel(stru
 	}
 
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
-	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
 	/* ensure all panel commands dispatched before enabling transcoder */
 	wait_for_cmds_dispatched_to_panel(encoder);
@@ -1256,6 +1255,8 @@ static void gen11_dsi_enable(struct inte
 	/* step6d: enable dsi transcoder */
 	gen11_dsi_enable_transcoder(encoder);
 
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
+
 	/* step7: enable backlight */
 	intel_backlight_enable(crtc_state, conn_state);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1952,16 +1952,12 @@ static int get_init_otp_deassert_fragmen
  * these devices we split the init OTP sequence into a deassert sequence and
  * the actual init OTP part.
  */
-static void fixup_mipi_sequences(struct drm_i915_private *i915,
-				 struct intel_panel *panel)
+static void vlv_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
 {
 	u8 *init_otp;
 	int len;
 
-	/* Limit this to VLV for now. */
-	if (!IS_VALLEYVIEW(i915))
-		return;
-
 	/* Limit this to v1 vid-mode sequences */
 	if (panel->vbt.dsi.config->is_cmd_mode ||
 	    panel->vbt.dsi.seq_version != 1)
@@ -1997,6 +1993,41 @@ static void fixup_mipi_sequences(struct
 	panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] = init_otp + len - 1;
 }
 
+/*
+ * Some machines (eg. Lenovo 82TQ) appear to have broken
+ * VBT sequences:
+ * - INIT_OTP is not present at all
+ * - what should be in INIT_OTP is in DISPLAY_ON
+ * - what should be in DISPLAY_ON is in BACKLIGHT_ON
+ *   (along with the actual backlight stuff)
+ *
+ * To make those work we simply swap DISPLAY_ON and INIT_OTP.
+ *
+ * TODO: Do we need to limit this to specific machines,
+ *       or examine the contents of the sequences to
+ *       avoid false positives?
+ */
+static void icl_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
+{
+	if (!panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] &&
+	    panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]) {
+		drm_dbg_kms(&i915->drm, "Broken VBT: Swapping INIT_OTP and DISPLAY_ON sequences\n");
+
+		swap(panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP],
+		     panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]);
+	}
+}
+
+static void fixup_mipi_sequences(struct drm_i915_private *i915,
+				 struct intel_panel *panel)
+{
+	if (DISPLAY_VER(i915) >= 11)
+		icl_fixup_mipi_sequences(i915, panel);
+	else if (IS_VALLEYVIEW(i915))
+		vlv_fixup_mipi_sequences(i915, panel);
+}
+
 static void
 parse_mipi_sequence(struct drm_i915_private *i915,
 		    struct intel_panel *panel)



