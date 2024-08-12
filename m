Return-Path: <stable+bounces-66487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3F94EC3F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89C3B21CA8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD21779A4;
	Mon, 12 Aug 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9D+msMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BA27457
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464107; cv=none; b=ST38262PRUu8sJRrgP0l3nwX51eIPm8tyWmbtMTwoOb7DcUSZDxV0ky6HWhm9tu8VCHk+mr/2GfQCmk3dgSPfTRK62qZzJc2n/O0MKa58+OWcNm9lzzHhRGLnl7dimrwfroHowYPLcdsxjHP0FBCjxzkNMXQI7ILucjEVMIXc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464107; c=relaxed/simple;
	bh=GcG11/aoKOU+8HkeVbso9mnrQQ9uXF3lVmzF8Mi9FGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zei3qDxTVBtxodT/j8WvghVBDNoBFDBRn3djxePUnfDYIUyKjsHjdOJy46DbRux3oqxMVvG5ikY/aRkFszKoWmILIB+JQJUKz0I+uS3+QcdpoNZBM/FXUREBqD6CdldP/7Zz5SDOVfe9Q2xnuw7lnVl4D2FLzBqxlGrs0yogeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9D+msMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C040C32782;
	Mon, 12 Aug 2024 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464107;
	bh=GcG11/aoKOU+8HkeVbso9mnrQQ9uXF3lVmzF8Mi9FGk=;
	h=Subject:To:Cc:From:Date:From;
	b=L9D+msMVOUMi8kSOWn677qzAsz+sn+QA9+3bxWRWDO+gNdRY6AtCZOtqSRYaF4OSi
	 RhBH2zn0I54O7jWCNHU8HRw0LJOSB85QbN8G2JT0U1M7z8d96INWaHh6G52NzuBBDj
	 0eXFZONzAaHHW/pUrsKOltF5bKKtoYLiJVC8D3kM=
Subject: FAILED: patch "[PATCH] genirq/irqdesc: Honor caller provided affinity in" failed to apply to 4.19-stable tree
To: shayd@nvidia.com,stable@vger.kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:01:44 +0200
Message-ID: <2024081244-luminous-french-8b11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x edbbaae42a56f9a2b39c52ef2504dfb3fb0a7858
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081244-luminous-french-8b11@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

edbbaae42a56 ("genirq/irqdesc: Honor caller provided affinity in alloc_desc()")
c410abbbacb9 ("genirq/affinity: Add is_managed to struct irq_affinity_desc")
bec04037e4e4 ("genirq/core: Introduce struct irq_affinity_desc")
c2899c3470de ("genirq/affinity: Remove excess indentation")
6da4b3ab9a6e ("genirq/affinity: Add support for allocating interrupt sets")
060746d9e394 ("genirq/affinity: Pass first vector to __irq_build_affinity_masks()")
5c903e108d0b ("genirq/affinity: Move two stage affinity spreading into a helper function")
b82592199032 ("genirq/affinity: Spread IRQs to all available NUMA nodes")
4c1ef72e9b71 ("PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edbbaae42a56f9a2b39c52ef2504dfb3fb0a7858 Mon Sep 17 00:00:00 2001
From: Shay Drory <shayd@nvidia.com>
Date: Tue, 6 Aug 2024 10:20:44 +0300
Subject: [PATCH] genirq/irqdesc: Honor caller provided affinity in
 alloc_desc()

Currently, whenever a caller is providing an affinity hint for an
interrupt, the allocation code uses it to calculate the node and copies the
cpumask into irq_desc::affinity.

If the affinity for the interrupt is not marked 'managed' then the startup
of the interrupt ignores irq_desc::affinity and uses the system default
affinity mask.

Prevent this by setting the IRQD_AFFINITY_SET flag for the interrupt in the
allocator, which causes irq_setup_affinity() to use irq_desc::affinity on
interrupt startup if the mask contains an online CPU.

[ tglx: Massaged changelog ]

Fixes: 45ddcecbfa94 ("genirq: Use affinity hint in irqdesc allocation")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20240806072044.837827-1-shayd@nvidia.com

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 07e99c936ba5..1dee88ba0ae4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;


