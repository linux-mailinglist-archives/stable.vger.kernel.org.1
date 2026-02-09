Return-Path: <stable+bounces-215404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAwHE1v4iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB5111954
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB74310C068
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792B37997A;
	Mon,  9 Feb 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0SKLggI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48228725B;
	Mon,  9 Feb 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648683; cv=none; b=jA/JdB2i31VdoYq/Qur7ZDypGatvFEhG/MyW37MZ1fnpNxkTYbs4SjaGAEbbhqZGzeezymFhR0lO9zHlFv8ZfUBeYABvjB2DBGX7HjBcmuSj2qPj/zP+QNIVN9qW2M2TN12NtKFpsReZ0Z2lhmipKvcreXZ4I795KfI22YW+y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648683; c=relaxed/simple;
	bh=X9XF8/jQgsvbhEt8ZgSy36xGDb52a3708WYc2f18XRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szpFjkFIEX6dreuT4GTSXYYHS09Z3XkbmiX8Eb+cI5MqncV2G4gAngV7o1jBCDqn5xGZq9HGWk55Ky1RQsRGy3vWcOirL7BqEWGfDSlsIY35bTsYrO0D8E3Pmf7SrtjcnUYrfpRxLFpx83b5HNSeYFT6kdHJnl3430o19jz8W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0SKLggI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89472C116C6;
	Mon,  9 Feb 2026 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648683;
	bh=X9XF8/jQgsvbhEt8ZgSy36xGDb52a3708WYc2f18XRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0SKLggIetU0mkrL2+MmlPM122VJHrFE+KCfas/MQU4+5CKYL8d+9uc8KOIIZQxLb
	 k+VGdwr9ZckOvCwU94xevC7ASkeVwskSccYtRLHnZUIxB8mfIvzSIBZIOXyhV1sxLz
	 cNHx3sja8czZFn9AFupNuQbfv2Ye29sf/fYpuluc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 25/41] net: liquidio: Initialize netdev pointer before queue setup
Date: Mon,  9 Feb 2026 15:24:46 +0100
Message-ID: <20260209142257.719982279@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215404-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,seu.edu.cn:email]
X-Rspamd-Queue-Id: ACFB5111954
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 926ede0c85e1e57c97d64d9612455267d597bb2c ]

In setup_nic_devices(), the netdev is allocated using alloc_etherdev_mq().
However, the pointer to this structure is stored in oct->props[i].netdev
only after the calls to netif_set_real_num_rx_queues() and
netif_set_real_num_tx_queues().

If either of these functions fails, setup_nic_devices() returns an error
without freeing the allocated netdev. Since oct->props[i].netdev is still
NULL at this point, the cleanup function liquidio_destroy_nic_device()
will fail to find and free the netdev, resulting in a memory leak.

Fix this by initializing oct->props[i].netdev before calling the queue
setup functions. This ensures that the netdev is properly accessible for
cleanup in case of errors.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: c33c997346c3 ("liquidio: enhanced ethtool --set-channels feature")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20260128154440.278369-2-zilin@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index eefb25bcf57ff..35e46245f1638 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3531,6 +3531,23 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		 */
 		netdev->netdev_ops = &lionetdevops;
 
+		lio = GET_LIO(netdev);
+
+		memset(lio, 0, sizeof(struct lio));
+
+		lio->ifidx = ifidx_or_pfnum;
+
+		props = &octeon_dev->props[i];
+		props->gmxport = resp->cfg_info.linfo.gmxport;
+		props->netdev = netdev;
+
+		/* Point to the  properties for octeon device to which this
+		 * interface belongs.
+		 */
+		lio->oct_dev = octeon_dev;
+		lio->octprops = props;
+		lio->netdev = netdev;
+
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
 			dev_err(&octeon_dev->pci_dev->dev,
@@ -3547,16 +3564,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 			goto setup_nic_dev_free;
 		}
 
-		lio = GET_LIO(netdev);
-
-		memset(lio, 0, sizeof(struct lio));
-
-		lio->ifidx = ifidx_or_pfnum;
-
-		props = &octeon_dev->props[i];
-		props->gmxport = resp->cfg_info.linfo.gmxport;
-		props->netdev = netdev;
-
 		lio->linfo.num_rxpciq = num_oqueues;
 		lio->linfo.num_txpciq = num_iqueues;
 		for (j = 0; j < num_oqueues; j++) {
@@ -3622,13 +3629,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		netdev->min_mtu = LIO_MIN_MTU_SIZE;
 		netdev->max_mtu = LIO_MAX_MTU_SIZE;
 
-		/* Point to the  properties for octeon device to which this
-		 * interface belongs.
-		 */
-		lio->oct_dev = octeon_dev;
-		lio->octprops = props;
-		lio->netdev = netdev;
-
 		dev_dbg(&octeon_dev->pci_dev->dev,
 			"if%d gmx: %d hw_addr: 0x%llx\n", i,
 			lio->linfo.gmxport, CVM_CAST64(lio->linfo.hw_addr));
-- 
2.51.0




