Return-Path: <stable+bounces-172563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB23B3277F
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC15A2034
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDFB21930A;
	Sat, 23 Aug 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZjE4tDnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237820296C
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935559; cv=none; b=H8heDmA6i3dIqBqtgCW61qgkbhvL9//OyXrTERMfbvx8qtCFZoyRj7V1lNVVIteM6ruog2njJATrkQ/zGSI97pzHATE4LPkEepvRSbxIV9LpMuXMuIHa+LHbYTCAvTWtgJqlsMSILqlUHjkMSTmXRJph+9djSR+7s5BQDHHhZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935559; c=relaxed/simple;
	bh=BCdjC2/99wU6R/fLEM3qVgnbjJjh7nGkHcKEdLpG0us=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kpuLgZsmsRffMJe5O42tEEmuXl+1oIUOvHXrPomicuSYIGcrh5lXnevDbPnO4ZG5y05pEyvJFUoQ3SBYdsXD5EDlzHW4nPes/IWVHS6t1UVbcUL3vcQUp5ff4qajRYZYUmdgIVCkRtIcLD/J0/zKg4tkemkL1OX9MtDEFWcX1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZjE4tDnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7692C4CEE7;
	Sat, 23 Aug 2025 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755935559;
	bh=BCdjC2/99wU6R/fLEM3qVgnbjJjh7nGkHcKEdLpG0us=;
	h=Subject:To:Cc:From:Date:From;
	b=ZjE4tDnKq+/fEBjkznHCsHT52JMNcUpHvNBr84u+dV+hu3eQjv+Iw+kUMaR52/2uy
	 nta9HcCg40GuxpUe8rYDizv/OjQpRedzLTUCMOcdEGbLAjqEJzCBuh3Wyp9N9/FsCE
	 XnNTXYoFwcQQwvM4Odk8iTzVhyuKFVhp8z0m4tQM=
Subject: FAILED: patch "[PATCH] drm/i915/lnl+/tc: Use the cached max lane count value" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,charlton.lin@intel.com,khaled.almahallawy@intel.com,mika.kahola@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 09:52:35 +0200
Message-ID: <2025082335-unblock-ahead-61ea@gregkh>
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
git cherry-pick -x c5c2b4b3841666be3a45346d0ffa96b4b143504e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082335-unblock-ahead-61ea@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5c2b4b3841666be3a45346d0ffa96b4b143504e Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 11 Aug 2025 11:01:51 +0300
Subject: [PATCH] drm/i915/lnl+/tc: Use the cached max lane count value

Use the cached max lane count value on LNL+, to account for scenarios
where this value is queried after the HW cleared the corresponding pin
assignment value in the TCSS_DDI_STATUS register after the sink got
disconnected.

For consistency, follow-up changes will use the cached max lane count
value on other platforms as well and will also cache the pin assignment
value in a similar way.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-5-imre.deak@intel.com
(cherry picked from commit afc4e84388079f4d5ba05271632b7a4d8d85165c)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 3f9842040bb0..6a2442a0649e 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -395,12 +395,16 @@ static void read_pin_configuration(struct intel_tc_port *tc)
 
 int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
 {
+	struct intel_display *display = to_intel_display(dig_port);
 	struct intel_tc_port *tc = to_tc_port(dig_port);
 
 	if (!intel_encoder_is_tc(&dig_port->base))
 		return 4;
 
-	return get_max_lane_count(tc);
+	if (DISPLAY_VER(display) < 20)
+		return get_max_lane_count(tc);
+
+	return tc->max_lane_count;
 }
 
 void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,


