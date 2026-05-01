Return-Path: <stable+bounces-242303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DDMCpKI9GnFCAIAu9opvQ
	(envelope-from <stable+bounces-242303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B82024ABD9E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B1563007497
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743339A812;
	Fri,  1 May 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DR7y61DE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772B394483
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633414; cv=none; b=W4yITjpfOkBXcOISvTe59m0uJhmLGrZV6jhka0hbGbeyh6snah80611zBuhzqyitm3R747Y2V4/6scac1NRxxyLFpd7CQAEWFHuGG6TWJG5G38YLgXrodPsRyBr2n1cQzNdtKzJOWyEFWqMztvK58msyjCPXPX+U2dPh5+yb2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633414; c=relaxed/simple;
	bh=p5dWufyf6EX/UA6y5zi+92TmtR6a0LEQ+/zfFG4auyA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pKnlXiQYdX/Sm07GnI6gjkF5oyA3xSta6SsdFFG+HcK28dflFcMn3DBBYRkw632n4xyFMk0Odiop/rHOrZJ2zsVXrzQl1DXnn5+UBAekEox160roVs/zcd6H7TZwc4abouzpDUqF1tY4PZBEyr+EbVW9kQ/Ir3EpGCcqGPNv188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DR7y61DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDC8C2BCB4;
	Fri,  1 May 2026 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633414;
	bh=p5dWufyf6EX/UA6y5zi+92TmtR6a0LEQ+/zfFG4auyA=;
	h=Subject:To:Cc:From:Date:From;
	b=DR7y61DEx355x1MRAGGOCAnqYtV311+txJg5bYxkMNb8gh/IFYYdidOoij4liqdn/
	 dhN2I3QJtHOPFHdv1YjsBNBzKraTBAW3yKG5bsU4M/yXhfIyfTgM2E03HSNt9svohn
	 1zhTg/DtTycYLb/mjslQdVvjR6LqjkSvPxHHstlM=
Subject: FAILED: patch "[PATCH] RDMA/mana_ib: Disable RX steering on RSS QP destroy" failed to apply to 6.12-stable tree
To: longli@microsoft.com,leon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:03:32 +0200
Message-ID: <2026050131-tanning-savor-298d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B82024ABD9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242303-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dbeb256e8dd87233d891b170c0b32a6466467036
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050131-tanning-savor-298d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbeb256e8dd87233d891b170c0b32a6466467036 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Wed, 25 Mar 2026 12:40:57 -0700
Subject: [PATCH] RDMA/mana_ib: Disable RX steering on RSS QP destroy

When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
destroys the RX WQ objects but does not disable vPort RX steering in
firmware. This leaves stale steering configuration that still points to
the destroyed RX objects.

If traffic continues to arrive (e.g. peer VM is still transmitting) and
the VF interface is subsequently brought up (mana_open), the firmware
may deliver completions using stale CQ IDs from the old RX objects.
These CQ IDs can be reused by the ethernet driver for new TX CQs,
causing RX completions to land on TX CQs:

  WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq == false)
  WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup fails)

Fix this by disabling vPort RX steering before destroying RX WQ objects.
Note that mana_fence_rqs() cannot be used here because the fence
completion is delivered on the CQ, which is polled by user-mode (e.g.
DPDK) and not visible to the kernel driver.

Refactor the disable logic into a shared mana_disable_vport_rx() in
mana_en, exported for use by mana_ib, replacing the duplicate code.
The ethernet driver's mana_dealloc_queues() is also updated to call
this common function.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://patch.msgid.link/20260325194100.1929056-1-longli@microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f3bb1edc7f79..e6fc3cc10795 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -799,6 +799,21 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
 
+	/* Disable vPort RX steering before destroying RX WQ objects.
+	 * Otherwise firmware still routes traffic to the destroyed queues,
+	 * which can cause bogus completions on reused CQ IDs when the
+	 * ethernet driver later creates new queues on mana_open().
+	 *
+	 * Unlike the ethernet teardown path, mana_fence_rqs() cannot be
+	 * used here because the fence completion CQE is delivered on the
+	 * CQ which is polled by userspace (e.g. DPDK), so there is no way
+	 * for the kernel to wait for fence completion.
+	 *
+	 * This is best effort — if it fails there is not much we can do,
+	 * and mana_cfg_vport_steering() already logs the error.
+	 */
+	mana_disable_vport_rx(mpc);
+
 	for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
 		ibwq = ind_tbl->ind_tbl[i];
 		wq = container_of(ibwq, struct mana_ib_wq, ibwq);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index dca62fb9a3a9..af2a35c09773 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2882,6 +2882,13 @@ static void mana_rss_table_init(struct mana_port_context *apc)
 			ethtool_rxfh_indir_default(i, apc->num_queues);
 }
 
+int mana_disable_vport_rx(struct mana_port_context *apc)
+{
+	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
+				       false);
+}
+EXPORT_SYMBOL_NS(mana_disable_vport_rx, "NET_MANA");
+
 int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab)
 {
@@ -3266,10 +3273,12 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 */
 
 	apc->rss_state = TRI_STATE_FALSE;
-	err = mana_config_rss(apc, TRI_STATE_FALSE, false, false);
+	err = mana_disable_vport_rx(apc);
 	if (err && mana_en_need_log(apc, err))
 		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
 
+	mana_fence_rqs(apc);
+
 	/* Even in err case, still need to cleanup the vPort */
 	mana_destroy_vport(apc);
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283bdd..743bfa8ad8e3 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -568,6 +568,7 @@ struct mana_port_context {
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 int mana_config_rss(struct mana_port_context *ac, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab);
+int mana_disable_vport_rx(struct mana_port_context *apc);
 
 int mana_alloc_queues(struct net_device *ndev);
 int mana_attach(struct net_device *ndev);


