Return-Path: <stable+bounces-185910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D6BE23FE
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13B804E19FE
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03130C616;
	Thu, 16 Oct 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pV/DGa7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A42343B6
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605100; cv=none; b=pEMjTNoXv0itUa2k40xw/ef+NVzdAGSH3NwF02ZLvWNTBRILgIPwkNFQaxdHbGPaki3Tk4tZiBWPGRFF3tuodR/9vOGW8LCozjJivQsZJZZAJ6w1gliLv/Qeim1hqT9fRPAd6ItIq4jNAv793bSVRufTxauHswYyp1abJueN7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605100; c=relaxed/simple;
	bh=za1087yWek1XORvqzXdx3tvFhQU0i4B+MAWKTffVVgQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h8fp6RvxMkI8+jvNm7gOd+7mz7R7+H4R8tmN3ZRFP5cBsCKljSr1RKnxDuju7gbvxC1JPIkkcT8Ih+cHwHof/0w/RKEJTCSdftBFIJqv7BCMXXfvnAJWKBrKmWPXzjbZnPm7Nu5r9slKCkW4qiu/F0Iog3QUUUhnDHiSlc/sQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pV/DGa7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B31BC4CEF1;
	Thu, 16 Oct 2025 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605100;
	bh=za1087yWek1XORvqzXdx3tvFhQU0i4B+MAWKTffVVgQ=;
	h=Subject:To:Cc:From:Date:From;
	b=pV/DGa7foGR5jVoOXdtAF1wPOcyvunrcNvddFDAlQdMDRkJqX0T8qVz75Dg+oPAzh
	 42J6eFcdZiExkJ3p40S7H5lpKy1o+uH67iQGO/VhWmf2s8eHx0PkLIwRTxkjZ7khI9
	 oYgu7d+ufYJ+ALbkFSZF+z7xVBuIXDxOZm7mRsug=
Subject: FAILED: patch "[PATCH] xen/events: Update virq_to_irq on migration" failed to apply to 6.1-stable tree
To: jason.andryuk@amd.com,jgross@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:58:17 +0200
Message-ID: <2025101617-tadpole-sneer-4143@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3fcc8e146935415d69ffabb5df40ecf50e106131
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101617-tadpole-sneer-4143@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3fcc8e146935415d69ffabb5df40ecf50e106131 Mon Sep 17 00:00:00 2001
From: Jason Andryuk <jason.andryuk@amd.com>
Date: Wed, 27 Aug 2025 20:36:03 -0400
Subject: [PATCH] xen/events: Update virq_to_irq on migration

VIRQs come in 3 flavors, per-VPU, per-domain, and global, and the VIRQs
are tracked in per-cpu virq_to_irq arrays.

Per-domain and global VIRQs must be bound on CPU 0, and
bind_virq_to_irq() sets the per_cpu virq_to_irq at registration time
Later, the interrupt can migrate, and info->cpu is updated.  When
calling __unbind_from_irq(), the per-cpu virq_to_irq is cleared for a
different cpu.  If bind_virq_to_irq() is called again with CPU 0, the
stale irq is returned.  There won't be any irq_info for the irq, so
things break.

Make xen_rebind_evtchn_to_cpu() update the per_cpu virq_to_irq mappings
to keep them update to date with the current cpu.  This ensures the
correct virq_to_irq is cleared in __unbind_from_irq().

Fixes: e46cdb66c8fc ("xen: event channels")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250828003604.8949-4-jason.andryuk@amd.com>

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b060b5a95f45..9478fae014e5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1797,9 +1797,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0) {
+		int old_cpu = info->cpu;
+
 		bind_evtchn_to_cpu(info, tcpu, false);
 
+		if (info->type == IRQT_VIRQ) {
+			int virq = info->u.virq;
+			int irq = per_cpu(virq_to_irq, old_cpu)[virq];
+
+			per_cpu(virq_to_irq, old_cpu)[virq] = -1;
+			per_cpu(virq_to_irq, tcpu)[virq] = irq;
+		}
+	}
+
 	do_unmask(info, EVT_MASK_REASON_TEMPORARY);
 
 	return 0;


