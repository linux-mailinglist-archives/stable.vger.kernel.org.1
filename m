Return-Path: <stable+bounces-41718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918208B5966
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4983128B7B5
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916AA53E08;
	Mon, 29 Apr 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zlN1EMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCD5338A
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396052; cv=none; b=CqxFtU3IU9by2d5D2T1HaSzTmpH1FbuO31h0XbMZsSoOHp9WO8ItVEBOoO4KKbQO4xyucIrn/BJDprl35Dz40gw2HufU0NgnH3ULuSyCNp6/H0kTydoeAllBT4BQl6mf3oyPyUAVCTOwYyphetzI55BPLuW/eEwsbnzC77AVovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396052; c=relaxed/simple;
	bh=SS3iiq+etJeCyaKPgwlFeaSCg/hVDcfoaez9l+VGg0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eQQQhoNItgB2g64LQXVcv5XDZI2i1rF6p+E2mxDlMtU/jS31Ok1bphbEhxeeg/+KqARu5S3jZnqou0irUoSMwiD0u6mYl1Ki57Y8SeWIjpjIwwsb4ctvSXuLuV8L6weblifg6um/tUeS6lSbP1W9iRGLW5hnBAjn+zwT7oeQsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zlN1EMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE6C4AF17;
	Mon, 29 Apr 2024 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714396051;
	bh=SS3iiq+etJeCyaKPgwlFeaSCg/hVDcfoaez9l+VGg0k=;
	h=Subject:To:Cc:From:Date:From;
	b=0zlN1EMV8dFxUOVT2vx8Lx+q9ZhGPtJ9zswa6UN9TH/S/bhAgp1fcD4+4/78og24f
	 E7lOegZKKfOEUqbn4zuM+qxd5qFw+L3RiA68ji1UtNNrN8zpLgTLX9B5Nr5f+3J8rp
	 39tsGsi1uheRhCnWTMSorqf/nu6GeVViWK+Fypg8=
Subject: FAILED: patch "[PATCH] macsec: Detect if Rx skb is macsec-related for offloading" failed to apply to 6.6-stable tree
To: rrameshbabu@nvidia.com,bpoirier@nvidia.com,cratiu@nvidia.com,kuba@kernel.org,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 15:07:28 +0200
Message-ID: <2024042928-mastiff-unmasked-6a54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 642c984dd0e37dbaec9f87bd1211e5fac1f142bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042928-mastiff-unmasked-6a54@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

642c984dd0e3 ("macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 642c984dd0e37dbaec9f87bd1211e5fac1f142bf Mon Sep 17 00:00:00 2001
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Date: Tue, 23 Apr 2024 11:13:04 -0700
Subject: [PATCH] macsec: Detect if Rx skb is macsec-related for offloading
 devices that update md_dst

Can now correctly identify where the packets should be delivered by using
md_dst or its absence on devices that provide it.

This detection is not possible without device drivers that update md_dst. A
fallback pattern should be used for supporting such device drivers. This
fallback mode causes multicast messages to be cloned to both the non-macsec
and macsec ports, independent of whether the multicast message received was
encrypted over MACsec or not. Other non-macsec traffic may also fail to be
handled correctly for devices in promiscuous mode.

Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-4-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 0206b84284ab..ff016c11b4a0 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -999,10 +999,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	struct metadata_dst *md_dst;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
+	bool is_macsec_md_dst;
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1013,14 +1015,42 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 * the SecTAG, so we have to deduce which port to deliver to.
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
-			struct macsec_rx_sc *rx_sc = NULL;
+			const struct macsec_ops *ops;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
-				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			ops = macsec_get_ops(macsec, NULL);
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
+			if (ops->rx_uses_md_dst && !is_macsec_md_dst)
 				continue;
 
+			if (is_macsec_md_dst) {
+				struct macsec_rx_sc *rx_sc;
+
+				/* All drivers that implement MACsec offload
+				 * support using skb metadata destinations must
+				 * indicate that they do so.
+				 */
+				DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
+				rx_sc = find_rx_sc(&macsec->secy,
+						   md_dst->u.macsec_info.sci);
+				if (!rx_sc)
+					continue;
+				/* device indicated macsec offload occurred */
+				skb->dev = ndev;
+				skb->pkt_type = PACKET_HOST;
+				eth_skb_pkt_type(skb, ndev);
+				ret = RX_HANDLER_ANOTHER;
+				goto out;
+			}
+
+			/* This datapath is insecure because it is unable to
+			 * enforce isolation of broadcast/multicast traffic and
+			 * unicast traffic with promiscuous mode on the macsec
+			 * netdev. Since the core stack has no mechanism to
+			 * check that the hardware did indeed receive MACsec
+			 * traffic, it is possible that the response handling
+			 * done by the MACsec port was to a plaintext packet.
+			 * This violates the MACsec protocol standard.
+			 */
 			if (ether_addr_equal_64bits(hdr->h_dest,
 						    ndev->dev_addr)) {
 				/* exact match, divert skb to this port */
@@ -1036,14 +1066,10 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				eth_skb_pkt_type(nskb, ndev);
 
 				__netif_rx(nskb);
-			} else if (rx_sc || ndev->flags & IFF_PROMISC) {
+			} else if (ndev->flags & IFF_PROMISC) {
 				skb->dev = ndev;
 				skb->pkt_type = PACKET_HOST;
 				ret = RX_HANDLER_ANOTHER;


