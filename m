Return-Path: <stable+bounces-155025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F5AE16F6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F774A5F24
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0E27F751;
	Fri, 20 Jun 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LsPCVH9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6E2356C7
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410374; cv=none; b=Z6UH3A2BRxctNP54neiauk5ASd5pu0ykOabMlsIMJFDQ+3Q8DmtRKXTfgCjtRkrQ/3CwVKd6EN0xZr3O0pzlke3EOPVo2kDX4iqz3G6IiJYvYKyLdgLoji+sN71ssAlgTU+jYVa/N7m/iwHMe79dJCvTz2dQSQ3zCQ4QBRG9ISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410374; c=relaxed/simple;
	bh=Es1Yagx2gL9By23vdt8KoYyT5rgAs6eaZa+1fsFmrOY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SYpgPDcAsmCM9e1G+lF+OIAF2nM9tmDWxFBFfs+A99K06li9T97vOaqC8XBR3tHPmp1ObYpt7NnxHBG0oInMzszAIM9fs1TVQwRGy5aUrflnnVUBlnXn2q0RGsVkB0nbiHv25tiIYu8lHE4I9SxQQpOM0Y5KHtLATvs2bZLYMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LsPCVH9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1488C4CEE3;
	Fri, 20 Jun 2025 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410374;
	bh=Es1Yagx2gL9By23vdt8KoYyT5rgAs6eaZa+1fsFmrOY=;
	h=Subject:To:Cc:From:Date:From;
	b=LsPCVH9DvjGOeu8VWW2tFobxvmWO1Bf5q3b+7dBUeZWlFJTLiI7ks6YS+dTbDdL2M
	 mkmT0Wcg6iocE/YgvWbnJ/jGqWStKVTkTKALseZYERSmRNXsxmCtDJNpvzIUTz/xmD
	 GuPSxIz551jZxIQ5spU+43U8VdQFwz68qy/P2fS4=
Subject: FAILED: patch "[PATCH] KVM: SVM: Clear current_vmcb during vCPU free for all" failed to apply to 5.15-stable tree
To: yosry.ahmed@linux.dev,jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:06:11 +0200
Message-ID: <2025062011-strained-factoid-f2fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1bee4838eb3a2c689f23c7170ea66ae87ea7d93a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062011-strained-factoid-f2fc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bee4838eb3a2c689f23c7170ea66ae87ea7d93a Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Tue, 29 Apr 2025 08:32:15 -0700
Subject: [PATCH] KVM: SVM: Clear current_vmcb during vCPU free for all
 *possible* CPUs

When freeing a vCPU and thus its VMCB, clear current_vmcb for all possible
CPUs, not just online CPUs, as it's theoretically possible a CPU could go
offline and come back online in conjunction with KVM reusing the page for
a new VMCB.

Link: https://lore.kernel.org/all/20250320013759.3965869-1-yosry.ahmed@linux.dev
Fixes: fd65d3142f73 ("kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb")
Cc: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8eb482ca3359..e6802e33c54d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1496,7 +1496,7 @@ static void svm_clear_current_vmcb(struct vmcb *vmcb)
 {
 	int i;
 
-	for_each_online_cpu(i)
+	for_each_possible_cpu(i)
 		cmpxchg(per_cpu_ptr(&svm_data.current_vmcb, i), vmcb, NULL);
 }
 


