Return-Path: <stable+bounces-125337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BCA6906E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA3461DD8
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399621B9C9;
	Wed, 19 Mar 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClwQgHz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860721B9C0;
	Wed, 19 Mar 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395117; cv=none; b=XVq1gV/5Pf51FW1agr+A/q2JN/LGBLjw9vhENIDaLdfDua/DX+e327PSkYC6btykSnKUGIRCydYh/JUpsVhq/kS4OGnHwZ1P09w0OOpd0oJZtggTcaWMsgpEZg5APmY0T6gJnRbBpVf4V2Zfb+cK8Gme/EJEfxAqEDi1C95P/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395117; c=relaxed/simple;
	bh=O8spj2uLW8+SBJNamKIlsNXit5s2v6/zZvZwVVXhOSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtNYa/IFPk1UbPIPHnfXQ9HBKjugQtTeTSYYSKVFjs8bcDSLjfpsZ4JyxvKcpgzOrn0/REkA0rm6aGckUWtoZ9kntIXXUS3viUd/GivDmDHWhGhgDcB4aYW+2KXYgM3hnCop0b3rQdVJpPmHOFFwWnNWZbx20xM8TBjh9wDiv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClwQgHz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC9C4CEE4;
	Wed, 19 Mar 2025 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395117;
	bh=O8spj2uLW8+SBJNamKIlsNXit5s2v6/zZvZwVVXhOSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClwQgHz8HQQlu2ScoACq76NneENdKpGLGC8iHArlnS8MXbXvb1NZiuvcCR86EZmca
	 APwQv6Z4Ya76JGvoDDfB6B/T3DtftrRrVO8T1q0ATCcFzhsV7iYswnGUjPPneBjFR5
	 qN/ij8H/g4BuHUhb8vMl2vtSbAd+2Wv8vpexFZB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 169/231] drm/i915/cdclk: Do cdclk post plane programming later
Date: Wed, 19 Mar 2025 07:31:02 -0700
Message-ID: <20250319143031.019050494@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6266f4a78131c795631440ea9c7b66cdfd399484 upstream.

We currently call intel_set_cdclk_post_plane_update() far
too early. When pipes are active during the reprogramming
the current spot only works for the cd2x divider update
case, as that is synchronize to the pipe's vblank. Squashing
and crawling are not synchronized in any way, so doing the
programming while the pipes/planes are potentially still using
the old hardware state could lead to underruns.

Move the post plane reprgramming to a spot where we know
that the pipes/planes have switched over the new hardware
state.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250218211913.27867-2-ville.syrjala@linux.intel.com
Reviewed-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
(cherry picked from commit fb64f5568c0e0b5730733d70a012ae26b1a55815)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_display.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7438,9 +7438,6 @@ static void intel_atomic_commit_tail(str
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	dev_priv->display.funcs.display->commit_modeset_enables(state);
 
-	if (state->modeset)
-		intel_set_cdclk_post_plane_update(state);
-
 	intel_wait_for_vblank_workers(state);
 
 	/* FIXME: We should call drm_atomic_helper_commit_hw_done() here
@@ -7521,6 +7518,8 @@ static void intel_atomic_commit_tail(str
 		intel_verify_planes(state);
 
 	intel_sagv_post_plane_update(state);
+	if (state->modeset)
+		intel_set_cdclk_post_plane_update(state);
 	intel_pmdemand_post_plane_update(state);
 
 	drm_atomic_helper_commit_hw_done(&state->base);



