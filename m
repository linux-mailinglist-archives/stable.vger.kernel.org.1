Return-Path: <stable+bounces-186471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB60BE9A87
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F807404DD
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907836CDEF;
	Fri, 17 Oct 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4VWj8zT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6436CE08
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713336; cv=none; b=LLDQak9Khb6R+9WfjCNvv/WkqRFeU1KcfKZ2rInGj8WbZDOMBdcVITq+lz3ah9car9+bUe6+52ak6Eyg/JQ8d97zUH1OMYUhYPKy0Tj0rEktQ+AjRk9i4Qn0i0LbTbHnhBCjOi/14mgaZRs4ZZ3ScJylLaaQAtLWoBeNzlzoAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713336; c=relaxed/simple;
	bh=5eGaiz+PrBBHCxWUkCi8Bc/n5i9mP8Pf38aMLhAHt3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn3rGCKbkjfhwtem55R+uIgt+NYIbZyWRvITxGoPzesM3LgPL96yZ3qTpkphfE2MjMnMrTeT8F9URrLqlFwA4JSXHT2z/ecYpokeYUGvBfPyYPSv2+9KBmTQfUlVucbx8kZv6vEzKCPQAOlGZIaOWjcqoKNxIjY8GHRf+iNJktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4VWj8zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA7C4CEE7;
	Fri, 17 Oct 2025 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760713335;
	bh=5eGaiz+PrBBHCxWUkCi8Bc/n5i9mP8Pf38aMLhAHt3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4VWj8zT7y5PNLGRbYObdhfrenOWuxt03mFysu9VQh3byTDoeCo1atQ0b6n1L1WPk
	 07jMd4NRRvvXNI1n/zedCGzA+thGqWJgnZPc2unOsO9HS9um9FO1U3/HUOYg476pU/
	 s+RinIsLA+9OFIrQcMVCcGUaDngRg1DukSFLnMZ5wG7DElJBa3tAgfztlWGSwOwgRe
	 y0hfTmec5Pue7BWEfYIRbeZ5lrrkghzWrVZkt7F3ixcRa9RopjxTX76tmjerBuYGI/
	 vjkeUrikcUIFbmrKMke3J7jqnb1vtEiB03A1/6WqBLUkWI+oFL7Rk3HC/Po4FsLcD/
	 Sv03YwJKdt7wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] xen/events: Update virq_to_irq on migration
Date: Fri, 17 Oct 2025 11:02:13 -0400
Message-ID: <20251017150213.4015434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101619-gallantly-clambake-79c5@gregkh>
References: <2025101619-gallantly-clambake-79c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 3fcc8e146935415d69ffabb5df40ecf50e106131 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/events/events_base.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index f8554d9a9f28e..a796db52cf681 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1717,9 +1717,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0) {
+		int old_cpu = info->cpu;
+
 		bind_evtchn_to_cpu(evtchn, tcpu);
 
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
-- 
2.51.0


