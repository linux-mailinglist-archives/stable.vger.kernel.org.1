Return-Path: <stable+bounces-186844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFDBE9EBE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C972174206E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4FA2F692B;
	Fri, 17 Oct 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiR4znRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C62F12D0;
	Fri, 17 Oct 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714390; cv=none; b=GNXKJzsER5IXiFEImbeZAcPt1AtQaiGALCUcCrGd9dCNJb/y48tX2FolyHVk2ETpVSwmtaFM4U7PF1R6Rw+Yb173EHG6m1uNQUqwJD/Dv44Uizl7+WgUxJLL3aEByUCVUm1SzD4+pUoDx4mmvgCQ8xpiCf1iVZ9PFwK+LZXo2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714390; c=relaxed/simple;
	bh=3ylKpRZqMBDYArYQiFRnxZ74Ds7Bf56+jX0hQ/GiCAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb5xZ1d8uI1qqxjRWEm98LtUtlo9Uyljw/T5MwCysgvqTJJHWH4SYl+MpRsAD6W3k+QhLg6jqfrZJVHAj0rCAVU08R8gEGs6TId4YR0U4upIfin55A6iCc7euPFi/6qtPCd8KH97CKa41Gwak+F13bpy/kWLE/QI2VtrTk5I4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiR4znRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C685C4CEE7;
	Fri, 17 Oct 2025 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714389;
	bh=3ylKpRZqMBDYArYQiFRnxZ74Ds7Bf56+jX0hQ/GiCAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiR4znRA46d6EBiUjv8Eq4yX3dm/MucZWGUC6GQD2ramPaLcs290R3+Wg08VQijj+
	 LmQrqz6Qv6H75hzj4uZ6BMbLzWoP3FBckDWP9+ovVnsFp1YB9sPzcB+6pLQyRAQlii
	 ISRJhyxEMPvwPj4qaqOYjL3ZxNQFZ0jCAJ3bOHxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.12 101/277] xen/events: Update virq_to_irq on migration
Date: Fri, 17 Oct 2025 16:51:48 +0200
Message-ID: <20251017145150.819144960@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Andryuk <jason.andryuk@amd.com>

commit 3fcc8e146935415d69ffabb5df40ecf50e106131 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/events/events_base.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1803,9 +1803,20 @@ static int xen_rebind_evtchn_to_cpu(stru
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



