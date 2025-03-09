Return-Path: <stable+bounces-121576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5BA58316
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B27A5E74
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394741A8418;
	Sun,  9 Mar 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4fM4faL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F6180A80
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516390; cv=none; b=BJ0uFnceGva4g11UsuVkJ7htJTvsGhHmFXvaj/zQJUBlKdQJoBmCqKl7WlB9BUEUp+pkTEPLnEntkBBD+Ne9emAHBibwgR1LHgOu7FL+eLpZfMdj/BvzuB+hd3u0fs6gkK/r9DjPLeqDPS2FhJdV1ksXNbAfGS8lymiRT6/jU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516390; c=relaxed/simple;
	bh=obveeS5mna9nkwXhz08ahpHDhJlEUGUst+qDBb3kd7c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LJ2BggR8ugBWpAi8uFTAm2xNefFobIobakKsanvp06jPbdl+/SkhpKP2F81deE33eQW3DSsqreIujj6KcFTZVXSc8qsq/mY7OXMvHSWgxfKvqr4nYaFCZaXrT3M6SvQGM5WOvpxTVYNLzPniIfvpDOAbKWXT8JO9RwpArtd04bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4fM4faL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71121C4CEE5;
	Sun,  9 Mar 2025 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741516389;
	bh=obveeS5mna9nkwXhz08ahpHDhJlEUGUst+qDBb3kd7c=;
	h=Subject:To:Cc:From:Date:From;
	b=c4fM4faLwK9dCLj4mUncOhRPx4Fbv5ms37xGYaPr5GrpBBe9pMH+lNQDjcwLvJHzL
	 tdSCXZsDxl92qQljzyH552SxAAFE91ayrKJlPzfeZ4PIvYYDpCE3j5X4FAEUxV+g5K
	 rstJCkuUlM61QtEUEVlKaHWPNxYzg3R8ATK6h87U=
Subject: FAILED: patch "[PATCH] drm/i915/mst: update max stream count to match number of" failed to apply to 5.10-stable tree
To: jani.nikula@intel.com,imre.deak@intel.com,rodrigo.vivi@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:31:32 +0100
Message-ID: <2025030932-sneezing-pristine-7955@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d1039a3c12fffe501c5379c7eb1372eaab318e0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030932-sneezing-pristine-7955@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1039a3c12fffe501c5379c7eb1372eaab318e0a Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 26 Feb 2025 15:56:26 +0200
Subject: [PATCH] drm/i915/mst: update max stream count to match number of
 pipes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We create the stream encoders and attach connectors for each pipe we
have. As the number of pipes has increased, we've failed to update the
topology manager maximum number of payloads to match that. Bump up the
max stream count to match number of pipes, enabling the fourth stream on
platforms that support four pipes.

Cc: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250226135626.1956012-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 15bccbfb78d63a2a621b30caff8b9424160c6c89)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index a65cf97ad12d..86d6185fda50 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1867,7 +1867,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *dig_port, int conn_base_id)
 	/* create encoders */
 	mst_stream_encoders_create(dig_port);
 	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
-					   &intel_dp->aux, 16, 3, conn_base_id);
+					   &intel_dp->aux, 16,
+					   INTEL_NUM_PIPES(display), conn_base_id);
 	if (ret) {
 		intel_dp->mst_mgr.cbs = NULL;
 		return ret;


