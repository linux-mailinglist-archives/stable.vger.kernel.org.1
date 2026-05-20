Return-Path: <stable+bounces-251942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEH+Kkv2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E7595045
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC82D30E7743
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C23F20F9;
	Wed, 20 May 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yC6gsS/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A63F20FA;
	Wed, 20 May 2026 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299333; cv=none; b=JQeQpwQkg72s6v2x+7naZcact4WWnouYCpyA4Z7CaCpakEgL0Ac3l/YcmakMWijlMU472h/atasTqSpBrwtZzKPkDMKVtO0g4YDgpdVmQObQyy6MOZMExvwbFvqnDkj9J/rppjEb/Z638YOjqK/nv5DHlOctwgKPnp3YWJK7YUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299333; c=relaxed/simple;
	bh=/uVcYS2EpD2Ih7kACWk3NsJTxsTWGpLg9Mgw/zzIYuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZPfciOwkXIlB0xdNaPq3s7HOB/zTQ7rop+PI9OA5tqdnK6IlaRRPawftllIXczB+AjYNQ0KowI8R3rRlUNCzgzQdrLbBA69kHGbiMG+DqoYRfogftKGBdCf9yUIYb2ZImezhn4MOSAa3QdjbOWH91JXdjEiiXi4iC5DDWiEmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yC6gsS/q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A881F000E9;
	Wed, 20 May 2026 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299332;
	bh=bz1I+4Tpip2BqS99p7nn7VmFa86ecsspVL9hqwWH8bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yC6gsS/qTk/0KZ1pYd4ZbHkR29ZjQgMXslyz9AMaovvTul1yGEwSNCJz5L1xEE5bU
	 /KFBuS+8o0pSvDit8+Fwl1c8QY03/wPpRIkaFtN/uMjwERuDI/AWZ4//Kjc+PFe+AV
	 U4h2jj6cOlAR7RTb5SzxVc7CA8LfENWOGn2e7c2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason-JH Lin <jason-jh.lin@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 732/957] mailbox: mtk-cmdq: Fix CURR and END addr for task insert case
Date: Wed, 20 May 2026 18:20:15 +0200
Message-ID: <20260520162150.431328227@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251942-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,mediatek.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7C8E7595045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH Lin <jason-jh.lin@mediatek.com>

[ Upstream commit d2591db9c8ef19fbb4d24ed15e0c6edfa6bc7917 ]

Fix CURR and END address calculation for inserting a cmdq task into the
task list by using cmdq_reg_shift_addr() for proper address converting.
This ensures both CURR and END addresses are set correctly when
enabling the thread.

Fixes: a195c7ccfb7a ("mailbox: mtk-cmdq: Refine DMA address handling for the command buffer")
Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 5791f80f995ab..a1360b70b83fb 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -434,14 +434,14 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 		if (curr_pa == end_pa - CMDQ_INST_SIZE ||
 		    curr_pa == end_pa) {
 			/* set to this task directly */
-			writel(task->pa_base >> cmdq->pdata->shift,
-			       thread->base + CMDQ_THR_CURR_ADDR);
+			gce_addr = cmdq_convert_gce_addr(task->pa_base, cmdq->pdata);
+			writel(gce_addr, thread->base + CMDQ_THR_CURR_ADDR);
 		} else {
 			cmdq_task_insert_into_thread(task);
 			smp_mb(); /* modify jump before enable thread */
 		}
-		writel((task->pa_base + pkt->cmd_buf_size) >> cmdq->pdata->shift,
-		       thread->base + CMDQ_THR_END_ADDR);
+		gce_addr = cmdq_convert_gce_addr(task->pa_base + pkt->cmd_buf_size, cmdq->pdata);
+		writel(gce_addr, thread->base + CMDQ_THR_END_ADDR);
 		cmdq_thread_resume(thread);
 	}
 	list_move_tail(&task->list_entry, &thread->task_busy_list);
-- 
2.53.0




