Return-Path: <stable+bounces-58214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569A92A334
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F621F23159
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAFC839E3;
	Mon,  8 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PULvm7Ud"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279E8287C
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443043; cv=none; b=odgtDA9yxqXoJJ3yQLzpAp+FGdxSyS7HDm48NC1n5ekeF51cwudBPUMc3UrVPllNyCYUnVs+AL9nRJKB3PXLyYQ7jQtrFiaLYixGA4wF2fmzGvoY1wU6+6AuH8cwlMSJDUMRNtyhtwRTSuDtugzK/QqgvMcnrtDNFJECquZfchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443043; c=relaxed/simple;
	bh=IbvzCdwqxhKMlTMRQwVIf7NV/zbWsNbXMb99Wr5hEhg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BIFUJ4OeKaYsvPpIEOpRIytq7YzgL8cYLI4kibl0ScJMIs+aNgSEmy/42o/dVZZgQvYJ1qf7Al9f2/tAtcCTeAHnYjh1jPnlm1awRwFnlPlbT0AcYSBJ35Z4jCS3h9IyUa7GgSJRwzEOq5hMowWiobst38ud1GosPdDTwpOq/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PULvm7Ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89CC116B1;
	Mon,  8 Jul 2024 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443043;
	bh=IbvzCdwqxhKMlTMRQwVIf7NV/zbWsNbXMb99Wr5hEhg=;
	h=Subject:To:Cc:From:Date:From;
	b=PULvm7Udvw9qMWCqzRq/6pMJet9vnI4+xC5oySemCl0lC9xpplWV02aJ4a9QLPqRN
	 z/YvEmpLYRApFEC76Gl8Uw508M7M0fE2qqEhTUfiilMc2WcHIbuTFTlGgYKL6Fwqh5
	 vJxywukUsnFdE7UckQV2cwKFJeNiuu2BhA3rojm4=
Subject: FAILED: patch "[PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming" failed to apply to 6.9-stable tree
To: imre.deak@intel.com,gustavo.sousa@intel.com,jani.nikula@intel.com,mika.kahola@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:50:39 +0200
Message-ID: <2024070839-undertake-variably-bedc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x f72383371e8c5d1d108532d7e395ff2c277233e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070839-undertake-variably-bedc@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

f72383371e8c ("drm/i915/display: For MTL+ platforms skip mg dp programming")
7fcf755896a3 ("drm/i915/display: use intel_encoder_is/to_* functions")
0a099232d254 ("drm/i915/snps: pass encoder to intel_snps_phy_update_psr_power_state()")
684a37a6ffa9 ("drm/i915/ddi: pass encoder to intel_wait_ddi_buf_active()")
65ea19a698f2 ("drm/i915/hdmi: convert *_port_to_ddc_pin() to *_encoder_to_ddc_pin()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f72383371e8c5d1d108532d7e395ff2c277233e5 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Tue, 25 Jun 2024 14:18:40 +0300
Subject: [PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming

For MTL+ platforms we use PICA chips for Type-C support and
hence mg programming is not needed.

Fixes issue with drm warn of TC port not being in legacy mode.

Cc: stable@vger.kernel.org

Signed-off-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625111840.597574-1-mika.kahola@intel.com
(cherry picked from commit aaf9dc86bd806458f848c39057d59e5aa652a399)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 3c3fc53376ce..6bff169fa8d4 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2088,6 +2088,9 @@ icl_program_mg_dp_mode(struct intel_digital_port *dig_port,
 	u32 ln0, ln1, pin_assignment;
 	u8 width;
 
+	if (DISPLAY_VER(dev_priv) >= 14)
+		return;
+
 	if (!intel_encoder_is_tc(&dig_port->base) ||
 	    intel_tc_port_in_tbt_alt_mode(dig_port))
 		return;


