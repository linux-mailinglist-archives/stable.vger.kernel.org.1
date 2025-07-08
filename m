Return-Path: <stable+bounces-160500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9172AFCEBF
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BB73B06B7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FC2E0916;
	Tue,  8 Jul 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEmPjFbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30C2E06E8
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987676; cv=none; b=H5Gj/SIZmeH11avLVpX6uNOHvd0dQwyBu88rQXCYOCqZCeIheXdIqMxozPspaMPabmuxhq1J+SPsTJAAR/Ya21CR+gfyVyDBaGDSoFoeZlaxuNljsxzgFHUiDE+2VeEZh1JOC3OZORbtDtAQJ0V5a+vyKsABSg8I6tcfSxyXsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987676; c=relaxed/simple;
	bh=8WInYyISl4Rk1KnVnIVLVaX/wrnLn6AAipplm2igJk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fFN1O2tz/1lBqu6K5/uzCGqesww1ePMqLl2QKP3N2xP0DREfFwfMCKMloyVnail3kQBroGzdKgA45pKUAOcqPqt61WVIrGLaQsJ5I543pUqiE3wHsp0O0gkhzNwXT3C9N+jDbcXT1jhJLR4fYaa58gxTq/DwMZQkIaJhpCzN5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEmPjFbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C2C4CEED;
	Tue,  8 Jul 2025 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751987675;
	bh=8WInYyISl4Rk1KnVnIVLVaX/wrnLn6AAipplm2igJk0=;
	h=Subject:To:Cc:From:Date:From;
	b=TEmPjFbIE44Hz7uIzDoKelplcTMDG8safXbOxN7Qbc+fGLX3vSmbnviJ94ivF0KxW
	 uF72BnKgPAY6v2/q6UeWiltakNNsv56c+OQRPFqNqRSVb7da/QSJC7RqYzGlemrkRc
	 GWXuipqoUxaPbhXSPB07Q1bYObOvoozNJEGf19g8=
Subject: FAILED: patch "[PATCH] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE" failed to apply to 5.10-stable tree
To: rui.zhang@intel.com,rafael.j.wysocki@intel.com,srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:14:19 +0200
Message-ID: <2025070819-upturned-grope-5b8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 964209202ebe1569c858337441e87ef0f9d71416
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070819-upturned-grope-5b8e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 964209202ebe1569c858337441e87ef0f9d71416 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 19 Jun 2025 15:13:40 +0800
Subject: [PATCH] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE
 bit cannot be changed

PL1 cannot be disabled on some platforms. The ENABLE bit is still set
after software clears it. This behavior leads to a scenario where, upon
user request to disable the Power Limit through the powercap sysfs, the
ENABLE bit remains set while the CLAMPING bit is inadvertently cleared.

According to the Intel Software Developer's Manual, the CLAMPING bit,
"When set, allows the processor to go below the OS requested P states in
order to maintain the power below specified Platform Power Limit value."

Thus this means the system may operate at higher power levels than
intended on such platforms.

Enhance the code to check ENABLE bit after writing to it, and stop
further processing if ENABLE bit cannot be changed.

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Link: https://patch.msgid.link/20250619071340.384782-1-rui.zhang@intel.com
[ rjw: Use str_enabled_disabled() instead of open-coded equivalent ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e3be40adc0d7..faa0b6bc5b53 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -341,12 +341,28 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	u64 val;
 	int ret;
 
 	cpus_read_lock();
 	ret = rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
-	if (!ret && defaults->set_floor_freq)
+	if (ret)
+		goto end;
+
+	ret = rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, false, &val);
+	if (ret)
+		goto end;
+
+	if (mode != val) {
+		pr_debug("%s cannot be %s\n", power_zone->name,
+			 str_enabled_disabled(mode));
+		goto end;
+	}
+
+	if (defaults->set_floor_freq)
 		defaults->set_floor_freq(rd, mode);
+
+end:
 	cpus_read_unlock();
 
 	return ret;


