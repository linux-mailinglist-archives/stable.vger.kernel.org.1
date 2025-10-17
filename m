Return-Path: <stable+bounces-186326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC11BE8F85
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE73B3AC8C6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703D2F6917;
	Fri, 17 Oct 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmfphyMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AF2F6903
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708480; cv=none; b=iaNQzlaubEq4Unxn31Ip8cWYi6DiPhZRX1qDv9MBNjPMsbn8W67ao7RzFQ0p7Fb3c5TITfubdCdypcv6tFC4RAP+w14DeDZLNQwHyBjQOHhLuIA7VZHDfSxyEtNEO+GdwqFGVfamwYpqoBNizEZz9KZMg+kMxMc9mfVRYm3XhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708480; c=relaxed/simple;
	bh=JhKM1twmyGRUlGozf7ey04Kx16HnuDL7crp/4UbnO7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp43WP2cIN6KHe3SuyZK5fUTBqLjUCIZIwMqmzAAwqH+8UxB6tt1R07l2E476pxAVAM46fcLVbomKZZ796YIRJofK2nt/5TeTQexPwEyqn+Z8TyIxnl5XO4b6x45aWidREjEcUHC5+R9CktrJvFZV5WBgMtmzKdIaCjSicGFjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmfphyMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C98C4CEE7;
	Fri, 17 Oct 2025 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760708480;
	bh=JhKM1twmyGRUlGozf7ey04Kx16HnuDL7crp/4UbnO7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmfphyMC7io14BvHzY6i3nwKbOcfA//t4VtB6ZZDeLyP+jmsRT+D4llPGGyb80XV6
	 PwAOgmTkM+q2uAR6Zsobauo3ISt8S7ffqmFyqhxcRi9mGUbMgz+I6dxp2FiqPzWKzJ
	 EjJaiyuLw9IdG+nchTq2ebTni02XYbpURjcJuQFjHzRmfBbAOXNjBhxXX4SURDj6WV
	 ijxvQaUUYCBXtyqT10FDMZR/UcuSbhygmI+4NWx+MK5C9imvypj/GS+JtjOfP1HFfT
	 b+2Q8ndxrGF5HbIeaZG7AobxTWSpsYfkn1sGPepDWvwH0ZnRuFv+/DMwVm85RDLfX8
	 kJTWIDzAR+fKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xen/events: Update virq_to_irq on migration
Date: Fri, 17 Oct 2025 09:41:17 -0400
Message-ID: <20251017134117.3957210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101617-tadpole-sneer-4143@gregkh>
References: <2025101617-tadpole-sneer-4143@gregkh>
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
index 96b96516c9806..93b09fd1fabfb 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1806,9 +1806,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * virq or IPI channel, which don't actually need to be rebound. Ignore
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0) {
+		int old_cpu = info->cpu;
+
 		bind_evtchn_to_cpu(evtchn, tcpu, false);
 
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


