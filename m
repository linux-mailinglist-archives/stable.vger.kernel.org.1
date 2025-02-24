Return-Path: <stable+bounces-119187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7616BA424B5
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01F319E05D1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9E24EF8F;
	Mon, 24 Feb 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nC0hoJtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A524EF8E;
	Mon, 24 Feb 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408616; cv=none; b=PHzPIDDGqQxgj259Nf550R7DcPXroj4fr9uE62QNKjHWOfOx4C4d6W7dLYr/7sLkPDc0hI2bN3riT/NTvBL4cCa/Jj89wfF7BlNosOh1f0NMBRhvWiCuUDOqRDKuLG6P01IdaFv8erBZRjKV21GDgXPcwDKGMyWnyK4NTSXamng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408616; c=relaxed/simple;
	bh=ZKrC+dpOB15uDcIo/Sqs1/g9gvJ+DNAPckzeSwpuAaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koQOUz+QR4PvZ0TmlN07eUzNIIM6+0NhUyBldjzOSYQ96NOvvuZ6e0NV30vpx11zTfRY8uXrT/Rh7v6cUhMcQfvrJDBE3CwydMnvYW+ujegWJU2ZDqcHOiZS6L721Q9YiN2E+uPT97rsQjZI7YiGPol4rDum2CIBEfnQWuXCgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nC0hoJtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDD3C4CEE8;
	Mon, 24 Feb 2025 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408616;
	bh=ZKrC+dpOB15uDcIo/Sqs1/g9gvJ+DNAPckzeSwpuAaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nC0hoJtFCJ8OihQJhu0pTc+U9jQBb5KtSC4W18tPdaLzyBaamuWZA1YxQxe+4A1HY
	 iMZNg3YUTH4lw1nEDxzcFXHicuBmdQABYpeBe+KUmSGIlz6DRUcbrtG7y3Btq49Pv4
	 wO6ZbShOPQ2+TGUKiBU0Fk8aXNo1sHfHmxggxJ9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jani Nikula <jani.nikula@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 109/154] drm/i915/dp: Fix error handling during 128b/132b link training
Date: Mon, 24 Feb 2025 15:35:08 +0100
Message-ID: <20250224142611.322880742@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit b9275eabe31e6679ae12c46a4a0a18d622db4570 upstream.

At the end of a 128b/132b link training sequence, the HW expects the
transcoder training pattern to be set to TPS2 and from that to normal
mode (disabling the training pattern). Transitioning from TPS1 directly
to normal mode leaves the transcoder in a stuck state, resulting in
page-flip timeouts later in the modeset sequence.

Atm, in case of a failure during link training, the transcoder may be
still set to output the TPS1 pattern. Later the transcoder is then set
from TPS1 directly to normal mode in intel_dp_stop_link_train(), leading
to modeset failures later as described above. Fix this by setting the
training patter to TPS2, if the link training failed at any point.

The clue in the specification about the above HW behavior is the
explicit mention that TPS2 must be set after the link training sequence
(and there isn't a similar requirement specified for the 8b/10b link
training), see the Bspec links below.

v2: Add bspec aspect/link to the commit log. (Jani)

Bspec: 54128, 65448, 68849
Cc: stable@vger.kernel.org # v5.18+
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250217223828.1166093-2-imre.deak@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 8b4bbaf8ddc1f68f3ee96a706f65fdb1bcd9d355)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dp_link_training.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -1561,7 +1561,7 @@ intel_dp_128b132b_link_train(struct inte
 
 	if (wait_for(intel_dp_128b132b_intra_hop(intel_dp, crtc_state) == 0, 500)) {
 		lt_err(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clear\n");
-		return false;
+		goto out;
 	}
 
 	if (intel_dp_128b132b_lane_eq(intel_dp, crtc_state) &&
@@ -1573,6 +1573,19 @@ intel_dp_128b132b_link_train(struct inte
 	       passed ? "passed" : "failed",
 	       crtc_state->port_clock, crtc_state->lane_count);
 
+out:
+	/*
+	 * Ensure that the training pattern does get set to TPS2 even in case
+	 * of a failure, as is the case at the end of a passing link training
+	 * and what is expected by the transcoder. Leaving TPS1 set (and
+	 * disabling the link train mode in DP_TP_CTL later from TPS1 directly)
+	 * would result in a stuck transcoder HW state and flip-done timeouts
+	 * later in the modeset sequence.
+	 */
+	if (!passed)
+		intel_dp_program_link_training_pattern(intel_dp, crtc_state,
+						       DP_PHY_DPRX, DP_TRAINING_PATTERN_2);
+
 	return passed;
 }
 



