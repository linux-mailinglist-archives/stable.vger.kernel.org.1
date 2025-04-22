Return-Path: <stable+bounces-135012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E55A95DC9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6692D3B7D5B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7876A1E9B3B;
	Tue, 22 Apr 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q6onxbj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD8148850
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302255; cv=none; b=Ewt8WnSMmxo62TsqKLdzkOO/aDRMzuJUY+84SPEw4sBC/CTwwaPoed2UNXL5t360WBbHJ5yk0xBX+FhzfwGzYs/OHyHrBvwbdKI6w2Jz40hX6Dsron8MIntT0stVPYBvh0pjHnXMMiv9nVl6C+ii6aRgtmH2LW08kclIlMzvZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302255; c=relaxed/simple;
	bh=vFkP9ywveGSzewf8wnh/H3jDN1pOuE1Xu2Kk6tQ8yB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iYCPYY6QVgSVOLanGm0vGhuRTqE4MbdZ6v3ZmOK1Jrb/lvg7Rw+Atgi0sF6zZ3Ow7OYSzAsoTTmQ4qE6BuPa+6qd3LsaS6IjuZT6DDKXDmHifvw6M87xNaRqCZaC4xxcTngeIyOxymaYrgYNEpW9EKs1ohM/I262UQ9scM61WN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q6onxbj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA293C4CEE9;
	Tue, 22 Apr 2025 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302255;
	bh=vFkP9ywveGSzewf8wnh/H3jDN1pOuE1Xu2Kk6tQ8yB4=;
	h=Subject:To:Cc:From:Date:From;
	b=q6onxbj8ji84WWf85N6VuvtT6Qa3julOdDU/Y5fDrDCn4OSXZtnBb52Mp00PibTWb
	 bGmip/uiFe+jPb/ukU51dzzA/Sbu1/MD5ySKvQR1F/PoWW6OE74DjMFRq6WJGSn5WN
	 TIwRyjxaxYAeQ9CMShoeeT/6WwoCKapHbzHbjMRI=
Subject: FAILED: patch "[PATCH] drm/i915/mst: update max stream count to match number of" failed to apply to 6.12-stable tree
To: jani.nikula@intel.com,imre.deak@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:10:41 +0200
Message-ID: <2025042241-smokiness-outscore-f8f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 15bccbfb78d63a2a621b30caff8b9424160c6c89
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042241-smokiness-outscore-f8f9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15bccbfb78d63a2a621b30caff8b9424160c6c89 Mon Sep 17 00:00:00 2001
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

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index faa261c8930c..889b3a902b8f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1896,7 +1896,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *dig_port, int conn_base_id)
 	/* create encoders */
 	mst_stream_encoders_create(dig_port);
 	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
-					   &intel_dp->aux, 16, 3, conn_base_id);
+					   &intel_dp->aux, 16,
+					   INTEL_NUM_PIPES(display), conn_base_id);
 	if (ret) {
 		intel_dp->mst_mgr.cbs = NULL;
 		return ret;


