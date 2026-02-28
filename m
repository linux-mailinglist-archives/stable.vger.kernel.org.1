Return-Path: <stable+bounces-220417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA27HUc6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C627A1C66B7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090AA30D4FB6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FD03B11D8;
	Sat, 28 Feb 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvBBcpx0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C03B11CD;
	Sat, 28 Feb 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300308; cv=none; b=dLZtR3dubwHeo5tRBIbTLzY4VeY8cGHESOaTGg08w5wzuwYyKLNop4+A12SXlZelROpzlo86O13AL6q5fl4vocIFA2PS/hL8Ph2n0QN1/4yGdApr4HQ7poObnFf6xwJnMOs5SIlNutBvYGZ3kuAp8n9MoNZDRgc400DpJNuyvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300308; c=relaxed/simple;
	bh=cNvj1NBc8cBn42kCKtjDzK2Ax93s/bISUV+sR8cKvBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=did1ykZSoLjVfxO/Dkda+bQ+NMqoZ40vEwtaPetPIizge1nHBUroZurxg+3fVwDyPo5PnxVxCGtnKYAbj7Tah0ktg4XCeKwriUzmO3StfNDtP+FpFULgUT75DySj5L/bSYnZrnLjzLg8u6e+I9ZJEprYqOTCNarl3PoNSCo/PjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvBBcpx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FFEC116D0;
	Sat, 28 Feb 2026 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300308;
	bh=cNvj1NBc8cBn42kCKtjDzK2Ax93s/bISUV+sR8cKvBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvBBcpx07QjLzlC5HdqTNprxkAJ3DTi6kYybmOVe5e2+kAmv9aE2qKyUlLL8bRv33
	 8mB+5mBFglLrLyyhSWtKaa3Y7cD3I1ihxLGPSfmj2LLMpDF9F7HZiCUB0e+8tzapQw
	 npHQF0/kYH1HifiPeze6wfd3akLxjZNt/5rk7JYERCHeJxOcL+TsSprdr7b5i1n649
	 aoUoQw6sRfEF5+8EyM5/FsY02JcEBAOczBCqDDn1kMk0cLcd9kspSHy00cqnDBAxas
	 NLZrd9ujhUZt8/i+DaBdYibDOF8beYJ1KiZieSZjq+DcPFRCkEHtSkZqyvkgKCe0+B
	 oFCOU/QE8qYyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 338/844] myri10ge: avoid uninitialized variable use
Date: Sat, 28 Feb 2026 12:24:11 -0500
Message-ID: <20260228173244.1509663-339-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220417-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C627A1C66B7
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fd24173439c033ffb3c2a2628fcbc9cb65e62bdb ]

While compile testing on less common architectures, I noticed that gcc-10 on
s390 finds a bug that all other configurations seem to miss:

drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_set_multicast_list':
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:25: error: 'cmd.data0' is used uninitialized in this function [-Werror=uninitialized]
  391 |  buf->data0 = htonl(data->data0);
      |                         ^~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:25: error: '*((void *)&cmd+4)' is used uninitialized in this function [-Werror=uninitialized]
  392 |  buf->data1 = htonl(data->data1);
      |                         ^~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_allocate_rings':
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:13: error: 'cmd.data1' is used uninitialized in this function [-Werror=uninitialized]
  392 |  buf->data1 = htonl(data->data1);
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data1' was declared here
 1939 |  struct myri10ge_cmd cmd;
      |                      ^~~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:393:13: error: 'cmd.data2' is used uninitialized in this function [-Werror=uninitialized]
  393 |  buf->data2 = htonl(data->data2);
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data2' was declared here
 1939 |  struct myri10ge_cmd cmd;

It would be nice to understand how to make other compilers catch this as
well, but for the moment I'll just shut up the warning by fixing the
undefined behavior in this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20260205162935.2126442-1-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/myricom/myri10ge/myri10ge.c  | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 7be30a8df2685..2f0cdbd4e2ac9 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -688,6 +688,9 @@ static int myri10ge_get_firmware_capabilities(struct myri10ge_priv *mgp)
 
 	/* probe for IPv6 TSO support */
 	mgp->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO;
