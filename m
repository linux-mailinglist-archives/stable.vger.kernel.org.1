Return-Path: <stable+bounces-163486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B04B0B97E
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 02:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3DB1895CEA
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18D39ACC;
	Mon, 21 Jul 2025 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deC0kWMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE30224FD
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753056911; cv=none; b=LJgjBEEeNoLJ3dTdZLPSHGYnx/pjumHiwdFlqUhMvR63RpxniOl819NLFTZqIYk1yOQivdeLTdAJbZO54VRwXzOyyl6fzJb3ORz/dE/lOP3Vp5HNOGTYZRiFgLBu3pBgyrnWCTSVTwwIwe3MxvYSpfRvWf3OGU/ZN8HrYnfZLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753056911; c=relaxed/simple;
	bh=OARoahJB9PxhTKsT6k22xbRA15gFmL1by/CStdQr5r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lK3x4Hh1RoPzMsqRdO9b+tZ+4KLMg7/NRfyY6GTHaWcJXKHVzMetjkUrPnlT798pnOQrarzv2Mu/nltDX+86g5RJVLx7xoDbypiKeP4OFhp8RCh4iEXRNv8uMM3wk+DGgxfOsfrEKWj9ZS57hS8fVBlif4fucW2RTDQ/0YeWVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deC0kWMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01588C4CEE7;
	Mon, 21 Jul 2025 00:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753056911;
	bh=OARoahJB9PxhTKsT6k22xbRA15gFmL1by/CStdQr5r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deC0kWMTfX+1dGm50bOparQQf7F4boT7SWWrbvzsMq/zHHKJbt/HuXjT6tk4eiyHG
	 yEyXMhTbTPEzbIyEAzh6+5jB+yOUglmajahPfcziNt635CcvS3D1LD1hW1elQ3dO3o
	 PW98OHIsfw/QCLvLU5aZh5gCcr1cOVw5uAVsr8b1tvItiVqTTNY/5OhYT3vi2dcYUc
	 LDN84qaXrm+URMCgak9vQFiwvbzizf1l6RaoYxsfHuzs9IQqLl1hLt9+r/4Z2//0Ph
	 8J2pVqSP9lkPjXLOHsZBQKxTX+rVpbcPt7nzBE7sZ8qLAcK8fVFAS5/fGwTj9WV8PR
	 PoJbafu1QD0zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed
Date: Sun, 20 Jul 2025 20:15:04 -0400
Message-Id: <20250721001504.767161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070818-buddhism-wikipedia-516a@gregkh>
References: <2025070818-buddhism-wikipedia-516a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 964209202ebe1569c858337441e87ef0f9d71416 ]

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
[ replaced rapl_write_pl_data() and rapl_read_pl_data() with rapl_write_data_raw() and rapl_read_data_raw() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 9dfc053878fda..40d149d9dce85 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -212,12 +212,33 @@ static int find_nr_power_limit(struct rapl_domain *rd)
 static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
+	u64 val;
+	int ret;
 
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
 		return -EACCES;
 
 	cpus_read_lock();
-	rapl_write_data_raw(rd, PL1_ENABLE, mode);
+	ret = rapl_write_data_raw(rd, PL1_ENABLE, mode);
+	if (ret) {
+		cpus_read_unlock();
+		return ret;
+	}
+
+	/* Check if the ENABLE bit was actually changed */
+	ret = rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
+	if (ret) {
+		cpus_read_unlock();
+		return ret;
+	}
+
+	if (mode != val) {
+		pr_debug("%s cannot be %s\n", power_zone->name,
+			 mode ? "enabled" : "disabled");
+		cpus_read_unlock();
+		return 0;
+	}
+
 	if (rapl_defaults->set_floor_freq)
 		rapl_defaults->set_floor_freq(rd, mode);
 	cpus_read_unlock();
-- 
2.39.5


