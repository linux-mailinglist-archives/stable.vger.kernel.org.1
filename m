Return-Path: <stable+bounces-118736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA64A41AC1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606C57A1F11
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78324C67F;
	Mon, 24 Feb 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fi/5ITTP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD12441A3
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392542; cv=none; b=ZfYrTFIP8d+GaRJL0McLDxQy0kD7Dm06xZcKuVukID5JXqKxWnISZgCToUs25RaJWWBo1VtIeRcrcoNTvRy1JdGI8Bjbj06as8fslgXc1ld+RqcxQ2pgnDpOg3tce3alD9qZQhQ0SVGh3++4dOCS7nnYSsp8SnPcqDyLCHQobnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392542; c=relaxed/simple;
	bh=cMaFVh/6iPGoH/zt8onDraPC8cCdPNveDgeJMd1/mso=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d/bmq2gmHogfBqV/eBPHbxmK8pHQu3YTahg/wsrb3jKMWs6ZilEAJwtWBl0FMWUMp8+Lzfm/8Rv3kyixCG7beDocmgn3ZPgkB1nlDbfHDgI+BbB3TlGsTaMJEAalUL/Ak0jZ5FegsnPOlf0T2gafCVsxlPw3RO/or3YjOhnNdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fi/5ITTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE6C4CED6;
	Mon, 24 Feb 2025 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392541;
	bh=cMaFVh/6iPGoH/zt8onDraPC8cCdPNveDgeJMd1/mso=;
	h=Subject:To:Cc:From:Date:From;
	b=Fi/5ITTPf3s/8tkXmtledeU8JUrR2y8HQfJhy+LANL4VNvrTdKYdvKvZQsr4XAIES
	 3w7jtcTUeMK9yy6ZjNWj2mFdZpEnTUqI1GzwXVVVYaO4jAxD0nD1VJGKD82QvMujLx
	 rixnAx5DSI2dY0mJUZcSpbfUrJTY/20rzDnS40K0=
Subject: FAILED: patch "[PATCH] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:22:18 +0100
Message-ID: <2025022418-clergyman-hacker-f7f7@gregkh>
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
git cherry-pick -x 879f70382ff3e92fc854589ada3453e3f5f5b601
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022418-clergyman-hacker-f7f7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


