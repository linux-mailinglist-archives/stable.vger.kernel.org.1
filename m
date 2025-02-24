Return-Path: <stable+bounces-118737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDFFA41AC4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F5D7A2192
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919A241669;
	Mon, 24 Feb 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8Z95XEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A891547E0
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392551; cv=none; b=KdGntzuwLzfklhE0qkGh4vAI6h3YyVdKQqeyrgDPajCQGAHlCyDEoe9uyBcxL12cy2fTPjmEq/xeckHu5VVseroJL4b9UI3drLuyr+pj84CVFyHDXV1KJVtMRhSzYrXdTOJePWQaXvU3fFswwlQTcHnXdH9ZV1ieitsb0aAx6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392551; c=relaxed/simple;
	bh=hUqawXkZCXEu7QvWRt7ctSIuHqeiz873NDIfGxVOea4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KRmd/C3WFZyvq35rMl5oIQoBAjmlgsowDYH3NipkgDCEwTcXZNWccOhsfDOSWw1R5ftkGYRyBNOpP1ZRgkdieBtGTIO8DNZNnjZG3GjaSeNF22hKnkeeFTw3NCFQAvKK58RXw54ekK7rgY6nXfHwPdQYdtO2Ze+zD43l+db5knY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8Z95XEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB72C4CEE9;
	Mon, 24 Feb 2025 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392550;
	bh=hUqawXkZCXEu7QvWRt7ctSIuHqeiz873NDIfGxVOea4=;
	h=Subject:To:Cc:From:Date:From;
	b=N8Z95XEAizHafEmasJDK++Aqq5Wj8mLQm3MeIO7U++07ZCVa24fzK4alSKSBv7Hd3
	 84pEuuZZMu9GnmHl3lR0rxW+5t4FMZtZFI1z67LXLBs2pDeWtr3fKyKwwCKmJxm2wK
	 gRaE9u34zuxdkZrfaXBZd9eH+RI8sLHv2qqXToiw=
Subject: FAILED: patch "[PATCH] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro" failed to apply to 6.6-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:22:18 +0100
Message-ID: <2025022418-frostlike-congrats-bf0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 879f70382ff3e92fc854589ada3453e3f5f5b601
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022418-frostlike-congrats-bf0d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 879f70382ff3e92fc854589ada3453e3f5f5b601 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Fri, 14 Feb 2025 16:19:51 +0200
Subject: [PATCH] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro

The format of the port width field in the DDI_BUF_CTL and the
TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
x3 lane mode for HDMI FRL has a different encoding in the two registers.
To account for this use the TRANS_DDI_FUNC_CTL's own port width macro.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-2-imre.deak@intel.com
(cherry picked from commit 76120b3a304aec28fef4910204b81a12db8974da)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index c977b74f82f0..82bf6c654de2 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -809,8 +809,8 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		/* select data lane width */
 		tmp = intel_de_read(display,
 				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
-		tmp &= ~DDI_PORT_WIDTH_MASK;
-		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
+		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
+		tmp |= TRANS_DDI_PORT_WIDTH(intel_dsi->lane_count);
 
 		/* select input pipe */
 		tmp &= ~TRANS_DDI_EDP_INPUT_MASK;


