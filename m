Return-Path: <stable+bounces-155026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E6AE16F7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11F74A5F5F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941F27F756;
	Fri, 20 Jun 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2tBeHP2w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C327F170
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410383; cv=none; b=eIpwEp6AINfM2gJp4UJsddTKC+oX4JgWVJh4BrY07MhL2exe3hWcbAPB4HcKJ8GScLVyhzcsOlvWp4ppTsJKZCMAq7x/qwYyYFENn+STiaCZYnU37EratzPAvE2LVvCDt6rT1TRIQ6O3zXLWqwNlua3od0/M4azvCG5ACa2hIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410383; c=relaxed/simple;
	bh=ZBIOn3pKt2i41/PZXHj5vxMvgR5fALlDcVUfLUdLhDQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B4UDE2/Ca/C5vWHhFuSdGg3fMjbtIY8F+o02zGvwzshfJdWqhWNtnJrO1mRVOgNrw9kbKn1a+JtTU2u7wIFftcMA08Rg2P8V6XyUCc17PGpYiGwskkVKZi/ptOR9xQgSfaerhJhtpYY4twYx/ykPSfIi9G04OGjHTuNc5byrjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2tBeHP2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4BC4CEE3;
	Fri, 20 Jun 2025 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410383;
	bh=ZBIOn3pKt2i41/PZXHj5vxMvgR5fALlDcVUfLUdLhDQ=;
	h=Subject:To:Cc:From:Date:From;
	b=2tBeHP2wh3WLdsuaga+q1C+VZRGt6CxeQA1CQyyv89UNdzrTnQhG/lO6MRApLQ+jy
	 lSrGRGsmAvbK3BZOEG+pt1DdnWAyngCvHWSVmRqa7vWUA4Cci9lYczO5/dhcnE9d3h
	 kecNORTlgKYQOq1KAcnwxa6R364QtaYAnhBx4/jo=
Subject: FAILED: patch "[PATCH] KVM: SVM: Clear current_vmcb during vCPU free for all" failed to apply to 5.4-stable tree
To: yosry.ahmed@linux.dev,jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:06:12 +0200
Message-ID: <2025062012-recolor-tameness-9454@gregkh>
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
git cherry-pick -x 1bee4838eb3a2c689f23c7170ea66ae87ea7d93a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-recolor-tameness-9454@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


