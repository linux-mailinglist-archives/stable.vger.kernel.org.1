Return-Path: <stable+bounces-188201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39CBF28E3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F5114F922A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF3330301;
	Mon, 20 Oct 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMBeBaWS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E432F765
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979194; cv=none; b=h1pnK8QbOz+BGHMASPEQ18euPad5ziItaVAqjBkTXRkP3DKuec78VxUlxS5Ine++3LkJsMzhcTRof2xbXfC5Fq/Kp5h4U6HLqfmPEf7JQqf6jx4oO8onYed32yD3veged9nwv7QRhyohNSjoFHnWdcuuFeCRUjz/NzAMQpx87j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979194; c=relaxed/simple;
	bh=eDYv2fEcU6WKuuCJuDPXUQCq5r8HjufbRopIdCIgeT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMQSu0GCNWY0uKMI/elpKG3YP0LEkDBmMMYGnE3TuAX5tI3iwGGVAXRrOBVkynntkzJ7UpL1Q0t8byN2o6dyCwoN49b1cGodUBANfoAJi/dNTBfcfzwRgAeQ3rwjmTC1SayclQy7ZSbgR6HvCFW+U1Wu/RbJUQLrJhK5HrGSgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMBeBaWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2735EC4CEF9;
	Mon, 20 Oct 2025 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979193;
	bh=eDYv2fEcU6WKuuCJuDPXUQCq5r8HjufbRopIdCIgeT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMBeBaWSnOJ+SxnjWpejCBOgPYPMsgHKn15e3o22q4NEBiVIy3kDD3cgV7uZ7t5Kk
	 PrseMrLvHBMLNG+CZv8hw4/9BPLLKRcQSEuCjiXjiIX5tMNgT7ny4X8SR3SzV4/aU1
	 AUNKgdyQpXzm4U65kYb6CpIw+xF7/zbhEW+ClyHoL0IshcRpg1j5tCt57ADRzBYzmc
	 Qlm6x88oFS789BeQdAPDcYPl7f1y0l5qNW0dy8Xlj05QnhR2E1nnm4ly2b2QdbFJq8
	 BA43V11QngRi+Fqs5JIkwwilzPV3Ln1XmImBIceT6gbqFhFIvOfgq6IKafOYeRxxJt
	 MJguIGvF99Q4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] x86/resctrl: Refactor resctrl_arch_rmid_read()
Date: Mon, 20 Oct 2025 12:53:08 -0400
Message-ID: <20251020165309.1843541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102047-tissue-surplus-ff35@gregkh>
References: <2025102047-tissue-surplus-ff35@gregkh>
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
index c261558276cdd..cff5bcaddf42f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -224,24 +224,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
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
@@ -253,7 +242,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
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


