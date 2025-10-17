Return-Path: <stable+bounces-186348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADBBE956C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F065867B5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAEF32E143;
	Fri, 17 Oct 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaBfGXbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC42F12BD
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712610; cv=none; b=u92zwUkDfeEbRPdGe7MUYQFTBlEW1CziamClU9LTELLjHe19gskBiomZ+xS5MD+ZJExTiPA1i73UyQMyqwXqU4yShyXYoFOvmsOY0XaD/gP+Pt16fQFQIb5hB8C/DTLgqtGxWldwrotNGDzopTmtSzOYheUZfW3HWnuyrfcEs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712610; c=relaxed/simple;
	bh=gRxMrX9zvTOUaiOhTz3mEBhCBLYycUZ3K8eMphNeaSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3AUTFJhddJRGgvXjMB4Pw0baWlvyNOC208aKJYY78QBD1EZHKveh4yU/lFAArFJzR4mUuxBXtCzA6DnWaSMyx0LMRPEbfzCVzuXwDm2kzZQ8T+KTqBFaweLdECBRafs/gC0kih1vl47l6aPbptzNvcOdJkgkPXzU2SHtIKu3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaBfGXbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C27CC4CEE7;
	Fri, 17 Oct 2025 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712610;
	bh=gRxMrX9zvTOUaiOhTz3mEBhCBLYycUZ3K8eMphNeaSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaBfGXbL0YflPKSrvDqXfUzJ1BANsVsBXmnd1nfBPP13Ezbr+15ywXBbrtHko/Lu7
	 I9+I9KyQnzLZE1M1ptuDWIq8k7RvXc5h1AAkK8BWDDER0JKccqcHROR2jMlAhmRmkv
	 APFKIh3kkr6GnADMlxaWgwBYarwD9Qp72o9/+x5pPVXXiaZIdc8WJkMo//oxTSUZ9U
	 qKcUdBlRHkqBn332O47cvo1VJ25QoT35NkuzHJX2KgNCUKhgWBBhXsPu5X7Y6c64hJ
	 R00MOUALsdnQKj43thtWOVn8Lu6ch8YMTTk1uO4J902hEHQVB0J02pLI6Os4PqMSEL
	 cZKZsRWbWfhhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xen/events: Update virq_to_irq on migration
Date: Fri, 17 Oct 2025 10:50:07 -0400
Message-ID: <20251017145007.4008799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101618-dividend-motion-dcc1@gregkh>
References: <2025101618-dividend-motion-dcc1@gregkh>
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
index f608663bdfd5b..b0c8144cae36a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1745,9 +1745,20 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
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


