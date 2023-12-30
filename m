Return-Path: <stable+bounces-8865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CE820538
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C8A2812F7
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E08483;
	Sat, 30 Dec 2023 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5rnBH1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720479DE;
	Sat, 30 Dec 2023 12:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938D0C433C7;
	Sat, 30 Dec 2023 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937963;
	bh=jjjHdzLSLEf4gyPj9vmT4t4Fqh9eB5/YqJM3GLetJeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5rnBH1TMzyTEW1toKBCBB/j0xe897kFXQ+0lYKSG4ayWBGHGFYvO3O05XaN06qni
	 9W5VWAlRbaicSWJkNrDGsZz9vMBg1oWbIbCt9fB0bgeRp+HObHYGGsuLiMN0cfED12
	 bQLP6UbvcTOG+jX93W7Z8UX1Qf8fetbbjFPN7OQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.6 130/156] drm/i915/dmc: Dont enable any pipe DMC events
Date: Sat, 30 Dec 2023 11:59:44 +0000
Message-ID: <20231230115816.610662108@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 49e0a85ec3441edc6c77aa40206d6e5ee4597efc upstream.

The pipe DMC seems to be making a mess of things in ADL. Various weird
symptoms have been observed such as missing vblank irqs, typicalle
happening when using multiple displays.

Keep all pipe DMC event handlers disabled until needed (which is never
atm). This is also what Windows does on ADL+.

We can also drop DG2 from disable_all_flip_queue_events() since
on DG2 the pipe DMC is the one that handles the flip queue events.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8685
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231211213750.27109-2-ville.syrjala@linux.intel.com
Reviewed-by: Imre Deak <imre.deak@intel.com>
(cherry picked from commit 648d7be8ecf47b0556e32550145c70db153b16fb)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dmc.c |   43 +++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -389,7 +389,7 @@ disable_all_flip_queue_events(struct drm
 	enum intel_dmc_id dmc_id;
 
 	/* TODO: check if the following applies to all D13+ platforms. */
-	if (!IS_DG2(i915) && !IS_TIGERLAKE(i915))
+	if (!IS_TIGERLAKE(i915))
 		return;
 
 	for_each_dmc_id(dmc_id) {
@@ -493,6 +493,45 @@ void intel_dmc_disable_pipe(struct drm_i
 		intel_de_rmw(i915, PIPEDMC_CONTROL(pipe), PIPEDMC_ENABLE, 0);
 }
 
+static bool is_dmc_evt_ctl_reg(struct drm_i915_private *i915,
+			       enum intel_dmc_id dmc_id, i915_reg_t reg)
+{
+	u32 offset = i915_mmio_reg_offset(reg);
+	u32 start = i915_mmio_reg_offset(DMC_EVT_CTL(i915, dmc_id, 0));
+	u32 end = i915_mmio_reg_offset(DMC_EVT_CTL(i915, dmc_id, DMC_EVENT_HANDLER_COUNT_GEN12));
+
+	return offset >= start && offset < end;
+}
+
+static bool disable_dmc_evt(struct drm_i915_private *i915,
+			    enum intel_dmc_id dmc_id,
+			    i915_reg_t reg, u32 data)
+{
+	if (!is_dmc_evt_ctl_reg(i915, dmc_id, reg))
+		return false;
+
+	/* keep all pipe DMC events disabled by default */
+	if (dmc_id != DMC_FW_MAIN)
+		return true;
+
+	return false;
+}
+
+static u32 dmc_mmiodata(struct drm_i915_private *i915,
+			struct intel_dmc *dmc,
+			enum intel_dmc_id dmc_id, int i)
+{
+	if (disable_dmc_evt(i915, dmc_id,
+			    dmc->dmc_info[dmc_id].mmioaddr[i],
+			    dmc->dmc_info[dmc_id].mmiodata[i]))
+		return REG_FIELD_PREP(DMC_EVT_CTL_TYPE_MASK,
+				      DMC_EVT_CTL_TYPE_EDGE_0_1) |
+			REG_FIELD_PREP(DMC_EVT_CTL_EVENT_ID_MASK,
+				       DMC_EVT_CTL_EVENT_ID_FALSE);
+	else
+		return dmc->dmc_info[dmc_id].mmiodata[i];
+}
+
 /**
  * intel_dmc_load_program() - write the firmware from memory to register.
  * @i915: i915 drm device.
@@ -532,7 +571,7 @@ void intel_dmc_load_program(struct drm_i
 	for_each_dmc_id(dmc_id) {
 		for (i = 0; i < dmc->dmc_info[dmc_id].mmio_count; i++) {
 			intel_de_write(i915, dmc->dmc_info[dmc_id].mmioaddr[i],
-				       dmc->dmc_info[dmc_id].mmiodata[i]);
+				       dmc_mmiodata(i915, dmc, dmc_id, i));
 		}
 	}
 



