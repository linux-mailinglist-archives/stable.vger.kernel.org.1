Return-Path: <stable+bounces-231107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH29LABIymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:53:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF43589C1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7A43019114
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AB3AE703;
	Mon, 30 Mar 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUzj8Cas"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3702609DC
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863996; cv=none; b=hOwhlOVKDjRh+UJy0sb+OdbrGw7ajx1SF9mDg7OmsEw+zW9KQtR9JAxIxnz04OoMd4iuv6WO4JzRJxXFwo3DW32JmI2+JPboKVGQ8480u6pdt/zzxfJwyX2F1D7PPk30xs5xxz9+vWn0CgcRpa8r+M/R1nKtpLr11lhGKB/Znf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863996; c=relaxed/simple;
	bh=WLyrUQs+CIrY9Qdlxc3Yo0NeCcde3G5RSASJ2bABxI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iGTq7UodJomEdaI3sH6CwojlFcqzZPH54JaPB1vDSVlVg7l75qWMyrEBlOKeta9IyeLfRJUrjINkDp7l0BbDVM0mMn7mUxDR4mHdUN/o156088ctj1Rw0g/4RCvKrbRSKbuR1nHNCDG3iagNlG2x2SenR2j7NnfyddCM7B2Zjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUzj8Cas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9804EC4CEF7;
	Mon, 30 Mar 2026 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863996;
	bh=WLyrUQs+CIrY9Qdlxc3Yo0NeCcde3G5RSASJ2bABxI4=;
	h=Subject:To:Cc:From:Date:From;
	b=qUzj8CashImI5KS/rjMfQumFnhKduIVNl1JJ6EX7/x7Dw8H1hV2bGA3wW0whj4EYB
	 jJM3l9q3jVLpf9LvKYdxPQpglaogVU6oyc6m7LC43Azfe92SH79NVMXbd08c91JwXQ
	 YeF6bIVFCHL3ePKL2WJf0Y8OW/977AlMJH5uH0Ug=
Subject: FAILED: patch "[PATCH] dmaengine: sh: rz-dmac: Protect the driver specific lists" failed to apply to 5.15-stable tree
To: claudiu.beznea@tuxon.dev,Frank.Li@nxp.com,claudiu.beznea.uj@bp.renesas.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:46:33 +0200
Message-ID: <2026033033-anaconda-untruth-e995@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[msgid.link:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,nxp.com:email,renesas.com:email]
X-Rspamd-Queue-Id: 76FF43589C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x abb863e6213dc41a58ef8bb3289b7e77460dabf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033033-anaconda-untruth-e995@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abb863e6213dc41a58ef8bb3289b7e77460dabf3 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Date: Mon, 16 Mar 2026 15:32:45 +0200
Subject: [PATCH] dmaengine: sh: rz-dmac: Protect the driver specific lists

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d84ca551b2bf..089e1ab29159 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -447,6 +448,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 		if (!desc)
 			break;
 
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -502,18 +504,21 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	dev_dbg(dmac->dev, "%s channel: %d src=0x%pad dst=0x%pad len=%zu\n",
 		__func__, channel->index, &src, &dest, len);
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	desc->type = RZ_DMAC_DESC_MEMCPY;
-	desc->src = src;
-	desc->dest = dest;
-	desc->len = len;
-	desc->direction = DMA_MEM_TO_MEM;
+		desc->type = RZ_DMAC_DESC_MEMCPY;
+		desc->src = src;
+		desc->dest = dest;
+		desc->len = len;
+		desc->direction = DMA_MEM_TO_MEM;
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	}
 
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -529,27 +534,29 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int dma_length = 0;
 	int i = 0;
 
-	if (list_empty(&channel->ld_free))
-		return NULL;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (list_empty(&channel->ld_free))
+			return NULL;
 
-	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
 
-	for_each_sg(sgl, sg, sg_len, i) {
-		dma_length += sg_dma_len(sg);
+		for_each_sg(sgl, sg, sg_len, i)
+			dma_length += sg_dma_len(sg);
+
+		desc->type = RZ_DMAC_DESC_SLAVE_SG;
+		desc->sg = sgl;
+		desc->sgcount = sg_len;
+		desc->len = dma_length;
+		desc->direction = direction;
+
+		if (direction == DMA_DEV_TO_MEM)
+			desc->src = channel->src_per_address;
+		else
+			desc->dest = channel->dst_per_address;
+
+		list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	}
 
-	desc->type = RZ_DMAC_DESC_SLAVE_SG;
-	desc->sg = sgl;
-	desc->sgcount = sg_len;
-	desc->len = dma_length;
-	desc->direction = direction;
-
-	if (direction == DMA_DEV_TO_MEM)
-		desc->src = channel->src_per_address;
-	else
-		desc->dest = channel->dst_per_address;
-
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 


