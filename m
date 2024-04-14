Return-Path: <stable+bounces-37237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64289C523
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40233B25ABE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739777C08D;
	Mon,  8 Apr 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQ/MWwA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BD71742;
	Mon,  8 Apr 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583649; cv=none; b=FL+2QbUvvlJP2Apsv0dXqevaNNQK5rtinaII1kU3jDpi/P6moP7Vd3gFHbilL26XAQ+0gUVB+RK6nDwi1A+RA69Zry67DWhAz+Ym29kZQTl1fEIdOP1z/q3ueVuF9+KfyLk4ZIzu2YboQVt1KGJRgtsq877ds3qrNFkiMDKY9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583649; c=relaxed/simple;
	bh=H74ObiayDQNYOpeL3MIhRxnBLqyl7gYi5F333U70pao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDG5FCNujRYyRWbSpz7rfbJcCuHo/T5X5ZxLEUzsF7qjB1Wh8PAul8SvNb7Csk1qJDLKVdReDqNjIaBkP2Ul/5JdA0GtuMrXHsHHpxbD5x90IaWKFT4P/8Uibk8m1CfqzGWrYT5vauLjTwJgeGGGMJ9luN+RJh/e2p5ux7t9YfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQ/MWwA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A567BC433C7;
	Mon,  8 Apr 2024 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583649;
	bh=H74ObiayDQNYOpeL3MIhRxnBLqyl7gYi5F333U70pao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQ/MWwA5sdEzRY4rJbXEmZDS891AgHMvEPDY85PYSeVLHBzE654+jCTAksMENScAU
	 IQMLSH+rki/HXxanXkqpQbY4JmiU3vmmkFLraoM5OXTVfvGFbcU0oMubjQjjFFdqhR
	 Qy/qH/zfvDCp8WZFqwg18Rjq7+JuCEvWeLKnnZAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephane Eranian <eranian@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 219/252] perf/x86/intel/ds: Dont clear ->pebs_data_cfg for the last PEBS event
Date: Mon,  8 Apr 2024 14:58:38 +0200
Message-ID: <20240408125313.454640910@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 312be9fc2234c8acfb8148a9f4c358b70d358dee upstream.

The MSR_PEBS_DATA_CFG MSR register is used to configure which data groups
should be generated into a PEBS record, and it's shared among all counters.

If there are different configurations among counters, perf combines all the
configurations.

The first perf command as below requires a complete PEBS record
(including memory info, GPRs, XMMs, and LBRs). The second perf command
only requires a basic group. However, after the second perf command is
running, the MSR_PEBS_DATA_CFG register is cleared. Only a basic group is
generated in a PEBS record, which is wrong. The required information
for the first perf command is missed.

 $ perf record --intr-regs=AX,SP,XMM0 -a -C 8 -b -W -d -c 100000003 -o /dev/null -e cpu/event=0xd0,umask=0x81/upp &
 $ sleep 5
 $ perf record  --per-thread  -c 1  -e cycles:pp --no-timestamp --no-tid taskset -c 8 ./noploop 1000

The first PEBS event is a system-wide PEBS event. The second PEBS event
is a per-thread event. When the thread is scheduled out, the
intel_pmu_pebs_del() function is invoked to update the PEBS state.
Since the system-wide event is still available, the cpuc->n_pebs is 1.
The cpuc->pebs_data_cfg is cleared. The data configuration for the
system-wide PEBS event is lost.

The (cpuc->n_pebs == 1) check was introduced in commit:

  b6a32f023fcc ("perf/x86: Fix PEBS threshold initialization")

At that time, it indeed didn't hurt whether the state was updated
during the removal, because only the threshold is updated.

The calculation of the threshold takes the last PEBS event into
account.

However, since commit:

  b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")

we delay the threshold update, and clear the PEBS data config, which triggers
the bug.

The PEBS data config update scope should not be shrunk during removal.

[ mingo: Improved the changelog & comments. ]

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240401133320.703971-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/ds.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1236,11 +1236,11 @@ pebs_update_state(bool needed_cb, struct
 	struct pmu *pmu = event->pmu;
 
 	/*
-	 * Make sure we get updated with the first PEBS
-	 * event. It will trigger also during removal, but
-	 * that does not hurt:
+	 * Make sure we get updated with the first PEBS event.
+	 * During removal, ->pebs_data_cfg is still valid for
+	 * the last PEBS event. Don't clear it.
 	 */
-	if (cpuc->n_pebs == 1)
+	if ((cpuc->n_pebs == 1) && add)
 		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {



