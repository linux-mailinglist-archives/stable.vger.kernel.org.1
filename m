Return-Path: <stable+bounces-158935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB289AEDB46
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24973AB7F6
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875825DD07;
	Mon, 30 Jun 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swqlUsub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580F239085
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283466; cv=none; b=k3VgJNbknGCUu9Ijygp9zL5vCoOTNqEJlMKY7BhWQIOVUp+CANq08OmfCDLTAIJAmJaaEdhQo0mJTepZOXpB0S2BYKp/UCGFpthDtvvgOR5i3pMfF26cb5iOoUOjPq64QHIwHKeloyKv+0Cu1j5VqOzHhbfw6/3Uzg2Bf1qrIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283466; c=relaxed/simple;
	bh=Z4kT5TsNTK7DCYDydsUR/RW9CEr9z2ZRFs6J/5RNPRs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hC2eeMgXwLhAr96tpk1yuo3htDxGKnfo9uE0slOvkQfhgJHW39oWr09e4JuNI32NUwLfJf+rvzUBv498U+yggv4s83yXzJ6AEExtJMVFpUdZ0pE9d9JkOUGVhK5//9j7OxHPCrNNG89G217VqeS2o0lDjX6daeL6cu+3gX6tt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swqlUsub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F82EC4CEE3;
	Mon, 30 Jun 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751283466;
	bh=Z4kT5TsNTK7DCYDydsUR/RW9CEr9z2ZRFs6J/5RNPRs=;
	h=Subject:To:Cc:From:Date:From;
	b=swqlUsub1xd5VMCW0btPpmjTlRQY1a2BaHSrt2aLtMfELxwDEh4/Pqfkt1NiFcCk+
	 BUustIN3M7N6Smm9A2ATFkqYqiSFwa4T1ujUUrf+5XY5PtTYh3AswsltR3t+O/r1Ao
	 CjPi9ZMmA0FV8xvi1QWyjYvrm3p3yxc9S6gsASZk=
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Work around Thunderbolt sink disconnect" failed to apply to 6.6-stable tree
To: imre.deak@intel.com,joonas.lahtinen@linux.intel.com,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 13:37:42 +0200
Message-ID: <2025063042-aviation-smelting-90dd@gregkh>
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
git cherry-pick -x 9cb15478916e849d62a6ec44b10c593b9663328c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063042-aviation-smelting-90dd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cb15478916e849d62a6ec44b10c593b9663328c Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 19 May 2025 16:34:17 +0300
Subject: [PATCH] drm/i915/dp_mst: Work around Thunderbolt sink disconnect
 after SINK_COUNT_ESI read

Due to a problem in the iTBT DP-in adapter's firmware the sink on a TBT
link may get disconnected inadvertently if the SINK_COUNT_ESI and the
DP_LINK_SERVICE_IRQ_VECTOR_ESI0 registers are read in a single AUX
transaction. Work around the issue by reading these registers in
separate transactions.

The issue affects MTL+ platforms and will be fixed in the DP-in adapter
firmware, however releasing that firmware fix may take some time and is
not guaranteed to be available for all systems. Based on this apply the
workaround on affected platforms.

See HSD #13013007775.

v2: Cc'ing Mika Westerberg.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13760
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14147
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250519133417.1469181-1-imre.deak@intel.com
(cherry picked from commit c3a48363cf1f76147088b1adb518136ac5df86a0)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ad1e4fc9c7fe..640c43bf62d4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4532,6 +4532,23 @@ intel_dp_mst_disconnect(struct intel_dp *intel_dp)
 static bool
 intel_dp_get_sink_irq_esi(struct intel_dp *intel_dp, u8 *esi)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	/*
+	 * Display WA for HSD #13013007775: mtl/arl/lnl
+	 * Read the sink count and link service IRQ registers in separate
+	 * transactions to prevent disconnecting the sink on a TBT link
+	 * inadvertently.
+	 */
+	if (IS_DISPLAY_VER(display, 14, 20) && !display->platform.battlemage) {
+		if (drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 3) != 3)
+			return false;
+
+		/* DP_SINK_COUNT_ESI + 3 == DP_LINK_SERVICE_IRQ_VECTOR_ESI0 */
+		return drm_dp_dpcd_readb(&intel_dp->aux, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
+					 &esi[3]) == 1;
+	}
+
 	return drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 4) == 4;
 }
 


