Return-Path: <stable+bounces-139148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F7AA4AF5
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69AA1BC0EEF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58025A2A6;
	Wed, 30 Apr 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTIblgKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZFtfpgp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A9258CC0;
	Wed, 30 Apr 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015560; cv=none; b=ktp/r0B5egUyh4xeO6wMlcm2HuZS8YkYiB+d30t5CePWs9uiThimHjiTwLlcL39qRzTcy4i10eLP8VC7Z18eFxoeBcHPh23cuh+FwX2Fu5zeGx38QEShjTQMlnqZilC9MFlwiVT74fj0LFATiEGx02bBdEM/O1WC7o0C0XhNY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015560; c=relaxed/simple;
	bh=nFYAW0v+9uHe4M6ljnmc4P4H29ga8YcCFjODz68mns4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MOjyjmvxX1zhQPEr6Ip+KQb2N+uYXcq4C/rx/zg5tmujDxnG7UW59UHZeYE/RLaMdgd4RFMXIQvxF0fnpoQ5PuMPO7CLoq8mIFe4LRW6vr9tRQ6sQkL6eQi8+IsErPWbzvkj5qdlje5gFSnE0nBhjCyJ7lCJ/Hz0PCSmIQee4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTIblgKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZFtfpgp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 12:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746015551;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qug2KW8awrP903hcx1xdDO2pRUhjcdkJTA7gXDOA/58=;
	b=aTIblgKksj+2K+y730TbSjvoUGomTRJbCBvJni2FjMZpyQ0LWzWNVIABdrmiu+xYalwihu
	xBJ4KU4r08Dvnn1Tqs0Bj1b39yakYcjA3s8HlPj6t8ksrvaJuy5CAozkV5pwL1GkO3eAWA
	k7qAzX+SNj13d8PrIlbOBY63G6TIzkAa0/w4f2wvB73caLyoBhKKa5YkLx3kAl74fD8faj
	AdMominHCyFBYyExA0OefBhyMTJLANsHwJoUc8lD1B1kM3auaJBPkJXqyL365UPOfh0kKL
	aZf3ZL7zAY7xld6Q5hm/GVTTRPpEdXogc9IDvCBg3RQPu5fIzwVjVu0DxmHBVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746015551;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qug2KW8awrP903hcx1xdDO2pRUhjcdkJTA7gXDOA/58=;
	b=dZFtfpgpBQISIexfSVdieKk2wNeD/kfG6VnkhHtnWKw3+GGT1GWCbnmscoHAedkcd4u75M
	jYswy6wwGzbmLLAw==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for
 guest with vCPU's value.
Cc: Seth Forshee <sforshee@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250426001355.1026530-1-seanjc@google.com>
References: <20250426001355.1026530-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601555003.22196.7586052125074681797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     58f6217e5d0132a9f14e401e62796916aa055c1b
Gitweb:        https://git.kernel.org/tip/58f6217e5d0132a9f14e401e62796916aa055c1b
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 25 Apr 2025 17:13:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Apr 2025 13:58:29 +02:00

perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPU's value.

When generating the MSR_IA32_PEBS_ENABLE value that will be loaded on
VM-Entry to a KVM guest, mask the value with the vCPU's desired PEBS_ENABLE
value.  Consulting only the host kernel's host vs. guest masks results in
running the guest with PEBS enabled even when the guest doesn't want to use
PEBS.  Because KVM uses perf events to proxy the guest virtual PMU, simply
looking at exclude_host can't differentiate between events created by host
userspace, and events created by KVM on behalf of the guest.

Running the guest with PEBS unexpectedly enabled typically manifests as
crashes due to a near-infinite stream of #PFs.  E.g. if the guest hasn't
written MSR_IA32_DS_AREA, the CPU will hit page faults on address '0' when
trying to record PEBS events.

The issue is most easily reproduced by running `perf kvm top` from before
commit 7b100989b4f6 ("perf evlist: Remove __evlist__add_default") (after
which, `perf kvm top` effectively stopped using PEBS).	The userspace side
of perf creates a guest-only PEBS event, which intel_guest_get_msrs()
misconstrues a guest-*owned* PEBS event.

Arguably, this is a userspace bug, as enabling PEBS on guest-only events
simply cannot work, and userspace can kill VMs in many other ways (there
is no danger to the host).  However, even if this is considered to be bad
userspace behavior, there's zero downside to perf/KVM restricting PEBS to
guest-owned events.

Note, commit 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily
in two rare situations") fixed the case where host userspace is profiling
KVM *and* userspace, but missed the case where userspace is profiling only
KVM.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Closes: https://lore.kernel.org/all/Z_VUswFkWiTYI0eD@do-x1carbon
Reported-by: Seth Forshee <sforshee@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250426001355.1026530-1-seanjc@google.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 00dfe48..c5f3854 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4395,7 +4395,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {

