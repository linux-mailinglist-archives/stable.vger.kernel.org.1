Return-Path: <stable+bounces-118735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC8A41ABE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1403A74E6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BB24BC11;
	Mon, 24 Feb 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3Im/V4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C949207A20
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392521; cv=none; b=KK8w6n2VW95KB+mC0VTdvai5NYynG8BpMb4BelSTkD7uZoZLtjUivP0DKpp7QxSEFofScZ4IT2W2U175vYsrnRTSSVFV7NRDZrndfKqtbfVG5Q/d3L3ATscCii7kJXYsLuWFxDfJ0QhOI1Lk2lVUnnsdxy3yQkog+DL34l5AEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392521; c=relaxed/simple;
	bh=GMt+zhnCuniaEuDIgOxgPzLgz4rPO4wUNmcgp/mtDfo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pP5NjYoIAab4ibJAl6qm7D3+ZZdXhdp/EDF8AZIOLNZupXQ8Ph4zEJEx/RBquyfARwkbMhdjaerMe5y44BEkSrYerMwqgzNboGkmfXUpadqmvGqB0vx+a0i92Qrv83/RuIIX9nbC84jWet7DsjZbAPOSWvO5xYaKqA5ydEztgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3Im/V4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D2C4CED6;
	Mon, 24 Feb 2025 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392520;
	bh=GMt+zhnCuniaEuDIgOxgPzLgz4rPO4wUNmcgp/mtDfo=;
	h=Subject:To:Cc:From:Date:From;
	b=a3Im/V4zD4XecgIDVjsoT5X/c2jLnQTTsbWDQN9izAjulYJNsYwwRRd87c5ijyzOJ
	 +jT7R3P5k7QrZsgKC0I9KBxFIF/gDBMyzOsVDmBkMhCFhEe8LJEhgJA0vyXFXMwu83
	 nXu1SysisgJ6IR2lT/8ilsbsFgxVZoQDdxdtij1Q=
Subject: FAILED: patch "[PATCH] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL" failed to apply to 6.6-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:21:56 +0100
Message-ID: <2025022456-vintage-hunter-6136@gregkh>
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
git cherry-pick -x 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022456-vintage-hunter-6136@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Fri, 14 Feb 2025 16:19:52 +0200
Subject: [PATCH] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL

Fix the port width programming in the DDI_BUF_CTL register on MTLP+,
where this had an off-by-one error.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-3-imre.deak@intel.com
(cherry picked from commit b2ecdabe46d23db275f94cd7c46ca414a144818b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index acb986bc1f33..2b9240ab547d 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3487,7 +3487,7 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(dev_priv, port),
 			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
 
-		buf_ctl |= DDI_PORT_WIDTH(lane_count);
+		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
 
 		if (DISPLAY_VER(dev_priv) >= 20)
 			buf_ctl |= XE2LPD_DDI_BUF_D2D_LINK_ENABLE;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 765e6c0528fb..786c727aea45 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -3633,7 +3633,7 @@ enum skl_power_gate {
 #define  DDI_BUF_IS_IDLE			(1 << 7)
 #define  DDI_BUF_CTL_TC_PHY_OWNERSHIP		REG_BIT(6)
 #define  DDI_A_4_LANES				(1 << 4)
-#define  DDI_PORT_WIDTH(width)			(((width) - 1) << 1)
+#define  DDI_PORT_WIDTH(width)			(((width) == 3 ? 4 : ((width) - 1)) << 1)
 #define  DDI_PORT_WIDTH_MASK			(7 << 1)
 #define  DDI_PORT_WIDTH_SHIFT			1
 #define  DDI_INIT_DISPLAY_DETECTED		(1 << 0)


