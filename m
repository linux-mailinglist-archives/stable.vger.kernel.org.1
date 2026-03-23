Return-Path: <stable+bounces-229572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QrlYArZswWmqTAQAu9opvQ
	(envelope-from <stable+bounces-229572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5172F8897
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CCD73055A3A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF83AC0D3;
	Mon, 23 Mar 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SClrVwdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835327B340;
	Mon, 23 Mar 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282283; cv=none; b=YGOnX8it1+9lJqTadE8UIGkv31R6bDvyJRV6Jda4Khr04BtXJ72kTo8HB1wBCiGjNTPnuatmbVrd+76HU6psUonoeXxqIUrRgGSLuOnFaPOMSDr0nt9LIctqHz65w1SLii/vjoUur+baVMQ1mV4cVGi7Gozekc4LczF6e9pt9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282283; c=relaxed/simple;
	bh=jfOhorBWP/fsMY2RB50JajNzGqlzoD4Tg59aCPl/bzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHCRaZK/WB3okINKEGqT1zqIGzWbCd9V3ys7DJaCeF2oprwAOYEb21dYNAj+0ezRDYvVaZmOPZeWbgPHzjTo6UAh7IYyTF1vFsUnP1G9GG0rGc29awSen2PYbFPhUMypCjrxBXeq53UDLuwXGnrws6BP+f8BfI66h6JGQO9iFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SClrVwdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7FC4CEF7;
	Mon, 23 Mar 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282283;
	bh=jfOhorBWP/fsMY2RB50JajNzGqlzoD4Tg59aCPl/bzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SClrVwdkJzXEqDyzWYQntIxT7e+M5XIs2Ij3EpREyOo+Lx3PA2Ma4GF/qw0tYKcGA
	 BKPeMGNgW0v+w3wV87TMaeCLj8MXCvNFWNaD3bjdhe0sTRa3ULC7RKGIsnwjfvrHUC
	 O6hYdkOxSDi2DtW515z/kHR5bTx3gOjQRXEDgr9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/481] net: dpaa2-switch: assign port_priv->mac after dpaa2_mac_connect() call
Date: Mon, 23 Mar 2026 14:41:22 +0100
Message-ID: <20260323134527.720324511@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BD5172F8897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 88d64367cea019fa6197d0d97a85ac90279919b7 ]

The dpaa2-switch has the exact same locking requirements when connected
to a DPMAC, so it needs port_priv->mac to always point either to NULL,
or to a DPMAC with a fully initialized phylink instance.

Make the same preparatory change in the dpaa2-switch driver as in the
dpaa2-eth one.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 74badb9c20b1 ("dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 1e8ce5db867b4..371f53a100e84 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1460,9 +1460,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	err = dpaa2_mac_open(mac);
 	if (err)
 		goto err_free_mac;
-	port_priv->mac = mac;
 
-	if (dpaa2_switch_port_is_type_phy(port_priv)) {
+	if (dpaa2_mac_is_type_phy(mac)) {
 		err = dpaa2_mac_connect(mac);
 		if (err) {
 			netdev_err(port_priv->netdev,
@@ -1472,11 +1471,12 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 		}
 	}
 
+	port_priv->mac = mac;
+
 	return 0;
 
 err_close_mac:
 	dpaa2_mac_close(mac);
-	port_priv->mac = NULL;
 err_free_mac:
 	kfree(mac);
 out_put_device:
@@ -1486,15 +1486,18 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 
 static void dpaa2_switch_port_disconnect_mac(struct ethsw_port_priv *port_priv)
 {
-	if (dpaa2_switch_port_is_type_phy(port_priv))
-		dpaa2_mac_disconnect(port_priv->mac);
+	struct dpaa2_mac *mac = port_priv->mac;
 
-	if (!dpaa2_switch_port_has_mac(port_priv))
+	port_priv->mac = NULL;
+
+	if (!mac)
 		return;
 
-	dpaa2_mac_close(port_priv->mac);
-	kfree(port_priv->mac);
-	port_priv->mac = NULL;
+	if (dpaa2_mac_is_type_phy(mac))
+		dpaa2_mac_disconnect(mac);
+
+	dpaa2_mac_close(mac);
+	kfree(mac);
 }
 
 static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
-- 
2.51.0




