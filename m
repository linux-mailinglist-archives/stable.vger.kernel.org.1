Return-Path: <stable+bounces-186328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA4CBE9126
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7DA84ECD01
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0D3570D4;
	Fri, 17 Oct 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZvMxs+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE18231C9F
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709345; cv=none; b=Geu+9wfaJyZavH7hOnIK7B27t+ZwrGmFSS32SA0VtksNpCH1gDxiTBtxjJOX4pCuyjtaZzhEFE77sqlS7vkuTW2NQKDaLWF09vmJ0RgcZliG3pM2hAKBH1KzpiEm/MO53xspf6/0NrlAG3ywDFqwZ986N6PMm74VZuvEE7xslsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709345; c=relaxed/simple;
	bh=6OcPCLr9K/yiVVwBCZlilMm64cfDtSNnNdNmbvnmG3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyjiJRmVDEYCfV+3nrZFBL7kA3l4oEaaDQArBnCjithQfbHuDiznTYErGDg8VdJa95KINZltYBgf8Yi5XZfaj8HJ4vL9K81nVFWOA8eUt/mRmP/LolqdrXTYxJWUiRDeAJoxDXY8jpsVdMM7NROFdcr9kBhm9srxItWXeKQtx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZvMxs+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F48EC4CEE7;
	Fri, 17 Oct 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709344;
	bh=6OcPCLr9K/yiVVwBCZlilMm64cfDtSNnNdNmbvnmG3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZvMxs+MUoEBivlYPY8VgkPgcSI8pEAybvQkgjMx/6T/G++Ll3i0dgN74Iu42Dym5
	 RVx2RdiOY/Fuym6RctqF04Gh29/ZGfmwxE1jLpvzi0Qx6nZMbJQSVn/9Qt3qCBIi8G
	 C1N3gd9sYnR3nY1aGBNm578PqnUruuMIM+m3n6yaEMPz/KTr2vq+qW4LOcBL6sPLwY
	 DR3r6pcocOm7OxTiuw8X62J4ZkhDkxzhID7r0uDHm4Tj++TphBJUYyD6jedwbXo2rI
	 G3TOp7dj2Jmld5/LG5tMVL5koJj6YgqZRb7LsT+JrlRknYq6oZ1v8/+Ll7fUh5TOXm
	 Jo4jjQqx9jcpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xen/events: Update virq_to_irq on migration
Date: Fri, 17 Oct 2025 09:55:42 -0400
Message-ID: <20251017135542.3964097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101617-sullen-exploit-1442@gregkh>
References: <2025101617-sullen-exploit-1442@gregkh>
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
index 04ff194fecf42..d3b3fe4a5be4a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1819,9 +1819,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
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


