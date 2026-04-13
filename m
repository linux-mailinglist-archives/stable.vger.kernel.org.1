Return-Path: <stable+bounces-236573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEAPHjQb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:35:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150D3EF4CE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F833025160
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310C3093CF;
	Mon, 13 Apr 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKNadWNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530227280A;
	Mon, 13 Apr 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097255; cv=none; b=jfBEPMTd3w38nUwO9AhJ6KedoLEzI77QNMgTK4q8kvzsv/VKjMoKI6rhD0b/dZCLzXqq1vG4t3L4mLPXCxJQkOUfYXDOUcqAzSuOrCQyyeQWV3rXXme/nYPrd+MaqWjar0UtgSLpZChQiP5kD6EyNb9dfY9I0wRufvq3n39ZS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097255; c=relaxed/simple;
	bh=mHSKuWtUmtjgZQnWmd515DNn8NyK9COIk7wwxd48/68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXm/PQyQ/VOVlMH9Q9sOZ0CoU/HVRwEwlUsEXbxU/6eZmvhvkXHMjVig/GhewxR7rIit7fXmt7jYyBQ4i3D5c2++Vm9JAo1FGpVobDiQBPQZQUYCIq6iwiPbg+urMlH0kzjqBNYhg1VNElG8V1qSnjyl2WlFgT1JBqhT2JBOeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKNadWNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F86C2BCAF;
	Mon, 13 Apr 2026 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097254;
	bh=mHSKuWtUmtjgZQnWmd515DNn8NyK9COIk7wwxd48/68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKNadWNPTXpaOx2imH2sGZz7VWf+ch9r0pq8Juw5ligkdTfod4SvJKnhzDEsZf1u1
	 3mOf7s9TA4UsRkpMCyD3q1K9IWhTU7OvyoX8kgg/Y78yUc/9bv0cLF0Q1AOU0Ecouw
	 6tlrjBMAZWIiYps9LycUDj+2XAoC8cBra2YjL+1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/570] net: dpaa2-switch: assign port_priv->mac after dpaa2_mac_connect() call
Date: Mon, 13 Apr 2026 17:53:17 +0200
Message-ID: <20260413155832.914440834@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236573-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,nxp.com:email]
X-Rspamd-Queue-Id: 2150D3EF4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 147e53c0552f8..a2812229511c3 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1456,9 +1456,8 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 	err = dpaa2_mac_open(mac);
 	if (err)
 		goto err_free_mac;
-	port_priv->mac = mac;
 
-	if (dpaa2_switch_port_is_type_phy(port_priv)) {
+	if (dpaa2_mac_is_type_phy(mac)) {
 		err = dpaa2_mac_connect(mac);
 		if (err) {
 			netdev_err(port_priv->netdev,
@@ -1468,11 +1467,12 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
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
@@ -1482,15 +1482,18 @@ static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 
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




