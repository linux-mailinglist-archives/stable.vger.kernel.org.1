Return-Path: <stable+bounces-120301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DFA4E77E
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846BB1886702
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B92853EC;
	Tue,  4 Mar 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9vRSeQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFA2853F6
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106180; cv=none; b=jioVOCq+bPsmTV6j1HVAbKvnNZp+09tA1LMLLGGh72XILE8n56agu2oenPP6sYKM5pIrnL4I03YI/exA575wbflDeucbHaYz43XSc0daY4SKlrJmhd6AmqgL8q+acCD53mh7GmEjKa1/TOu2LABiNOHWry2e8IjeearckSDOd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106180; c=relaxed/simple;
	bh=RyBBeHvmvcpXbNH8fnTgQYJES+IRAVisylVgT4ap0aA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uZjRUnj2ot9NG9D1sLcga4EuhY2GWxS4pb51GRiG6Bh78+iJIZGMKGXH9qTI1jrfIuh1wPZzvBSEzH6xWXap3E5WqqWvVdtzXrqkdjs7r8qfh8lHpOCdvIDK853uDsjkCkyvHuju0yumeNWAxcMoLtAf97eYfDdgJJxuKKe3Wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9vRSeQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E7FC4CEE5;
	Tue,  4 Mar 2025 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106180;
	bh=RyBBeHvmvcpXbNH8fnTgQYJES+IRAVisylVgT4ap0aA=;
	h=Subject:To:Cc:From:Date:From;
	b=I9vRSeQwlkhXKYI9v6vC3ISbdm6dVabNrDxMt61wvzzetbf4mbjd6ryoa3Iegxp1Q
	 7jjUBNPCH5pVxkan2usRRlkMpDMwXOKfls/lENCaqcSYmwHTdT6bERIrgIwQKZa3bG
	 xnJUfESO7MySF2IF41W21SS+p4RGJrtEeiQf/DS4=
Subject: FAILED: patch "[PATCH] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()" failed to apply to 5.4-stable tree
To: wei.fang@nxp.com,claudiu.manoil@nxp.com,kuba@kernel.org,michal.swiatkowski@linux.intel.com,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:36:09 +0100
Message-ID: <2025030409-primp-ripcord-cc40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 39ab773e4c120f7f98d759415ccc2aca706bbc10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030409-primp-ripcord-cc40@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39ab773e4c120f7f98d759415ccc2aca706bbc10 Mon Sep 17 00:00:00 2001
From: Wei Fang <wei.fang@nxp.com>
Date: Mon, 24 Feb 2025 19:12:44 +0800
Subject: [PATCH] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()

When a DMA mapping error occurs while processing skb frags, it will free
one more tx_swbd than expected, so fix this off-by-one issue.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Cc: stable@vger.kernel.org
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Link: https://patch.msgid.link/20250224111251.1061098-2-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6a6fc819dfde..55ad31a5073e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -167,6 +167,24 @@ static bool enetc_skb_is_tcp(struct sk_buff *skb)
 	return skb->csum_offset == offsetof(struct tcphdr, check);
 }
 
+/**
+ * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer Tx frame
+ * @tx_ring: Pointer to the Tx ring on which the buffer descriptors are located
+ * @count: Number of Tx buffer descriptors which need to be unmapped
+ * @i: Index of the last successfully mapped Tx buffer descriptor
+ */
+static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
+{
+	while (count--) {
+		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	}
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -372,13 +390,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }


