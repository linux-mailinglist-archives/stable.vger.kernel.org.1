Return-Path: <stable+bounces-155027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EBEAE16F9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFACD5A1508
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48C27FB35;
	Fri, 20 Jun 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7OXTvYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38527FB30
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410386; cv=none; b=m0Bd+sT2lzswbaMzW7VrFbagNHicCG25gO0mU0Pl4Nk0NNzKTyLM29Yw4xqV3dVQhVed4jz/PlH02sA7Y+kZK3yVp8dv6rSJj78LwQk2CZ9aKhJM9GvKz/GhHpyXI+dum/euvCG/4deQmRqMXHObRj/GNSjceASJhZQEu/h5wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410386; c=relaxed/simple;
	bh=YEJOmvxahThDxYPssRgkR7vjy9p/G6dq+7P4QlNC4vs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CDJc0djtlUlc+WUivPBhkZ2xgcWhXEnWDygHSDpQkuAehxOo+THJV61KGwwbOovjuXk6h69AEHAcRXIgjfGm2K+EQ+TD+UoQfYGn7c3cNDz2h8hCDBXw1HWVzxBGHtAqFyiIn1isZHDVUMIvTMm139QktW76+0tcSq6y+/WgfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7OXTvYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82522C4CEED;
	Fri, 20 Jun 2025 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410385;
	bh=YEJOmvxahThDxYPssRgkR7vjy9p/G6dq+7P4QlNC4vs=;
	h=Subject:To:Cc:From:Date:From;
	b=z7OXTvYTsgIeXY3PWoVZSJd0G00eJ3qqzj+xEd/O1PSn15Q+odSkcsvjX4hTu57Pf
	 itC+V+hbTtC2DGs8O11oHEwlx9UCY167pqmtcIxH1JrCsvgMogHkspIBVlBlqi3IFT
	 FyBRDY07hiezglbuJvzmnyDtk5sKGnJuaZGSzoes=
Subject: FAILED: patch "[PATCH] KVM: SVM: Clear current_vmcb during vCPU free for all" failed to apply to 5.10-stable tree
To: yosry.ahmed@linux.dev,jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:06:12 +0200
Message-ID: <2025062012-hardly-earthlike-2158@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1bee4838eb3a2c689f23c7170ea66ae87ea7d93a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-hardly-earthlike-2158@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


