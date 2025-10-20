Return-Path: <stable+bounces-187952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834ABEFC63
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86722189D13E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABF2E6CD9;
	Mon, 20 Oct 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6cd4KG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70952E6CA3
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947211; cv=none; b=i8M12kVroQXr3EsDfX7Xj+wLed02C2FX6er9T20QLbWsDsoBcqzH+i7CdSL6cgbUIfbbIbXig8obCDFtTep2VsxvITBYt80r2BgWb7pdOdHuJINj8tu2415R/+sY6r2WePFFUUNHCQdyJD7bYLn/tcgdnPBYKSOMxw93dzDwR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947211; c=relaxed/simple;
	bh=hKQXpvuKw88kp9elHFDpT38rNkD0Bm+ox3BfBsi9kX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fht4/DW5cew0R5d/hmtG3JgyICqvDg87AOrxUDWIB7AxmZoyhmeK1Vb2WFzdGLthpipJPMWic1HGFTV+0wl96NyKg2JFTsX8SUUAWwqEVWSWczJBMvmgokHOhcdqT33DQACWqiJc3Met2udJjWaJVrp02u5DwqIVu+VAdrvE11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6cd4KG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B4C4CEF9;
	Mon, 20 Oct 2025 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947211;
	bh=hKQXpvuKw88kp9elHFDpT38rNkD0Bm+ox3BfBsi9kX4=;
	h=Subject:To:Cc:From:Date:From;
	b=H6cd4KG2IB0KMw4HWvLXMHOjpu1zoE4R54tA/bsIT5BWD9tTTtUDxsjOQjjfFmqXJ
	 W9gQgJUvhct+1eSimvnJtRxkD4Vfj3Uqns7N40ybhSJLz4gimd4U/Qwjo1LpSOdYrB
	 BzyBbNe5OjL0vLtVA1XMqJB8GiQbRFSKI82uVMtw=
Subject: FAILED: patch "[PATCH] x86/resctrl: Fix miscount of bandwidth event when" failed to apply to 5.4-stable tree
To: babu.moger@amd.com,bp@alien8.de,reinette.chatre@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 09:59:58 +0200
Message-ID: <2025102058-citadel-crinkly-125f@gregkh>
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
git cherry-pick -x 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102058-citadel-crinkly-125f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15292f1b4c55a3a7c940dbcb6cb8793871ed3d92 Mon Sep 17 00:00:00 2001
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 10 Oct 2025 12:08:35 -0500
Subject: [PATCH] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously unavailable RMID

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state.

When a bandwidth counter is read for such an RMID, the hardware sets
MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
remains set on first read after tracking re-starts and is clear on all
subsequent reads as long as the RMID is tracked.

resctrl miscounts the bandwidth events after an RMID transitions from the
"Unavailable" state back to being tracked. This happens because when the
hardware starts counting again after resetting the counter to zero, resctrl
in turn compares the new count against the counter value stored from the
previous time the RMID was tracked.

This results in resctrl computing an event value that is either undercounting
(when new counter is more than stored counter) or a mistaken overflow (when
new counter is less than stored counter).

Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
zero whenever the RMID is in the "Unavailable" state to ensure accurate
counting after the RMID resets to zero when it starts to be tracked again.

Example scenario that results in mistaken overflow
==================================================
1. The resctrl filesystem is mounted, and a task is assigned to a
   monitoring group.

   $mount -t resctrl resctrl /sys/fs/resctrl
   $mkdir /sys/fs/resctrl/mon_groups/test1/
   $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   21323            <- Total bytes on domain 0
   "Unavailable"    <- Total bytes on domain 1

   Task is running on domain 0. Counter on domain 1 is "Unavailable".

2. The task runs on domain 0 for a while and then moves to domain 1. The
   counter starts incrementing on domain 1.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   7345357          <- Total bytes on domain 0
   4545             <- Total bytes on domain 1

3. At some point, the RMID in domain 0 transitions to the "Unavailable"
   state because the task is no longer executing in that domain.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   "Unavailable"    <- Total bytes on domain 0
   434341           <- Total bytes on domain 1

4.  Since the task continues to migrate between domains, it may eventually
    return to domain 0.

    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
    17592178699059  <- Overflow on domain 0
    3232332         <- Total bytes on domain 1

In this case, the RMID on domain 0 transitions from "Unavailable" state to
active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
the counter is read and begins tracking the RMID counting from 0.

Subsequent reads succeed but return a value smaller than the previously
saved MSR value (7345357). Consequently, the resctrl's overflow logic is
triggered, it compares the previous value (7345357) with the new, smaller
value and incorrectly interprets this as a counter overflow, adding a large
delta.

In reality, this is a false positive: the counter did not overflow but was
simply reset when the RMID transitioned from "Unavailable" back to active
state.

Here is the text from APM [1] available from [2].

"In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
first QM_CTR read when it begins tracking an RMID that it was not
previously tracking. The U bit will be zero for all subsequent reads from
that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
read with the U bit set when that RMID is in use by a processor can be
considered 0 when calculating the difference with a subsequent read."

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
    Bandwidth (MBM).

  [ bp: Split commit message into smaller paragraph chunks for better
    consumption. ]

Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c8945610d455..2cd25a0d4637 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	struct arch_mbm_state *am;
 	u64 msr_val;
 	u32 prmid;
 	int ret;
@@ -251,12 +253,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
 
-	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	if (!ret) {
+		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	} else if (ret == -EINVAL) {
+		am = get_arch_mbm_state(hw_dom, rmid, eventid);
+		if (am)
+			am->prev_msr = 0;
+	}
 
-	return 0;
+	return ret;
 }
 
 static int __cntr_id_read(u32 cntr_id, u64 *val)


