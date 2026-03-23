Return-Path: <stable+bounces-229060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB2xFbJYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E27682F6030
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22C8630F99EB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6300726ED46;
	Mon, 23 Mar 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3FoQ5t0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265381DE4E0;
	Mon, 23 Mar 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277933; cv=none; b=K1brvhAVFGtVCejq9S0nxUayopEmOOTUzJq6tghRlegSXiaNQNzHw8avr7NrrYdXWzTwvww6xHudEhukOaArAAfGsMdhFXizGq4evDl+S9vgY+TldXqxQlacT9Kzo8pTTjNqAZmHmo7ZU0QX+uAACCYgIU+LagWHSDBt9m5iZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277933; c=relaxed/simple;
	bh=mlR32GblaanuWD+Ayy+ii8CnZauV55PTbZgX8+wQZ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoQ6iDycYqh4790BoBz9n1aRvyXfZ18evU8u/pCqOG/OnvjMTdB96ENPnaMWdzksTTwcGlb26+Lb7Tkgw7TpOur0anUD2GdtzM4PuAFIkDnFS5CpBGKbw9aVVpAO1YJNh7m2XMgLihUzdGuiFDmKlTXk43/NY32mOghdoEymDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3FoQ5t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2FAC4CEF7;
	Mon, 23 Mar 2026 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277933;
	bh=mlR32GblaanuWD+Ayy+ii8CnZauV55PTbZgX8+wQZ6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3FoQ5t0gyqTGtRPuPIxacafEVCwbBEC8s+JwSMPV3uNwCdBW+V4MoUeocueZnr0y
	 oJPSCroh3G4QqUgDI3yFyWTlhWoBGf+OrMsgxmthf7fI/GqfbOUaCIErw0VVydDJB/
	 R8H30p2xT9Z0M7t5Df9izQ1BNARZvNplPyg9bb64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 149/567] octeon_ep: Relocate counter updates before NAPI
Date: Mon, 23 Mar 2026 14:41:09 +0100
Message-ID: <20260323134537.518638753@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229060-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E27682F6030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vimlesh Kumar <vimleshk@marvell.com>

[ Upstream commit 18c04a808c436d629d5812ce883e3822a5f5a47f ]

Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion,
and replace napi_complete with napi_complete_done.

Moving the IQ/OQ counter updates before napi_complete_done ensures
1. Counter registers are updated before re-enabling interrupts.
2. Prevents a race where new packets arrive but counters aren't properly
   synchronized.
napi_complete_done (vs napi_complete) allows for better
interrupt coalescing.

Fixes: 37d79d0596062 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
Link: https://patch.msgid.link/20260227091402.1773833-2-vimleshk@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeon_ep/octep_main.c   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index db24c290a9079..111caa5ce12fa 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -534,12 +534,12 @@ static void octep_clean_irqs(struct octep_device *oct)
 }
 
 /**
- * octep_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ * octep_update_pkt() - Update IQ/OQ IN/OUT_CNT registers.
  *
  * @iq: Octeon Tx queue data structure.
  * @oq: Octeon Rx queue data structure.
  */
-static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
+static void octep_update_pkt(struct octep_iq *iq, struct octep_oq *oq)
 {
 	u32 pkts_pend = oq->pkts_pending;
 
@@ -555,7 +555,17 @@ static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
 	}
 
 	/* Flush the previous wrties before writing to RESEND bit */
-	wmb();
+	smp_wmb();
+}
+
+/**
+ * octep_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @oq: Octeon Rx queue data structure.
+ */
+static void octep_enable_ioq_irq(struct octep_iq *iq, struct octep_oq *oq)
+{
 	writeq(1UL << OCTEP_OQ_INTR_RESEND_BIT, oq->pkts_sent_reg);
 	writeq(1UL << OCTEP_IQ_INTR_RESEND_BIT, iq->inst_cnt_reg);
 }
@@ -581,7 +591,8 @@ static int octep_napi_poll(struct napi_struct *napi, int budget)
 	if (tx_pending || rx_done >= budget)
 		return budget;
 
-	napi_complete(napi);
+	octep_update_pkt(ioq_vector->iq, ioq_vector->oq);
+	napi_complete_done(napi, rx_done);
 	octep_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
 	return rx_done;
 }
-- 
2.51.0




