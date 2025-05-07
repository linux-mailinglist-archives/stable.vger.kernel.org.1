Return-Path: <stable+bounces-142631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9563AAEB6F
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3507B8A99
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073681E1DF6;
	Wed,  7 May 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaLgGzmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886E2144BF;
	Wed,  7 May 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644846; cv=none; b=kZ07JTxKEoiV2wp8tHqMa9aU5UKfOya3Y97lDEcTPkHiWYzqn4GyaJ5NCI5Rlbivr54qPeb3YQrNW2In5hUiD79LrGnEggnKpeO/rx8PBNblEr38QkZqFtbG5KTX2OzAhEAhPL9n6bwYPOOsziEx+tFRimbUk0mIlkc7T4NjKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644846; c=relaxed/simple;
	bh=MiUt3pxvSzBp/X4vazk9WYdyZ3lHhUHmcCdIpRmOlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lasi0lutBt+9TFIvVvY3m+Wieifn81aXa+5OuJug87uzoL04ZfC35bnKZy2UFqmPFUdNfDqzYEABc7l3Y/sYI/AFiqbiRmX2+Kjbe3Dk6PViG6UrMhC1Al1hq5HAvLygvQD8fjIRTaf1IQSvI0+QdbeUkbI4ugng/0oAQueoOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaLgGzmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47209C4CEE2;
	Wed,  7 May 2025 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644846;
	bh=MiUt3pxvSzBp/X4vazk9WYdyZ3lHhUHmcCdIpRmOlbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaLgGzmFeD7mieT5T5QCIO6OW5KhhHHLF+O/ZT8W7luTDROUgMuZlrLdX/ktQN1cB
	 YZtc0CNrK3+1ZiR6bxuBmapq12fKgHC8eabpfXC5zdaotBV41q963Umo7VpeEZHCF5
	 ODFA3KqQtKbcO46/nI4AmYVAwQSFmthEqH+saZAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seth Forshee <sforshee@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 6.6 012/129] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPUs value.
Date: Wed,  7 May 2025 20:39:08 +0200
Message-ID: <20250507183814.036055162@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Sean Christopherson <seanjc@google.com>

commit 58f6217e5d0132a9f14e401e62796916aa055c1b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4206,7 +4206,7 @@ static struct perf_guest_switch_msr *int
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {



