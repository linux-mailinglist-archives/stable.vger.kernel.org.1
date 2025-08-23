Return-Path: <stable+bounces-172562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A7B3277E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A296C17D601
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B91F4199;
	Sat, 23 Aug 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcYa1UvP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A61DE4C4
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935544; cv=none; b=Rllub4vDLnMdF+J7fHju7boFZatKo9ipn+M1JDU8R+R0QMu+E7jXz2rtB5LuFtZse9v7x01E4/qsnRyXgCCIA1ZTlFFAtMWhObvXwEs3EMiGPrL4K5cC6aoRLsNGykgPT6Bp8ABQPEvrmfK3ypCXyZzac65WPEb/ZkBUTKLIZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935544; c=relaxed/simple;
	bh=ycYX4WFm0EBp5I59sUGt4x8yVLOytOtux2Dwy1dIuB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NajWiSZKEqUvWJVbNtrfQ0MkMU5v5DRUc51Fa4sGw62DAurkcjSKjxPLTsd+1QnJrC88pbxxQlbhO+8c/6e0Ij1t51eNh2e/tSD39D/UQEntiqiX445P6BWVWwm8139gjv+2qThN387qglnxFMmgJdPW7U3eiqaJ5JVdQipvdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcYa1UvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6AC4CEE7;
	Sat, 23 Aug 2025 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755935543;
	bh=ycYX4WFm0EBp5I59sUGt4x8yVLOytOtux2Dwy1dIuB4=;
	h=Subject:To:Cc:From:Date:From;
	b=hcYa1UvPlkiY4RQ5uPpT/cZyRaqyDsrhchTaa9TuE9t8wH2tpaRpAIdusD0Kd20Tw
	 GhrCE4ooxb8nylLaNlzDk4o7DbQ369Qu4oL/EA1LDj2BWggZtWGM0Lx2NH1OqQgXoz
	 YXCwEDPvtTSw61QuzS3uunEIVSs8k/5UUCxRjqAE=
Subject: FAILED: patch "[PATCH] drm/i915/lnl+/tc: Fix max lane count HW readout" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,charlton.lin@intel.com,khaled.almahallawy@intel.com,mika.kahola@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 09:52:20 +0200
Message-ID: <2025082320-stooge-trekker-dc42@gregkh>
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
git cherry-pick -x c87514a0bb0a64507412a2d98264060dc0c1562a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082320-stooge-trekker-dc42@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c87514a0bb0a64507412a2d98264060dc0c1562a Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 11 Aug 2025 11:01:50 +0300
Subject: [PATCH] drm/i915/lnl+/tc: Fix max lane count HW readout

On LNL+ for a disconnected sink the pin assignment value gets cleared by
the HW/FW as soon as the sink gets disconnected, even if the PHY
ownership got acquired already by the BIOS/driver (and hence the PHY
itself is still connected and used by the display). During HW readout
this can result in detecting the PHY's max lane count as 0 - matching
the above cleared aka NONE pin assignment HW state. For a connected PHY
the driver in general (outside of intel_tc.c) expects the max lane count
value to be valid for the video mode enabled on the corresponding output
(1, 2 or 4). Ensure this by setting the max lane count to 4 in this
case. Note, that it doesn't matter if this lane count happened to be
more than the max lane count with which the PHY got connected and
enabled, since the only thing the driver can do with such an output -
where the DP-alt sink is disconnected - is to disable the output.

v2: Rebased on change reading out the pin configuration only if the PHY
    is connected.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-4-imre.deak@intel.com
(cherry picked from commit 33cf70bc0fe760224f892bc1854a33665f27d482)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 34435c4fc280..3f9842040bb0 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -23,6 +23,7 @@
 #include "intel_modeset_lock.h"
 #include "intel_tc.h"
 
+#define DP_PIN_ASSIGNMENT_NONE	0x0
 #define DP_PIN_ASSIGNMENT_C	0x3
 #define DP_PIN_ASSIGNMENT_D	0x4
 #define DP_PIN_ASSIGNMENT_E	0x5
@@ -308,6 +309,8 @@ static int lnl_tc_port_get_max_lane_count(struct intel_digital_port *dig_port)
 		REG_FIELD_GET(TCSS_DDI_STATUS_PIN_ASSIGNMENT_MASK, val);
 
 	switch (pin_assignment) {
+	case DP_PIN_ASSIGNMENT_NONE:
+		return 0;
 	default:
 		MISSING_CASE(pin_assignment);
 		fallthrough;
@@ -1159,6 +1162,12 @@ static void xelpdp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 		tc->lock_wakeref = tc_cold_block(tc);
 
 		read_pin_configuration(tc);
+		/*
+		 * Set a valid lane count value for a DP-alt sink which got
+		 * disconnected. The driver can only disable the output on this PHY.
+		 */
+		if (tc->max_lane_count == 0)
+			tc->max_lane_count = 4;
 	}
 
 	drm_WARN_ON(display->drm,


