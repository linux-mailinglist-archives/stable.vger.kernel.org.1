Return-Path: <stable+bounces-36362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD0989BCF9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE241C217CD
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E953389;
	Mon,  8 Apr 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W38alxHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE552F8E
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571907; cv=none; b=oO0urO7jWWbk1y9OE02g+Q+5kfSXS9t+wm/XEl3938oQkaB6cuFocav8ZVz7Y4t8ORtwLdNy+fGW57T+KdINVks+uX+W/ZYERa1yJWu3cz/7CLkwf42Bn8kjpLFqzuQP7J/10bsfbe10uA7av4dinbT1p8rmp7zhfhTmagLqU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571907; c=relaxed/simple;
	bh=CVsWjRkgGIBxPsBDKY8iPWw/yuf1FeHBSP/tVyk1zM0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nb5I6/f6JpbXQPbRUWA2FAWYS2IOSysRWk4y+seeTHPnVLnMjN3cTv2VskEm0d01ujk74H2dx1iqjuDHYzZmQ5o8iyJ5Nsmrg3ZDfD+yb9xCyPgep4RYNpVNzjQSBtsBzf5ZygnlGjptqrvtfdZAKaDCHsvwsJ9u4F532YlaWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W38alxHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A55C433C7;
	Mon,  8 Apr 2024 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571906;
	bh=CVsWjRkgGIBxPsBDKY8iPWw/yuf1FeHBSP/tVyk1zM0=;
	h=Subject:To:Cc:From:Date:From;
	b=W38alxHZRFv+eh3jdx9+ZMrhBwpq8p0s6KyQ1inW38Ay80yvaYetkbG9fWzl4s8In
	 FUiZm+5Zz5NzqyRW3v3dzulTqA9ybuGx63y/56Yjcki+kKf/tkL4qHLxB1TkhZkIyq
	 t0BfgZqR+D0zmub6c+2fLVImM79wzhnAyZRNL6Aw=
Subject: FAILED: patch "[PATCH] drm/i915/mst: Reject FEC+MST on ICL" failed to apply to 6.6-stable tree
To: ville.syrjala@linux.intel.com,rodrigo.vivi@intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:25:03 +0200
Message-ID: <2024040803-tackling-bogged-527d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 99f855082f228cdcecd6ab768d3b8b505e0eb028
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040803-tackling-bogged-527d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

99f855082f22 ("drm/i915/mst: Reject FEC+MST on ICL")
126f94e87e79 ("drm/i915: Fix FEC pipe A vs. DDI A mixup")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99f855082f228cdcecd6ab768d3b8b505e0eb028 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Tue, 2 Apr 2024 16:51:47 +0300
Subject: [PATCH] drm/i915/mst: Reject FEC+MST on ICL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ICL supposedly doesn't support FEC on MST. Reject it.

Cc: stable@vger.kernel.org
Fixes: d51f25eb479a ("drm/i915: Add DSC support to MST path")
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402135148.23011-7-ville.syrjala@linux.intel.com
(cherry picked from commit b648ce2a28ba83c4fa67c61fcc5983e15e9d4afb)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 36afbb68d87d..abd62bebc46d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1422,7 +1422,8 @@ static bool intel_dp_source_supports_fec(struct intel_dp *intel_dp,
 	if (DISPLAY_VER(dev_priv) >= 12)
 		return true;
 
-	if (DISPLAY_VER(dev_priv) == 11 && encoder->port != PORT_A)
+	if (DISPLAY_VER(dev_priv) == 11 && encoder->port != PORT_A &&
+	    !intel_crtc_has_type(pipe_config, INTEL_OUTPUT_DP_MST))
 		return true;
 
 	return false;


