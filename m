Return-Path: <stable+bounces-172560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA268B3277C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389BC176342
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519922FAF8;
	Sat, 23 Aug 2025 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSv4Ifsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1122F762
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935511; cv=none; b=PpPiNR8cEFas0CzHLrJ7oYxA0gsbroY4yH88NUX+MNfUMXhKItFDQQivMNHsKIK2skuz8oFPxX4sIyHX+hnFHiEbP6PWkWxv8qcSsZlV2nmMW6tAP583U9EG3TyvMr8f1fbkha6kC2VcPFkEgODaYVS9PKGMy6OKYpsOICi79bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935511; c=relaxed/simple;
	bh=SBlhUaMvxw3+gM6W7Eb17wURWygBgsTaQBPUUBWV7lY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iyDDUzi9oHiGcaBLtfa4fVvyI6wWY2Ps1bjtDmaGWAPJUam4IBRP2dXH2aeVMFNT5WpaoT5rQM7PdsH9oYekAwAdG4GbPxnaKcvSavYG1RJpvDD7jtqgcVhziPkkqtWRcGOjffKln92t+bns/RdPVj6umb0DgNssUgi7AEPHIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSv4Ifsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A39C4CEF1;
	Sat, 23 Aug 2025 07:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755935511;
	bh=SBlhUaMvxw3+gM6W7Eb17wURWygBgsTaQBPUUBWV7lY=;
	h=Subject:To:Cc:From:Date:From;
	b=DSv4IfsgQ10rILdU5sVRmXBJ7FLRov7Q4Kcvri8JL9VGUmiGPLnUub54HnISdhTv/
	 tKQaF5s3vvanYJKFlc979QHBRKabcLTgtM9QlPUsQjfeX7A+TIYF7g74xoj7xkpEEi
	 BrHcPPfafc3fo1CJVzHZtLj6saZfLUDZNZE5OLuM=
Subject: FAILED: patch "[PATCH] drm/i915/lnl+/tc: Fix handling of an enabled/disconnected" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,charlton.lin@intel.com,jani.nikula@intel.com,khaled.almahallawy@intel.com,luciano.coelho@intel.com,mika.kahola@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 09:51:47 +0200
Message-ID: <2025082347-portside-bulb-25f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f52d6aa98379842fc255d93282655566f2114e0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082347-portside-bulb-25f5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f52d6aa98379842fc255d93282655566f2114e0c Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 11 Aug 2025 11:01:48 +0300
Subject: [PATCH] drm/i915/lnl+/tc: Fix handling of an enabled/disconnected
 dp-alt sink

The TypeC PHY HW readout during driver loading and system resume
determines which TypeC mode the PHY is in (legacy/DP-alt/TBT-alt) and
whether the PHY is connected, based on the PHY's Owned and Ready flags.
For the PHY to be in DP-alt or legacy mode and for the PHY to be in the
connected state in these modes, both the Owned (set by the BIOS/driver)
and the Ready (set by the HW) flags should be set.

On ICL-MTL the HW kept the PHY's Ready flag set after the driver
connected the PHY by acquiring the PHY ownership (by setting the Owned
flag), until the driver disconnected the PHY by releasing the PHY
ownership (by clearing the Owned flag). On LNL+ this has changed, in
that the HW clears the Ready flag as soon as the sink gets disconnected,
even if the PHY ownership was acquired already and hence the PHY is
being used by the display.

When inheriting the HW state from BIOS for a PHY connected in DP-alt
mode on which the sink got disconnected - i.e. in a case where the sink
was connected while BIOS/GOP was running and so the sink got enabled
connecting the PHY, but the user disconnected the sink by the time the
driver loaded - the PHY Owned but not Ready state must be accounted for
on LNL+ according to the above. Do that by assuming on LNL+ that the PHY
is connected in DP-alt mode whenever the PHY Owned flag is set,
regardless of the PHY Ready flag.

This fixes a problem on LNL+, where the PHY TypeC mode / connected state
was detected incorrectly for a DP-alt sink, which got connected and then
disconnected by the user in the above way.

v2: Rename tc_phy_in_legacy_or_dp_alt_mode() to tc_phy_owned_by_display().
    (Luca, Jani)

Cc: Jani Nikula <jani.nikula@intel.com>
Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
[Imre: Add one-liner function documentation for tc_phy_owned_by_display()]
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-2-imre.deak@intel.com
(cherry picked from commit 89f4b196ee4b056e0e8c179b247b29d4a71a4e7e)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 3bc57579fe53..8208539bfe66 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1226,14 +1226,19 @@ static void tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc->phy_ops->get_hw_state(tc);
 }
 
-static bool tc_phy_is_ready_and_owned(struct intel_tc_port *tc,
-				      bool phy_is_ready, bool phy_is_owned)
+/* Is the PHY owned by display i.e. is it in legacy or DP-alt mode? */
+static bool tc_phy_owned_by_display(struct intel_tc_port *tc,
+				    bool phy_is_ready, bool phy_is_owned)
 {
 	struct intel_display *display = to_intel_display(tc->dig_port);
 
-	drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
+	if (DISPLAY_VER(display) < 20) {
+		drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
 
-	return phy_is_ready && phy_is_owned;
+		return phy_is_ready && phy_is_owned;
+	} else {
+		return phy_is_owned;
+	}
 }
 
 static bool tc_phy_is_connected(struct intel_tc_port *tc,
@@ -1244,7 +1249,7 @@ static bool tc_phy_is_connected(struct intel_tc_port *tc,
 	bool phy_is_owned = tc_phy_is_owned(tc);
 	bool is_connected;
 
-	if (tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned))
+	if (tc_phy_owned_by_display(tc, phy_is_ready, phy_is_owned))
 		is_connected = port_pll_type == ICL_PORT_DPLL_MG_PHY;
 	else
 		is_connected = port_pll_type == ICL_PORT_DPLL_DEFAULT;
@@ -1352,7 +1357,7 @@ tc_phy_get_current_mode(struct intel_tc_port *tc)
 	phy_is_ready = tc_phy_is_ready(tc);
 	phy_is_owned = tc_phy_is_owned(tc);
 
-	if (!tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned)) {
+	if (!tc_phy_owned_by_display(tc, phy_is_ready, phy_is_owned)) {
 		mode = get_tc_mode_in_phy_not_owned_state(tc, live_mode);
 	} else {
 		drm_WARN_ON(display->drm, live_mode == TC_PORT_TBT_ALT);


