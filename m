Return-Path: <stable+bounces-188199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCFBF279D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C992A3A4D03
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82C320A15;
	Mon, 20 Oct 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD5wRAdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28031BCAB
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978338; cv=none; b=TZsdleDNjVdF/bbCywaZnvPeDNK7fkadPr1WapMn7H9B8DyDizYPLJYN5ZGtMTD41xYhYTu1vxCVR+HFDHM3wRePoJTfCYNy/Vjndq3i550QCh+K6vv/K/9ZkjcjUTPhIYL/EB0V1w0ZcIxfl+ExH3EnMoB0XrURFYPOzKf5f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978338; c=relaxed/simple;
	bh=/D3C2kDuMV6cEUux+P20+5500Bg5eCY4bYCWcJpAMtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMIDybizOM5WvNyeGe0Krl2fDRB8wVJWiAQIq++V9uFtosOcXOsDjUnGgxYr2OMLVbHPS2bfILSjDYjj0yWq+7jYHNOTow+nZwufN3XP2BEfEpOK89z5mwJIS+gmaV2U3w6K7Fhusy0cztkDI5kcOzAzqDbgO3h9rsePGcdf5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD5wRAdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8EC4CEF9;
	Mon, 20 Oct 2025 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978337;
	bh=/D3C2kDuMV6cEUux+P20+5500Bg5eCY4bYCWcJpAMtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AD5wRAdUmbI1NS99dTPPoXsNmbi7AeAFCAAno9NE1jaDcbZE0BUPaOEAue45J02j2
	 zRVQyGXraZgumNBtDqIOIvaeEzKzwmbED9hzypClkuet7IMweDsJX/rMH0H5P243q4
	 NVHkBRrjYREqjYgKVEcFdi/Tr7ntARvQ/Qxni1Wem0RD48wlZbrZIkZ5EogM3O8Ymv
	 PfXe9PPIITPoMytJ6vwAg3Hz2klP/xwcNtsv3S67akgY6Fc5y/xnmddm4ePAU/mkmO
	 box4V4xqbvgie6cXLSasPwaT+gKXAT9EkTgL3d1RreJMBiIbId7eXzNEzfywVtJgL7
	 BqWYxdmNtwwfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] x86/resctrl: Refactor resctrl_arch_rmid_read()
Date: Mon, 20 Oct 2025 12:38:52 -0400
Message-ID: <20251020163853.1841192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102049-machine-domestic-c4b2@gregkh>
References: <2025102049-machine-domestic-c4b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Babu Moger <babu.moger@amd.com>

[ Upstream commit 7c9ac605e202c4668e441fc8146a993577131ca1 ]

resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
account for the overflow for MBM events and apply counter scaling for all the
events. This logic is common to both reading an RMID and reading a hardware
counter directly.

Refactor the hardware value adjustment logic into get_corrected_val() to
prepare for support of reading a hardware counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
Stable-dep-of: 15292f1b4c55 ("x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561850e0c..b8d0748c4f2db 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -312,24 +312,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
-			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *ignored)
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	int cpu = cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	u32 prmid;
-	int ret;
-
-	resctrl_arch_rmid_read_context_check();
-
-	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
-	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
+	u64 chunks;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
@@ -341,7 +330,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 		chunks = msr_val;
 	}
 
-	*val = chunks * hw_res->mon_scale;
+	return chunks * hw_res->mon_scale;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val, void *ignored)
+{
+	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	u64 msr_val;
+	u32 prmid;
+	int ret;
+
+	resctrl_arch_rmid_read_context_check();
+
+	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
+	ret = __rmid_read_phys(prmid, eventid, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
 
 	return 0;
 }
-- 
2.51.0


