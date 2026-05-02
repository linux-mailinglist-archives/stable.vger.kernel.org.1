Return-Path: <stable+bounces-242579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 68NQFZlo9Wm7KwIAu9opvQ
	(envelope-from <stable+bounces-242579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F904B0B9D
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603863016CA4
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4B2C1788;
	Sat,  2 May 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgedaovP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED272C11D7
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777690773; cv=none; b=EF22w9jKF8i4LQWzVJv+odqKgDJZIOuJfPi2C8ey3WzUa841GF/YwYGjiqu3mGoOD/dJSMm/NeAYNSChGIAR1GD8tsLJmR3IkMK+KzugAFPuDrrfAXdqloOR10vfycjFUm3lNJQ35xenMmtvcV67ce8/UFFhenQvA1G4dWF51JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777690773; c=relaxed/simple;
	bh=Gep9kLWQM9tlejhuAhTtp6HB3asG19A6jnFp+37kL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH2t/ML6CvV4ix34TFIUci3hTUbVFuS1WVe0uNnWc+AOmKPuGo46dYxdLG5rckO++9vvORxWWNN7bEZeVFqfwQ/byS/ZyYr9cT+2mJUriHdQo4aDMdcshkRogKzwwgnuiQOed89H+IUVSMTBUHVyftXNWQZVoFi6+ru190n9rtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgedaovP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278CC2BCB4;
	Sat,  2 May 2026 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777690773;
	bh=Gep9kLWQM9tlejhuAhTtp6HB3asG19A6jnFp+37kL/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgedaovPLzvlt0bp+bhqnAsjc0qgW6cPgijRxZntqDpdcvVmbAwU9c1yqp43YvKXM
	 riTugLsBATgbHNwgvRAPXbm6vTgaJRgivrMiv93dPXqPtRV7mwUU2lyRIc9Q+b0Ygo
	 guAI0bvAMfc3fDuUlSELLbei6zoKHmzbwXIvwsPzpFOCzPTK/zJNcV70oErYYxKl/b
	 fPxvBE4PT6D7edVf4ziVn1r5F7XW69lypf2b5ijDUPeZugQVHEengEt35xI6UH/Ek2
	 qjeiB7radqKzclPuE4K36qgpJu59QJeU6KwnNlw2Ikc+r91nGi9vabtAuB+yG86c/2
	 jFCRzk7lGqmvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] RDMA/mana_ib: Disable RX steering on RSS QP destroy
Date: Fri,  1 May 2026 22:59:23 -0400
Message-ID: <20260502025930.238469-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050132-kinetic-idealize-dece@gregkh>
References: <2026050132-kinetic-idealize-dece@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8F904B0B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242579-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Long Li <longli@microsoft.com>

[ Upstream commit dbeb256e8dd87233d891b170c0b32a6466467036 ]

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
[ kept early-return error handling and used unquoted NET_MANA namespace in EXPORT_SYMBOL_NS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/qp.c               | 15 +++++++++++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
 include/net/mana/mana.h                       |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 4b3b5b274e849..8009a339bf9ca 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -449,6 +449,21 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	ndev = mc->ports[qp->port - 1];
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
index b56a337b1e212..343f6e879af39 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2380,6 +2380,13 @@ static void mana_rss_table_init(struct mana_port_context *apc)
 			ethtool_rxfh_indir_default(i, apc->num_queues);
 }
 
+int mana_disable_vport_rx(struct mana_port_context *apc)
+{
+	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
+				       false);
+}
+EXPORT_SYMBOL_NS(mana_disable_vport_rx, NET_MANA);
+
 int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab)
 {
@@ -2620,12 +2627,14 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 */
 
 	apc->rss_state = TRI_STATE_FALSE;
-	err = mana_config_rss(apc, TRI_STATE_FALSE, false, false);
+	err = mana_disable_vport_rx(apc);
 	if (err) {
 		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
 		return err;
 	}
 
+	mana_fence_rqs(apc);
+
 	mana_destroy_vport(apc);
 
 	return 0;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 7892b79854f62..d716771a7262c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -437,6 +437,7 @@ struct mana_port_context {
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 int mana_config_rss(struct mana_port_context *ac, enum TRI_STATE rx,
 		    bool update_hash, bool update_tab);
+int mana_disable_vport_rx(struct mana_port_context *apc);
 
 int mana_alloc_queues(struct net_device *ndev);
 int mana_attach(struct net_device *ndev);
-- 
2.53.0