+	cmd.data0 = 0,
+	cmd.data1 = 0,
+	cmd.data2 = 0,
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_MAX_TSO6_HDR_SIZE,
 				   &cmd, 0);
 	if (status == 0) {
@@ -806,6 +809,7 @@ static int myri10ge_update_mac_address(struct myri10ge_priv *mgp,
 		     | (addr[2] << 8) | addr[3]);
 
 	cmd.data1 = ((addr[4] << 8) | (addr[5]));
+	cmd.data2 = 0;
 
 	status = myri10ge_send_cmd(mgp, MXGEFW_SET_MAC_ADDRESS, &cmd, 0);
 	return status;
@@ -817,6 +821,9 @@ static int myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
 	int status, ctl;
 
 	ctl = pause ? MXGEFW_ENABLE_FLOW_CONTROL : MXGEFW_DISABLE_FLOW_CONTROL;
+	cmd.data0 = 0,
+	cmd.data1 = 0,
+	cmd.data2 = 0,
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, 0);
 
 	if (status) {
@@ -834,6 +841,9 @@ myri10ge_change_promisc(struct myri10ge_priv *mgp, int promisc, int atomic)
 	int status, ctl;
 
 	ctl = promisc ? MXGEFW_ENABLE_PROMISC : MXGEFW_DISABLE_PROMISC;
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, atomic);
 	if (status)
 		netdev_err(mgp->dev, "Failed to set promisc mode\n");
@@ -1946,6 +1956,8 @@ static int myri10ge_allocate_rings(struct myri10ge_slice_state *ss)
 	/* get ring sizes */
 	slice = ss - mgp->ss;
 	cmd.data0 = slice;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_RING_SIZE, &cmd, 0);
 	tx_ring_size = cmd.data0;
 	cmd.data0 = slice;
@@ -2238,12 +2250,16 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
 	status = 0;
 	if (slice == 0 || (mgp->dev->real_num_tx_queues > 1)) {
 		cmd.data0 = slice;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET,
 					   &cmd, 0);
 		ss->tx.lanai = (struct mcp_kreq_ether_send __iomem *)
 		    (mgp->sram + cmd.data0);
 	}
 	cmd.data0 = slice;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SMALL_RX_OFFSET,
 				    &cmd, 0);
 	ss->rx_small.lanai = (struct mcp_kreq_ether_recv __iomem *)
@@ -2312,6 +2328,7 @@ static int myri10ge_open(struct net_device *dev)
 	if (mgp->num_slices > 1) {
 		cmd.data0 = mgp->num_slices;
 		cmd.data1 = MXGEFW_SLICE_INTR_MODE_ONE_PER_SLICE;
+		cmd.data2 = 0;
 		if (mgp->dev->real_num_tx_queues > 1)
 			cmd.data1 |= MXGEFW_SLICE_ENABLE_MULTIPLE_TX_QUEUES;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_ENABLE_RSS_QUEUES,
@@ -2414,6 +2431,8 @@ static int myri10ge_open(struct net_device *dev)
 
 	/* now give firmware buffers sizes, and MTU */
 	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_SET_MTU, &cmd, 0);
 	cmd.data0 = mgp->small_bytes;
 	status |=
@@ -2472,7 +2491,6 @@ static int myri10ge_open(struct net_device *dev)
 static int myri10ge_close(struct net_device *dev)
 {
 	struct myri10ge_priv *mgp = netdev_priv(dev);
-	struct myri10ge_cmd cmd;
 	int status, old_down_cnt;
 	int i;
 
@@ -2491,8 +2509,13 @@ static int myri10ge_close(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 	if (mgp->rebooted == 0) {
+		struct myri10ge_cmd cmd;
+
 		old_down_cnt = mgp->down_cnt;
 		mb();
+		cmd.data0 = 0;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status =
 		    myri10ge_send_cmd(mgp, MXGEFW_CMD_ETHERNET_DOWN, &cmd, 0);
 		if (status)
@@ -2956,6 +2979,9 @@ static void myri10ge_set_multicast_list(struct net_device *dev)
 
 	/* Disable multicast filtering */
 
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	err = myri10ge_send_cmd(mgp, MXGEFW_ENABLE_ALLMULTI, &cmd, 1);
 	if (err != 0) {
 		netdev_err(dev, "Failed MXGEFW_ENABLE_ALLMULTI, error status: %d\n",
-- 
2.51.0


