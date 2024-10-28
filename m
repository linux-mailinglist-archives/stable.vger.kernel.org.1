Return-Path: <stable+bounces-88382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CA9B25B3
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98512817BC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1E18E77B;
	Mon, 28 Oct 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmIrsE7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5B18DF68;
	Mon, 28 Oct 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097204; cv=none; b=B4mqYBHI3JvKWuhyp9n7DivVsitxitepkjO3t+Cdk8oJ1211XwoCUbpBb9eN4Pweh1RdcVTuxNPNJibFDaxa1j7nb4g8o3//3GSpXcIRLf+Du/dU+rGdYs+F+QdwpcuoiPe6auplFLNFG4m2KK9l9QUJJQP7guChTP9BAUPeKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097204; c=relaxed/simple;
	bh=K8keYF/FhTXxLLQZMaMI3jEK52ZfJGi9r0QlS9EpUNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg2BdftjA/MfOQtuOkBdD9SYaa/tdeqRGWlyw2GlFv5Lv4dJFk2nbdhJB9aJ6aS169WGH0bRQ2YsAB0fo1ufQSrIAWU3cbv0GgVgEwP3vSk2gGogHnIOcuTImYvcc+yb0FP4B+E4UUyrVrBG69DIzcX2PfmrYKFjYuJgBkgLPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmIrsE7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747EDC4CECD;
	Mon, 28 Oct 2024 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097203;
	bh=K8keYF/FhTXxLLQZMaMI3jEK52ZfJGi9r0QlS9EpUNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmIrsE7mcRxzKAOk3ROobdCpwa9+T7ZrD+mJpx/gFx9GaAXCdBlnzW1GL06xHM8Uq
	 yLZY5+1EwQhzSgipI3a79yHcGpKD0YWl8RxREspGhTOJzKRVQvul9o9ONzMz+Ziaep
	 z0rirTNvRG+J+ZwFs7bcmswcYamFVI84TTRGtsUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	Martin Kletzander <nert.pinx@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/137] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Mon, 28 Oct 2024 07:24:05 +0100
Message-ID: <20241028062258.947490321@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kletzander <nert.pinx@gmail.com>

[ Upstream commit 2b5648416e47933939dc310c4ea1e29404f35630 ]

The resctrl schemata file supports specifying memory bandwidth associated with
the Memory Bandwidth Allocation (MBA) feature via a percentage (this is the
default) or bandwidth in MiBps (when resctrl is mounted with the "mba_MBps"
option).

The allowed range for the bandwidth percentage is from
/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity of
/sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for the MiBps
bandwidth is 0 to U32_MAX.

There are two issues with parsing of MiBps memory bandwidth:

* The user provided MiBps is mistakenly rounded up to the granularity
  that is unique to percentage input.

* The user provided MiBps is parsed using unsigned long (thus accepting
  values up to ULONG_MAX), and then assigned to u32 that could result in
  overflow.

Do not round up the MiBps value and parse user provided bandwidth as the u32
it is intended to be. Use the appropriate kstrtou32() that can detect out of
range values.

Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 84f23327caed4..d2cb96738ff6b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -27,10 +27,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -40,16 +40,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -63,7 +68,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
-- 
2.43.0




