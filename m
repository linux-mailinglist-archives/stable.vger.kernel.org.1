Return-Path: <stable+bounces-160499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87BAFCEBE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF14F481367
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E862E0405;
	Tue,  8 Jul 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="No25x67W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A312CD8B
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987673; cv=none; b=MXfabXwhtcz7me3WYjmGz9XOauOjslleIByTKjCtjpt/Y+BDwsFsBySr5blajSvfVNTkOV0GqHuHBYOeyCsPKHkrAHX5rQ9o+rgCz8UGD56If9JRvMVd97SyUWsLyDU4agdq8sRhmg3UDsa3ikYWr23IKo/pPTdcDZIvVnGmJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987673; c=relaxed/simple;
	bh=pVWnN1QNjVTvgzclMaeLYMHTeFChotHcDYOrXXgnZSM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uW/NePT0dpLetmM7S+fp7uSY051tj55P/XkyzV6MDAPDpD7ewpB64+wvUmY34L6cyd04lfy2ShM33s1NmcHSS9avhWrxrOCHDVoNbb5a1SsHDx6ZXYgCYXmznlpPdu9BYAutB5TQVnZpea/+bm/b+A/ztipH6+eD42Je5id1caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=No25x67W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68834C4CEED;
	Tue,  8 Jul 2025 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751987672;
	bh=pVWnN1QNjVTvgzclMaeLYMHTeFChotHcDYOrXXgnZSM=;
	h=Subject:To:Cc:From:Date:From;
	b=No25x67Wpv5MixEUFr1CZc20BtBV65EoyA2QI1Xi+sxXV/Nyc8WGKlqCT6H4iBgRr
	 rtbw+CMC3JQchlTRJEajtSoGpgCY7Zov/ACX2Wu/1nnkBmlyB+CfMbb7M8H6vPkst5
	 rxzS8ihEAdmX98uc6NNF+MROvptQ1UcpqUccILnk=
Subject: FAILED: patch "[PATCH] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE" failed to apply to 5.4-stable tree
To: rui.zhang@intel.com,rafael.j.wysocki@intel.com,srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 17:14:19 +0200
Message-ID: <2025070819-mourner-tingling-cd53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 964209202ebe1569c858337441e87ef0f9d71416
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070819-mourner-tingling-cd53@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


