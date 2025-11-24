Return-Path: <stable+bounces-196680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC288C80006
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6343A7370
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E082F60CC;
	Mon, 24 Nov 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="abFSSo5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282926A08A
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981569; cv=none; b=rT5mViK9nLhAkNHvzPHRKXe8K5Guj3xmMB1KCYdUNMXULulJOtl44CANk1U7gR0+R3yiX+2fePuz+h3QF+DRm6KwgiWn6qj6YxWunPXQJ0zXJwwbo2C5n3gqVE7SMqfYV7iM8rjHYETRZuhbQ8ZO5PrCJLv1Whrmnu5neWaF4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981569; c=relaxed/simple;
	bh=D1YzZShyg2AJKXWaZhnmfIM9niZbxJcOSQSSfv/djcw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dbTHBRjrsZT6dwhnTBSrQkS2Lp/dnJLBzwAYoCffIXor20ZMMHj37OsyPES92mJ/5eZW6GHlGCVzIUuo+M588WMr/VuG1HwR1Zkbe4oF+xuUNw1mFsuzwL4dhyA75cwFkPwvKURyT50vxRhyTOfVMLuMRZluD2qlhwPIe9ljBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=abFSSo5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E15C4CEF1;
	Mon, 24 Nov 2025 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763981568;
	bh=D1YzZShyg2AJKXWaZhnmfIM9niZbxJcOSQSSfv/djcw=;
	h=Subject:To:Cc:From:Date:From;
	b=abFSSo5d+D54sRd4JtyHISFTZd7DvpTf4piTedHIDNRnACWc4S5up5awnSfYvCx0j
	 loDK3rpWD1iYrMOZjM+BLBD2ymELD4qkMcLpZpOxVaFGBkOAg3bt1zo7AQ0vrOefB8
	 8yjUCgTM+7GHey+bsOgMbLtQf5XbnEfSd2jtOrNI=
Subject: FAILED: patch "[PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share" failed to apply to 5.4-stable tree
To: sebastianene@google.com,maz@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 11:52:34 +0100
Message-ID: <2025112434-arise-unlimited-9689@gregkh>
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
git cherry-pick -x 103e17aac09cdd358133f9e00998b75d6c1f1518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112434-arise-unlimited-9689@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 103e17aac09cdd358133f9e00998b75d6c1f1518 Mon Sep 17 00:00:00 2001
From: Sebastian Ene <sebastianene@google.com>
Date: Fri, 17 Oct 2025 07:57:10 +0000
Subject: [PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share

Verify the offset to prevent OOB access in the hypervisor
FF-A buffer in case an untrusted large enough value
[U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
is set from the host kernel.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4e16f9b96f63..58b7d0c477d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges;
+	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -516,7 +516,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
-	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
+	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	if (fraglen < checked_offset) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
 	}


