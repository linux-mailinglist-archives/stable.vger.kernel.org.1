Return-Path: <stable+bounces-32967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDBE88E85F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1005129B943
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FA4503E;
	Wed, 27 Mar 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0021SpI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9C1EF0D
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551525; cv=none; b=jNjgGat9G8nPWxqBf8mGDlS9KqaiR+YmtF3NRq1tgXWIGL9jrmNQu8Bu9ba590vA3rxQ6tXO5jQwCsBecblFMmuHYMPgVa3BElE35QWS4av+52dGPP4TqOlu3G+zUtHO7kNlVtv58FasLZoIoAl6tCWQ7DEqTVxJAF2drP37O34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551525; c=relaxed/simple;
	bh=a9c7P7r1qhUEtrD8o9lpBu9g9Okl7XUIw7pbVLmEvUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ENUq1bILcot0WV8jEXWhGp6BzxDZ6GRf/XoGfFV6Ey1TPRL0ACwvtwBTPepI5TDngIDvKIBf5sYPP1/Qlrty+mM4tkPDW1u30qHlrPWT1hc+liF+T/XJ0ju7/GxqBYl+yz9d2lWcLNOf7MVQjaGjnHFX7TQYFYXjIljqxgo1u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0021SpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05177C433C7;
	Wed, 27 Mar 2024 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711551524;
	bh=a9c7P7r1qhUEtrD8o9lpBu9g9Okl7XUIw7pbVLmEvUw=;
	h=Subject:To:Cc:From:Date:From;
	b=N0021SpIjqkn934sEPk58P0Vu3l8hKzJxACsX+9oy3Ub4osbzrDmYvqQINwocVIes
	 jwEYMD9VhKPJFH/oYTjr7VUIMTVd3hzu9nrrTfByBMzvBTVRkf3AilOZdJ4d1bgane
	 L5wrmNzEguuG+GXNuBbhwVAtbE8fyKWGone7tGio=
Subject: FAILED: patch "[PATCH] KVM: x86: Mark target gfn of emulated atomic instruction as" failed to apply to 5.15-stable tree
To: seanjc@google.com,dmatlack@google.com,jmattson@google.com,mkrebs@google.com,tatashin@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 15:58:41 +0100
Message-ID: <2024032739-sloped-goal-fadb@gregkh>
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
git cherry-pick -x 910c57dfa4d113aae6571c2a8b9ae8c430975902
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032739-sloped-goal-fadb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

910c57dfa4d1 ("KVM: x86: Mark target gfn of emulated atomic instruction as dirty")
5d6c7de6446e ("KVM: x86: Bail to userspace if emulation of atomic user access faults")
1c2361f667f3 ("KVM: x86: Use __try_cmpxchg_user() to emulate atomic accesses")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 910c57dfa4d113aae6571c2a8b9ae8c430975902 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 14 Feb 2024 17:00:03 -0800
Subject: [PATCH] KVM: x86: Mark target gfn of emulated atomic instruction as
 dirty

When emulating an atomic access on behalf of the guest, mark the target
gfn dirty if the CMPXCHG by KVM is attempted and doesn't fault.  This
fixes a bug where KVM effectively corrupts guest memory during live
migration by writing to guest memory without informing userspace that the
page is dirty.

Marking the page dirty got unintentionally dropped when KVM's emulated
CMPXCHG was converted to do a user access.  Before that, KVM explicitly
mapped the guest page into kernel memory, and marked the page dirty during
the unmap phase.

Mark the page dirty even if the CMPXCHG fails, as the old data is written
back on failure, i.e. the page is still written.  The value written is
guaranteed to be the same because the operation is atomic, but KVM's ABI
is that all writes are dirty logged regardless of the value written.  And
more importantly, that's what KVM did before the buggy commit.

Huge kudos to the folks on the Cc list (and many others), who did all the
actual work of triaging and debugging.

Fixes: 1c2361f667f3 ("KVM: x86: Use __try_cmpxchg_user() to emulate atomic accesses")
Cc: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <tatashin@google.com>
Cc: Michael Krebs <mkrebs@google.com>
base-commit: 6769ea8da8a93ed4630f1ce64df6aafcaabfce64
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20240215010004.1456078-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 48a61d283406..e4270eaa33df 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8007,6 +8007,16 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 
 	if (r < 0)
 		return X86EMUL_UNHANDLEABLE;
+
+	/*
+	 * Mark the page dirty _before_ checking whether or not the CMPXCHG was
+	 * successful, as the old value is written back on failure.  Note, for
+	 * live migration, this is unnecessarily conservative as CMPXCHG writes
+	 * back the original value and the access is atomic, but KVM's ABI is
+	 * that all writes are dirty logged, regardless of the value written.
+	 */
+	kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(gpa));
+
 	if (r)
 		return X86EMUL_CMPXCHG_FAILED;
 


