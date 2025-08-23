Return-Path: <stable+bounces-172564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC42B3277B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011C87BDDEA
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13E20296C;
	Sat, 23 Aug 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BsTis9wO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36427472
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935570; cv=none; b=hR8zTTC+w8+G9BPLhO916VNYtq7nlyD6FPlsfRAskRQ6Gen2xBTvnAqqhwUpNZGep44s9nHULCb9ANhl/5lM2odEm7yeBd+Y4J/7nWMlRuyCAHdGCfYG50d/tVaeLJK/mpLd47BdFsghwpWdDrJgYVy9l6mwi9z6hpJTIk94Y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935570; c=relaxed/simple;
	bh=SrvHnULy9qZs6YrDiwAZuds3Yh7Ibrd/vBGOn2vAGpw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YMOov5AlTzVvIb6lt+EwMbfHCli0mY4ThHKCuR2KFE4MdPbkm3zhQHsEk09h5thOCx7ff2/9OWRzrlly4+H86ucIfiuD51LdO0sPrj/03uS2LXPxDzaDxJhddmxpvCD1Sx/OxN41UjNFAn4Bg2pYPu60F1D6HPvGi1D4XJ2VJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BsTis9wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F89C4CEE7;
	Sat, 23 Aug 2025 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755935569;
	bh=SrvHnULy9qZs6YrDiwAZuds3Yh7Ibrd/vBGOn2vAGpw=;
	h=Subject:To:Cc:From:Date:From;
	b=BsTis9wOt+OQNq6ukblYPb00HwbVL/5k89tfik6pFAgYzRVFk/B0RF3X2vnuV+r9e
	 mMGhKyunb4HCRck7BCM/UFaXfbdsKYRBI8LEllrJTzWQFsuZD4pA7l9L+T3HAvR2hB
	 jN+c+LLMIWqMNovBiyOen+186d5mpuLEcaMIjsVQ=
Subject: FAILED: patch "[PATCH] drm/i915/icl+/tc: Convert AUX powered WARN to a debug message" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,charlton.lin@intel.com,khaled.almahallawy@intel.com,mika.kahola@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 09:52:47 +0200
Message-ID: <2025082347-unstuck-spiral-493c@gregkh>
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
git cherry-pick -x d7fa5754e83cd36c4327eb2d806064e598a72ff6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082347-unstuck-spiral-493c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7fa5754e83cd36c4327eb2d806064e598a72ff6 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 11 Aug 2025 11:01:52 +0300
Subject: [PATCH] drm/i915/icl+/tc: Convert AUX powered WARN to a debug message

The BIOS can leave the AUX power well enabled on an output, even if this
isn't required (on platforms where the AUX power is only needed for an
AUX access). This was observed at least on PTL. To avoid the WARN which
would be triggered by this during the HW readout, convert the WARN to a
debug message.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-6-imre.deak@intel.com
(cherry picked from commit 6cb52cba474b2bec1a3018d3dbf75292059a29a1)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 6a2442a0649e..668ef139391b 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1498,11 +1498,11 @@ static void intel_tc_port_reset_mode(struct intel_tc_port *tc,
 	intel_display_power_flush_work(display);
 	if (!intel_tc_cold_requires_aux_pw(dig_port)) {
 		enum intel_display_power_domain aux_domain;
-		bool aux_powered;
 
 		aux_domain = intel_aux_power_domain(dig_port);
-		aux_powered = intel_display_power_is_enabled(display, aux_domain);
-		drm_WARN_ON(display->drm, aux_powered);
+		if (intel_display_power_is_enabled(display, aux_domain))
+			drm_dbg_kms(display->drm, "Port %s: AUX unexpectedly powered\n",
+				    tc->port_name);
 	}
 
 	tc_phy_disconnect(tc);


